# == Schema Information
#
# Table name: visits
#
#  id               :bigint(8)        not null, primary key
#  user_id          :integer          not null
#  shortened_url_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ApplicationRecord

  belongs_to :visitor,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'

  belongs_to :visited_url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :ShortenedUrl

  def self.record_visit!(options)
    user = options[:user]
    url = options[:shortened_url]

    Visit.create!(user_id: user.id, shortened_url_id: url.id)
  end

end
