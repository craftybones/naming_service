class Email < ApplicationRecord
  belongs_to :emailable, polymorphic: true, optional: true

  validates :category, presence: true
  validates :address, format: { with: /\S+@\S+\.\S+/, if: :address_present?,
            message: -> (object, data) do
              "for category `#{object.category}` is invalid"
            end
  }

  scope :address, -> (address) { where address: address }

  def attributes
    {
        :id => nil,
        :category => nil,
        :address => nil,
        :created_at => nil,
        :updated_at => nil
    }
  end


  private

  def address_present?
    !address.blank?
  end

end
