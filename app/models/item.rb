# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Item < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :item_tag_relation, dependent: :destroy
  has_many :tags, through: :item_tag_relation

  validates :user_id, presence:true
  validates :title, presence: true
  validates :content, presence: true

  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags
  
      # Destroy old taggings:
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
  
      # Create new taggings:
      new_tags.each do |new_name|
        post_tag = Tag.find_or_create_by(name:new_name)
        self.tags << post_tag
      end
  end
end
