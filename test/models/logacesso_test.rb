require 'test_helper'

class LogacessoTest < ActiveSupport::TestCase
	setup do
		Logacesso.delete_all
	end
	def test_create
		Logacesso.create({guid: "017d68a9-4be1-4e25-928a-6b5d05ccb962", local: "http://localhost", datahora: Time.now})
		
		assert_equal Logacesso.where(guid: "017d68a9-4be1-4e25-928a-6b5d05ccb962").count, 1
	end
	
	def test_listar_ultimos_acessos_retornar_ate_50_registros
		assert_equal true, Logacesso.listar_ultimos_acessos(50).count <= 50
	end
end