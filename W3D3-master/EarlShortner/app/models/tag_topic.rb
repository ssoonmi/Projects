# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint(8)        not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class TagTopic < ApplicationRecord

  has_many :taggings,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: :Tagging

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url

  def popular_links
    # self.shortened_urls.visits.group_by('shortened_urls.id').limit_by('5')
    self.shortened_urls
      .join(:visits)
      .group(:shortened_url_id)
      .order('COUNT(visits.id) DESC')
      .limit(5)
  end

end
