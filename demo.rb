require_relative 'lib/acme_widget_factory'

# Demo script to show the basket functionality
def main
  puts "=== Acme Widget Co. Shopping Basket Demo ===\n\n"

  # Create a new basket
  basket = AcmeWidgetFactory.create_basket

  # Example 1: B01, G01
  puts "Example 1: B01, G01"
  basket.add('B01')
  basket.add('G01')
  puts "Subtotal: $#{'%.2f' % basket.subtotal}"
  puts "Discount: $#{'%.2f' % basket.discount}"
  puts "Delivery: $#{'%.2f' % basket.delivery_cost}"
  puts "Total: $#{'%.2f' % basket.total}"
  puts "Expected: $37.85\n\n"

  # Reset basket
  basket = AcmeWidgetFactory.create_basket

  # Example 2: R01, R01
  puts "Example 2: R01, R01"
  basket.add('R01')
  basket.add('R01')
  puts "Subtotal: $#{'%.2f' % basket.subtotal}"
  puts "Discount: $#{'%.2f' % basket.discount}"
  puts "Delivery: $#{'%.2f' % basket.delivery_cost}"
  puts "Total: $#{'%.2f' % basket.total}"
  puts "Expected: $54.37\n\n"

  # Reset basket
  basket = AcmeWidgetFactory.create_basket

  # Example 3: R01, G01
  puts "Example 3: R01, G01"
  basket.add('R01')
  basket.add('G01')
  puts "Subtotal: $#{'%.2f' % basket.subtotal}"
  puts "Discount: $#{'%.2f' % basket.discount}"
  puts "Delivery: $#{'%.2f' % basket.delivery_cost}"
  puts "Total: $#{'%.2f' % basket.total}"
  puts "Expected: $60.85\n\n"

  # Reset basket
  basket = AcmeWidgetFactory.create_basket

  # Example 4: B01, B01, R01, R01, R01
  puts "Example 4: B01, B01, R01, R01, R01"
  basket.add('B01')
  basket.add('B01')
  basket.add('R01')
  basket.add('R01')
  basket.add('R01')
  puts "Subtotal: $#{'%.2f' % basket.subtotal}"
  puts "Discount: $#{'%.2f' % basket.discount}"
  puts "Delivery: $#{'%.2f' % basket.delivery_cost}"
  puts "Total: $#{'%.2f' % basket.total}"
  puts "Expected: $98.27\n\n"

  puts "=== Demo Complete ==="
end

main if __FILE__ == $PROGRAM_NAME
