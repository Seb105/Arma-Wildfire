#include "script_component.hpp"

params ["_tree", "_particles", "_damageDistance"];
if !(_tree in GVAR(burningObjects)) exitWith {
    {deleteVehicle _x} forEach _particles;
};
private _nearbyUnits = _tree nearEntities ["Man", _damageDistance];
private _nearbyLeaders = _nearbyUnits apply {leader _x};
_nearbyLeaders = _nearbyLeaders arrayIntersect _nearbyLeaders;
{
    [_x] remoteExecCall [QFUNC(fireDamage), _x];
} forEach _nearbyUnits;
{
    [_x, _tree] remoteExecCall [QFUNC(unitAvoidFire), _tree];
} forEach _nearbyLeaders;
[{_this call FUNC(fireLoopServer)}, _this, 1] call CBA_fnc_waitAndExecute;
