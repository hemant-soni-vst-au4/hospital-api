class Doctor < ApplicationRecord
    
    has_many :schedules
    has_many :appointments, through: :schedules

    validate :name, presence: true
    VALID_EMAIL_ADDRESS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
    validate :email, presence: true, uniqueness: true,
                      format: { with: VALID_EMAIL_ADDRESS },
                      length: { minimum: 6, maximum: 100}
end
