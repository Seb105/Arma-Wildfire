#include "script_component.hpp"

params ["_logic", "_units", "_activated"];
if !(isServer && _activated) exitWith {};

// burnable types might be undefined at mission start.
private _types = missionNameSpace getVariable [
    QGVAR(burnableTypes),
    if (GVAR(burnBuildings)) then {
        ["TREE", "SMALL TREE", "BUSH", "BUILDING", "HOUSE", "CHURCH", "CHAPEL", "FUELSTATION"]
    } else {
        ["TREE", "SMALL TREE", "BUSH"]
    }
];

private _nearbyObjects = (nearestTerrainObjects [_logic, _types, 15]) select {
    _x call FUNC(canBurn);
};

{
    [{
        [_this] remoteExec [QFUNC(fire)]
    }, _x, random 2] call CBA_fnc_waitAndExecute;
} forEach _nearbyObjects;

deleteVehicle _logic;