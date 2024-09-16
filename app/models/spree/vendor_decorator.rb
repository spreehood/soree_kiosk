# frozen_string_literal: true

module Spree
  module VendorDecorator
    def self.prepended(base)
      base.has_many :displays, class_name: 'Spree::Display'
    end
  end
end

Spree::Vendor.prepend Spree::VendorDecorator
