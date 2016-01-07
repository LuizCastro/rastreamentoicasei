class Contato
	include Mongoid::Document
	field :nome, type: String
	field :email, type: String
	field :descricao, type: String
	
	def self.email_existe?(email)
		return Contato.where(email: email).count > 0
	end
end

