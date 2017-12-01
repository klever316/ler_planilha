require 'scpu-service.rb'
require 'cpf_cnpj'

class SearchController < ApplicationController

  def init
        
  end

  def index
    
  end

  def list    
    @processos = SCPUService.Processos()
    @nome_parte = search_params[:nome_parte]
    @polo = search_params[:polo]
    @doc = search_params[:doc]
    @mother = search_params[:mother]
  end

  def search
    if(params["txtPesquisa"].delete(' ') == "")
      flash[:danger] = "Por favor forneça um nome"
      redirect_to :search_index
    else
      nome_parte = params["txtPesquisa"]
      poloFiltro = params["polo"]
      @processos = SCPUService.Search(nome_parte, poloFiltro)       
      redirect_to controller: 'search', action:'list', nome_parte: nome_parte, polo: poloFiltro, doc: params["doc"], mother: params["mother"]
    end    
  end

  def destroy
    puts params.inspect
    SCPUService.Remove(params["numero"])    
    redirect_to :search_doSearch
  end

  private

    def search_params
      params.permit(:txtPesquisa, :nome_parte, :polo, :area, :doc, :mother)
    end

  
end
