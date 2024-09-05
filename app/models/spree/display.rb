module Spree
  class Display < ActiveRecord::Base
    has_many :display_products
    has_many :products, through: :display_product, class_name: 'Spree::Product'
    belongs_to :vendor

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
  end
end
