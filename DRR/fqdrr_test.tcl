
#create a new simulator
set ns [new Simulator]

#get argument drr, fq 
set qtype [lindex $argv 0]
#get simulation duration
set simTime [lindex $argv 1]
if {$simTime < 1} {
	set simTime 3
}
#get cwnd size if modifying for all
set cwndsiz [lindex $argv 2]

#Open the Trace files
set tracefile1 [open out.tr w] 
set winfile [open WinFile w]
$ns trace-all $tracefile1

#opening NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#create the tcp/ftp src nodes
set numSrc 20

#defining a finish procedure
proc finish {} {
	global ns nf numSrc tracefile1
	$ns flush-trace
	#close the nam trace file
        #close $nf
	#close $tracefile1
	exec xgraph WinFile -geometry 400x400 &
	#execute the nam file in background
	#exec nam out.nam &
	exit 0
}

#color them
#$ns color 1 Red
#$ns color 2 SeaGreen
#$ns color 3 Yellow
#$ns color 4 Blue

#create the basic 3 backbone nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
#$ns duplex-link $n0 $n1 15Mb 3ms DRR
$ns duplex-link $n0 $n1 15Mb 3ms $qtype
$ns duplex-link $n1 $n2 20Mb 25ms DropTail

#give position for the link on nam
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right

#set monitors for link between n0, n1 and n2 for nam
$ns duplex-link-op $n0 $n1 queuePos 0.5
$ns duplex-link-op $n1 $n2 queuePos 0.5

#set queuesize, buffer capacity
$ns queue-limit $n0 $n1 100
$ns queue-limit $n1 $n2 100

#Create the 4 tcp agents and ftp sources
for {set i 1} {$i<=$numSrc} {incr i} {
    set tcpsrc($i) [new Agent/TCP]

    $ns attach-agent $n0 $tcpsrc($i) 
    $tcpsrc($i) set class_ 2
    if {$cwndsiz > 10} {
		$tcpsrc($i) set window_ $cwndsiz
    } else {

    	if {$i == 1} {
		    $tcpsrc($i) set window_ 9
    	}
		if {$i == 2} {
#		    $tcpsrc($i) set packetSize_ 164
		    $tcpsrc($i) set window_ 18
    	}
    	if {$i == 3} {
#		    $tcpsrc($i) set packetSize_ 248
		    $tcpsrc($i) set window_ 45
		}
    	if {$i == 4} {
#		    $tcpsrc($i) set packetSize_ 335
		    $tcpsrc($i) set window_ 60
    	}
    }
	#create sink and connect src, sink and node
    set tcpsink($i) [new Agent/TCPSink]
    $ns attach-agent $n2 $tcpsink($i)
    $ns connect $tcpsrc($i) $tcpsink($i)
    $tcpsrc($i) set fid_ $i

    #create the ftp sources over tcp
    #well else try this
    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcpsrc($i)
    $ftp($i) set type_ FTP
}



#compute throughputs
proc calc_throughput {tcpsrc srcno simT file} {
		set totpkts [$tcpsrc set ndatapack_]
		set pktsiz [$tcpsrc set packetSize_]
		set totsntsrc [$tcpsrc set ndatabytes_]
		set totretsrc [$tcpsrc set nrexmitbytes_]
		set throughput [expr [expr [expr [expr $totsntsrc - $totretsrc]*8.0/$simT]/1024]/1024]
		#puts " Source $srcno: Number of packets Gen: $totpkts, Pkt size: $pktsiz B Throughput : $throughput Mbps"
		puts $file "$srcno $throughput"
		#$ns at [expr $now+$time] "calc_throughput $tcpsrc $srcno $simT $file"
}

for {set j 1} {$j<=$numSrc} {incr j} {
    $ns at 0.0 "$ftp($j) start"
    $ns at $simTime "$ftp($j) stop"
    $ns at $simTime "calc_throughput $tcpsrc($j) $j $simTime $winfile"
}

#detach tcp and sink agents - not nece

#call finish after simulation duration
$ns at $simTime "finish"

#Run the simulation
$ns run
