FactoryBot.define do
  factory :purchase_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    address { '1-1' }
    building_name { 'サンプルビル' }
    phone_number { '09012345678' }
  end
end
