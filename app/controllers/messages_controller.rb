class MessagesController < ApplicationController
  # def create
  #   @booking = Booking.find(params[:booking_id])
  #   @message = Message.new(message_params)
  #   @message.booking = @booking
  #   @message.user = current_user
  #   if @message.save
  #     respond_to do |format|
  #       format.turbo_stream do
  #         render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
  #                                                             target: "messages",
  #                                                             locals: { message: @message, user: current_user })
  #       end
  #       format.html { redirect_to booking_path(@booking) }
  #     end
  #   else
  #     render "bookings/show", status: :unprocessable_entity
  #   end
  # end

  def create
    @booking = Booking.find(params[:booking_id])
    @message = Message.new(message_params)
    @message.booking = @booking
    @message.user = current_user

    if @message.save
      respond_success
    else
      respond_failure
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def respond_success
    respond_to do |format|
      format.turbo_stream { render_turbo_stream }
      format.html { redirect_to booking_path(@booking) }
    end
  end

  def respond_failure
    render "bookings/show", status: :unprocessable_entity
  end

  def render_turbo_stream
    render turbo_stream: turbo_stream.append(
      :messages,
      partial: "messages/message",
      target: "messages",
      locals: { message: @message, user: current_user }
    )
  end
end
