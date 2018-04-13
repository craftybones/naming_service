class Batch < ApplicationRecord

  has_many :intern

  scope :all_except, -> (id) { where("id != #{id}").order("created_at DESC") }
  scope :with_name, -> (name) { where name: name }

  validates :name, presence: true

  def self.all(*args)
    super.order("created_at DESC")
  end

end
