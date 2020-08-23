my_mutex = Mutex.new                                                   # Se crea un objeto Mutex (controlar el acceso)
cv = ConditionVariable.new                                          # Se crea un objeto CV (evitar deadlocks)
a = Thread.new {                                                    # Se crea un objeto hilo de bloque:
    my_mutex.synchronize {                                             # Bajo sincronización del objeto mutex
		print "A: Esta en una region critica, esperando por cv\n"      # se imprime por pantalla el mensaje
		cv.wait(my_mutex)                                              # la CV espera a una señal producida por el mutex
		print "A: Esta en la region critica de nuevo!. Sigue\n"        # tras la espera se imprime por pantalla otro mensaje
        cv.signal
    }
}
print "En medio\n"                                                  # se imprime en el hilo principal 
b = Thread.new {                                                    # Se crea otro objeto hilo "b" con el bloque:
	my_mutex.synchronize {                                             # Bajo el control del mismo mutex anterior
    cv.signal                                                      # se emite la señal a la cv para activar el segundo mensaje de A
	
    puts "B: Esta en la region critica pero tiene a cv"            # se imprie el primer mensaje de b
		puts "B: Esta en la region critica, Saliendo"                  # se imprime el segundo mensaje de b
    	
    }
}
a.join                                                              # ::join, invocado en ambos Threads, asegurará que se termine 
b.join                                                              # la ejecución de ambos aunque el hilo principal termine antes
print "Al final del hilo principal\n"

# LA SALIDA DEL PROGRAMA SERÁ:
    #"En medio\n"
    #"A: Esta en una region critica, esperando por cv\n"
    #"B: Esta en la region critica pero tiene a cv"
    #"B: Esta en la region critica, Saliendo"
    #"A: Esta en la region critica de nuevo!. Sigue\n"
    #"Al final del hilo principal\n"

# La secuencia de mensajes toma la forma que tiene debido a la restricción de la zona crítica provocada por la CV.
# El hilo 'a' no continuará su ejecución hasta que 'b' termine. De esto deducimos que no importa donde esté colocada
# la instrucción "cv.signal" dentro del hilo 'b', continuará en el último "cv.wait(mutex)" al terminar la ejecución 
# del hilo 'b'. 
# Los mesajes del hilo principal tienen la forma que se presenta debido a dos factores:
# - "En medio" es el primer mensaje por ser el hilo principal el primero en la lista de ejecución.
# - "Al final" es el último mensaje por estar tras los ::join de los hilos 'a' y 'b'.