# frozen_string_literal: true

module Spree
  class DisplayProduct < ActiveRecord::Base
    belongs_to :display
    belongs_to :product

    after_save :append_to_products_array
    after_destroy :remove_from_products_array

    validates :display, presence: true

    scope :ordered_by_products_array, ->(products_array) {
      order_clause = products_array.map.with_index { |id, index| "id = #{id} DESC" }.join(", ")
      where(id: products_array).order(Arel.sql(order_clause))
    }

    private

    def append_to_products_array
      display.products_array.append(id) unless display.products_array.include?(id)
      display.save!
    end

    def remove_from_products_array
      display.products_array.delete(id) if display.products_array.include?(id)
      display.save!
    end

  end
end
