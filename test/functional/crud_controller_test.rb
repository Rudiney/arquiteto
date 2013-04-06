module CrudControllerTest
	
	def setup
		sign_in(current_user)
	end
	
	def test_CRUD_sem_sessao_nao_acessa
		sem_sessao_nao_acessa(:get, :index)
		sem_sessao_nao_acessa(:get, :new)
		sem_sessao_nao_acessa(:get, :show, id: objeto)
		sem_sessao_nao_acessa(:get, :edit, id: objeto)
		sem_sessao_nao_acessa(:post, :create, create_params)
		sem_sessao_nao_acessa(:post, :update, update_params)
	end	
	
	def test_CRUD_get_index
		get(:index)
		assert_response(:success)
		assert_not_nil(assigns(nome_plural))
		assert_equal(nome_plural.to_s, assigns(:menu_ativo))
	end
	
	def test_CRUD_get_new
		get(:new)
		assert_response(:success)
		assert(assigns(nome_singular).new_record?, " #{nome_singular} deveria ser um novo objeto")
	end
	
	def test_CRUD_criar_registro
		assert_difference("#{class_name}.count", +1) do
		  post(:create, create_params)
		end
		
		assert_redirected_to(assigns(nome_singular))
	end
	
	def test_CRUD_get_show
		get(:show, id: objeto)
		assert_response(:success)
	end
	
	def test_CRUD_get_edit
		get(:edit, id: objeto)
		assert_response(:success)
		assert_equal(objeto, assigns(nome_singular))
	end
	
	def test_CRUD_atualizar
		put(:update, update_params)
		assert_redirected_to(assigns(nome_singular))
	end
	
	def test_CRUD_destruir
		assert_difference("#{class_name}.count", -1) do
			delete(:destroy, id: objeto)
		end
		
		assert_redirected_to(send("#{nome_plural}_path"))
	end
end