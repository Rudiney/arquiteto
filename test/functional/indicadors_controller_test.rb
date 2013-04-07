# encoding: UTF-8

require 'test_helper'

class IndicadorsControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		sign_in(current_user)
		escolhe_produto(produtos(:um))
		@objeto = FactoryGirl.create(:indicador)
	end
end
