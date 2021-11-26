#include "script_component.hpp"

params ["_tree"];
_tree call FUNC(removeObject);
publicVariable QGVAR(burningObjects);
