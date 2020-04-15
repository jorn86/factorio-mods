# Barrel only
Replaces all recipes that use fluids, with recipes that use barreled fluids.

Some recipes are scaled up, so that they can require or produce a whole barrel,
 instead of wasting some of the fluid.

The recipes require or return empty barrels where needed, so that they all add up.

If the dirty barrels mod is installed, all used barrels become dirty, so all output barrels
 need to be provided as empty, clean ones. No reusing barrels between inputs and outputs! 

Unfortunately, I cannot compensate for the extra filled barrels generated when using productivity modules.
If those extra barrels cause problems, you can install another mod to deal with them,
 like Burn Barrels or Barrel Recycling.

It's not possible to have Pumpjacks require barrels, so you'll have to do that step manually.
 The same goes for ores that need fluid to mine: I can't change the mining drills to work with barrels,
 so you'll have to unbarrel at the mining site.

This mod is incompatible with any mod that adds its own barrel types, such as Bob's. Let me know if other
 mods do so, so I can add them as incompatible.
It should be compatible with modded fluids, as long as that mod doesn't do anything weird with them,
 or uses them in recipes in ratios I haven't accounted for. 
 If you run into unexpected incompatibilites, let me know and I can look into them.

## Changelog
The [changelog](changelog.txt) contains all notable changes to this project.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
