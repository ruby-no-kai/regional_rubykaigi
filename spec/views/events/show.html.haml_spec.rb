# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'events/show.html.haml' do
  context 'adminとしてログインしていない時' do
    before do
      view.should_receive(:logged_in_as_admin?).and_return(false)
    end

    context '会議の説明がある場合' do
      before do
        assign(:event, Factory.create(:tokyo01, :desc => "!blah\nblah blah"))

        render
      end

      subject { Nokogiri.HTML(rendered).at_css('div.event_desc') }

      it '説明を表示する' do
        should_not be_nil
      end

      it 'hikidocの結果をHTMLエスケープしない' do
        subject.inner_html.should match(/^\<h3\>/)
      end
    end

    context '会議の説明がない場合' do
      before do
        assign(:event, Factory.create(:tokyo01, :desc => nil))
      end

      it 'エラーにならず何も表示しない' do
        lambda {
          render

          rendered.should_not have_content('div.event_desc')
        }.should_not raise_exception
      end
    end

    context '会議の問い合わせ用のメールアドレスがある場合' do
      before do
        assign(:event, Factory.create(:tokyo01))

        render
      end

      it 'お問い合わせを表示する' do
        rendered.should have_content('お問い合わせ')
      end
    end

    context '会議の問い合わせ用のメールアドレスがない場合' do
      before do
        assign(:event, Factory.create(:tokyo01, :contact_email => nil))

        render
      end

      it 'お問い合わせを表示しない' do
        rendered.should_not have_content('お問い合わせ')
      end
    end
  end
end
