class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_time

  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true

  validates :category_id, numericality: { other_than: 1, only_integer: true, message: "can't be blank" }
  validates :status_id, numericality: { other_than: 1, only_integer: true, message: "can't be blank" }
  validates :shipping_fee_id, numericality: { other_than: 1, only_integer: true, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, only_integer: true, message: "can't be blank" }
  validates :delivery_time_id, numericality: { other_than: 1, only_integer: true, message: "can't be blank" }

  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }
  def sold_out?
    sale_status == 1
  end
end
