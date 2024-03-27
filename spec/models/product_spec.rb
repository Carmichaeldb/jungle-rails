require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: "Flowers")
    end

    it 'Product is created with all Fields' do
      product = Product.new(name: "Tulips", price_cents: 100, quantity: 1, category: @category)
      expect(product).to be_valid
    end

    it 'validates name' do
      product = Product.new(name: nil, price_cents: 100, quantity: 1, category: @category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates price' do
      product = Product.new(name: "Tulips", price_cents: nil, quantity: 1, category: @category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates quantity' do
      product = Product.new(name: "Tulips", price_cents: 100, quantity: nil, category: @category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates category' do
      product = Product.new(name: "Tulips", price_cents: 100, quantity: 1, category: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
