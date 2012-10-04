# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120405135424) do

  create_table "arquivos_fonte", :force => true do |t|
    t.string   "caminho_completo", :null => false
    t.integer  "produto_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "arquivos_fonte", ["produto_id", "caminho_completo"], :name => "index_arquivos_fonte_on_projeto_id_and_caminho_completo", :unique => true

  create_table "categorias_arquivos_fonte", :force => true do |t|
    t.integer  "produto_id",               :null => false
    t.string   "nome",                     :null => false
    t.string   "string_expressao_regular", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funcionalidade_historias", :force => true do |t|
    t.integer  "funcionalidade_id", :null => false
    t.integer  "historia_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "funcionalidade_historias", ["funcionalidade_id", "historia_id"], :name => "indice_unico_pela_historia_funcionalidade", :unique => true

  create_table "funcionalidades", :force => true do |t|
    t.string   "nome",            :null => false
    t.integer  "produto_id",      :null => false
    t.string   "url_artigo_wiki"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "historia_anexos", :force => true do |t|
    t.integer  "historia_id",          :null => false
    t.string   "descricao"
    t.string   "arquivo_file_name"
    t.integer  "arquivo_file_size"
    t.string   "arquivo_content_type"
    t.datetime "arquivo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "historias", :force => true do |t|
    t.integer  "produto_id",                            :null => false
    t.string   "nome",                                  :null => false
    t.text     "descricao"
    t.integer  "prioridade"
    t.integer  "situacao",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "complexidade_negocio",   :default => 0, :null => false
    t.integer  "complexidade_interface", :default => 0, :null => false
    t.integer  "esforco",                :default => 0, :null => false
    t.integer  "risco",                  :default => 0, :null => false
    t.integer  "pacote_id"
  end

  add_index "historias", ["situacao", "prioridade"], :name => "index_historias_on_situacao_and_prioridade"

  create_table "pacotes", :force => true do |t|
    t.integer  "produto_id"
    t.string   "nome"
    t.text     "descricao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "produtos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_base_wiki"
    t.text     "descricao"
  end

  create_table "relacao_funcionalidades", :force => true do |t|
    t.integer  "funcionalidade_um_id",                :null => false
    t.integer  "funcionalidade_dois_id",              :null => false
    t.string   "relacao",                :limit => 5, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relacao_funcionalidades", ["funcionalidade_dois_id", "funcionalidade_um_id"], :name => "indice_entre_dois_e_um", :unique => true
  add_index "relacao_funcionalidades", ["funcionalidade_um_id", "funcionalidade_dois_id"], :name => "indice_entre_um_e_dois", :unique => true

  create_table "repositorios", :force => true do |t|
    t.integer  "produto_id",                              :null => false
    t.string   "endereco",                                :null => false
    t.integer  "ultima_revisao_importada", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repositorios", ["produto_id"], :name => "index_repositorios_on_projeto_id", :unique => true

  create_table "tarefas", :force => true do |t|
    t.integer  "historia_id",        :null => false
    t.string   "descricao",          :null => false
    t.integer  "segundos_estimados"
    t.integer  "segundos_reais"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tarefas_arquivos_fonte", :force => true do |t|
    t.integer  "tarefa_id",        :null => false
    t.integer  "arquivo_fonte_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tarefas_arquivos_fonte", ["tarefa_id", "arquivo_fonte_id"], :name => "index_tarefas_arquivos_fonte_on_tarefa_id_and_arquivo_fonte_id", :unique => true

  add_foreign_key "arquivos_fonte", "produtos", :name => "arquivos_fonte_projeto_id_fk", :dependent => :delete

  add_foreign_key "funcionalidade_historias", "funcionalidades", :name => "funcionalidade_historias_funcionalidade_id_fk", :dependent => :delete
  add_foreign_key "funcionalidade_historias", "historias", :name => "funcionalidade_historias_historia_id_fk", :dependent => :delete

  add_foreign_key "funcionalidades", "produtos", :name => "funcionalidades_projeto_id_fk", :dependent => :delete

  add_foreign_key "historias", "produtos", :name => "historias_projeto_id_fk"

  add_foreign_key "relacao_funcionalidades", "funcionalidades", :name => "relacao_funcionalidades_funcionalidade_dois_id_fk", :column => "funcionalidade_dois_id"
  add_foreign_key "relacao_funcionalidades", "funcionalidades", :name => "relacao_funcionalidades_funcionalidade_um_id_fk", :column => "funcionalidade_um_id"

  add_foreign_key "repositorios", "produtos", :name => "repositorios_projeto_id_fk", :dependent => :delete

  add_foreign_key "tarefas", "historias", :name => "tarefas_historia_id_fk", :dependent => :delete

  add_foreign_key "tarefas_arquivos_fonte", "arquivos_fonte", :name => "tarefas_arquivos_fonte_arquivo_fonte_id_fk", :dependent => :delete
  add_foreign_key "tarefas_arquivos_fonte", "tarefas", :name => "tarefas_arquivos_fonte_tarefa_id_fk", :dependent => :delete

end
