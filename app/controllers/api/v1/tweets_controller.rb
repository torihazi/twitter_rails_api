# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include RackSessionFix
      before_action :authenticate_api_v1_user!

      def index
        tweets = Tweet.all
        render json: { message: '成功', data: tweets }, status: :ok
      end

      def create
        tweet = current_api_v1_user.tweets.build(tweet_params)
        if tweet.save
          attach_image(tweet) if params[:blob_ids].present?
          render json: { message: '投稿成功', data: tweet }, status: :created
        else
          render json: { message: '投稿失敗', error: tweet.errors }, status: :unprocessable_entity
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:content)
      end

      def attach_image(tweet)
        params[:blob_ids]&.each do |blob_id|
          tweet.images.attach(ActiveStorage::Blob.find_signed(blob_id))
        end
      end
    end
  end
end
