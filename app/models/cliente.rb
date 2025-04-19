class Cliente < ApplicationRecord
  has_many :trabajos, dependent: :destroy
end
