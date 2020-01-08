Train teleporter
-------------------------------------
This mod allows you to teleport trains across the map, and even to different surfaces.
 Do you want to build train stations inside Factorissimo buildings? Have trains travel between planets in Space Exploration?
 Or just have your trains arrive sooner? With this mod, you can do all of it!

To teleport a train, you need to define a stop in its schedule with exactly one condition: A Circuit-type condition, where
 the first signal is the custom signal "Teleport train" added by this mod.
 The train will teleport to the next station in its schedule as soon as it arrives at that stop.

It is also possible to skip a number of stops, using the second signal of the condition.
 You can either set it to a constant number to always skip that number of stops, or select a signal
 which will be evaluated against the train stop (not against the train itself, so no need to enable "Send to train" on the stop). 

This mod raises a custom event when a train is teleported. To subscribe to the event, add this code in your mod:
```
script.on_event(remote.call('train-teleporter', 'get_events').train_teleported, function(event)
    print('train id before teleport = ' .. event.from)
    print('train id before teleport = ' .. event.to)
    -- use old and new train ids here. Note that the train with the from id probably doesn't exist any more.
end)
```

#### Limitations and known issues
* A teleported train will get a new internal id and name. The Factorio engine doesn't allow train teleportation between surfaces,
   so I have to spawn a new one and remove the old one.
* Stations on different surfaces are hidden from the train schedule GUI. To work around this issue, 
   copy those stations to the current surface, add them to the schedule, then remove the copied stations. 
* Teleportation can't fully check if the target station is clear.
   Collisions might happen if a train is pulling into a station normally while another is teleporting to it.
   You can [help me](https://forums.factorio.com/viewtopic.php?f=25&t=79853&p=472856) lessen the chances of that happening.  
* If a train is directly in front of the teleportation station target, it might jump to manual mode while trying to spawn
   the teleported train. To prevent this, don't park trains in front of your stops, even temporarily.
* Modded trains aren't supported if they have properties the vanilla trains don't support, like using non-burner fuel.

Changelog
---------
The [changelog](changelog.txt) contains all notable changes to this project.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
