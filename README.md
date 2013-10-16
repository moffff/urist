# Urist: logic scenarios tree processor

## Features

- logs full scenario chain that is performed
- you can include any extra data to scenario execution results
- KISS: one scenario — one class — one file
- watches and breaks infinite scenario looping

## Scenarios setup

1. Put your scenarios to `app/scenarios/` or `lib/logic`.
2. Add that folder to your environment autoload. For instance, in
   Ruby on Rails, you can do that by adding to `config/application.rb`
   to the `class Application` something like this:

   ```
   config.autoload_paths += %W(#{config.root}/path_to_scenarios/)
   ```

   (obviously you should use your own path instead of **path_to_scenarios**)

## Scenario examples

`> cat app/scenarios/simple_scenario.rb`

```
class SimpleScenario < Urist::Scenario
  def logic
    result = {  :decision => true, :description => "Example description",
    			:money_in_bank => 100500, :leprecon => true }
  end
end
```

---------

`> cat app/scenarios/more_specific_scenario.rb`

```
class MoreSpecificScenario < Urist::Scenario
  @links = { :need_more_scenarios => SimpleScenario }

  def logic
    limit = rand(1000)

    if limit > 333
      result = { :decision => :need_more_scenarios, :limit => limit }
    else
      result = { :decision => :decline, :description => "Bad luck.", :limit => limit}
    end
  end
end

```

## Installation

Gemfile:

    gem 'urist'

## Usage

A. Fetch all the data you need:

```
client   = Client.needed_now # instance of some class
price    = 10000.65          # numbers
products = client.products   # arrays
```

B. Assemble them into hash:

```
information = {:client => client, :price => price, :products => products}
```

C. Create new runner and, well, run it:

```
runner = Urist.new(:startup_scenario => NewAndLongScenario, :information => information)
result = runner.go!
```

D. Extract the decision and other parameters from result:

```
decision    = result[:decision]
description = result[:description]
limit       = result[:limit]
```

E. Capture all execution logs

```
log = runner.logs # array with all results
```

F. Summarize all executed scenarios

```
scenarios = runner.scenarios # array with all executed scenarios
```

G. You're done!

## License

Copyright © 2013 Artem Kornienko (contacts@theteam.io) and released under an [MIT license](http://opensource.org/licenses/MIT).

