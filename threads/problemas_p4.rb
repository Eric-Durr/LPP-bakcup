print Thread.main                                 # imprime por pantalla el hilo principal de ejecución     
print "\n"                      
t1 = Thread.new {sleep 100}                       # Se crea un hilo cuyo bloque de ejecución es una espera de 100 unidades                 
Thread.list.each.with_index(1) {|thr, i| p "thread #{i}: #{thr}" } # Se obtiene una lista de los hilos activos y se imprimen con salto de linea
                                                  # Se imprimen primero el hilo principal y a continuación el t1
print "Current thread = " + Thread.current.to_s   # Se imprime el hilo que actualmente está en ejecución (principal) (es el del ámbito)
print "\n"
t2 = Thread.new {sleep 100}                       # Se crea otro hilo (t2) el cual también hace una espera de 100 unidades
Thread.list.each.with_index(1) {|thr, i| p "thread #{i}: #{thr}" }                   # Se obtiene una lista de los hilos activos y se imprimen con salto de linea
                                                  # Se imprimen primero el hilo principal, el t1 y el t2 ya que los tres siguen activos
print "Current thread = " + Thread.current.to_s        # Se imprime el hilo que actualmente está en ejecución (principal))
                                                 
print "\n"
Thread.kill(t1)                                   # Se termina el hilo t1, haya terminado o no 
#Thread.pass                                       # Se pasa al siguiente hilo de ejecución (t2)
t3 = Thread.new do                                # Se crea otro hilo t3 en cuyo bloque, trtas una espera de 20 unidades  se sale del hilo
  sleep 20
	Thread.exit
end
Thread.kill(t2)                                   # Se termina con el hilo t2

#(Como no se ha hecho join ni pass de los hilos, t2 y t3 siguen activos hasta terminar la ejecución del hilo principal)
Thread.list.each.with_index(1) {|thr, i| p "thread #{i}: #{thr}" }  # Se imprime la lista de hilos activos (el principal, t2 y t3)
Thread.exit                                       