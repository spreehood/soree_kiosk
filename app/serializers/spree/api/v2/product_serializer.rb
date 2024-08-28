module Spree
    module Api
      module V2
        class ProductSerializer < BaseSerializer
          attributes :id, :name, :description, :price

          # Add any other attributes or associations as needed
        end
      end
    end
  end
  