# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#  user_id    :integer
#
# Indexes
#
#  index_comments_on_item_id  (item_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  item_id  (item_id => items.id)
#  user_id  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :user_id, presence:true
  validates :comment, presence: true, length: { maximum: 1000 }
end
