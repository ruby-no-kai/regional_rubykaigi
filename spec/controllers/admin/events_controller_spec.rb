# -*- coding: utf-8 -*-
require 'spec_helper'
 
describe Admin::EventsController do
  before do
    @admin_user = Factory.create(:admin_user)
    controller.stub!(:current_user).and_return(@admin_user)

    @event = Factory.create(:tokyo01)
  end

  describe 'GET /index' do
    before do
      get 'index'
    end

    it { response.status.should == 200 }
  end

  describe 'GET /show' do
    before do
      get 'show', :id => @event.id
    end

    it { response.status.should == 200 }
  end

  describe 'GET /edit' do
    before do
      get 'edit', :id => @event.id
    end

    it { response.status.should == 200 }
  end
end
