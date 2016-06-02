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

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    let(:product) { FactoryGirl.create(:product) }
    before :each do
      get :index
    end

    it 'assigns products as @products' do
      expect(assigns(:products)).to eq([product])
    end
  end

  describe 'GET #show' do
    let(:product) { FactoryGirl.create(:product)}
    before :each do
      get :show, id: product
    end

    it 'assigns product as @product' do
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      let(:product) { FactoryGirl.attributes_for(:product) }

      it 'assigns product as a Product' do
        post :create, product: product
        expect(assigns(:product)).to be_a Product
      end

      it 'creates a new record' do
        expect {
          post :create, product: product
        }.to change(Product, :count).by(1)
      end

      it 'redirects to product page' do
        post :create, product: product
        expect(response).to redirect_to Product.last
      end
    end

    context 'invalid attributes' do
      let(:product) { FactoryGirl.attributes_for(:product, title: nil) }

      it 'does not save the product' do
        expect {
          post :create, product: product
        }.not_to change(Product, :count)
      end

      it 're-renders :new template' do
        post :create, product: product
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'valid attributes' do
      let(:product) { FactoryGirl.create(:product) }

      before :each do
        put :update, id: product, product: FactoryGirl.attributes_for(:product, title: "Test")
      end

      it 'change product attributes' do
        product.reload
        expect(product.title).to eq("Test")
      end

      it 'redirects to the product' do
        expect(response).to redirect_to product
      end
    end

    context 'invaldi attributes' do
      let(:product) { FactoryGirl.create(:product) }

      before :each do
        put :update, id: product, product: FactoryGirl.attributes_for(:product, title:nil)
      end

      it 'does not change product' do
        product.reload
        expect(product.title).to eq("MyString")
      end

      it 're-renders :edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @product = FactoryGirl.create(:product)
    end

    it 'assigns product' do
      delete :destroy, id: @product
      expect(assigns(:product)).to eq(@product)
    end

    it 'deletes the record' do
      expect {
        delete :destroy, id: @product
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to products index' do
      delete :destroy, id: @product
      expect(response).to redirect_to products_path
    end
  end
end
