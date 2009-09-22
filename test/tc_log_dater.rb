require "../lib/log_dater.rb"
require "test/unit"

class TestLogDater < Test::Unit::TestCase
  def setup
    @dater = LogDater.new
    @dater.start_time(Time.gm(2009, 9, 05, 02, 55, 0));
  end
  
  def test_parse_filename_date
    parsed_date = @dater.parse_filename_date("loggc_2009-09-05-02-55.log")
    assert_equal(Time.gm(2009, 9, 05, 02, 55, 0), parsed_date)
  end

  def test_parse_line
    timestamp1, message1 = @dater.parse_line("10.482: [GC [PSYoungGen: 131072K->4966K(152896K)] 134940K->8835K(1551040K), 0.0172760 secs]")
    assert_equal("10.482", timestamp1)
    assert_equal("[GC [PSYoungGen: 131072K->4966K(152896K)] 134940K->8835K(1551040K), 0.0172760 secs]", message1)
    
    timestamp2, message2 = @dater.parse_line("19.053: [Full GC [PSYoungGen: 21823K->0K(152896K)] [ParOldGen: 4482K->25988K(1398144K)] 26306K->25988K(1551040K) [PSPermGen: 26709K->26676K(45696K)], 0.5509240 secs]")
    assert_equal("19.053", timestamp2)
    assert_equal("[Full GC [PSYoungGen: 21823K->0K(152896K)] [ParOldGen: 4482K->25988K(1398144K)] 26306K->25988K(1551040K) [PSPermGen: 26709K->26676K(45696K)], 0.5509240 secs]", message2)
  end

  def test_format_increment_time
    formated_time = @dater.format_increment_time(19.053)
    assert_equal("2009-09-05 02:55:19.053", formated_time)
  end
end