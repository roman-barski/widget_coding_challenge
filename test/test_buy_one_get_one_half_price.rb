require 'minitest/autorun'
require_relative '../lib/product'
require_relative '../lib/basket_item'
require_relative '../lib/offers/buy_one_get_one_half_price'

class TestBuyOneGetOneHalfPrice < Minitest::Test
  def setup
    @red_widget = Product.new(code: 'R01', name: 'Red Widget', price: 32.95)
    @green_widget = Product.new(code: 'G01', name: 'Green Widget', price: 24.95)
    @offer = BuyOneGetOneHalfPrice.new(product_code: 'R01')
  end

  def test_apply_with_two_items
    items = [
      BasketItem.new(product: @red_widget, quantity: 1),
      BasketItem.new(product: @red_widget, quantity: 1)
    ]
    
    discount = @offer.apply(items)
    expected_discount = (32.95 * 0.5).round(2) # Half price for second item
    
    assert_equal expected_discount, discount
  end

  def test_apply_with_three_items
    items = [
      BasketItem.new(product: @red_widget, quantity: 1),
      BasketItem.new(product: @red_widget, quantity: 1),
      BasketItem.new(product: @red_widget, quantity: 1)
    ]
    
    discount = @offer.apply(items)
    expected_discount = (32.95 * 0.5).round(2) # Only one discount for every two items
    
    assert_equal expected_discount, discount
  end

  def test_apply_with_four_items
    items = [
      BasketItem.new(product: @red_widget, quantity: 2),
      BasketItem.new(product: @red_widget, quantity: 2)
    ]
    
    discount = @offer.apply(items)
    expected_discount = (32.95 * 0.5 * 2).round(2) # Two discounts for four items
    
    assert_equal expected_discount, discount
  end

  def test_apply_with_one_item
    items = [BasketItem.new(product: @red_widget, quantity: 1)]
    
    discount = @offer.apply(items)
    
    assert_equal 0.0, discount
  end

  def test_apply_with_different_products
    items = [
      BasketItem.new(product: @red_widget, quantity: 1),
      BasketItem.new(product: @green_widget, quantity: 1)
    ]
    
    discount = @offer.apply(items)
    
    assert_equal 0.0, discount
  end

  def test_description
    expected = "Buy one R01, get the second half price"
    assert_equal expected, @offer.description
  end
end
