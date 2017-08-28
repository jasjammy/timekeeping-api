class TimeEntriesController < ApplicationController
  before_action :set_time_entry , only: [:show, :update, :destroy]

  # GET /time_entries
  # This returns the result set of where we
  # display each timecard and time entries if any
  # Possible returns :
  #     200 : OK
  def index
    @time_entries = TimeEntry.all
    render :json => @time_entries, status: :ok
  end

  # GET /time_entries/<time_entry_id>
  # This fetches the appropriate timecard given the id and
  # displays timecard and its time enteries if any.
  # Possible returns :
  #    200 : OK
  #    422 : Unprocessable Entity [When request is bad or time card
  #           not found]
  def show
    render :json => @time_entry, status: :ok
  end

  # POST /time_entries params : {time:<DateTime> , timecard_id:<Integer> }
  # This creates  a time card with the username and occurence
  # Possible returns:
  #    200 : Ok
  #    422 : Unprocessable Entity [When request is bad]
  def create
    @time_entry = TimeEntry.create!(
        time_card_id: time_entry_params[:timecard_id],
        time: time_entry_params[:time]
    )
    render :json => @time_entry, status: :ok

  end

  # PUT /time_entries/<time_entry_id> params : {time:<DateTime> , timecard_id:<Integer> }
  # This updates a time card with the username and occurence given
  # Possible returns:
  #    200 : Ok
  #    422 : Unprocessable Entity [When request is bad or time card
  #           not found]
  def update
    @time_entry.update(
        time_card_id: time_entry_params[:timecard_id],
        time: time_entry_params[:time]
    )
    render status: :ok
  end

  # DELETE /timecards/<timecard_id>
  # This deletes the timecard and its associated time enteries if any
  # Possible returns:
  #    200 : Ok
  #    422 : Unprocessable Entity [When request is bad or time card
  #           not found]
  def destroy
    @time_entry.destroy
    render status: :ok
  end

  private

  def set_time_entry
    @time_entry = TimeEntry.find(params[:id])
  end

  def time_entry_params
    params.permit(:time, :time_card_id, :timecard_id)
  end

end



