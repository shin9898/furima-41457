require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_form = FactoryBot.build(:purchase_form, user_id: user.id, item_id: item.id)
  end

  describe '商品購入情報の保存' do
    context '内容に問題がないとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_form).to be_valid
      end

      it 'building_nameが空でも保存できること' do
        @purchase_form.building_name = ''
        expect(@purchase_form).to be_valid
      end
    end

    context '内容に問題があるとき' do
      it 'user_idが空のとき' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include "User can't be blank"
      end

      it 'item_idが空のとき' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include "Item can't be blank"
      end

      it 'postal_codeが空のとき' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include "Postal code can't be blank"
      end

      it 'postal_codeにハイフン（-)がないとき' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end

      it 'postal_codeが全角文字列のとき' do
        @purchase_form.postal_code = '１２３ー４５６７'
        @purchase_form.valid?
        binding.pry
        expect(@purchase_form.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end

      it 'cityが空のとき' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include "City can't be blank"
      end

      it 'addressが空のとき' do
        @purchase_form.address = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include "Address can't be blank"
      end

      it 'phone_numberが空のとき' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include "Phone number can't be blank"
      end

      it 'phone_numberが12桁以上のとき' do
        @purchase_form.phone_number = '012345678910'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include 'must be 10 or 11 digits long'
      end

      it 'phone_number半角数値以外の入力があるとき' do
        @purchase_form.phone_number = '090-1234-5678'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include 'must be 10 or 11 digits long'
      end

      it 'prefecture_idが1のとき' do
        @purchase_form.prefecture_id = 1
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include "Prefecture can't be blank"
      end
    end
  end
end
