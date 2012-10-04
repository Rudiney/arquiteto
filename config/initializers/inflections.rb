# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )

	inflect.irregular 'historia', 'historias'
	inflect.irregular 'arquivo_fonte', 'arquivos_fonte'
	inflect.irregular 'tarefa_arquivo_fonte', 'tarefas_arquivos_fonte'
	inflect.irregular 'categoria_arquivo_fonte', 'categorias_arquivos_fonte'
end
