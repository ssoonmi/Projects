class AddTaggingsUrlIndex < ActiveRecord::Migration[5.2]
  def change
    add_index(:taggings, :shortened_url_id) # unique: false
  end
end
