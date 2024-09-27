# frozen_string_literal: true

class Api::V1::Users::ConfirmationsController < Devise::ConfirmationsController
  include RackSessionFix
  respond_to :json

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    
        if resource.errors.empty?
          redirect_to "http://localhost:3000/auth?confirmation=success"
        else
          redirect_to "http://localhost:3000/auth?confirmation=failure"
        end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
