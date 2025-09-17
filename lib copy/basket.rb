# frozen_string_literal: true

require_relative 'basket_item'
require_relative 'delivery_calculator'

# Main shopping basket class
class Basket
  attr_reader :catalog, :delivery_calculator, :offers, :items

  def initialize(catalog:, delivery_calculator: DeliveryCalculator.new, offers: [])
    @catalog = catalog
    @delivery_calculator = delivery_calculator
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = catalog.find_by_code(product_code)
    raise ArgumentError, "Product with code '#{product_code}' not found" unless product

    existing_item = find_item_by_code(product_code)
    if existing_item
      existing_item.quantity += 1
    else
      items << BasketItem.new(product: product)
    end
  end

  def total
    subtotal = calculate_subtotal
    discount = calculate_discount
    delivery_cost = delivery_calculator.calculate_delivery_cost(subtotal - discount)
    
    (subtotal - discount + delivery_cost).round(2)
  end

  def subtotal
    calculate_subtotal.round(2)
  end

  def discount
    calculate_discount.round(2)
  end

  def delivery_cost
    delivery_calculator.calculate_delivery_cost(subtotal - discount)
  end

  def empty?
    items.empty?
  end

  def size
    items.sum(&:quantity)
  end

  private

  def find_item_by_code(product_code)
    items.find { |item| item.product.code == product_code }
  end

  def calculate_subtotal
    items.sum(&:total_price)
  end

  def calculate_discount
    offers.sum { |offer| offer.apply(items) }
  end
end
