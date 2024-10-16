# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        render json: { message: '成功', data: current_api_v1_user }, status: :ok
      end

      def create
        tweet = current_api_v1_user.tweets.build(tweet_params)
        if tweet.save
          render json: {message: '投稿成功', data: tweet}, status: :created
        else
          render json: {message: '投稿失敗', error: tweet.errors}, status: :unprocessable_entity
        end
      end

      private
  
      def tweet_params
        params.require(:tweet).permit(:content)
      end

    end


  end
end
