class LogacessoController < ApplicationController
	def index
		@rastrear = false
		@acessos = Logacesso.desc(:datahora).limit(50)
	end
	def salvar
		guid = params[:guid]
		local = params[:local]
		datahora = Time.now
		
		validar_parametros(guid, local)
		
		Logacesso.create({guid: guid, local: local, datahora: datahora})
		
		render :nothing => true
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
