module Spree
  module Api
    module V2
      class DisplaySerializer < BaseSerializer
        attributes :id, :name, :screen_size, :orientation, :display_type, :products_array, :active
      end
    end
  end
end
