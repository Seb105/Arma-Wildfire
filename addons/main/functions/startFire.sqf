#include "script_component.hpp"

if !(isServer) exitWith {};

params ["_obj", ["_burnBuildings", false], ["_spreadDist", 35], ["_speedMetresPerSec", 1], ["_maxBurningObjects", 600]];

if (isNil "seb_fireTypes") then {
    seb_fireTypes = ["TREE", "SMALL TREE", "BUSH"];
    if (_burnBuildings) then {seb_fireTypes append ["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "FUELSTATION"]}
};

if (isNil "seb_spreadDist") then {
    seb_spreadDist = _spreadDist;
};

if (isNil "seb_fireSpeed") then {
    seb_fireSpeed = _speedMetresPerSec;
};

if (isNil "seb_fireSleep") then {
    seb_fireSleep = (seb_spreadDist/seb_fireSpeed)/2 // t = d/v
};

if (isNil "seb_burningObjects") then {
    seb_burningObjects = [];
};

if (isNil "seb_fireLength") then {
    seb_fireLength = 90;
};

if (isNil "seb_burnedObjects") then {
    seb_burnedObjects = [];
};

if (isNil "seb_maxBurningObjects") then {
    seb_maxBurningObjects = _maxBurningObjects;
};

private _nearbyObjects = (nearestTerrainObjects [_obj, seb_fireTypes, seb_spreadDist]) select {
    !(isObjectHidden _x || damage _x >= 0.55 || _x in seb_burningObjects || _x in seb_burnedObjects)
};
{
    [{[_this] remoteExec ["seb_fnc_fire"]}, _x, random 2] call CBA_fnc_waitAndExecute;
} forEach _nearbyObjects;