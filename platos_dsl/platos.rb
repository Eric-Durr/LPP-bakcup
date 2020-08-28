class Plato
    attr_accessor :nombre, :alimentos, :precios
	def initialize(nombre, &bloque_dsl)
		@nombre = nombre
		@alimentos = []
        @precios = {}

		if block_given?
			if bloque_dsl.arity == 1
				yield.self
			else
				instance_eval(&bloque_dsl)
			end
		end
	end
	
	def to_s
		salida = "\n\n" 
		salida << " #{@nombre} \n\n#{'-' * @nombre.size} \n\n"
		salida << "Alimentos:\n---------\n"
		@alimentos.each { |el| 
				salida << "#{el[:nom]}\n"
				salida << "Proteinas: #{el[:p]}g/100g\n" if el[:p]
				salida << "Carbohidratos: #{el[:c]}g/100g\n" if el[:c]
				salida << "Grasas: #{el[:l]}g/100g\n\n" if el[:l]
		}
		salida << "Precios:\n--------\n"
		salida << "Coste: #{@precios[:c] == nil ? 0.0 : @precios[:c]}€ " 
		salida <<  "| Venta: #{@precios[:v] == nil ? 0.0 : @precios[:v]}€"

		salida
	end

	def alimento(nombre, options = {})
		alimento = {}
		
		alimento[:nom] = nombre if nombre.empty? == false
		alimento[:nom] = "unnamed" if nombre.empty?
		alimento[:p] = options[:proteinas] if options[:proteinas]
		alimento[:c] = options[:carbohidratos] if options[:c]
		alimento[:l] = options[:grasas] if options[:grasas]
		
		@alimentos << alimento
  end
	
	def precios(options = {})
		@precios[:c] = options[:coste] if options[:coste]
		@precios[:v] = options[:venta] if options[:venta]
	end

end

big_chicken = Plato.new("Hamburguesa de pollo") do
    alimento "pan", :proteinas => 8.4 , :carbohidratos => 51.5, :grasas => 1.6
    alimento "pollo", :proteinas => 18 , :carbohidratos => 13.5, :grasas => 13
    alimento "pimiento", :proteinas => 1.2 , :carbohidratos => 3.8, :grasas => 0.2    
    alimento "tomate", :proteinas => 0.8 , :carbohidratos => 3.5, :grasas => 0.2
    alimento "lechuga", :proteinas => 1.3 , :carbohidratos => 1.4, :grasas => 0.6
    alimento "queso", :proteinas => 25.3 , :carbohidratos => 0.3, :grasas => 32.2
    alimento "mayonesa", :proteinas => 1.3 , :carbohidratos => 6, :grasas => 75.7

    precios :coste => 4.5, :venta => 6.75
end

puts big_chicken 