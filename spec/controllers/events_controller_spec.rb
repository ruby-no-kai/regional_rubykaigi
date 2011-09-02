# -*- coding: utf-8 -*-
require 'spec_helper'

describe EventsController do

  describe "#fetch_event" do
    specify do
      get 'show', :name => "no_such_kaigi"
      response.status.should == 404
    end
  end

  describe 'POST /register' do
    before do
      Date.stub!(:today).and_return(Date.parse('2008-08-14'))
      DateTime.stub!(:now).and_return(DateTime.parse('2008-08-14 15:00:00'))

      @event = Factory.create(:tokyo01, :notify_email_enabled => true)
    end

    context '正しい登録情報の場合' do
      before do
        post 'register', :name => 'tokyo01', :attendee => {:event_id => @event.id, :name => 'attendee01', :email => 'attendee01@test.local'}
      end

      it '登録メールを送信する' do
        ActionMailer::Base.deliveries.should_not be_empty
      end

      it '完了を表示する' do
        response.should redirect_to(:action => :done)
      end
    end
  end
end
