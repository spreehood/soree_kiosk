module Spree
  module Api
    module V2
      class DisplayProductSerializer < BaseSerializer
        set_type :display_product

        attributes :id, :display_id, :video_url

        has_one :product, serializer: Spree::V2::Storefront::ProductSerializer

        attribute :qr_code_url do |object|
          Rails.application.routes.url_helpers.rails_blob_url(object.qr_code_image, only_path: true) if object.qr_code_image.attached?
        end
      end
    end
  end
end
