# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        include RackSessionFix
        respond_to :json
        # before_action :configure_sign_up_params, only: [:create]
        # before_action :configure_account_update_params, only: [:update]

        # POST /resource
        def create
          build_resource(sign_up_params)
          resource.save
          if resource.persisted?
            if resource.active_for_authentication?
              sign_up(resource_name, resource)
              render json: { message: '認証メールを送信しました', data: resource }, status: :ok
            else
              render json: { message: '認証メールを確認してください', data: resource }, status: :ok
            end
          else
            Rails.logger.debug { "登録エラー: #{resource.errors.full_messages.join(',')}" }
            render json: { message: '登録エラーです。管理者に連絡してください' }, status: :unprocessable_entity
          end
        end

        # GET /resource/edit
        # def edit
        #   super
        # end

        # PUT /resource
        # def update
        #   super
        # end

        # DELETE /resource
        # def destroy
        #   super
        # end

        protected

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_sign_up_params
        #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
        # end

        def sign_up_params
          params.permit(:name, :email, :password, :birth)
        end

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_account_update_params
        #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
        # end

        # The path used after sign up.
        # def after_sign_up_path_for(resource)
        #   super(resource)
        # end

        # The path used after sign up for inactive accounts.
        # def after_inactive_sign_up_path_for(resource)
        #   super(resource)
        # end
      end
    end
  end
end
