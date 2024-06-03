class Sale < ApplicationRecord
  belongs_to :inn_room
  belongs_to :inn

  validates :name, :start_date, :end_date, :discount_percentage, presence: true
  validates :discount_percentage, numericality: { greater_than: 0 }
  validates :discount_percentage, numericality: { in: 1..100 }
  validate :start_date_is_future
  validates :end_date, comparison: { greater_than: :start_date }

  private

  def start_date_is_future
    if self.start_date.present? && self.start_date <= Date.current
      self.errors.add(:start_date, 'deve ser futura')
    end
  end
end
