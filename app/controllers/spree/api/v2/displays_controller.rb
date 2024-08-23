module Spree
  module Api
    module V2
      class DisplaysController < ::Spree::Api::V2::ResourceController
        before_action :load_display, only: [:show, :update, :destroy]
        before_action :require_spree_current_user

        def index
          @displays = Spree::Display.all
          render_serialized_payload { serialize_resource(@displays) }
        end

        def show
          render_serialized_payload { serialize_resource(@display) }
        end

        def create
          @display = Spree::Display.new(display_params)

          if @display.save
            render_serialized_payload { serialize_resource(@display) }
          else
            render_error_payload(@display.errors)
          end
        end

        def update
          display = Spree::Display.find(params[:id])
          
          if @display.update(display_params)
            render_serialized_payload { serialize_resource(@display) }
          else
            render_error_payload(display.errors)
          end
        end

        def destroy
          display = Spree::Display.find(params[:id])

          if display.destroy
            render_serialized_payload { serialize_resource(display) }
          else
            render_error_payload(display.errors)
          end
        end

        private

        def load_display
          @display = Spree::Display.find(params[:id])
        end

        def display_params
          params.require(:display).permit(permitted_display_attributes)
        end

        def permitted_display_attributes
          permitted_attributes.display_attributes
        end

        def resource_serializer
          Spree::Api::V2::DisplaySerializer
        end

        def collection_serializer
          Spree::Api::V2::DisplaySerializer
        end
      end
    end
  end
end
