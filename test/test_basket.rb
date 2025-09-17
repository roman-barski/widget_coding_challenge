require 'minitest/autorun'
require_relative '../lib/product'
require_relative '../lib/product_catalog'
require_relative '../lib/basket'
require_relative '../lib/offers/buy_one_get_one_half_price'

class TestBasket < Minitest::Test
  def setup
    @products = [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    ]
    @catalog = ProductCatalog.new(@products)
    @offers = [BuyOneGetOneHalfPrice.new(product_code: 'R01')]
    @basket = Basket.new(catalog: @catalog, offers: @offers)
  end

  def test_initialization
    assert_equal @catalog, @basket.catalog
    assert_equal @offers, @basket.offers
    assert @basket.empty?
    assert_equal 0, @basket.size
  end

  def test_add_product
    @basket.add('R01')
    
    refute @basket.empty?
    assert_equal 1, @basket.size
    assert_equal 1, @basket.items.length
    assert_equal 'R01', @basket.items.first.product.code
  end

  def test_add_same_product_twice
    @basket.add('R01')
    @basket.add('R01')
    
    assert_equal 1, @basket.items.length
    assert_equal 2, @basket.items.first.quantity
    assert_equal 2, @basket.size
  end

  def test_add_invalid_product
    assert_raises(ArgumentError) do
      @basket.add('INVALID')
    end
  end

  def test_total_without_offers
    basket = Basket.new(catalog: @catalog) # No offers
    basket.add('B01')
    basket.add('G01')
    
    # B01: $7.95 + G01: $24.95 = $32.90
    # Delivery: $4.95 (under $50)
    # Total: $32.90 + $4.95 = $37.85
    assert_equal 37.85, basket.total
  end

  def test_total_with_red_widget_offer
    @basket.add('R01')
    @basket.add('R01')
    
    # R01: $32.95 + R01: $32.95 = $65.90
    # Discount: $16.475 (half price for second R01)
    # Subtotal after discount: $49.425
    # Delivery: $4.95 (under $50)
    # Total: $49.425 + $4.95 = $54.375 ≈ $54.37
    assert_in_delta 54.37, @basket.total, 0.02
  end

  def test_subtotal
    @basket.add('B01')
    @basket.add('G01')
    
    expected_subtotal = 7.95 + 24.95
    assert_equal expected_subtotal, @basket.subtotal
  end

  def test_discount
    @basket.add('R01')
    @basket.add('R01')
    
    expected_discount = (32.95 * 0.5).round(2)
    assert_equal expected_discount, @basket.discount
  end

  def test_delivery_cost
    @basket.add('B01')
    @basket.add('G01')
    
    # Subtotal: $32.90, no discount
    # Delivery cost for under $50: $4.95
    assert_equal 4.95, @basket.delivery_cost
  end

  def test_delivery_cost_free
    @basket.add('R01')
    @basket.add('R01')
    @basket.add('R01')
    
    # Subtotal: $98.85, discount: $16.475
    # After discount: $82.375
    # Still under $90, so delivery: $2.95
    # Let's add more to get free delivery
    @basket.add('B01')
    
    # Subtotal: $106.80, discount: $16.475
    # After discount: $90.325
    # Free delivery!
    assert_equal 0.0, @basket.delivery_cost
  end
end
