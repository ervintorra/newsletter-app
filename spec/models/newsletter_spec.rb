require 'rails_helper'

RSpec.describe Newsletter, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    # it { should validate_numericality_of(:publish_at).is_greater_than(Newsletter::MINIMUM_TIME_TO_SCHEDULE_NEWSLETTER) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end
