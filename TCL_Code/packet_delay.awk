BEGIN {
 highest_packet_id = 0;
 # Compute number of packet sent
    packet_sent0 = 0;
	packet_sent1 = 0;
    packet_sent2 = 0;
	packet_sent3 = 0;
    packet_sent4 = 0;
	packet_sent5 = 0;
	packet_sent6 = 0;
	packet_sent7 = 0;
	packet_sent8 = 0;
	packet_sent9 = 0;
	packet_sent10 = 0;
	packet_sent11 = 0;
	packet_sent12 = 0;
	packet_sent13 = 0;
	packet_sent14 = 0;
	packet_sent15 = 0;
	packet_sent16 = 0;
	packet_sent17 = 0;
	packet_sent18 = 0;
	packet_sent19 = 0;
	###
	# Delay of each packet
	 packet_delay0 = 0;
	packet_delay1 = 0;
    packet_delay2 = 0;
	packet_delay3 = 0;
    packet_delay4 = 0;
	packet_delay5 = 0;
	packet_delay6 = 0;
	packet_delay7 = 0;
	packet_delay8 = 0;
	packet_delay9 = 0;
	packet_delay10 = 0;
	packet_delay11 = 0;
	packet_delay12 = 0;
	packet_delay13 = 0;
	packet_delay14 = 0;
	packet_delay15 = 0;
	packet_delay16 = 0;
	packet_delay17 = 0;
	packet_delay18 = 0;
	packet_delay19 = 0;
}

{
	action = $1;
	time = $2;
	node_1 = $3;
	node_2 = $4;
	src = $5;
	flow_id = $8;
	node_1_address = $9;
	node_2_address = $10;
	seq_no = $11;
	packet_id = $12;
	if ( packet_id > highest_packet_id ) highest_packet_id = packet_id;
	
	    if ( start_time[packet_id] == 0 ) start_time[packet_id] = time;
	if ( start_time[packet_id] == 0 ) {
		start_time[packet_id] = time;
		flow[packet_id] = flow_id;
	}	

    # only useful for small unicast where packet_id doesn't wrap.
    # checking receive means avoiding recording drops
     if ( action != "d" ) {
       if ( action == "r" ) {
		# could test for receiving node_2_address or flow_id here.
		end_time[packet_id] = time;
		}
     } else {
		end_time[packet_id] = -1;
     }   
       ## Compute number of packet sent
	if(action  == "+"  && node_1_address ="0.0" && node_2_address == "2.0") {
        
        packet_sent0 = packet_sent0+1;
        }
    if(action  == "+"  && node_1_address ="0.1" && node_2_address == "2.1") {
        
        packet_sent1 = packet_sent1+1;
        }
    if(action  == "+"  && node_1_address ="0.2" && node_2_address == "2.2") {
        
        packet_sent2 = packet_sent2+1;
        }
	if(action  == "+"  && node_1_address ="0.3" && node_2_address == "2.3") {
        
        packet_sent3 = packet_sent3+1;
        }
    if(action  == "+"  && node_1_address ="0.4" && node_2_address == "2.4") {
        
        packet_sent4 = packet_sent4+1;
        }
    if(action  == "+"  && node_1_address ="0.5" && node_2_address == "2.5") {
        
        packet_sent5 = packet_sent5+1;
        }
	if(action  == "+"  && node_1_address ="0.6" && node_2_address == "2.6") {
        
        packet_sent6 = packet_sent6+1;
        }
    if(action  == "+"  && node_1_address ="0.7" && node_2_address == "2.7") {
        
        packet_sent7 = packet_sent7+1;
        }
    if(action  == "+"  && node_1_address ="0.8" && node_2_address == "2.8") {
        
        packet_sent8 = packet_sent8+1;
        }
	if(action  == "+"  && node_1_address ="0.9" && node_2_address == "2.9") {
        
        packet_sent9 = packet_sent9+1;
        }
    if(action  == "+"  && node_1_address ="0.10" && node_2_address == "2.10") {
        
        packet_sent10 = packet_sent10+1;
        }
    if(action  == "+"  && node_1_address ="0.11" && node_2_address == "2.11") {
        
        packet_sent11 = packet_sent11+1;
        }	
    if(action  == "+"  && node_1_address ="0.12" && node_2_address == "2.12") {
        
        packet_sent12 = packet_sent12+1;
        }
    if(action  == "+"  && node_1_address ="0.13" && node_2_address == "2.13") {
        
        packet_sent13 = packet_sent13+1;
        }
    if(action  == "+"  && node_1_address ="0.14" && node_2_address == "2.14") {
        
        packet_sent2 = packet_sent2+1;
        }
	if(action  == "+"  && node_1_address ="0.15" && node_2_address == "2.15") {
        
        packet_sent15 = packet_sent15+1;
        }
    if(action  == "+"  && node_1_address ="0.16" && node_2_address == "2.16") {
        
        packet_sent16 = packet_sent16+1;
        }
    if(action  == "+"  && node_1_address ="0.17" && node_2_address == "2.17") {
        
        packet_sent17 = packet_sent17+1;
        }
	if(action  == "+"  && node_1_address ="0.18" && node_2_address == "2.18") {
        
        packet_sent18 = packet_sent18+1;
        }
    if(action  == "+"  && node_1_address ="0.19" && node_2_address == "2.19") {
        
        packet_sent19 = packet_sent19+1;
        }
}

END {
    for ( packet_id = 0; packet_id < highest_packet_id; packet_id++ ) {
			start = start_time[packet_id];
			end = end_time[packet_id];
			packet_duration = end - start;
		if ( start < end ) printf("%d %f\n", flow[packet_id], packet_duration);
		
	}

} 