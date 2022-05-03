#include "script_component.hpp"

if (!isServer) exitwith {};
GVAR(burningObjects) = [];
publicVariable QGVAR(burningObjects);
