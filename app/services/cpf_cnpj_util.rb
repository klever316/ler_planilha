require 'cpf_cnpj'

class DocumentUtils

    def self.Format(document)

        if(document.length == 11)
            cpf = CPF.new(document)
            cpf.formatted
        else
            cnpj = CNPJ.new(document)
            cnpj.formatted
        end
    end
end