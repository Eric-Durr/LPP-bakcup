def inc(n)                    # Se define la función incremento, esta incrementa un argumento en 
                              # una unidad
	n + 1
end

sum = 0                       # Se define la variable sum como objeto Numeric a 0
threads = (1..10).map do      # Se crea un Array de 10 hilos con programación funcional
	Thread.new do             # En cada hilo se ejecuta un bloque que:
		100_000.times do      # Repite 100000 veces el incremento de sum en una unidad
			sum = inc(sum)      
		end
	end
end
threads.each(&:join)          # Se aplica un join a cada hilo del array con funciones de orden superior
print sum                     # se imprime el valor de sum

# Se espera que sum tenga el valor 100000 * 10 = 1000000. Sin embargo, al todos los hilos acceder a la 
# misma variable (región de memoria) sin ningún tipo de control, se produce una condición de carrera.
# sum no obtendrá el valor esperado, sino un número que devendrá de la aleatoriedad en la que los hilos
# hayan accedido a la variable. La concurrencia provoca que algunos accesos sean casi paralelos y que 
# algunos hilos terminen antes que otros, corrompiendo el valor esperado.