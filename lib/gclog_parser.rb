class GCLogParser
  attr_accessor :start_time
  attr_reader :filename
  
  def initialize(filename)
    @filename = filename
    @start_time = parse_filename_date(@filename)
  end
  
  def parse_filename_date(filename)
    regex = /.*\/loggc_(\d{4})-(\d{2})-(\d{2})-(\d{2})-(\d{2})\.log$/
    match = regex.match(filename)
    Time.gm(match[1], match[2], match[3], match[4], match[5], 0)
  end
  
  def parse_line(raw_line)
    delta_ms, message = raw_line.split(": ", 2)
    [@start_time + delta_ms.to_f, message]
  end

  def format_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S.") + format_millisecond(time.usec.div(1000))
  end
  
  def format_millisecond(msec)
    msec < 100 ? "0#{msec}" : msec.to_s
  end
  
  def format_line(raw_line)
    line_time, line_message = parse_line(raw_line)
    format_time(line_time) + ": " + line_message
  end
  
  def print_formated_lines
    file = File.new(@filename, "r")
    while (line = file.gets)
      puts format_line(line)
    end
  end
  
end