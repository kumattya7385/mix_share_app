# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#
# Indexes
#
#  index_comments_on_item_id  (item_id)
#
# Foreign Keys
#
#  item_id  (item_id => items.id)
#
class Comment < ApplicationRecord
  belongs_to :item

  validates :name, presence: true, length: { maximum: 20}
  validates :comment, presence: true, length: { maximum: 1000 }
end
