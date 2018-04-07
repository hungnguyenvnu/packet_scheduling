# ################################################
# Make a simulator (scheduler)
  set ns [new Simulator]

# ################################################
#Define different colors for data flows (for NAM)
  $ns color 1 Blue
  $ns color 2 Red

# -------------------------------
# Open the Window plot file
# -------------------------------
  set winfile2 [open WinFile2 w]

# -------------------------------
# Define a 'finish' procedure
# -------------------------------
  proc finish {} {
     global ns winfile winfile2

     close $winfile2
     exit 0
  }

# ################################################
# Create this configuration:
#
#            0                 4
#    2Mb/10ms \  0.3Mb/100ms  / 0.5Mb/40ms
#              2 ----------- 3
#    2Mb/10ms /               \ 0.5Mb/30ms
#            1                 5
#
#  TCP1: (t=0)   0 -> 4
#  TCP2: (t=20)  1 -> 5
# ################################################

# ################################################
# Create the nodes:
  set n0 [$ns node]
  set n1 [$ns node]
  set n2 [$ns node]
  set n3 [$ns node]
  set n4 [$ns node]
  set n5 [$ns node]

Queue/DRR set quantum_ 500
puts "# Buckets = [Queue/DRR set buckets_]"
puts "mask = [Queue/DRR set mask_]"
puts "quantum = [Queue/DRR set quantum_]"
puts "blimit = [Queue/DRR set blimit_]"

# ################################################
# Create the links:
  $ns duplex-link $n0 $n2   2Mb  10ms DropTail
  $ns duplex-link $n1 $n2   2Mb  10ms DropTail
  $ns duplex-link $n2 $n3 0.3Mb 200ms DRR
  $ns duplex-link $n3 $n4 0.5Mb  40ms DropTail
  $ns duplex-link $n3 $n5 0.5Mb  30ms DropTail

# ################################################
#Monitor the queue for link (n0-n1). (for NAM)
$ns duplex-link-op $n2 $n3 queuePos 0.1


# ################################################
# Give node position (for NAM)
  $ns duplex-link-op  $n0 $n2 orient right-down
  $ns duplex-link-op  $n1 $n2 orient right-up
  $ns duplex-link-op  $n2 $n3 orient right
  $ns duplex-link-op  $n3 $n4 orient right-up
  $ns duplex-link-op  $n3 $n5 orient right-down


# ########################################################
# Set Queue Size of link (n2-n3) to 10 (default is 50 ?)
  $ns queue-limit $n2 $n3 10

# -----------------------------------------------------
# Setup First UDP connection
#
#       UDP->0                 4 <- SINK
#    2Mb/10ms \  0.3Mb/100ms  / 0.5Mb/40ms
#              2 ----------- 3
#    2Mb/10ms /               \ 0.5Mb/30ms
#            1                 5
#
#  TCP1: (t=0)   0 -> 4
# -----------------------------------------------------

  set udp1 [new Agent/UDP]
  $ns attach-agent $n0 $udp1

  set udp1_sink [new Agent/Null]
  $ns attach-agent $n4 $udp1_sink

  $ns connect $udp1 $udp1_sink

  $udp1 set fid_ 1

# ########################################################
# Setup a CBR flow over the UDP connection
# ########################################################

  set cbr1  [new Application/Traffic/CBR]
  $cbr1 attach-agent $udp1

# ---------------
# Transmission rate = 512/10 ms = 51200 bytes/sec = 50KBps = 400 Kbps = 0.4 Mbps
# ---------------
  $cbr1  set packetSize_ 512
  $cbr1  set interval_   10ms


# ########################################################
# Schedule start/stop times
  $ns at 0.0 "$cbr1 start"


# -----------------------------------------------------
# Setup Second TCP connection
#
#            0                 4
#    2Mb/10ms \  0.3Mb/100ms  / 0.5Mb/40ms
#              2 ----------- 3
#    2Mb/10ms /               \ 0.5Mb/30ms
#       TCP->1                 5<-SINK
#
#  TCP2: (t=20)   1 -> 5
# -----------------------------------------------------

  set tcp2 [new Agent/TCP/Reno]
  $ns attach-agent $n1 $tcp2

# set sink2 [new Agent/TCPSink/DelAck]
  set sink2 [new Agent/TCPSink]
  $ns attach-agent $n5 $sink2

  $ns connect $tcp2 $sink2
  $tcp2 set window_ 8000
  $tcp2 set packetSize_ 552

# This give the packet of TCP flow 2 a different color...
  $tcp2 set fid_ 2


# ########################################################
# Setup a FTP over TCP connection
  set ftp2 [new Application/FTP]
  $ftp2 attach-agent $tcp2
  $ftp2 set type_ FTP


# ########################################################
# Schedule start/stop times
  $ns at 20.0 "$ftp2 start"
  $ns at 500.0 "$ftp2 stop"





# -----------------------------------------------------------------
# plotWindow(tcpSource,file): write CWND from $tcpSource
#			      to output file $file every 0.1 sec
# -----------------------------------------------------------------
  proc plotWindow {tcpSource file} {
     global ns

     set time 0.1
     set now [$ns now]
     set cwnd [$tcpSource set cwnd_]
     set wnd [$tcpSource set window_]
     puts $file "$now $cwnd"
     $ns at [expr $now+$time] "plotWindow $tcpSource $file" 
  }

# -----------------------------------------------------------
# Start plotWindow for TCP 2
# -----------------------------------------------------------
  $ns at 0.1 "plotWindow $tcp2 $winfile2"

# ####################################################################
# Set simulation end time
  $ns at 200.0 "finish"

# ####################################################################
# Run !!!!
  $ns run
