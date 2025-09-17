# frozen_string_literal: true

require_relative '../offer'

# Buy one get one half price offer
class BuyOneGetOneHalfPrice < Offer
  attr_reader :product_code, :discount_percentage

  def initialize(product_code:, discount_percentage: 50)
    @product_code = product_code
    @discount_percentage = discount_percentage
  end

  def apply(items)
    applicable_items = items.select { |item| item.product.code == product_code }
    return 0.0 if applicable_items.empty?

    # Calculate total quantity of applicable items
    total_quantity = applicable_items.sum(&:quantity)
    return 0.0 if total_quantity < 2

    # Calculate discount for every second item
    discounted_quantity = total_quantity / 2
    item_price = applicable_items.first.product.price
    discount_amount = discounted_quantity * item_price * (discount_percentage / 100.0)
    discount_amount.round(2)
  end

  def description
    "Buy one #{product_code}, get the second half price"
  end
end
