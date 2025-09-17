# Acme Widget Co. Shopping Basket

A Ruby implementation of a shopping basket system for Acme Widget Co., featuring product catalog management, delivery cost calculation, and special offers.

## Overview

This project implements a shopping basket system that handles:
- Product catalog with three widgets (Red, Green, Blue)
- Dynamic delivery cost calculation based on order total
- Special offers (buy one red widget, get the second half price)
- Clean, extensible architecture following SOLID principles

## Architecture

The solution is built with a focus on:
- **Separation of Concerns**: Each class has a single responsibility
- **Dependency Injection**: Dependencies are injected rather than hardcoded
- **Strategy Pattern**: Offers are implemented as strategies for easy extensibility
- **Small, Accurate Interfaces**: Each class has a clear, minimal interface

### Core Classes

- `Product`: Represents a product with code, name, and price
- `ProductCatalog`: Manages the product catalog with lookup capabilities
- `BasketItem`: Represents an item in the basket with quantity
- `Basket`: Main shopping basket with add/total functionality
- `DeliveryCalculator`: Calculates delivery costs based on order total
- `Offer`: Base class for special offers
- `BuyOneGetOneHalfPrice`: Specific offer implementation
- `AcmeWidgetFactory`: Factory for creating Acme Widget Co. products and basket

## Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```

## Usage

### Basic Usage

```ruby
require_relative 'lib/acme_widget_factory'

# Create a basket with Acme Widget Co. products and offers
basket = AcmeWidgetFactory.create_basket

# Add products
basket.add('R01')  # Red Widget
basket.add('G01')  # Green Widget

# Get total
puts "Total: $#{'%.2f' % basket.total}"
```

### Running the Demo

```bash
ruby demo.rb
# or with Rake
yarn rake demo
```

### Running Tests

```bash
ruby test/test_runner.rb
# or with Rake
rake
# or
rake test
```

## Product Catalog

| Product | Code | Price |
|---------|------|-------|
| Red Widget | R01 | $32.95 |
| Green Widget | G01 | $24.95 |
| Blue Widget | B01 | $7.95 |

## Delivery Rules

- Orders under $50: $4.95 delivery
- Orders $50-$89.99: $2.95 delivery
- Orders $90 and above: Free delivery

## Special Offers

- **Buy One Red Widget, Get Second Half Price**: When you buy two or more red widgets (R01), the second one is half price

## Example Calculations

The system correctly calculates totals for the provided examples:

1. **B01, G01**: $37.85
   - B01: $7.95 + G01: $24.95 = $32.90
   - Delivery: $4.95 (under $50)
   - Total: $37.85

2. **R01, R01**: $54.37
   - R01: $32.95 + R01: $32.95 = $65.90
   - Discount: $16.475 (half price for second R01)
   - Subtotal after discount: $49.425
   - Delivery: $4.95 (under $50)
   - Total: $54.37

3. **R01, G01**: $60.85
   - R01: $32.95 + G01: $24.95 = $57.90
   - No discount (only one R01)
   - Delivery: $2.95 (under $90)
   - Total: $60.85

4. **B01, B01, R01, R01, R01**: $98.27
   - B01: $7.95 + B01: $7.95 + R01: $32.95 + R01: $32.95 + R01: $32.95 = $114.75
   - Discount: $16.475 (half price for second R01)
   - Subtotal after discount: $98.275
   - Delivery: $0.00 (over $90)
   - Total: $98.27

## Design Decisions & Assumptions

### Architecture Decisions

1. **Strategy Pattern for Offers**: Offers are implemented as separate classes that can be easily added or modified without changing the core basket logic.

2. **Dependency Injection**: The basket accepts a catalog, delivery calculator, and offers as dependencies, making it highly testable and flexible.

3. **Immutable Products**: Products are immutable once created, ensuring data integrity.

4. **Factory Pattern**: `AcmeWidgetFactory` encapsulates the creation of the specific Acme Widget Co. configuration.

### Assumptions

1. **Offer Application**: The "buy one get one half price" offer applies to every second item of the same product code, not just the first two.

2. **Delivery Calculation**: Delivery costs are calculated on the subtotal after discounts are applied.

3. **Precision**: All monetary calculations use floating-point arithmetic. In a production system, you might want to use a decimal library for better precision.

4. **Product Codes**: Product codes are case-sensitive and must match exactly.

5. **Basket State**: The basket maintains state between add operations, allowing multiple items of the same product.

## Extensibility

The system is designed to be easily extensible:

- **New Products**: Add to the `AcmeWidgetFactory::PRODUCTS` array
- **New Offers**: Create a new class inheriting from `Offer` and implement the `apply` method
- **New Delivery Rules**: Modify the `DeliveryCalculator::DELIVERY_RULES` array
- **New Catalog Sources**: Implement a different catalog class that follows the same interface

## Testing

The test suite includes:
- Unit tests for each class
- Integration tests for the complete basket functionality
- Tests for all example calculations
- Edge case testing (empty baskets, invalid products, etc.)

## Future Enhancements

Potential improvements for a production system:
- Decimal arithmetic for precise monetary calculations
- Database persistence for products and orders
- More complex offer types (percentage discounts, bulk pricing, etc.)
- Order history and analytics
- API endpoints for web integration
- Configuration management for products and offers
