class Api::V1::TweetsController < ApplicationController
before_action :authenticate_api_v1_user!

  def index
    render json: {message: "成功", data: current_api_v1_user}, status: :ok
  end
end
