# -*- coding: utf-8 -*-
class EventsController < ApplicationController
  before_filter :fetch_event, :except => [:index]
  before_filter :check_published, :except => [:index]
  before_filter :check_registration_enabled, :except => [:index, :show]

  verify :method => :post, :only => :register, :redirect_to => {:action => "index"}
  def index
    @upcomings = Event.upcomings
    @archives = Event.archives
  end

  def show
    return if render_original_template
  end

  def registration
    @attendee = Attendee.new
  end

  def register
    @attendee = Attendee.new(params[:attendee])
    @attendee.remote_ip = request.remote_ip
    @attendee.event = @event
    if @attendee.save
      if @event.notify_email_enabled?
        Registration.deliver_message(@attendee)
      end
      redirect_to :action => 'done', :name => @event.name
    else
      render :action => 'registration'
    end
  end

  TOKYO_MAPPINGS = {
    'tokyo02' => 'tokyu01',
    'tokyo04' => 'tokyu02',
    'tokyo06' => 'oedo01',
    'tokyo07' => 'tokyu03',
    'tokyo08' => 'tokyu04',
  }.freeze
  private
  def fetch_event
    event_name = params[:name]
    if(regional_tokyo = TOKYO_MAPPINGS[event_name])
      redirect_to event_path(:action => 'show', :name => regional_tokyo)
      return
    end

    @event = find_event_by_name_or_synonyms(event_name)
    unless @event
      render :file => "public/404.html", :status => 404
      return
    end

    if @event.redirect_to_external? && @event.redirect_url.present?
      redirect_to @event.redirect_url
      return
    end

    @page_title = @event.title
  end

  def check_registration_enabled
    unless @event.registration_enabled?
      redirect_to :action => 'show', :name => @event.name
    end
  end

  def check_published
    return true if logged_in_as_admin?
    unless @event.published?
      # FIXME もうちょっとユーザフレンドリーに
      redirect_to :action => 'index'
    end
  end

  def render_original_template
    begin
      render @event.name, :layout => false
    rescue ActionView::MissingTemplate
      return false
    end
  end

  def find_event_by_name_or_synonyms(name)
    Event.find_by_name(name) || Event.find(:first,
      :conditions => ['synonyms LIKE :synonyms', {:synonyms => "%#{name}%"}])
  end
end
