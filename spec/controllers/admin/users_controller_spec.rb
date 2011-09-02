# -*- coding: utf-8 -*-
require 'spec_helper'
 
describe Admin::UsersController do
  before do
    @admin_user = Factory.create(:admin_user)
    controller.stub!(:current_user).and_return(@admin_user)

    @event = Factory.create(:tokyo01)
  end

  describe 'GET /index' do
    before do
      get 'index'
    end

    it { response.status.should == '200 OK' }
  end

  describe 'GET /edit' do
    before do
      get 'edit', :id => @admin_user.id
    end

    it { response.status.should == '200 OK' }
  end

  describe 'POST /update' do
    before do
      post 'update', :id => @admin_user.id, :user => {:admin => true}
    end

    it { response.should redirect_to(:action => :index) }
  end

  describe 'GET /destroy' do
    before do
      @user = User.create(:login => 'test', :identity_url => 'http://test.local/identity/test')

      get 'destroy', :id => @user.id
    end

    it { lambda { @user.reload }.should raise_exception }
  end
end
