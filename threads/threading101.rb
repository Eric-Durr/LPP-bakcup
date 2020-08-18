$str = "My Ruby thread example"

def foo1
    a = 0
    while a <= 3
        p "Foo1 function: #{a}"
        sleep(1)
        a += 1
    end

    p "#{$str}"
end

def foo2
    b = 0
    while b <= 3
        p "Foo2 function: #{b}"
        sleep(0.5)
        b += 1
    end
    
    p "#{$str}"
end

th1 = Thread.new {foo1()}
th2 = Thread.new {foo2()}

th1.join
th2.join

p "process end"

