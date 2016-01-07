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
		
		Contato.create ({nome: nome, email: email, descricao: descricao})
		
		rescue ArgumentError => detalhe
			isError = true
			errorMessage = detalhe.message
		end
		
		render :json=> { :isError => isError, :errorMessage => errorMessage }
	end
	
	private
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
		
		if Contato.where(email: email).count > 0
			raise ArgumentError, "E-mail já enviou contato."
		end
	end
end
