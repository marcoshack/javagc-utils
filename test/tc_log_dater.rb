require "../lib/log_dater.rb"
require "test/unit"

class TestLogDater < Test::Unit::TestCase
  def setup
    @dater = LogDater.new
    @log_start_time = Time.gm(2009, 9, 05, 02, 55, 0)
    @dater.start_time = @log_start_time;
  end
  
  def test_parse_filename_date
    parsed_date = @dater.parse_filename_date("loggc_2009-09-05-02-55.log")
    assert_equal(Time.gm(2009, 9, 05, 02, 55, 0), parsed_date)
  end

  def test_parse_line
    time, message = @dater.parse_line("10.482: [GC [PSYoungGen: 131072K->4966K(152896K)] 134940K->8835K(1551040K), 0.0172760 secs]")
    assert_equal(@log_start_time + 10.482, time)
    assert_equal("[GC [PSYoungGen: 131072K->4966K(152896K)] 134940K->8835K(1551040K), 0.0172760 secs]", message)
  end
  
  def test_format_line
    formated_line = @dater.format_line("10.482: [GC [PSYoungGen: 131072K->4966K(152896K)] 134940K->8835K(1551040K), 0.0172760 secs]")
    assert_equal("2009-09-05 02:55:10.482: [GC [PSYoungGen: 131072K->4966K(152896K)] 134940K->8835K(1551040K), 0.0172760 secs]", formated_line)
  end
  
  def test_format_millisecond
    assert_equal("099", @dater.format_millisecond(99))
    assert_equal("100", @dater.format_millisecond(100))
    assert_equal("101", @dater.format_millisecond(101))
  end
  
  # def test_read_file_line_by_line
  #   
  # end
end