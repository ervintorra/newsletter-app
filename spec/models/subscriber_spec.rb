require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
