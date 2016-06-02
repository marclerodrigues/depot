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

class Product < ActiveRecord::Base
  validates :title, :presence => true
  validates :title, :uniqueness => true
  validates :price, :numericality => { :greater_than_of_equal_to => 0.01 }
  validates :image_url, :format => {
    :with => %r{\.(jpg|png)$}i,
    :message => 'Must be a URL for JPG ou PNG image.',
    :multiline => true
  }
end
