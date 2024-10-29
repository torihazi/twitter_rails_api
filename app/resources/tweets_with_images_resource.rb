# frozen_string_literal: true

class TweetsWithImagesResource < BaseResource
  root_key :tweet

  attributes :id, :content, :image_urls, :created_at

  one :user, resource: UserResource
end
