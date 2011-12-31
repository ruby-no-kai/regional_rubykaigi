# -*- coding: utf-8 -*-
require 'spec_helper'

describe Registration do
  before do
    @event = Factory.create(:tokyo01)
    @attendee = Attendee.new(:name => 'john', :email => 'john@test.local')
    @attendee.event = @event

    Registration.notification(@attendee).deliver
    @notification = ActionMailer::Base.deliveries.first
  end

  it 'メールを送る' do
    @notification.to.should include(@attendee.email)
  end
end
