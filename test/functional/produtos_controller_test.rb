require 'test_helper'

class ProdutosControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		sign_in(current_user)
		@objeto = @produto = produtos(:um)
		#nao escolhe um produto
	end
end
