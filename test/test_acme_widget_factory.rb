require 'minitest/autorun'
require_relative '../lib/acme_widget_factory'

class TestAcmeWidgetFactory < Minitest::Test
  def test_create_catalog
    catalog = AcmeWidgetFactory.create_catalog
    
    assert_equal 3, catalog.size
    assert_equal 'Red Widget', catalog.find_by_code('R01').name
    assert_equal 'Green Widget', catalog.find_by_code('G01').name
    assert_equal 'Blue Widget', catalog.find_by_code('B01').name
  end

  def test_create_basket
    basket = AcmeWidgetFactory.create_basket
    
    assert basket.empty?
    assert_equal 3, basket.catalog.size
    assert_equal 1, basket.offers.length
    assert_equal 'R01', basket.offers.first.product_code
  end
end
