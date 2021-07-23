class ChangingOptionsSystem < ActiveRecord::Migration[6.0]
  def change
    remove_reference :course_options, :user_option
    add_reference :course_options, :option, foreign_key: true

    remove_reference :user_options, :urgence
    remove_reference :user_options, :volume

    # drop_table :urgences
    # drop_table :volumes

    remove_column :options, :urgence
    remove_column :options, :volume
    remove_column :options, :groupe
    add_column :options, :ticket_nb, :integer


  end
end
