class LogDater
  
  def parse_filename_date(filename)
    # Time.gm(2009, 9, 05, 02, 55, 0)
  end
  
  def parse_line(raw_line)
    raw_line.split(": ", 2)
  end
  
  def format_increment_time(increment)
    # time_obj.strftime("%Y-%m-%d %H:%M:%S.") + time_obj.usec.div(1000).to_s
  end
  
  def start_time(time)
    @start_time = time
  end
end