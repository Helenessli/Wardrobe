class Outfit < ApplicationRecord
    has_many_attached :images
    has_many :outfit_items
    has_many :items, through: :outfit_items, dependent: :destroy
    accepts_nested_attributes_for :items
    
    validates :number, presence: true
end
