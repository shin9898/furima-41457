## Users テーブル

| Column              | Type    | Options                     |
|---------------------|---------|-----------------------------|
| nickname            | string  | null: false                 |
| email               | string  | null: false, unique: true   |
| encrypted_password  | string  | null: false                 |
| first_name          | string  | null: false                 |
| last_name           | string  | null: false                 |
| birthday            | date    | null: false                 |

### Association
- has_many :items
- has_many :purchases

## Items テーブル

| Column              | Type    | Options                      |
|---------------------|---------|------------------------------|
| name                | string  | null: false                  |
| description         | text    | null: false                  |
| category_id (FK)    | integer | null: false, foreign_key     |
| condition_id (FK)   | integer | null: false, foreign_key     |
| price               | integer | null: false                  |
| user_id (FK)        | integer | null: false, foreign_key     |

### Association
- belongs_to :user
- has_one :purchase

## Purchases テーブル

| Column              | Type    | Options                      |
|---------------------|---------|------------------------------|
| item_id (FK)        | integer | null: false, foreign_key     |
| user_id (FK)        | integer | null: false, foreign_key     |

### Association
- belongs_to :item
- belongs_to :user
- has_one :shipping_address

## ShippingAddresses テーブル

| Column              | Type    | Options                      |
|---------------------|---------|------------------------------|
| postal_code         | string  | null: false                  |
| prefecture_id (FK)  | integer | null: false, foreign_key     |
| city                | string  | null: false                  |
| address             | string  | null: false                  |
| building_name       | string  |                              |
| phone_number        | string  | null: false                  |
| purchase_id (FK)    | integer | null: false, foreign_key     |

### Association
- belongs_to :purchase
