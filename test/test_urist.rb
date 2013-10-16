require 'test/unit'
require 'urist'
require './test/scenarios_for_tests.rb'

class UristTest < Test::Unit::TestCase
  def test_simple_scenario
    runner = Urist.new(:startup_scenario => BasicSimpleScenario)
    result = runner.go!

    assert_equal basic_simple_result, result
  end

  def test_linked_scenarios_with_end_in_basic_simple
    information = { :limit => 1000 }
    runner = Urist.new(:startup_scenario => MoreSpecificScenario, :information => information)
    result = runner.go!

    assert_equal basic_simple_result, result
  end

  def test_linked_scenarios_with_end_in_another_simple
    information = { :limit => 5 }
    runner = Urist.new(:startup_scenario => MoreSpecificScenario, :information => information)
    result = runner.go!

    assert_equal another_simple_result, result
  end

  def test_logs_from_linked_scenarios_poor
    information = { :limit => 5 }
    runner = Urist.new(:startup_scenario => MoreSpecificScenario, :information => information)
    result = runner.go!

    assert_equal linked_scenarios_logs_poor, runner.logs
  end

  def test_logs_from_linked_scenarios_rich
    information = { :limit => 1000 }
    runner = Urist.new(:startup_scenario => MoreSpecificScenario, :information => information)
    result = runner.go!

    assert_equal linked_scenarios_logs_rich, runner.logs
  end

  def test_scenarios_from_linked_scenarios_rich
    information = { :limit => 1000 }
    runner = Urist.new(:startup_scenario => MoreSpecificScenario, :information => information)
    result = runner.go!

    assert_equal [MoreSpecificScenario, BasicSimpleScenario], runner.scenarios
  end

  private
    def basic_simple_result
      { :decision => true, :description => "Example description",
    	  :money_in_bank => 100500, :leprecon => true }
    end

    def another_simple_result
       { :decision => false, :description => "Example bad description",
    		 :money_in_bank => 0, :leprecon => false }
    end

    def linked_scenarios_logs_poor
      [{ :decision => :poor_man, :description => "Bad luck.", :limit => 5}, another_simple_result]
    end

    def linked_scenarios_logs_rich
      [{ :decision => :need_more_scenarios, :limit => 1000}, basic_simple_result]
    end
end
