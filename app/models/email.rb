class Email < ApplicationRecord
  belongs_to :intern
  validates :category, presence: true
  validates :address, format: { with: /\S+@\S+\.\S+/,
            message: -> (object, data) do
              "for category `#{object.category}` is invalid"
            end
  }
end
