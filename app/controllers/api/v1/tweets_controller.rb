# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        render json: { message: '成功', data: current_api_v1_user }, status: :ok
      end
    end
  end
end
