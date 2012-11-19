class EventsController < ApplicationController
  def index
    @event = Event.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
