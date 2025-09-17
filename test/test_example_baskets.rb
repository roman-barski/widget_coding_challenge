require 'minitest/autorun'
require_relative '../lib/acme_widget_factory'

class TestExampleBaskets < Minitest::Test
  def setup
    @basket = AcmeWidgetFactory.create_basket
  end

  def test_basket_b01_g01
    @basket = AcmeWidgetFactory.create_basket
    @basket.add('B01')
    @basket.add('G01')
    
    # B01: $7.95 + G01: $24.95 = $32.90
    # Delivery: $4.95 (under $50)
    # Total: $32.90 + $4.95 = $37.85
    assert_equal 37.85, @basket.total
  end

  def test_basket_r01_r01
    @basket = AcmeWidgetFactory.create_basket
    @basket.add('R01')
    @basket.add('R01')
    
    # R01: $32.95 + R01: $32.95 = $65.90
    # Discount: $16.475 (half price for second R01)
    # Subtotal after discount: $49.425
    # Delivery: $4.95 (under $50)
    # Total: $49.425 + $4.95 = $54.375 ≈ $54.37
    assert_in_delta 54.37, @basket.total, 0.02
  end

  def test_basket_r01_g01
    @basket = AcmeWidgetFactory.create_basket
    @basket.add('R01')
    @basket.add('G01')
    
    # R01: $32.95 + G01: $24.95 = $57.90
    # No discount (only one R01)
    # Delivery: $2.95 (under $90)
    # Total: $57.90 + $2.95 = $60.85
    assert_equal 60.85, @basket.total
  end

  def test_basket_b01_b01_r01_r01_r01
    @basket = AcmeWidgetFactory.create_basket
    @basket.add('B01')
    @basket.add('B01')
    @basket.add('R01')
    @basket.add('R01')
    @basket.add('R01')
    
    # B01: $7.95 + B01: $7.95 + R01: $32.95 + R01: $32.95 + R01: $32.95 = $114.75
    # Discount: $16.475 (half price for second R01)
    # Subtotal after discount: $98.275
    # Delivery: $0.00 (over $90)
    # Total: $98.275 ≈ $98.27
    assert_in_delta 98.27, @basket.total, 0.02
  end
end
