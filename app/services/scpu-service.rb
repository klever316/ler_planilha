require 'net/http'
require 'json'

class SCPUService

    def self.Search(nome_parte)
        
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
        puts res.body 
        json = JSON.parse(res.body)        
        processos = Array.new
        json.each do |item|                 
          proc = item.slice("id", "numeroFormatado", "unidade", "situacao", "sistema", "flagSegredoJustica", "classeJudicial", "nomeMae", "assuntoPrincipal")
          processos << proc
        end        
        processos
    end
end