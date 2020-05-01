# == Schema Information
#
# Table name: item_tag_relations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#  tag_id     :integer          not null
#
# Indexes
#
#  index_item_tag_relations_on_item_id  (item_id)
#  index_item_tag_relations_on_tag_id   (tag_id)
#
# Foreign Keys
#
#  item_id  (item_id => items.id)
#  tag_id   (tag_id => tags.id)
#
class ItemTagRelation < ApplicationRecord
  belongs_to :item
  belongs_to :tag
end
