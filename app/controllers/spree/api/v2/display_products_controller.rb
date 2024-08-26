# frozen_string_literal: true

module Spree
  module Api
    module V2
      class DisplayProductsController < Spree::Api::V2::ResourceController
        before_action :require_spree_current_user
        before_action :load_display

        def index
          render_serialized_payload { serialize_resource(collection) }
        end

        def create
          display_product = @display.display_products.new(display_product_params)

          if display_product.save
            render_serialized_payload { serialize_resource(display_product) }
          else
            render_error_payload(display_product.errors)
          end
        end

        def update
          display_product = @display.display_products.find(params[:id])

          if display_product.update(display_product_params)
            render_serialized_payload { serialize_resource(display_product) }
          else
            render_error_payload(display_product.errors)
          end
        end

        def destroy
          display_product = @display.display_products.find(params[:id])

          if display_product.destroy
            render_serialized_payload { serialize_resource(display_product) }
          else
            render_error_payload(display_product.errors)
          end
        end

        private

        def collection
          @collection ||= @display.display_products.ordered_by_products_array(@display.products_array)
        end

        def resource_serializer
          Spree::Api::V2::DisplayProductSerializer
        end

        def collection_serializer
          Spree::Api::V2::DisplayProductSerializer
        end

        def load_display
          @display = Spree::Display.find(params[:display_id])
        end

        def display_product_params
          params.require(:display_product).permit(:product_id, :qr_code_url, :video_url)
        end
      end
    end
  end
end
