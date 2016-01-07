class Contato
	include Mongoid::Document
	field :nome, type: String
	field :email, type: String
	field :descricao, type: String
end

