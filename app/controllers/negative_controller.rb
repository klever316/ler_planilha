require './lib/pdf/generate_negative'
require 'cpf_cnpj_util.rb'

class NegativeController < ApplicationController

    def notValidToProccess        
        doc = params[:doc] == nil ? "" : DocumentUtils.Format(params[:doc])
        GeneratePdf::NegativeNotValid(params[:nome_parte], params[:polo], doc, current_user.username)
        redirect_to '/negative_not_valid.pdf'
    end

    def validToProccess

    end

    private
        def negative_params
            params.permit(:nome_parte, :polo)
        end
end