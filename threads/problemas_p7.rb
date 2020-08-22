
count = 0                                           # Se inicia un objeto Numeric a cero
threads = []                                        # se crea un objeto Array vacío
10.times do |i|                                     # Se crean 10 hilos en un bucle
	threads[i] = Thread.new do 
		sleep(rand(0.1))                            # Se pausan los hilos durante un tiempo aleatorio
		Thread.current["mycount"] = count           # El hilo actual se iguala al valor del contador
		count += 1                                  # Se incrementa el contador
	end
end

threads.each {|t| t.join; print t["mycount"], ", "} # Cada hilo de los creados ejecuta join e 
                                                    # imprime su valor de contador
puts "count = #{count}"                             # Se imprime el resultado final de la cuenta

# El contador valdrá 10 al finalizar la ejecución, sin embargo los hilos, al pausarse durante 
# un tiempo aleatorio irán adoptando un valor en "mycount" entre 1 y 10. Según vayan terminando,
# de manera aleatorioa, se imprimirán sus números. Si quitásemos el ::join el hilo principal podría
# finalizar antes que el tiempo de pausa de cada hilo.
