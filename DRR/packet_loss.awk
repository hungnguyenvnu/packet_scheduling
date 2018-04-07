BEGIN {
    packet_lost0 = 0;
    packet_lost1 = 0;
    packet_lost2 = 0;
	packet_lost3 = 0;
    packet_lost4 = 0;
	packet_lost5 = 0;
	packet_lost6 = 0;
	packet_lost7 = 0;
	packet_lost8 = 0;
	packet_lost9 = 0;
	packet_lost10 = 0;
	packet_lost11 = 0;
	packet_lost12 = 0;
	packet_lost13 = 0;
	packet_lost14 = 0;
	packet_lost15 = 0;
	packet_lost16 = 0;
	packet_lost17 = 0;
	packet_lost18 = 0;
	packet_lost19 = 0;
	
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

    #total_throughput = 0
    final = 0
    time_ini = 0.0
    count = 0
}
{
    ackn = $5
    event = $1
    
    time = $2
    node = 0
    flowid= $8
    from_node = $3
    to_node= $4 #from node should be 2
    source = $9
    dest= $10
    #I HAVE THREE SOURCES SO I USED THREE PACKET LOSTS 
    if(event  == "d"  && source ="0.0" && dest == "2.0") {
        
        packet_lost0 = packet_lost0+1;
        }
    if(event  == "d"  && source ="0.1" && dest == "2.1") {
        
        packet_lost1 = packet_lost1+1;
        }
    if(event  == "d"  && source ="0.2" && dest == "2.2") {
        
        packet_lost2 = packet_lost2+1;
        }
	if(event  == "d"  && source ="0.3" && dest == "2.3") {
        
        packet_lost3 = packet_lost3+1;
        }
    if(event  == "d"  && source ="0.4" && dest == "2.4") {
        
        packet_lost4 = packet_lost4+1;
        }
    if(event  == "d"  && source ="0.5" && dest == "2.5") {
        
        packet_lost5 = packet_lost5+1;
        }
	if(event  == "d"  && source ="0.6" && dest == "2.6") {
        
        packet_lost6 = packet_lost6+1;
        }
    if(event  == "d"  && source ="0.7" && dest == "2.7") {
        
        packet_lost7 = packet_lost7+1;
        }
    if(event  == "d"  && source ="0.8" && dest == "2.8") {
        
        packet_lost8 = packet_lost8+1;
        }
	if(event  == "d"  && source ="0.9" && dest == "2.9") {
        
        packet_lost9 = packet_lost9+1;
        }
    if(event  == "d"  && source ="0.10" && dest == "2.10") {
        
        packet_lost10 = packet_lost10+1;
        }
    if(event  == "d"  && source ="0.11" && dest == "2.11") {
        
        packet_lost11 = packet_lost11+1;
        }	
    if(event  == "d"  && source ="0.12" && dest == "2.12") {
        
        packet_lost12 = packet_lost12+1;
        }
    if(event  == "d"  && source ="0.13" && dest == "2.13") {
        
        packet_lost13 = packet_lost13+1;
        }
    if(event  == "d"  && source ="0.14" && dest == "2.14") {
        
        packet_lost2 = packet_lost2+1;
        }
	if(event  == "d"  && source ="0.15" && dest == "2.15") {
        
        packet_lost15 = packet_lost15+1;
        }
    if(event  == "d"  && source ="0.16" && dest == "2.16") {
        
        packet_lost16 = packet_lost16+1;
        }
    if(event  == "d"  && source ="0.17" && dest == "2.17") {
        
        packet_lost17 = packet_lost17+1;
        }
	if(event  == "d"  && source ="0.18" && dest == "2.18") {
        
        packet_lost18 = packet_lost18+1;
        }
    if(event  == "d"  && source ="0.19" && dest == "2.19") {
        
        packet_lost19 = packet_lost19+1;
        }
	## Compute number of packet sent
	if(event  == "+"  && source ="0.0" && dest == "2.0") {
        
        packet_sent0 = packet_sent0+1;
        }
    if(event  == "+"  && source ="0.1" && dest == "2.1") {
        
        packet_sent1 = packet_sent1+1;
        }
    if(event  == "+"  && source ="0.2" && dest == "2.2") {
        
        packet_sent2 = packet_sent2+1;
        }
	if(event  == "+"  && source ="0.3" && dest == "2.3") {
        
        packet_sent3 = packet_sent3+1;
        }
    if(event  == "+"  && source ="0.4" && dest == "2.4") {
        
        packet_sent4 = packet_sent4+1;
        }
    if(event  == "+"  && source ="0.5" && dest == "2.5") {
        
        packet_sent5 = packet_sent5+1;
        }
	if(event  == "+"  && source ="0.6" && dest == "2.6") {
        
        packet_sent6 = packet_sent6+1;
        }
    if(event  == "+"  && source ="0.7" && dest == "2.7") {
        
        packet_sent7 = packet_sent7+1;
        }
    if(event  == "+"  && source ="0.8" && dest == "2.8") {
        
        packet_sent8 = packet_sent8+1;
        }
	if(event  == "+"  && source ="0.9" && dest == "2.9") {
        
        packet_sent9 = packet_sent9+1;
        }
    if(event  == "+"  && source ="0.10" && dest == "2.10") {
        
        packet_sent10 = packet_sent10+1;
        }
    if(event  == "+"  && source ="0.11" && dest == "2.11") {
        
        packet_sent11 = packet_sent11+1;
        }	
    if(event  == "+"  && source ="0.12" && dest == "2.12") {
        
        packet_sent12 = packet_sent12+1;
        }
    if(event  == "+"  && source ="0.13" && dest == "2.13") {
        
        packet_sent13 = packet_sent13+1;
        }
    if(event  == "+"  && source ="0.14" && dest == "2.14") {
        
        packet_sent2 = packet_sent2+1;
        }
	if(event  == "+"  && source ="0.15" && dest == "2.15") {
        
        packet_sent15 = packet_sent15+1;
        }
    if(event  == "+"  && source ="0.16" && dest == "2.16") {
        
        packet_sent16 = packet_sent16+1;
        }
    if(event  == "+"  && source ="0.17" && dest == "2.17") {
        
        packet_sent17 = packet_sent17+1;
        }
	if(event  == "+"  && source ="0.18" && dest == "2.18") {
        
        packet_sent18 = packet_sent18+1;
        }
    if(event  == "+"  && source ="0.19" && dest == "2.19") {
        
        packet_sent19 = packet_sent19+1;
        }
}


END {
        print("1 " , packet_lost0*100/packet_sent0)
        print("2 " , packet_lost1*100/packet_sent1)
        
        print("3 " , packet_lost2*100/packet_sent2)
		
        print("4 " , packet_lost3*100/packet_sent3)
        
        print("5" , packet_lost4*100/packet_sent4)
        
        print("6 " , packet_lost5*100/packet_sent5)
		
        print("7 " , packet_lost6*100/packet_sent6)
        
        print("8" , packet_lost7*100/packet_sent7)
        
        print("9 " , packet_lost8*100/packet_sent8)
        print("10 " , packet_lost9*100/packet_sent9)
        print("11" , packet_lost10*100/packet_sent10)
        print("12 " , packet_lost11*100/packet_sent11)
		print("13 " , packet_lost12*100/packet_sent12)
        print("14" , packet_lost13*100/packet_sent13)
        print("15 " , packet_lost14*100/packet_sent14)
        print("16 " , packet_lost15*100/packet_sent15)
        print("17" , packet_lost16*100/packet_sent16)
        
        print("18 " , packet_lost17*100/packet_sent17)
		
        print("19 " , packet_lost18*100/packet_sent18)
		print("20 " , packet_lost19*100/packet_sent19)
#TOTAL LOST COUNT
        #packet_lost_total = packet_lost1+packet_lost2+packet_lost3;
        #
        #print("Total packet drop= " , packet_lost_total)
        #



}