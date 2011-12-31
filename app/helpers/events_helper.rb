# -*- coding: utf-8 -*-
module EventsHelper
  def render_registration_link(outer = :div)
    if @event.use_builtin_registration?
      content_tag outer, {:class => "registration_link"}, false do
        if @event.registration_enabled?
          link_to('フォームから参加登録をする', :action => 'registration')
        else
          message_for_retgistration_is_closed
        end
      end
    else
      content_tag outer, {:class => "registration_external"}, false do
        render_hiki(@event.register_information)
      end
    end
  end

  def message_for_retgistration_is_closed
    content_tag :span, :class => "closed" do
      "参加登録の受付は終了しました"
    end
  end

  def dates_of(event)
    if event.single_day?
      event.start_on.strftime("%Y-%m-%d(%a)")
    else
      "#{event.start_on.strftime("%Y-%m-%d(%a)")}〜#{event.end_on.strftime('%m-%d(%a)')}"
    end
  end
end
