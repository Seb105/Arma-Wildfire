#include "script_component.hpp"

if !(isServer) exitWith {};

params ["_obj"];

private _nearbyObjects = (nearestTerrainObjects [_obj, GVAR(burnTypes), GVAR(spreadDist)]) select {
    _x call FUNC(canBurn);
};
{
    [{[_this] remoteExec [QGVAR(fire)]}, _x, random 2] call CBA_fnc_waitAndExecute;
} forEach _nearbyObjects;