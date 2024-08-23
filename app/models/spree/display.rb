module Spree
  class Display < ActiveRecord::Base
    has_many :display_product
    has_many :product, through: :display_product, class_name: 'Spree::Product'

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
      when 'mobile'
        '360x640'
      else
        '800x600'
      end
    end
  end
end
