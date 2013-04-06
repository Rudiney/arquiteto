require 'test_helper'

class ProjetosControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		sign_in(current_user)
		escolhe_produto(produtos(:um))
		@objeto = FactoryGirl.create(:projeto)
	end
end
