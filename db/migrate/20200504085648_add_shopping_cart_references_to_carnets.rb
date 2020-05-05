class AddShoppingCartReferencesToCarnets < ActiveRecord::Migration[5.2]
  def change
    add_reference :carnets, :shopping_cart, foreign_key: true
    add_reference :courses, :shopping_cart, foreign_key: true
  end
end
