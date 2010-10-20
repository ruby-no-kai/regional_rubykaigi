require 'csv'
class Admin::AttendeesController < AdminController
  before_filter :fetch_event_with_attendees

  def fetch_event_with_attendees
    @event = Event.find(params[:event_id], :include => :attendees, :order => "attendees.created_at DESC")
  end

  def index
    @attendees = @event.attendees
    respond_to do |format|
      format.html
      format.csv do
        buffer = ""
        CSV::Writer.generate(buffer) do |csv|
          @attendees.each do |attendee|
            csv << [
              attendee.name,
              attendee.email,
              attendee.comment,
              attendee.created_at
            ]
          end
        end
        filename = Time.now.utc.strftime("%s-attendees-%s.csv" % [
                                     @event.name,
                                     Time.now.utc.strftime("%Y%m%d-%H%M%S")
        ])
        send_data(buffer, :type => 'text/csv', :filename => filename, :disposition => 'attachment')
      end
    end
  end

  def destroy
    @attendee = Attendee.find(params[:id])
    @attendee.destroy
    redirect_to :action => 'index'
  end
end
