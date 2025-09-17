require 'minitest/autorun'
require_relative '../lib/product'
require_relative '../lib/product_catalog'

class TestProductCatalog < Minitest::Test
  def setup
    @products = [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95)
    ]
    @catalog = ProductCatalog.new(@products)
  end

  def test_initialization
    assert_equal 2, @catalog.size
    refute @catalog.empty?
  end

  def test_find_by_code
    product = @catalog.find_by_code('R01')
    assert_equal 'Red Widget', product.name
    assert_equal 32.95, product.price
  end

  def test_find_by_code_not_found
    product = @catalog.find_by_code('INVALID')
    assert_nil product
  end

  def test_all_products
    all_products = @catalog.all_products
    assert_equal 2, all_products.length
    assert_includes all_products.map(&:code), 'R01'
    assert_includes all_products.map(&:code), 'G01'
  end

  def test_empty_catalog
    empty_catalog = ProductCatalog.new([])
    assert empty_catalog.empty?
    assert_equal 0, empty_catalog.size
  end
end
