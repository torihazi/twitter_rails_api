# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include RackSessionFix
      before_action :authenticate_api_v1_user!
      before_action :set_tweet, only: [:show]

      def index
        tweets = Tweet
                 .preload(:user)
                 .with_attached_images
                 .order(created_at: 'DESC')
                 .limit(params.fetch(:limit, 0))
                 .offset(params.fetch(:offset, 0))
        render json: { message: '', data: TweetsWithImagesResource.new(tweets), meta: Tweet.count }
      end

      def show
        render json: { message: '', data: TweetsWithImagesResource.new(@tweet) }
      end

      def create
        tweet = current_api_v1_user.tweets.build(tweet_params)
        if tweet.save
          attach_image(tweet) if params[:blob_ids].present?
          render json: { message: 'Post Success', data: TweetsWithImagesResource.new(tweet) }, status: :created
        else
          render json: { message: 'Post Fail', error: tweet.errors }, status: :unprocessable_entity
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

      def set_tweet
        @tweet = Tweet.find(params[:id])
      end
    end
  end
end
