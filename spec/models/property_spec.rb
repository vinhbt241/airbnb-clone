require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'validations' do
    before { allow(subject).to receive(:pending_or_address?).and_return(true) }
    before { allow(subject).to receive(:pending_or_headline?).and_return(true) }
    before { allow(subject).to receive(:pending_or_description?).and_return(true) }
    before { allow(subject).to receive(:pending_or_price?).and_return(true) }
    before { allow(subject).to receive(:pending_or_images?).and_return(true) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:headline) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it "is expected to validate that number of images attached must bigger than 5" do 
      property = Property.new(status: "pending")
      expect(property.filetype_is_valid).to be_falsy
    end
  end

  describe 'When address method was called' do
    it "return address string(currently only include country)" do 
      property = build(:property, country: "Vietnam")
      expect(property.address).to eq("Vietnam")
    end 
    it "return nil when attributes in address(currently only include country) are nil" do 
      property = build(:property, country: nil)
      expect(property.address).to be_nil
    end
  end
    
end
