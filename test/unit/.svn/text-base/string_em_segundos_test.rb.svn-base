# encoding: UTF-8

require 'test_helper'

class StringEmSegundosTest < ActiveSupport::TestCase

	test "string com H" do
		10.times do |hora|
			segundos = hora *  1.hour
			assert_equal(segundos.to_i, "#{hora}H".em_segundos, "falhou ao converter a hora #{hora}H")
			assert_equal(segundos.to_i, "#{hora}h".em_segundos, "falhou ao converter a hora #{hora}h")
			
			9.times do |decimal|
				hora = hora + (decimal/10.0)
				segundos = hora *  1.hour
				assert_equal(segundos.to_i, "#{hora}h".em_segundos, "falhou ao converter a hora #{hora}h")
				assert_equal(segundos.to_i, "#{hora}H".em_segundos, "falhou ao converter a hora #{hora}H")
			end
		end
	end
	
	test "string sem H" do
		10.times do |hora|
			segundos = hora *  1.hour
			assert_equal(segundos.to_i, "#{hora}".em_segundos, "falhou ao converter a hora #{hora}")
			
			9.times do |decimal|
				hora = hora + (decimal/10.0)
				segundos = hora * 1.hour
				assert_equal(segundos.to_i, "#{hora}".em_segundos, "falhou ao converter a hora #{hora}")
			end
		end		
	end
	
	test "string com M" do
		10.times do |minuto|
			segundos = minuto * 1.minute
			assert_equal(segundos.to_i, "#{minuto}M".em_segundos, "falhou ao converter o minuto #{minuto}M")
			assert_equal(segundos.to_i, "#{minuto}m".em_segundos, "falhou ao converter o minuto #{minuto}m")
			
			9.times do |decimal|
				minuto = minuto + (decimal/10.0)
				segundos = minuto * 1.minute
				assert_equal(segundos.to_i, "#{minuto}M".em_segundos, "falhou ao converter o minuto #{minuto}M")
				assert_equal(segundos.to_i, "#{minuto}m".em_segundos, "falhou ao converter o minuto #{minuto}m")
			end
		end
	end
	
	test "string com H:M" do
		10.times do |hora|
			60.times do |minuto|
				segundos = (hora * 1.hour) + (minuto * 1.minute)
				str_minuto = minuto.to_s.rjust(2,'0')
				assert_equal(segundos.to_i, "#{hora}:#{str_minuto}".em_segundos, "falhou ao converter a string #{hora}:#{str_minuto}")
			end
		end
	end


	test "sortidos" do
		(1..5700).to_a.each do |minuto|
			assert_equal(minuto.minutes, minuto.minutes.em_horas.em_segundos)
		end
	end
end