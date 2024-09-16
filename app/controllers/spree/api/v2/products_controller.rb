# frozen_string_literal: true

module Spree
  module Api
    module V2
      class ProductsController < ::Spree::Api::V2::BaseController
        def index
          render_serialized_payload { serialize_resource(paginated_collection) }
        end

        private

        def collection
          Spree::Display.find(params[:display_id]).products
        end

        def paginated_collection
          collection_paginator.new(collection, params).call
        end

        def resource_serializer
          Spree::V2::Storefront::ProductSerializer
        end
      end
    end
  end
end
