require 'rails_helper'

RSpec.describe Realstate, type: :model do
  let!(:valid_real_state){ build(:realstate) }
  let!(:str_sample){ 'abcdefghijklmnop' }

  it 'return valid with name lengt in 1..128, outside is invalid' do
    valid_real_state.name = str_sample * 8 # length 128
    expect(valid_real_state.save).to eq(true)
    expect(valid_real_state.update(name: 'a')).to eq(true)
    expect(valid_real_state.update(name: str_sample * 4)).to eq(true)

    # outside
    expect(valid_real_state.update(name: (str_sample * 8) + 'a')).to eq(false)
    expect(valid_real_state.update(name: '')).to eq(false)
  end

  it 'only accept [house department land commercial_ground] as category' do

    # valid categories
    Realstate.categories.keys.each do |category|
      valid_real_state.category = category.to_sym
      valid_real_state.save
      expect(valid_real_state.valid?).to eq(true)
    end

    # wrong category
    expect { valid_real_state.update(category: :wrong_category) }
      .to raise_error(ArgumentError)
      .with_message(/is not a valid category/)
  end

  it 'return valid with street lengt in 1..128, outside invvalid' do
    valid_real_state.name = str_sample * 8 # length 128
    expect(valid_real_state.save).to eq(true)
    expect(valid_real_state.update(street: "a")).to eq(true)
    expect(valid_real_state.update(street: str_sample * 4)).to eq(true)

    # outside limits
    expect(valid_real_state.update(street: (str_sample * 8) + 'a')).to eq(false)
    expect(valid_real_state.update(street: '')).to eq(false)
  end

  it 'check external_number onlu alpha and dashes' do
    valid_real_state.external_number = '123#@-11'
    valid_real_state.save
    expect(valid_real_state.valid?).to eq(false)

    valid_real_state.external_number = 'W23 -11'
    valid_real_state.save
    expect(valid_real_state.valid?).to eq(false)
  end

  it 'validate internal_number valid (alpha dashes and spaces) and invalid string' do
    Realstate.categories.keys.each do |category|
      expect(valid_real_state.update(category: category.to_sym, internal_number: '1Ad- 11')).to eq(true)
    end

    Realstate.categories.keys.each do |category|
      expect(valid_real_state.update(category: category.to_sym, internal_number: '13@ #-11n')).to eq(false)
    end
  end

  it 'validate internal_number is required for categories [department, commercial_ground] not for [house, land]' do
    expect(valid_real_state.update(category: :department, internal_number: '')).to eq(false)
    expect(valid_real_state.update(category: :commercial_ground, internal_number: '')).to eq(false)
    expect(valid_real_state.update(category: :house, internal_number: '')).to eq(true)
    expect(valid_real_state.update(category: :land, internal_number: nil)).to eq(true)
  end

  it 'country must be any under ISO 3166- Alpha2 (Two characters).' do
    # must be exact 2 chars
    expect(valid_real_state.update(country: 'asdfa')).to eq(false)
    expect(valid_real_state.update(country: 'a')).to eq(false)

    # country not exists
    expect(valid_real_state.update(country: 'zy')).to eq(false)
    expect(valid_real_state.update(country: '$#')).to eq(false)

    # country exists
    expect(valid_real_state.update(country: 'us')).to eq(true)
    expect(valid_real_state.update(country: 'ru')).to eq(true)
    expect(valid_real_state.update(country: 'mx')).to eq(true)

  end

  it 'rooms required and positive' do
    expect(valid_real_state.update(rooms: nil)).to eq(false)

    expect(valid_real_state.update(rooms: -1)).to eq(false)
  end

  it 'bathrooms required, permit zero only for categories [land commercial_ground], not for [house department]' do
    expect(valid_real_state.update(bathrooms: nil)).to eq(false)
    expect(valid_real_state.update(bathrooms: -3)).to eq(false)

    expect(valid_real_state.update(category: :land, bathrooms: 0)).to eq(true)
    expect(valid_real_state.update(category: :commercial_ground, bathrooms: 0)).to eq(true)
    expect(valid_real_state.update(category: :house, bathrooms: 0)).to eq(false)
    expect(valid_real_state.update(category: :department, bathrooms: 0)).to eq(false)
  end
end
