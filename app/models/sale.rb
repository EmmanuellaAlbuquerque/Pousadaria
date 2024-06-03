class Sale < ApplicationRecord
  belongs_to :inn_room
  belongs_to :inn
end
