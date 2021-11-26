#include "script_component.hpp"

params ["_logic", "_units", "_activated"];
if !(isServer && _activated) exitWith {};

private _nearbyFires = GVAR(burningObjects) select {_x distance2D _logic < 25};
{
    [_x, false] call FUNC(extinguishObject);
} forEach _nearbyFires;
publicVariable QGVAR(burningObjects);
deleteVehicle _logic;
