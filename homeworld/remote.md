Remote interface
----------------
Current status: In development, anything can change, untested, use at your own risk.

This mod has a remote interface to allow other mods to interact with it. 
You can override the requirements, and get the current homeworld status.

### Status
To get the homeworld status, call `remote.call('homeworld', 'get_status')`. The returned object will have properties:
* `tier`: The current homeworld tier
* `max_tier`: The highest tier the homeworld has ever been
* `population`: The current population
* `max_population`: The highest the homeworld population has ever been
* `stockpile`: A table where the keys are item names, and the values are the current amount in the stockpile

I'm not responsible for what happens if you write to this object. I'm hoping the engine will make a copy so it won't affect anything,
but it's not documented so I don't know.

### Config
To get the homeworld tier config, call `remote.call('homeworld', 'get_config')`.
 The returned object is a config table, as documented below

To set the homeworld tier config, call `remote.call('homeworld', 'set_config', 'My mod name', new_config)`.
 The second argument is a config table, documented below.
 This function wll return `nil` if the call succeeded, or a string containing an error message if it didn't.
 
A config table is a list of tier objects, which have the following properties:
* `pop_min`: The population at which the homeworld will be downgraded to the previous tier. Not present on the first tier.
* `pop_max`: The population at which the homeworld will be upgraded to the next tier. Not present on the last tier.
* `requirements`: The daily requirements. It is a list of tables with the following properties:
  * `old`: The item name, which was also a requirement on the previous tier.
  * `new`: The item name, which was not a requirement on the previous tier.
    * If you specify both `old` and `new`, this requirement is an upgrade. The player must supply at least the `old` item
   to sustain the population, and must upgrade to the `new` requirement during this tier in order to increase population. 
  * `count`: The amount of this item consumed *per person*. This is multiplied by the current homeworld population
   to calculate the actual requirement. Setting this above 1 is not recommended unless you're giving 
   the player a way to produce a lot of the item, or you're looking for a really difficult production challenge.
* `upgrade_rewards`: A table where the keys are item names, and the values are numbers. The player will receive the rewards
   when they first reach the `pop_max` value of this tier. Not present on the last tier.
* `recurring_rewards`: A table where the keys are item names, and the values are numbers. Only present on the last tier.
 Unlike the `upgrade_rewards`, *these rewards are per person* of population on the homeworld, and are rewarded every night
 if the requirements have been met.
