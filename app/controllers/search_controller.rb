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
    nome_parte = params.permit(:txtPesquisa)["txtPesquisa"]
    @processos = SCPUService.Search(nome_parte)       
    redirect_to :search_doSearch
  end

  def destroy
    SCPUService.Remove(params["id"])    
    redirect_to :search_doSearch
  end

  
end
