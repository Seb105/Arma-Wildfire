#include "script_component.hpp"

params ["_tree"];
if (typeOf _tree isEqualTo "") then {
    _tree hideObjectGlobal true;
} else {
    _tree setDamage ((random 0.45) + 0.55);
};
GVAR(burnedObjects) pushBack _tree;
GVAR(burningObjects) deleteAt (GVAR(burningObjects) find _tree);