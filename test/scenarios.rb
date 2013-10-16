class AnotherSimpleScenario < Urist::Scenario
  def logic
    result = {  :decision => false, :description => "Example bad description",
    			      :money_in_bank => 0, :leprecon => false }
  end
end

class BasicSimpleScenario < Urist::Scenario
  def logic
    result = {  :decision => true, :description => "Example description",
    			      :money_in_bank => 100500, :leprecon => true }
  end
end

class MoreSpecificScenario < Urist::Scenario
  @links = { :need_more_scenarios => BasicSimpleScenario, :poor_man => AnotherSimpleScenario }

  def logic
    limit = @information[:limit]

    if limit > 333
      result = { :decision => :need_more_scenarios, :limit => limit }
    else
      result = { :decision => :poor_man, :description => "Bad luck.", :limit => limit}
    end
  end
end
