require 'net/http'
require 'json'

class SCPUService

    @@processos = Array.new

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
        json = JSON.parse(res.body)        
        @@processos = Array.new
        json.each do |item|                 
          proc = item.slice("id", "numeroFormatado", "unidade", "situacao", "sistema", "flagSegredoJustica", "classeJudicial", "nomeMae", "assuntoPrincipal")
          if(item["dataDistribuicao"] != nil)
            proc["dataDistribuicao"] = Time.at(item["dataDistribuicao"].to_f / 1000).strftime("%m/%d/%Y %T")
          end
          @@processos << proc
        end        
        @@processos
    end

    def self.Processos
      @@processos
    end

    def self.Remove(id)
      @@processos = @@processos.select{|proc| proc["id"] != id}      
    end
end