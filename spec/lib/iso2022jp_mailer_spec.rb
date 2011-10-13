# -*- coding: utf-8 -*-
require 'spec_helper'

class TestMailer < Iso2022jpMailer
  def test
    mail do |format|
      format.text { "テスト" }
    end
  end
end

describe Iso2022jpMailer do
  it 'ISO-2022-JPで出力する' do
    TestMailer.test.deliver
    ActionMailer::Base.deliveries.first.to_s.should match(Regexp.new(Regexp.escape("\e$B%F%9%H\e(B")))
  end
end
