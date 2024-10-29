# frozen_string_literal: true

class Tweet < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many_attached :images

  def image_urls
    images.map { |image| url_for(image) } if images.attached?
  end
end
