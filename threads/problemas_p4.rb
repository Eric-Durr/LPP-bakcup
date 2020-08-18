print Thread.main                                
print "\n"
t1 = Thread.new {sleep 100}                      
Thread.list.each {|thr| p thr }                  
print "Current thread = " + Thread.current.to_s  
print "\n"
t2 = Thread.new {sleep 100}                      
Thread.list.each {|thr| p thr }                  
print Thread.current                             
                                                 
print "\n"
Thread.kill(t1)                                  
Thread.pass                                      
t3 = Thread.new do                               
  sleep 20
	Thread.exit
end
Thread.kill(t2) 
Thread.list.each {|thr| p thr }

Thread.exit 