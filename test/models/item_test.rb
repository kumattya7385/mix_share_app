# == Schema Information
#
# Table name: items
#
#  id                :integer          not null, primary key
#  content           :text
#  impressions_count :integer          default(0)
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
