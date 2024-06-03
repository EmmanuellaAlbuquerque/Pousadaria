require 'rails_helper'

RSpec.describe Sale, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:discount_percentage) }
  it { should validate_numericality_of(:discount_percentage) }
  it { should belong_to(:inn) }
  it { should belong_to(:inn_room) }

  it 'the start date must be in the future' do
    sale = Sale.new(start_date: 1.day.ago)

    sale.valid?

    expect(sale.errors.include? :start_date).to be true
    expect(sale.errors[:start_date]).to include 'deve ser futura'
  end

  it 'the end date must greater than the start date' do
    sale = Sale.new(start_date: 2.day.from_now, end_date: 2.day.from_now)

    sale.valid?

    expect(sale.errors.include? :end_date).to be true
    expect(sale.errors[:end_date]).to include "deve ser maior que #{2.day.from_now.to_date}"
  end
end
