class GCLogParser
  attr_accessor :start_time
  attr_reader :filename
  
  def initialize(filename)
    @filename = filename
    @start_time = parse_filename_date(@filename)
  end
  
  def parse_filename_date(filename)
    regex = /[.*\/]?loggc_(\d{4})-(\d{2})-(\d{2})-(\d{2})-(\d{2})\.log$/
    match = regex.match(filename)
    Time.gm(match[1], match[2], match[3], match[4], match[5], 0)
  end
  
  def parse_line(raw_line)
    delta_ms, message = raw_line.split(": ", 2)
    [@start_time + delta_ms.to_f, message]
  end

  def GCLogParser.format_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S.") + format_millisecond(time)
  end
  
  def GCLogParser.format_millisecond(time)
    ("%.3f" % time.to_f).split('.', 2)[1]
  end
  
  def format_line(raw_line)
    line_time, line_message = parse_line(raw_line)
    GCLogParser.format_time(line_time) + ": " + line_message
  end
  
  def print_formated_lines
    file = File.new(@filename, "r")
    while (line = file.gets)
      puts format_line(line)
    end
  end
  
end
