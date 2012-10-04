# encoding: UTF-8

require 'test_helper'

class NumeroEmHorasTest < ActiveSupport::TestCase

	test "horas" do
		24.times do |hora|
			assert_equal("#{hora}:00", hora.hours.em_horas)
		end
	end
	
	test "minutos" do
		60.times do |minuto|
			assert_equal("0:#{minuto.to_s.rjust(2,'0')}", minuto.minutes.em_horas)
		end		
	end
	
	test "horas e minutos" do
		70.times do |hora|
			60.times do |minuto|
				segundos = (hora.hour) + (minuto.minute)
				assert_equal("#{hora}:#{minuto.to_s.rjust(2,'0')}", segundos.em_horas)
			end
		end		
	end
	
	test "H:M -> s -> H:M" do
		['1:40','2:20','10:59','5:01','4:30','6:02','5:40','8:22'].each do |hora_formatada|
			assert_equal(hora_formatada, hora_formatada.em_segundos.em_horas)
		end
	end
end