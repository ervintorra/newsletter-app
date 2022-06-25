module JobServices
  class TimeScheduler
    attr_reader :start_time, :end_time

    INCREMENT = 1.second
    BATCH_SIZE = ScheduleNextNewslettersInRow::BATCH_SIZE

    def initialize(start_time, end_time)
      @start_time = start_time
      @end_time = end_time
      @counter = 0
    end

    def increment
      if @counter == BATCH_SIZE
        @counter = 0
        @end_time += INCREMENT
      end

      @counter += 1
    end

    def increment_end_time_on_new_time(time)
      if includes?(time)
        increment
      else
        @counter = 0
        @end_time = time
      end
    end

    private

    # def same_with_start_end_time?(time)
    #   (@start_time == time) && (@end_time == time)
    # end

    def includes?(time)
      (time >= @start_time) && (time <= @end_time)
    end
  end
end
