# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'events/index.html.haml' do
  context '何も会議がない場合' do
    before do
      assign(:upcomings, [])
      assign(:archives, [])
    end

    context 'ログインしていない場合' do
      before do
        view.should_receive(:logged_in?).and_return(false)
        view.should_receive(:logged_in_as_admin?).and_return(false)

        render :file => 'events/index.html.haml', :layout => 'layouts/application.html.haml'
      end

      it 'ルートへのリンクをを表示する' do
        rendered.should have_selector('a[href="/"]', :content => 'Regional RubyKaigi')
      end

      it 'DABlogへのリンクを表示する' do
        rendered.should have_selector('a', :content => 'D.A.Black')
      end
    end
  end
end
