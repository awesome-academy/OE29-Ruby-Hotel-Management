class Comment < ApplicationRecord
  COMMENT_PARAM = %w(content user_id).freeze

  belongs_to :user
  belongs_to :room
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true,
            length: {maximum: Settings.comments.comment_content}

  delegate :name, to: :user, prefix: true
end
