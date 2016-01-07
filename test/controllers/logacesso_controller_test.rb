require 'test_helper'

class LogacessoControllerTest < ActionController::TestCase
	setup do
		@request.headers['Accept'] = Mime::JSON
		@request.headers['Content-Type'] = Mime::JSON.to_s
	end
	
	def test_validar_parametros_guid_invalido
		controller = LogacessoController.new
		assert_raise ArgumentError do
			controller.validar_parametros("", "")
		end
	end
	
	def test_validar_parametros_local_invalido
		controller = LogacessoController.new
		assert_raise ArgumentError do
			controller.validar_parametros("017d68a9-4be1-4e25-928a-6b5d05ccb962", "")
		end
	end
	
	def test_validar_parametros_sucesso
		controller = LogacessoController.new
		assert_nothing_raised do
			controller.validar_parametros("017d68a9-4be1-4e25-928a-6b5d05ccb962", "http://localhost")
		end
	end
	
	def test_salvar_guid_invalido
		post :salvar, {:guid => "", :local => ""}
		
		body = JSON.parse(response.body)
		
		assert_equal true, body["isError"]
	end
	
	def test_salvar_local_invalido
		
		post :salvar, {:guid => "017d68a9-4be1-4e25-928a-6b5d05ccb962", :local => ""}
		
		body = JSON.parse(response.body)
		
		assert_equal true, body["isError"]
	end
	
	def test_salvar_successo
		post :salvar, {:guid => "017d68a9-4be1-4e25-928a-6b5d05ccb962", :local => "http://localhost"}, :format => "json"
		assert_response :success
		
		body = JSON.parse(response.body)
		
		assert_equal false, body["isError"]
	end
end
