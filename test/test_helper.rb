# encoding: UTF-8

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'functional/crud_controller_test'

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
	
	def escolhe_produto(p)
		@request.session[:produto_id] = p.id
	end

	def deve_ter_um_produto_escolhido_para_acessar_as_acoes(acoes)
		@request.session[:produto_id] = nil
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
	
	def sem_sessao_nao_acessa(method,action,params={})
		sign_out(current_user)
		send(method, action, params)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação #{action}")
	end
	
	def objeto
		raise "Preciso de um @objeto para testar" unless @objeto
		@objeto
	end
	
	def class_name
		objeto.class.name
	end
	
	def nome_plural
		@nome_plural ||= class_name.tableize.to_sym
	end
	
	def nome_singular
		@nome_singular ||= class_name.underscore.to_sym
	end
	
	def current_user
		users(:rudi)
	end
	
	def create_params
		{nome_singular =>  objeto.accessible_attributes}
	end
	
	def update_params
		{id: objeto, nome_singular => objeto.accessible_attributes}
	end
end

class ActionController::TestCase
  include Devise::TestHelpers
end