class Poll < ActiveRecord::Base

  validates :title, presence: true
  validates :author_id, presence: true

  belongs_to :poll_author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :questions,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Question
end
