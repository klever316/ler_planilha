require 'net/http'
require 'json'
require 'scpu-service.rb'

class SearchController < ApplicationController

  def init
        
  end

  def index
    
  end

  def list    
    @processos = session[:processos]
  end

  def search
    nome_parte = params.permit(:txtPesquisa)["txtPesquisa"]
    @processos = SCPUService.Search(nome_parte)      
    session[:processos] = @processos
    redirect_to :search_doSearch
  end

  def destroy
    puts params.inspect
    @processos = session[:processos]
    session[:processos] = @processos.select{|proc| proc["id"] != params["id"]}
    redirect_to :search_doSearch
  end

  
end
