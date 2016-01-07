require 'test_helper'

class LogacessoControllerTest < ActionController::TestCase
	
	def test_validar_parametros_guid_invalido
		controller = LogacessoController.new
		assert_raise ArgumentError do
			controller.validar_parametros(:guid => nil, :local => "")
		end
	end
	
	def test_validar_parametros_local_invalido
		controller = LogacessoController.new
		assert_raise ArgumentError do
			controller.validar_parametros(:guid => "017d68a9-4be1-4e25-928a-6b5d05ccb962", :local => "")
		end
	end
	
	def test_validar_parametros_sucesso
		controller = LogacessoController.new
		assert_nothing_raised ArgumentError do
			controller.validar_parametros(:guid => "017d68a9-4be1-4e25-928a-6b5d05ccb962", :local => "http://localhost")
		end
	end
end
