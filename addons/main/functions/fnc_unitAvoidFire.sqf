#include "script_component.hpp"

params ["_unit"];
private _grp = group _unit;
private _firstWaypoint = (waypoints _grp)#0;
if (wayPointName _grp isEqualTo QGVAR(fleeWP)) exitWith {};
private _originalBehaviour = combatBehaviour _grp;
private _originalSpeed = speedMode _grp;
private _originalStance = 
private _safePos = [
    _unit,  // Centre
    0,      // Mindist
    250,     // Maxdist
    0,      // Objdist
    0,      // Watermode
    10,      // Max gradient
    0,      // Shoremode
    GVAR(burningObjects) apply {[_x, 100]},   // Blacklist positions
    [getPos _unit, getPos _unit] // Default positions
] call BIS_fnc_findSafePos;
_grp setCombatBehaviour "CARELESS";
_grp setSpeedMode "FULL";
(units _grp) doMove _safePos;
_grp addWaypoint [_safePos, 10, 0, QGVAR(fleeWP)];
[_grp, 1] setWaypointBehaviour _originalBehaviour;
[_grp, 1] setWaypointSpeed _originalSpeed;
