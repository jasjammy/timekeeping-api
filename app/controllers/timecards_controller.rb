class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :update, :destroy]

  # GET /timecards
  # This returns the result set of where we
  # display each timecard and time entries if any
  # Possible returns :
  #     200 : OK
  def index
    @timecards = TimeCard.all
    render :json => @timecards.to_json(:include => :time_entry), status: :ok
  end

  # GET /timecards/<timecard_id>
  # This fetches the appropriate timecard given the id and
  # displays timecard and its time enteries if any.
  # Possible returns :
  #    200 : OK
  #    422 : Unprocessable Entity [When request is bad or time card
  #           not found]
  def show
    render :json => @timecard.to_json(:include => :time_entry), status: :ok
  end

  # POST /timecards params : {username:<String> , occurence:<Date> }
  # This creates  a time card with the username and occurence
  # Possible returns:
  #    200 : Ok
  #    422 : Unprocessable Entity [When request is bad]
  def create
    @timecard = TimeCard.create!(timecard_params)
    render :json => @timecard, status: :ok

  end

  # PUT /timecards/<timecard_id> params : {username:<String> , occurence:<Date> }
  # This updates a time card with the username and occurence given
  # Possible returns:
  #    200 : Ok
  #    422 : Unprocessable Entity [When request is bad or time card
  #           not found]
  def update
    @timecard.update(timecard_params)
    render status: :ok
  end

  # DELETE /timecards/<timecard_id>
  # This deletes the timecard and its associated time enteries if any
  # Possible returns:
  #    200 : Ok
  #    422 : Unprocessable Entity [When request is bad or time card
  #           not found]
  def destroy
    @timecard.destroy
    render status: :ok
  end

  private

  def set_timecard
    @timecard = TimeCard.find(params[:id])
  end

  def timecard_params
    params.permit(:username, :occurence)
  end

end


