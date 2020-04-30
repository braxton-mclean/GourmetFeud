# GourmetFeud
 
Gourmet Feud is a Turn-based Tactical-RPG for the class Fundamentals of Game Design at GSU, developed by Braxton McLean, Ethan Bovard, Daniel Green, and Faizon Williams.

The gameplay is akin to Final Fantasy Tactics in battle style, where Units take turns on the battlefield individually rather than as a collective like Fire Emblem and Advance Wars.  

At most this is meant to be a functional prototype of a tactics-game engine with a cute story to allow exploration of different battle mechanics and styles.

Playable version available at: http://theeverblack.com/gourmet_feud/GourmetFeud.html

## A technical note

Gourmet Feud was developed with the Godot game engine in GDScript. There are Colosseums, the metaphorical arenas that enclose units and their enemies for combat. On a fundamental level, an opportunity was made to flesh out Colosseum TileMaps with the MapGridComponent, which follows a row, column order system that defines traversability that units can recognize if they can move to a particular tile or not.

For pathfinding, a breadth first search algorithm was used to spawn a list containing coordinates to get from point A to point B, all the while recognizing traversability values from the MapGridComponent system, with accompanying "comma-separated values" (CSV) files.

For those inept in the way of tactics games, we have Units (notable examples include Alm and Celica) which hold stats such as health, strength, dexterity, and so forth. For each turn, they can either attack a target, move around the map perhaps to get a vantage point, or wait. The charm of the tactics genre is to work with what you have -- it is possible to exhaust both the Attack and Move options. Once you do, you have no choice but to wait, adding to the compelling nature of this variety of games. It also follows the model of tactics games that precede it, thanks to a game tick system that keeps track of which legend is up for combat.

## Summary

In a world of relative peace, the continent of Agore is the home of several realms of prideful people. Ingrained in each culture is a deep pride in the preparation of their food from the earth which they gew. A diverse land, deserts butt up against tundra, which are separated by wide mountain ranges giving way to deep forests and wide planes. Almost every type of environment can be found somewhere across Agore, and some lie even beneath the surface.

Having found relative economic and cultural stability across the known world after generations of war, the realms took it upon themselves to avoid future conflict by encouraging competitive outlets for the restlessness caused by peace. Early on this took the form of various sports tournaments, traveling teams, and competition in the sciences, but overall this led to bitter conflict. Accusations of cheating, unethical practices to achieve greater feats, and subterfuge that could threaten a nation’s sovereignty threatened to break the balance for which their ancestors worked so hard to achieve.

A suggestion to cease the direct competitions in the name of sports and progress and other objectively measurable competitions and to instead create a friendlier outlet that celebrates the differences in their cultures was met with much trepidation but took hold after the first Agore Annual Gourmet Feud. The premise was simple: every year a set of competitions would be formed to pit the nations of the world against each other, and the winning team or country would have their selected food prepared and eaten across the world at the Festival of Food. This required great organization and cooperation from all members of the world stage, and tempered many of the issues as everyone contributed to both the creation of competitions and keeping things logistically feasible.

The game Gourmet Feud explores the Agore Annual Gourmet Feud. For this particular year, the competition is a series of mock military battles by small squads in a single-elimination bracket. The size of the teams allows for all cultures to feasibly raise and train the participants without heavily impacting the local culture, and promotes exemplifying their culture both through combat technique and personalities chosen to represent them.
