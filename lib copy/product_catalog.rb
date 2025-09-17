# frozen_string_literal: true

# Manages the product catalog
class ProductCatalog
  attr_reader :products

  def initialize(products = [])
    @products = products.each_with_object({}) do |product, hash|
      hash[product.code] = product
    end
  end

  def find_by_code(code)
    products[code]
  end

  def all_products
    products.values
  end

  def empty?
    products.empty?
  end

  def size
    products.size
  end
end
