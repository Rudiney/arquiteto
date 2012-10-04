# encoding: UTF-8

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

	# este comando é necessário quando o rails não encontra a classe relacionada a fixture
	# utilizando somente o nome do arquivo.
	# o erro gerado é No class attached to find
	set_fixture_class :relacao_funcionalidades => "RelacaoFuncionalidades"

	# Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
	#
	# Note: You'll currently still have to declare fixtures explicitly in integration tests
	# -- they do not yet inherit this setting
	fixtures :all

	# Add more helper methods to be used by all tests here...
	
	def deve_ter_um_produto_escolhido_para_acessar_as_acoes(acoes)
		acoes.each do |acao|
			get(acao)
			assert_redirected_to('/escolha_um_produto',"Não deve ser possível acessar a ação #{acao} sem um produto escolhido")
		end
	end
	
	def valida_campos_obrigatorios(registro,*campos)
		campos.each do |campo|
			valor_antigo = registro.send(campo)
			registro.send("#{campo}=",nil)
			assert(!registro.save, "não deveria salvar com o campo #{campo} em branco!")
			registro.send("#{campo}=",valor_antigo)
		end		
	end
end
