module Spree
  module Api
    module V2
      class DisplaySerializer < BaseSerializer
        attributes :id, :name, :screen_size, :orientation, :vendor_id, :display_type, :products_array, :active

        attribute :qr_code_url do |object|
          Rails.application.routes.url_helpers.rails_blob_url(object.qr_code_image, only_path: true) if object.qr_code_image.attached?
        end

        has_many :products, serializer: Spree::V2::Storefront::ProductSerializer
      end
    end
  end
end
