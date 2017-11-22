require 'scpu-service.rb'

class SearchController < ApplicationController

  def init
        
  end

  def index
    
  end

  def list    
    @processos = SCPUService.Processos()
  end

  def search
    puts params.inspect
    nome_parte = params["txtPesquisa"]
    poloFiltro = params["polo"]
    @processos = SCPUService.Search(nome_parte, poloFiltro)       
    redirect_to :search_doSearch
  end

  def destroy
    SCPUService.Remove(params["id"])    
    redirect_to :search_doSearch
  end

  
end
