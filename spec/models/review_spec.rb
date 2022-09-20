require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:rating) }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  end
end
