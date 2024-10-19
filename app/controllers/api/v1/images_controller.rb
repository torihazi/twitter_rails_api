class Api::V1::ImagesController < ApplicationController
  include RackSessionFix

  before_action :authenticate_api_v1_user!

  def create
    blob_ids = generate_blob_and_signed_ids
    render json: {message: "",data: blob_ids}, status: :created
  end

  private
  def generate_blob_and_signed_ids
    blob_singned_ids = []
    params[:images]&.each do |image|
      blob = create_blob_and_upload(image)
      blob_singned_ids.push(blob.signed_id)
    end
    blob_singned_ids
  end

  def create_blob_and_upload(image)
    ActiveStorage::Blob.create_and_upload!(
      io: image,
      filename: image.original_filename,
      content_type: image.content_type
    )
  end
    
end
