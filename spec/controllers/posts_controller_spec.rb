require 'rails_helper'

RSpec.describe PostsController, type: :controller do
describe "GET #index" do

context 'ransack search posts' do

  let!(:post1) { FactoryGirl.create(:post1)}
  let!(:post2) { FactoryGirl.create(:post2)}
  let!(:post3) { FactoryGirl.create(:post3)}
  let!(:post4) { FactoryGirl.create(:post1)}

  context 'finds specific post' do


    it "should find post by searching title" do
      login_with create( :user )
      get :index, q: {title_cont: 'post3'} 
      expect(assigns(:posts).first).to eq post3
      get :index, q: {title_cont: 'post2'} 
      expect(assigns(:posts).first).to eq post2
      get :index, q: {title_cont: 'post1'} 
      expect(assigns(:posts).first).to eq post1
      expect(assigns(:posts).second).to eq post4
    end
    
    it "should find post by searching description" do
      login_with create( :user )
      get :index, q: {description_cont: 'Money'} 
      expect(assigns(:posts).first).to eq post3
      get :index, q: {description_cont: 'Helpful'} 
      expect(assigns(:posts).first).to eq post2
      get :index, q: {description_cont: 'Fun'} 
      expect(assigns(:posts).first).to eq post1
    end
    
    it "should find post by offer type" do
      login_with create( :user )
      get :index, q: {offer_type_cont: 'Full-Time'} 
      expect(assigns(:posts).first).to eq post3
      get :index, q: {offer_type_cont: 'Part-Time'} 
      expect(assigns(:posts).first).to eq post2
      get :index, q: {offer_type_cont: 'Internship'} 
      expect(assigns(:posts).second).to eq post1
      expect(assigns(:posts).third).to eq post4
    end
    
    it "should find post by location" do
      login_with create( :user )
      get :index, q: {location_cont: '3'} 
      expect(assigns(:posts).first).to eq post3
      get :index, q: {location_cont: '2'} 
      expect(assigns(:posts).first).to eq post2
      get :index, q: {location_cont: '1'} 
      expect(assigns(:posts).first).to eq post1
      expect(assigns(:posts).second).to eq post4
    end

  end
end
end
end

