# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  image_url   :string
#  price       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do

  let(:product) { FactoryGirl.build(:product) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_numericality_of :price }
  it { is_expected.to validate_uniqueness_of :title }
  it { is_expected.to allow_value("http://testurll.com/test.jpg").for(:image_url) }
  it { is_expected.not_to allow_value("http://testurll.com").for(:image_url) }

  it 'has a valid factory' do
    expect(product).to be_valid
  end
end
