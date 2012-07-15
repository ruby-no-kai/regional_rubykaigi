# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'admin/events/index.html.haml' do
  before do
    @tokyo01 = Factory(:tokyo01)
  end

  context '会議が1つある場合' do
    before do
      assign(:events, [@tokyo01])
      render
      @rows = Nokogiri.HTML(rendered).css('table tr')
    end

    it '会議が1つある' do
      @rows.should have(1).row
    end

    context 'その会議について' do
      before do
        @row = @rows.first
      end

      it '会議名が表示されている' do
        @row.css('span').text.should eq(@tokyo01.title)
      end

      it '編集リンクがある' do
        @row.css("a[href='edit_admin_event_path(@tokyo01)']").should_not be_nil
      end

      it '削除リンクがある' do
        @row.css("a[data-method='delete']").should_not be_nil
      end
    end
  end
end
