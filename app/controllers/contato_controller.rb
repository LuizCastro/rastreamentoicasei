class ContatoController < ApplicationController
	def index
		@activePage = "contato"
	end
	
	def enviar
		isError =  false
		errorMessage = ""
		begin
		nome = params[:nome]
		email = params[:email]
		descricao = params[:descricao]
		
		validar_campos(nome, email, descricao)
		
		rescue ArgumentError => detalhe
			isError = true
			errorMessage = detalhe.message
		end
		
		begin 
			Contato.create ({nome: nome, email: email, descricao: descricao})
		rescue ArgumentError
			isError = true
			errorMessage = "Ocorreu um erro interno, tente novamente."
		end

		render :json=> { :errorMessage => errorMessage }, :status => (isError ? 400 : 200)

	end
	
	def validar_campos(nome, email, descricao)
		if nome == nil || nome == ""
			raise ArgumentError, "Nome não foi informado."
		end
		
		if email == nil || email == ""
			raise ArgumentError, "E-mail não foi informado."
		end
		
		if(descricao == nil || descricao == "")
			raise ArgumentError, "Descrição não foi informada."
		end
		
		if Contato.email_existe?(email)
			raise ArgumentError, "E-mail já enviou contato."
		end
	end
end
