# frozen_string_literal: true

# Calculates delivery costs based on order total
class DeliveryCalculator
  DELIVERY_RULES = [
    { threshold: 90.0, cost: 0.0 },
    { threshold: 50.0, cost: 2.95 },
    { threshold: 0.0, cost: 4.95 }
  ].freeze

  def calculate_delivery_cost(order_total)
    rule = DELIVERY_RULES.find { |r| order_total >= r[:threshold] }
    rule[:cost]
  end
end
