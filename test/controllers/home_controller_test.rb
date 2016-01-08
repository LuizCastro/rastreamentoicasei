require 'test_helper'

class HomeControllerTest < ActionController::TestCase
	def test_index_render
		get :index
		assert_equal assigns(:activePage), "home"
		assert_response 200
	end
end
