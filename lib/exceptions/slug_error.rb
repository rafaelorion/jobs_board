module Exceptions
	class SlugError < StandardError
		attr_accessor :objeto

		def initialize(objeto)

			@objeto = objeto
	    end

	end
end