class TimeEntry < ApplicationRecord
  belongs_to :time_card
  validates_presence_of :time

  after_create :update_time_worked
  after_update :update_time_worked
  after_destroy :update_time_worked

  # Calculates the total hours worked everytime a
  # TimeEntry is updated.
  # It updates the total_hours_worked in TimeCard parent.
  def update_time_worked

    time_entries = self.time_card.time_entry
    total_hours = 0
    # Ordering by time so the total hours can be calculated.
    # An odd array will have [start_time1, end_time1, start_time2]
    # and the total_hours_worked = start_time1 - end_time1
    # An even array will have [start_time1, end_time1, start_time2, end_time 2]
    # and the total_hours_worked =  (start_time1 - end_time1) + (start_time2 - end_time2)

    time_entries = time_entries.order(time: :asc)
    time_entries_count = time_entries.count

    i = 0
    while i < time_entries_count and i+1 < time_entries_count
      start_time = time_entries[i].time
      end_time = time_entries[i+1].time
      i = i+2
      total_hours = total_hours +  time_diff(start_time, end_time).to_i
    end

    if time_entries_count == 1
      self.time_card.update_attribute(:total_hours_worked, 0)
    else
      self.time_card.update(:total_hours_worked =>  total_hours)
    end

  end

  private

    # Calculates the hours difference from start_time <DateTime> to
    # end_time <DateTime>
    def time_diff(start_time, end_time)
      seconds_diff = (start_time - end_time).to_i.abs
      hours = seconds_diff / 3600
      return hours
    end
end
