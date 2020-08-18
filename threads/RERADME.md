# Quick Ruby multithreading notes


1. a new threas is created using ```thread.new``` (this one will be different from the main thread). Ruby provides 3 keywords:
    - ::new
    - ::start
    - ::fork
   The thread will exit when the block which it remains exits


```ruby
                            #originalthread
th1 = Thread.new {
                            #newthread
}
                            #originalthread
```
2. any thread can be terminated with ::kill keyword ```Thread.kill(th1)```