require 'test_helper'

class LogacessoControllerTest < ActionController::TestCase
	setup do
		@request.headers['Accept'] = Mime::JSON
		@request.headers['Content-Type'] = Mime::JSON.to_s
		@controller = LogacessoController.new
	end
	
	def test_validar_parametros_guid_invalido

		assert_raise ArgumentError do
			@controller.validar_parametros("", "")
		end
	end
	
	def test_validar_parametros_local_invalido
		
		assert_raise ArgumentError do
			@controller.validar_parametros("017d68a9-4be1-4e25-928a-6b5d05ccb962", "")
		end
	end
	
	def test_validar_parametros_sucesso
		
		assert_nothing_raised do
			@controller.validar_parametros("017d68a9-4be1-4e25-928a-6b5d05ccb962", "http://localhost")
		end
	end
	
	def test_salvar_guid_invalido
		post :salvar, {:guid => "", :local => ""}
		assert_response 400
	end
	
	def test_salvar_local_invalido
		
		post :salvar, {:guid => "017d68a9-4be1-4e25-928a-6b5d05ccb962", :local => ""}
		assert_response 400
	
	end
	
	def test_salvar_successo
		post :salvar, {:guid => "017d68a9-4be1-4e25-928a-6b5d05ccb962", :local => "http://localhost"}, :format => "json"
		assert_response :success
	end
	
	def test_index_render
		
		@request.headers['Accept'] = Mime::HTML
		@request.headers['Content-Type'] = Mime::HTML.to_s
		
		get :index
		assert_response 200
		
		assert_not_nil assigns(:acessos)
		assert_equal assigns(:activePage), "acessos"
		assert_equal assigns(:rastrear), false
	end
end
