module Spree
  module PermittedAttributes
    ATTRIBUTES += %i[display_attributes]
    mattr_reader *ATTRIBUTES

    @@display_attributes = [:name, :screen_size, :orientation, :display_type, products_array: []]
  end
end
