require 'prawn'
require 'time'

module GeneratePdf
    PDF_OPTIONS = {
        # Escolhe o Page size como uma folha A4
        :page_size => "A4",
        # Define o formato do layout como portrait (poderia ser landscape)
        :page_layout => :portrait,
        # Define a margem do documento
        :margin => [40, 75]
    }

    def self.header(pdf)
        logo = "#{Rails.root}/app/assets/images/logo.png"
        pdf.image logo, :position => :center, :fit => [43, 57]

        pdf.move_down 5
        pdf.font "Times-Roman"
        pdf.text "ESTADO DO CEARÁ", :align => :center, :style => :bold, :size => 12
        pdf.text "PODER JUDICIÁRIO", :align => :center, :style => :bold, :size => 12
        pdf.text "COMARCA DE FORTALEZA", :align => :center, :style => :bold, :size => 12
        pdf.text "SEÇÃO DE CERTIDÕES", :align => :center, :style => :bold, :size => 12

        pdf.move_down 30
    end

    def self.NegativeNotValid(nome_parte, polo, doc)
        # Apenas uma string aleatório para termos um corpo de texto pro contrato
        certifico = "<b>CERTIFICO</b>, em virtude da faculdade que me é conferida por lei e a requerimento da parte interessada, que consultando nos Sistemas Informatizados do Serviço de Distribuição desta Comarca, <b>DESDE 1º DE AGOSTO DE 1994, ATÉ A PRESENTE DATA, em relação ao(s) Polo</b>(s) <b>[polo], dos processos de Natureza Cível, EM TRÂMITE, distribuídos aos Juízos Cíveis, de Execuções Fiscais, de Recuperação de Empresas e Falências, da Fazenda Pública, de Registros Públicos, de Família, de Sucessões, da Justiça Militar e Juizados Especiais Cíveis,</b> verifiquei <b>NADA CONSTAR</b>, em nome de <b>[nome]</b>"
        certifico2 = "<b>CERTIFICO</b>, ainda, que a supracitada consulta baseia-se nas classes e assuntos definidos nas Tabelas Processuais Unificadas do Poder Judiciário, instituídas pela Resolução CNJ nº. 46/2007, <b>exceto aqueles protegidos por Segredo de Justiça</b>, na forma do Art. 189 da Lei nº. 13.105/2015, <b>os quais, só serão informados nas certidões destinadas à instrução processual.</b>"
        certifico3 = "<b>CERTIFICO</b>, finalmente, que esta certidão só é <b>válida por 30 (trinta) dias</b>, a contar da data de sua emissão, <b>sem rasuras ou emendas, com assinatura do Agente Público responsável e Selo de Autenticidade.</b>"
     
        certifico.sub! "[nome]", nome_parte.upcase

        if(polo == "Todos")
            certifico.sub! "[polo]", "ATIVOU OU PASSIVO"
        else
            certico.sub! "[polo]", polo.upcase
        end

        if(doc != nil && doc != "")
            if(doc.length == 14)
                certifico += ", <b>CPF nº. " + doc + " ."
            else
                certifico += ", <b>CNPJ nº. " + doc + " ."
            end
        else
            certifico += "."
        end
        
        Prawn::Document.new(PDF_OPTIONS) do |pdf|

            pdf.font_families.update("Times New Roman" => {
                :normal => "#{Rails.root}/app/assets/fonts/Times New Roman.ttf",
                :bold => "#{Rails.root}/app/assets/fonts/TIMESBD.TTF"
            })
            self.header(pdf)

            pdf.font "Times-Roman"
            pdf.text "<u>CERTIDÃO DE DISTRIBUIÇÃO CÍVEL</u>", :align => :center, :style => :bold, :size => 12, :inline_format => true

            pdf.move_down 15
            pdf.text "NÃO É VALIDA PARA INSTRUÇÃO PROCESSUAL", :align => :center, :style => :bold, :size => 12

            pdf.move_down 30
            pdf.font "Times New Roman"
            pdf.text certifico, :align => :justify, :size => 12, :indent_paragraphs => 57, :inline_format => true

            pdf.move_down 15
            pdf.text certifico2, :align => :justify, :size => 12, :indent_paragraphs => 57, :inline_format => true

            pdf.move_down 15
            pdf.text certifico3, :align => :justify, :size => 12, :indent_paragraphs => 57, :inline_format => true

            now = Time.current
            data = "Fortaleza, " + now.strftime("%d/%m/%Y ás %H:%M")
            pdf.move_down 15
            pdf.text "O referido é verdade e dou fé.", :align => :justify, :size => 12, :indent_paragraphs => 57, :inline_format => true
            pdf.text data, :align => :justify, :size => 12, :indent_paragraphs => 57, :inline_format => true
            pdf.text "Usuário.", :align => :justify, :size => 12, :indent_paragraphs => 57, :inline_format => true
        #   # Define a cor do traçado
        #   pdf.fill_color "666666"
        #   # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
        #   pdf.text "Agreement", :size => 32, :style => :bold, :align => :center
        #   # Move 80 PDF points para baixo o cursor
        #   pdf.move_down 80
        #   # Escreve o texto do contrato com o tamanho de 14 PDF points, com o alinhamento justify
        #   pdf.text "#{lorem_ipsum}", :size => 12, :align => :justify, :inline_format => true
        #   # Move mais 30 PDF points para baixo o cursor
        #   pdf.move_down 30
        #   # Escreve o texto com os detalhes que o usuário entrou
        #   pdf.text "Maaah oeeeeh!", :size => 12, :align => :justify, :inline_format => true
        #   # Move mais 30 PDF points para baixo o cursor
        #   pdf.move_down 10         
          
          # Gera no nosso PDF e coloca na pasta public com o nome agreement.pdf
          pdf.render_file('public/negative_not_valid.pdf')
        end
    end
end