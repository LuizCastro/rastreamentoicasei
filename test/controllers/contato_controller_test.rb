require 'test_helper'

class ContatoControllerTest < ActionController::TestCase
	setup do
		@request.headers['Accept'] = Mime::JSON
		@request.headers['Content-Type'] = Mime::JSON.to_s
		
		#inicia base para testes
		Contato.delete_all
		Contato.create({nome: "Evandro Passos", email: "evpassos@gmail.com", descricao: "testes"})
		
		@controller = ContatoController.new
	end
	
	def test_validar_parametros_nome_em_branco
		
		assert_raise ArgumentError do
			@controller.validar_campos("", "", "")
		end
	end
	
	def test_validar_parametros_email_em_branco

		assert_raise ArgumentError do
			@controller.validar_campos("evandro", "", "")
		end
	end
	
	def test_validar_parametros_descricao_em_branco

		assert_raise ArgumentError do
			@controller.validar_campos("evandro", "evpassos@gmail.com", "")
		end
	end
	
	def test_validar_parametros_email_existente

		assert_raise ArgumentError do
			@controller.validar_campos("evandro", "evpassos@gmail.com", "testes")
		end
	end
	
	def test_validar_parametros_sucesso

		assert_nothing_raised ArgumentError do
			@controller.validar_campos("ainne", "ainne.arlete@gmail.com", "sucesso de teste")
		end
	end
	
	def test_enviar_nome_em_branco
		post :enviar, {:nome => "", :email => "", :descricao => ""}
		body = JSON.parse(response.body)
		assert_response 400
		assert_equal "Nome não foi informado.", body["errorMessage"]
	end
	
	def test_enviar_email_em_branco
		post :enviar, {:nome => "evandro", :email => "", :descricao => ""}
		body = JSON.parse(response.body)
		assert_response 400
		assert_equal "E-mail não foi informado.", body["errorMessage"]
	end
	
	def test_enviar_descricao_em_branco
		post :enviar, {:nome => "evandro", :email => "evpassos@gmail.com", :descricao => ""}
		body = JSON.parse(response.body)
		assert_response 400
		assert_equal "Descrição não foi informada.", body["errorMessage"]
	end
	
	def test_enviar_email_existente
		post :enviar, {:nome => "Evandro", :email => "evpassos@gmail.com", :descricao => "testes"}, :format => "json"
		assert_response 400
		body = JSON.parse(response.body)
		assert_equal "E-mail já enviou contato.", body["errorMessage"]
	end
	
	def test_enviar_successo
		post :enviar, {:nome => "Ainne", :email => "ainne.arlete@gmail.com", :descricao => "testes"}, :format => "json"
		assert_response :success
	end
	
	def test_index_render
		@request.headers['Accept'] = Mime::HTML
		@request.headers['Content-Type'] = Mime::HTML.to_s
		
		get :index
		assert_equal assigns(:activePage), "contato"
		assert_response 200
	end
end
