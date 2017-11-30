require 'net/http'
require 'json'

class SCPUService

    @@processos = Array.new

    def self.Search(nome_parte, poloFiltro)
        
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
          if(item["dataDistribuicao"] != nil)
            item["dataDistribuicao"] = Time.at(item["dataDistribuicao"].to_f / 1000).strftime("%d/%m/%Y %H:%M")
          end

          if item["partes"].length > 0
            p = item["partes"].select { |parte| parte["nome"].downcase == nome_parte.downcase }.first            
            item["tipoParte"] = p["tipoParte"]
          end

          if(poloFiltro == "Todos")
            @@processos << item
          else
            if(item["partes"].any? { |parte| parte["nome"].downcase == nome_parte.downcase && parte["tipoPolo"].downcase == poloFiltro.downcase } || item["flagSegredoJustica"] == "S")
              @@processos << item              
            end
          end

        end      
    end

    def self.Processos
      @@processos
    end

    def self.Remove(id)
      @@processos = @@processos.select{|proc| proc["id"] != id}      
    end
end