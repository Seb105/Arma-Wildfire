#include "script_component.hpp"

params ["_logic", "_units", "_activated"];

if !(isServer && _activated) exitwith {};

private _nearbyfires = GVAR(burningObjects) select {
    _x distance2D _logic < 25
};
{
    [_x, false] call FUNC(extinguishObject);
} forEach _nearbyfires;
publicVariable QGVAR(burningObjects);
deletevehicle _logic;
