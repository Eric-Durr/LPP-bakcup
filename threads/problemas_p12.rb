def inc(n)                           # Se defince el método para incrementar un objeto dado
	n + 1
end
mutex = Mutex.new                    # Se crea un objeto Mutex
sum = 0                              # Se crea la variable sum
threads = (1..10).map do             # Se hace un array de 10 hilos mediante un map (functional)
Thread.new do                  
        10_000.times do              # En un bucle de 10.000 iteraciones:
            
			mutex.synchronize do     # Se emplea el mutex para sincronizar los hilos
				sum = inc(sum)       # se incrementa la variable en una unidad
			end
		end
	end
end
threads.each(&:join)                 # Se asegura la ejecución de todos los hilos con el ::join
print sum                            # Se imprime el resultado.

# En este caso la condición de carrera no corrompe el valor de sum, ya que el objeto mutex asegura la
# sincronización del acceso al recurso compartido por los 10 hilos, de esta manera se produce una
# exclusión mutua donde solo un hilo a la vez tiene permitido el acceso a los datos.
# sum tiene como valor 100.000 (10_000 * )