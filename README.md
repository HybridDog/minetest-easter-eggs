# Easter Eggs Mod

Easter Eggs Mod for Minetest. Adds some easter-themed custom items.

Supported hunger mods:
* <https://github.com/BlockMen/hunger>
* <https://github.com/tenplus1/hud_hunger>
* <http://repo.or.cz/w/minetest_hbhunger.git>

## Installation

To install, just clone this repository into your "mods" directory.

## Configuration
_config.lua_ stores some configuration that allows to customize this mod.

One important setting is the variable _MAX_SP_ - maximum value of satiation
(aka hunger). Different hunger mods may have different values for this and
_MAX_SP_ should be set appropriately. Player should encounter 'sugar overdose'
effect if and only if player's hunger bar is full before he uses the chocolate egg.

In case of any further problems with 'sugar overdose' effect please consult
_get_sp()_ function from _init.lua_ and your hunger mod's source code.  
'Sugar overdose' isn't supposed to work at all if no supported hunger mod
is detected. If it does, rejoice. If it does work but works incorrectly
and setting _MAX_SP_ doesn't help, _SO_ENABLED = false_ flag setting disables
the feature completely.

## License

All soure code, textures and models are licenced with WTFPL (see LICENSE.txt for details).

**Forum topic:** <https://forum.minetest.net/viewtopic.php?f=9&t=17213>
