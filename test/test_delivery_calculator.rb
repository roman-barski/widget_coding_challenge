require 'minitest/autorun'
require_relative '../lib/delivery_calculator'

class TestDeliveryCalculator < Minitest::Test
  def setup
    @calculator = DeliveryCalculator.new
  end

  def test_free_delivery_over_90
    assert_equal 0.0, @calculator.calculate_delivery_cost(90.0)
    assert_equal 0.0, @calculator.calculate_delivery_cost(100.0)
  end

  def test_delivery_cost_50_to_89
    assert_equal 2.95, @calculator.calculate_delivery_cost(50.0)
    assert_equal 2.95, @calculator.calculate_delivery_cost(75.0)
    assert_equal 2.95, @calculator.calculate_delivery_cost(89.99)
  end

  def test_delivery_cost_under_50
    assert_equal 4.95, @calculator.calculate_delivery_cost(0.0)
    assert_equal 4.95, @calculator.calculate_delivery_cost(25.0)
    assert_equal 4.95, @calculator.calculate_delivery_cost(49.99)
  end
end
