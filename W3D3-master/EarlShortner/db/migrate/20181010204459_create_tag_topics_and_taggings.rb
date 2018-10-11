class CreateTagTopicsAndTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_topics do |t|
      t.string :topic, null: false

      t.timestamps
    end

    # is adding an index here useful, as every tag_topic will already have a unique ID?
    add_index(:tag_topics, :topic, unique: true)

    create_table :taggings do |t|
      t.integer :shortened_url_id, null: false
      t.integer :tag_topic_id, null: false

      t.timestamps
    end

    # does an index on tag_topic_id on this table point to the same tag_topic_id for all instances that occur in this table?

    # same question for shortened_url_id...

    add_index(:taggings, :tag_topic_id) # unique: false

  end
end
