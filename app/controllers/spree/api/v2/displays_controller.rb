module Spree
  module Api
    module V2
      class DisplaysController < ::Spree::Api::V2::ResourceController
        before_action :load_vendor
        before_action :require_spree_current_user, :require_vendor_access, only: [:create, :update, :destroy]
        before_action :load_display, only: [:show, :update, :destroy]

        def index
          @displays = @vendor.displays.order(active: :desc)
          
          render_serialized_payload { serialize_resource(@displays) }
        end

        def show
          render_serialized_payload { serialize_resource(@display) }
        end

        def create
          @display = @vendor.displays.new(display_params)

          if @display.save
            render_serialized_payload { serialize_resource(@display) }
          else
            render_error_payload(@display.errors)
          end
        end

        def update
          if @display.update(display_params)
            render_serialized_payload { serialize_resource(@display) }
          else
            render_error_payload(display.errors)
          end
        end

        def destroy
          if @display.destroy
            render_serialized_payload { serialize_resource(display) }
          else
            render_error_payload(display.errors)
          end
        end

        private

        def load_display
          @display = @vendor.displays.find(params[:id])
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

        def load_vendor
          @vendor ||= Spree::Vendor.find(params[:vendor_id])
        end

        def require_vendor_access
          return if @vendor.users.include?(spree_current_user)

          render_error_payload('You do not have permission to access this vendor', 401)
        end
      end
    end
  end
end
