# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

# This class no needs further testing as long it is fully tested by sorcery.
describe Authentication do
  it { should belong_to :user }
end
