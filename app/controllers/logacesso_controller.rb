class LogacessoController < ApplicationController
	def index
		@rastrear = false
		@activePage = "acessos"
		@acessos = Logacesso.listar_ultimos_acessos(50)
	end
	def salvar
		isError =  false
		errorMessage = ""
		begin
		guid = params[:guid]
		local = params[:local]
		datahora = Time.now
		
		validar_parametros(guid, local)
		
		rescue ArgumentError => detalhe
			isError = true
			errorMessage = detalhe.message
		end
		
		begin 
			Logacesso.create({guid: guid, local: local, datahora: datahora})
		rescue ArgumentError 
			isError = true
			errorMessage = "Ocorreu um erro interno, tente novamente."
		end
		
		render :json=> { :errorMessage => errorMessage }, :status => (isError ? 400 : 200)
	end
	
	def validar_parametros(guid, local)
		if guid == nil || guid == ""
			raise ArgumentError, "Guid não pode ser vazio"
		end
		
		if local == nil || local == ""
			raise ArgumentError, "Local não pode ser vazio"
		end
	end
end
