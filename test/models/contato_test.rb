require 'test_helper'

class ContatoTest < ActiveSupport::TestCase
	setup do
		Contato.delete_all
	end
	def test_create
		Contato.create({nome: "evandro", email: "evpassos@gmail.com", descricao: "descricao"})
		
		assert_equal Contato.where(email: "evpassos@gmail.com").count, 1
	end
	
	def test_email_existe_passando_email_inexistente
		assert_equal false, Contato.email_existe?("ainne.arlete@gmail.com")
	end
	
	def test_email_existe_passando_email_existente
		assert_equal false, Contato.email_existe?("evpassos@gmail.com")
	end
end