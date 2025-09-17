# frozen_string_literal: true

# Represents an item in the shopping basket
class BasketItem
  attr_reader :product
  attr_accessor :quantity

  def initialize(product:, quantity: 1)
    @product = product
    @quantity = quantity
  end

  def total_price
    product.price * quantity
  end

  def ==(other)
    other.is_a?(BasketItem) && product == other.product && quantity == other.quantity
  end

  def eql?(other)
    self == other
  end

  def hash
    [product, quantity].hash
  end

  def to_s
    "#{product.name} x#{quantity} = $#{'%.2f' % total_price}"
  end
end
