require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:property_id) }
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
  end

  describe 'date_range_overlap?' do 
    it 'should return false when date range is not overlap' do 
      reservation = Reservation.new(from: Date.new(2022, 9, 15), to: Date.new(2022, 9, 20))
      expect(reservation.date_range_overlap?(Date.new(2022, 9, 21), Date.new(2022, 9, 25))).to be_falsy
    end

    it 'should return true when date range is overlap' do 
      reservation = Reservation.new(from: Date.new(2022, 9, 15), to: Date.new(2022, 9, 20))
      expect(reservation.date_range_overlap?(Date.new(2022, 9, 17), Date.new(2022, 9, 25))).to be_truthy
    end
  end

  describe 'nights' do 
    it 'should return correct number of night that user reserved' do 
      reservation = Reservation.new(from: Date.new(2022, 9, 15), to: Date.new(2022, 9, 20))
      expect(reservation.nights).to eq(5)  
    end
  end

  describe 'status_step' do 
    it "should return correct step of reservation's current status" do 
      reservation = Reservation.new(status: "processing")
      expect(reservation.status_step).to eq(1) 
      reservation.status = "success"
      expect(reservation.status_step).to eq(2)
      reservation.status = "failure"
      expect(reservation.status_step).to eq(2)
      reservation.status = "completed"
      expect(reservation.status_step).to eq(3)
    end
  end
end
