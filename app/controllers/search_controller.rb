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
    if(params["txtPesquisa"].delete(' ') == "")
      flash[:danger] = "Por favor forneça um nome"
      redirect_to :search_index
    else
      nome_parte = params["txtPesquisa"]
      poloFiltro = params["polo"]
      @processos = SCPUService.Search(nome_parte, poloFiltro)       
      redirect_to :search_doSearch
    end    
  end

  def destroy
    SCPUService.Remove(params["id"])    
    redirect_to :search_doSearch
  end

  
end
