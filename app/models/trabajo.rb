class Trabajo < ApplicationRecord
  before_create :set_nro_trabajo

  private

  def set_nro_trabajo
    max = Trabajo.maximum(:nro_trabajo) || 0
    self.nro_trabajo = max + 1
  end

  belongs_to :cliente

  validates :cliente_id, presence: true
end
