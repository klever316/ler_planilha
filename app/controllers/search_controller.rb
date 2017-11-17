require 'net/http'
require 'json'

class SearchController < ApplicationController

  def init
    
  end

  def index
  end

  def search
    nome_parte = params.permit(:txtPesquisa)["txtPesquisa"]    
    uri = URI('http://consultaprocesso.tjce.jus.br/scpu-web/api/consulta/nomeParte/')
    data = { 
      nomeParte: nome_parte, 
      criterioConsulta: 2,
      primeiroRegistro: 0,
      quantidadeRegistros: 50
    }
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, {"Content-Type" => "application/json", "Accept" => "application/json"})
    request.body = data.to_json

    res = http.request(request)    
    json = JSON.parse(res.body)
    processos = Array.new
    json.each do |item|
      puts item.inspect
      proc = item.slice("numeroFormatado", "unidade", "situacao", "sistema", "flagSegredoJustica", "classeJudicial")
      processos << proc
    end

    head :no_content
  end
end
