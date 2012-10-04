# encoding: UTF-8

require 'test_helper'

class ArrayRandomTest < ActiveSupport::TestCase

	test "random do array" do
		array = [1,2,3,4,5,6,7,8,9,0,"zero","um","dois","três","quatro","cinco","seis","sete","oito","nove"]
		
		200.times do
			random = array.random
			assert(array.include?(random))
		end
	end

end