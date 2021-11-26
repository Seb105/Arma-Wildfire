#include "script_component.hpp"
params [
    "_tree", 
    ["_broadcast", true]
];
if !(isServer) exitWith {};
GVAR(burningObjects) deleteAt (GVAR(burningObjects) find _tree);
if (_broadcast) then {
    publicVariable QGVAR(burningObjects);
};
