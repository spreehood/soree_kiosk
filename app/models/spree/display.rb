module Spree
  class Display < ActiveRecord::Base
    require 'rqrcode'
    has_many :display_products
    has_many :products, through: :display_products, class_name: 'Spree::Product'
    belongs_to :vendor

    has_one_attached :qr_code_image

    after_save :generate_qr_code

    before_validation :set_default_screen_size

    validates :name, presence: true
    validates :orientation, presence: true

    private

    def set_default_screen_size
      if screen_size.blank?
        self.screen_size = default_screen_size
      end
    end

    def default_screen_size
      case display_type
      when 'kiosk'
        '65x65'
      when 'bag'
        '21x21'
      else
        '800x600'
      end
    end

    def generate_qr_code
      return if qr_code_image.attached? || ENV['STOREFRONT_URL'].blank?

      display_storefront_url = "#{ENV['STOREFRONT_URL']}/displays/#{id}"

      qrcode = RQRCode::QRCode.new(display_storefront_url)

      png = qrcode.as_png(size: 300)

      io = StringIO.new(png.to_s)
      qr_code_image.attach(io: io, filename: "qr_display_#{id}.png", content_type: 'image/png')

      public_url = Rails.application.routes.url_helpers.rails_blob_path(qr_code_image, only_path: true)

      update(qr_code_url: public_url)
    end
  end
end
