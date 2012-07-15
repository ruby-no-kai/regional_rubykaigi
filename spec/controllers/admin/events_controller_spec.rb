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

    it 'should have 1 event' do
      assigns(:events).should have(1).event
    end
  end

  describe 'GET /new' do
    before do
      get 'new'
    end

    subject { assigns(:event) }
    it { should be_new_record }
  end

  describe 'GET /edit' do
    before do
      get 'edit', :id => @event.id
    end

    subject { assigns(:event) }
    it { should_not be_nil }
    its(:name) { should eq(@event.name) }
  end

  describe 'POST /create' do
    before do
      post 'create', {:event => {:title => '´ôÉìRuby²ñµÄ01', :name => 'gifu01', :capacity => 10, :start_on => '2014-08-01', :end_on => '2014-08-02'}}
    end

    it 'should create new event' do
      Event.count.should eq(2)
    end
  end

  describe 'POST /update' do
    before do
      @new_capacity = 50
      post 'update', {:id => @event.id, :event => {:title => @event.title, :name => @event.name, :capacity => @new_capacity, :start_on => @event.start_on.to_s, :end_on => @event.end_on.to_s}}
      @event.reload
    end

    it 'should update an event' do
      @event.capacity.should eq(@new_capacity)
    end
  end

  describe 'GET /destroy' do
    before do
      get 'destroy', :id => @event.id
    end

    it 'should delete an event' do
      Event.count.should eq(0)
    end
  end
end
