class Batch < ApplicationRecord

  scope :all_except, -> (id) { where("id != #{id}").order("created_at DESC") }

  validates :name, presence: true

  def self.all(*args)
    super.order("created_at DESC")
  end

end
