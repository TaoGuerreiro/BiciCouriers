class AddReferenceToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :urgences, foreign_key: true
    add_reference :courses, :volumes, foreign_key: true
  end
end
