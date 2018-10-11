class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :shortened_url_id, null: false

      t.timestamps
    end

    remove_index(:shortened_urls, :long_url)
  end
end
