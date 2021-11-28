#include "script_component.hpp"

params ["_unit"];
private _grp = group _unit;
private _firstWaypoint = (waypoints _grp)#0;
if (wayPointName _grp isEqualTo QGVAR(fleeWP)) exitWith {};
private _originalBehaviour = combatBehaviour _grp;
private _originalSpeed = speedMode _grp;
private _safePos = [
    _unit,  // Centre
    0,      // Mindist
    250,     // Maxdist
    0,      // Objdist
    0,      // Watermode
    10,      // Max gradient
    0,      // Shoremode
    GVAR(burningObjects) apply {[_x, 100]}, 
    [getPos _unit, getPos _unit]
] call BIS_fnc_findSafePos;
_grp setCombatBehaviour "CARELESS";
_grp setSpeedMode "FULL";
{_x doMove _safePos} forEach (units _grp);
_grp addWaypoint [_safePos, 10, 0, QGVAR(fleeWP)];
[_grp, 1] setWaypointBehaviour _originalBehaviour;
[_grp, 1] setWaypointSpeed _originalSpeed;
