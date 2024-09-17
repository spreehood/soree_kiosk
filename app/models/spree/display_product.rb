# frozen_string_literal: true

module Spree
  class DisplayProduct < ActiveRecord::Base
    include Spree::Core::Engine.routes.url_helpers
    require 'rqrcode'

    belongs_to :display
    belongs_to :product

    has_one_attached :qr_code_image

    after_save :append_to_products_array
    after_save :generate_qr_code
    after_destroy :remove_from_products_array

    validates :display, presence: true

    scope :ordered_by_products_array, ->(products_array) {
      order_clause = products_array.map.with_index { |id, index| "id = #{id} DESC" }.join(", ")
      where(id: products_array).order(Arel.sql(order_clause))
    }

    private

    def append_to_products_array
      return if display.products_array.include?(id)

      display.products_array.append(id) 
      display.save!
    end

    def remove_from_products_array
      return if !display.products_array.include?(id)

      display.products_array.delete(id)
      display.save!
    end


    def generate_qr_code
      return if qr_code_image.attached?

      product_storefront_url = if ENV['STOREFRONT_URL']
                                "#{ENV['STOREFRONT_URL']}/products/#{product.slug}?display_id=#{display.id}"
                              else
                                product_url(product.slug, host: Rails.application.routes.default_url_options[:host], display_id: display.id)
                              end

      qrcode = RQRCode::QRCode.new(product_storefront_url)
      png = qrcode.as_png(size: 300)

      io = StringIO.new(png.to_s)
      qr_code_image.attach(io: io, filename: "qr_product_#{id}.png", content_type: 'image/png')
    end
  end
end
