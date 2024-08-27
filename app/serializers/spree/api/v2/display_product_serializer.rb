module Spree
  module Api
    module V2
      class DisplayProductSerializer < BaseSerializer
        set_type :display_product

        attributes :id, :display_id, :qr_code_url, :video_url

         has_one :product
      end
    end
  end
end
