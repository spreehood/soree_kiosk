# frozen_string_literal: true

module Spree
  class DisplayProduct < ActiveRecord::Base
    belongs_to :display
    belongs_to :product

    validates :display, presence: true

    scope :ordered_by_products_array, ->(products_array) {
      order_clause = products_array.map.with_index { |id, index| "id = #{id} DESC" }.join(", ")
      where(id: products_array).order(Arel.sql(order_clause))
    }
  end
end
