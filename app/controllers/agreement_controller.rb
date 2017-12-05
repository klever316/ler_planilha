require './lib/pdf/generate_negative'
require 'cpf_cnpj_util.rb'

class AgreementController < ApplicationController

    def notValidToProccess        
        doc = params[:doc] == nil ? "" : DocumentUtils.Format(params[:doc])
        GeneratePdf::NegativeNotValid(params[:nome_parte], params[:polo], doc, current_user.username)
        redirect_to '/negative_not_valid.pdf'
    end

    def validToProccess        
        puts params.inspect
        doc = params[:doc] == nil ? "" : DocumentUtils.Format(params[:doc])
        GeneratePdf::NegativeValid(params[:nome_parte], params[:polo], doc, current_user.username, params[:mother])
        redirect_to '/negative_valid.pdf'
    end

    def make
        ag_params = agreements_param
        ag_params["username"] = current_user.username
        if(ag_params["area"] == "civel")
            GeneratePdf::Civel(ag_params)
        else
            GeneratePdf::Crime(ag_params)
        end
        redirect_to '/agreement.pdf'
    end

    private
        def agreements_param
            params.permit(:nome_parte, :polo, :mother, :doc, :goal, :area, :type)
        end
end