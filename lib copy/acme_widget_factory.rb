# frozen_string_literal: true

require_relative 'product'
require_relative 'product_catalog'
require_relative 'basket'
require_relative 'offers/buy_one_get_one_half_price'

# Factory class to create Acme Widget Co products and basket
class AcmeWidgetFactory
  PRODUCTS = [
    Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
    Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
    Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
  ].freeze

  def self.create_catalog
    ProductCatalog.new(PRODUCTS)
  end

  def self.create_basket
    catalog = create_catalog
    offers = [BuyOneGetOneHalfPrice.new(product_code: 'R01')]
    
    Basket.new(
      catalog: catalog,
      offers: offers
    )
  end
end
