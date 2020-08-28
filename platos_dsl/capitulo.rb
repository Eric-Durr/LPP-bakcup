# Este DSL (Domain Spacific Language) viene a representar un lenguaje de prograqmación en miniatura para generar objetos que sirvan de capítulos mutables para una historia

class Capitulo

    def initialize (numero, titulo, &block)
        @numero = numero
        @titulo = titulo
        @resumen = ""
        @personajes = []
        @escenas = []
        @notas = []
        @desarrollo = ""

        if block_given?
            if block.arity == 1
                yield
            else
                instance_eval(&block)
            end
        end
    end

    def to_s
        output = ""
        output <<  "Capítulo #{@numero} | #{@titulo} \n" 
        output <<  "#{'-' * (@numero.length + @titulo.length + 13)}\n\n"
        output <<  "#{@resumen}\n"
        output <<  "#{'=' * (@numero.length + @titulo.length + 13)}\n\n"
        output << "Hay #{personajes.length} personajes :" 
        output << "#{@personajes.map{|per| {per[:nom]}.join(', ')}} \n\n"
        output << "Las escenas del capítulo son #{@escenas.length}:\n"
        @escenas.each.with_index(1) do |escena, inx|
            output << "#{inx}) #{escena[:nom]}: #{escena[:des]}\n"
        end
    end

    def leer_notas
        output = ""
        @notas.each.with_index(1) do |nota, inx|
            output << "#{inx}) #{nota[:str]}"
        end  
        output
    end

    def borrar_nota(&block)
    end
    def insertar_nota(&block)
    end

    def aumentar_desarrollo(&block)
    end

    def borrar_desarrollo
        @desarrollo = ""
    end

    def resumen (texto)
        @resumen = texto
    end

    def personaje(nombre, options={})
        personaje = {}
        personaje[:nom] = nombre 
        options[:real] == "si" ? personaje[:r] = true : personaje[:r] = false
        personaje[:roll] = options[:roll] if options[:roll]
        
        @personajes << personaje
    end
    
    def escena(titulo, options={})
        escena = {}
        escena[:nom] = titulo 
        escena[:des] = options[:descripcion] if options[:descripcion]
        escena[:loc] = options[:localizacion] if options[:localizacion]
    end

    def nota(texto, options={})
        nota = texto
        @notas << nota
    end

end
