FactoryGirl.define do
	factory :indicador do
		nome 'indicador'
		tipo{ Indicador::TIPOS.values.sample }
	end
end