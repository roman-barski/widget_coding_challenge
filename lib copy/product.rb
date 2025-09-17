# frozen_string_literal: true

# Represents a product in the catalog
class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end

  def ==(other)
    other.is_a?(Product) && code == other.code
  end

  def eql?(other)
    self == other
  end

  def hash
    code.hash
  end

  def to_s
    "#{name} (#{code}) - $#{'%.2f' % price}"
  end
end
