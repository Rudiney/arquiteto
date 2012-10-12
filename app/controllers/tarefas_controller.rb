class TarefasController < ApplicationController
	before_filter :deve_escolher_um_produto
	
	def nova
		@historia = Historia.find(params[:historia_id])
		
		@tarefa = @historia.tarefas.new(params[:tarefa])
		
		if(@tarefa.save)		
			respond_to do |f|
				f.js{render('atualiza_tabela_tarefas')}
			end
		else
			render :text => :error
		end
	end
	
	def deleta
		@tarefa = Tarefa.find(params[:id])
		@historia = @tarefa.historia
		
		@tarefa.destroy
		
		respond_to{ |f| f.js{render('atualiza_tabela_tarefas')}}
	end
	
	def edita
		@tarefa = Tarefa.find(params[:id])

		respond_to{|f| f.js }
	end
	
	def atualiza
		@tarefa = Tarefa.find(params[:id])
		@historia = @tarefa.historia
		@tarefa.update_attributes(params[:tarefa])
		respond_to{ |f| f.js{render('atualiza_tabela_tarefas')}}
	end
end
