# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'byebug'

class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, :user_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  has_many :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  def self.random_code
    short = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: short)
      short = SecureRandom.urlsafe_base64
    end

    return short
  end

  def self.make_shortened_url!(options)
    user = options[:user]
    long_url = options[:long_url]
    short_url = ShortenedUrl.random_code

    ShortenedUrl.create!(short_url: short_url, long_url: long_url, user_id: user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques(time = 10.minutes.ago)
    self.visitors.where("visits.created_at > :time", time: time).count
  end

end
