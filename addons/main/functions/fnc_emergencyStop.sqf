#include "script_component.hpp"

if (!isServer) exitWith {};
GVAR(burningObjects) = [];
publicVariable QGVAR(burningObjects);
