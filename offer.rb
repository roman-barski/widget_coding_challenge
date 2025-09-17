# frozen_string_literal: true

# Base class for special offers
class Offer
  def apply(items)
    raise NotImplementedError, "Subclasses must implement #apply method"
  end

  def description
    raise NotImplementedError, "Subclasses must implement #description method"
  end
end
