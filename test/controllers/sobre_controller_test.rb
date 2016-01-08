require 'test_helper'

class SobreControllerTest < ActionController::TestCase
	def test_index_render
		get :index
		assert_equal assigns(:activePage), "sobre"
		assert_response 200
	end
end
