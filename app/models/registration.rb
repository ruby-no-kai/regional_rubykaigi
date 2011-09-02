# -*- coding: utf-8 -*-
class Registration < Iso2022jpMailer

  def notification(attendee)
    @attendee = attendee
    @event = @attendee.event
    mail(
      :subject => base64("[#{@event.title}]登録完了のおしらせ"),
      :to => @attendee.email,
      :from => @event.contact_email,
      # FIXME integrate into site_config.rb
      :bcc => (::MAIL_CONF[:bcc] || @event.contact_email),
      :date => Time.now
    )
  end

end
