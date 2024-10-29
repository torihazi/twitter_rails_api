# frozen_string_literal: true

class UserResource < BaseResource
  root_key :user

  attributes :id, :name, :email
end
