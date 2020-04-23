class Tweet < ApplicationRecord
  validates :text, presence: true

  belongs_to :user
  has_many :comments

  def self.search(search)
    return Tweet.all unless search
    Tweet.where('text LIKE(?)', "%#{search}%")
  end

  #上の関数は下の関数と同一
  # def self.search(search)
  #   if search
  #     Tweet.where('text LIKE(?)', "%#{search}%")
  #   else
  #     Tweet.all
  #   end
  # end
end
