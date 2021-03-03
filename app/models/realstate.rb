class Realstate < ApplicationRecord
  enum category: %I[house department land commercial_ground]

  validates :name, length: { in: 1..128 }
  validates :street, length: { in: 1..128 }
  validates :external_number, format: { with: /\A[-\w\d]{1,12}\z/ }
  validates_presence_of :internal_number, if: ->(rs) { rs.department? || rs.commercial_ground? }
  validates :internal_number, format: { with: /\A[-\s\w\d]{,12}\z/ }
  validates :neighborhood, length: { in: 1..128 }
  validates :city, length: { in: 1..64 }
  validate :country_code
  validates :rooms, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :bathrooms, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :bathroms_number

  private

  def country_code
    return unless ISO3166::Country.find_country_by_alpha2(country).nil?

    errors.add(:country, 'Must be any under ISO 3166- Alpha2')
  end

  def bathroms_number
    return unless bathrooms&.zero? && !(land? || commercial_ground?)

    errors.add(:bathrooms, 'zero only if land or commercial_ground')
  end
end
