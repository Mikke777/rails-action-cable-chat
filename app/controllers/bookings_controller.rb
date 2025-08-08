class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user: current_user)
  end

  def show
    @booking = Booking.find(params[:id])
    @message = Message.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @booking = Booking.new(booking_params)
    @booking.restaurant = @restaurant
    @booking.user = current_user
    if @booking.save
      redirect_to @restaurant
    else
      render "restaurants/show"
    end
  end

  private

  def booking_params
    params.expect(booking: [:date])
  end
end
