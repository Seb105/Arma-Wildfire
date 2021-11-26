#include "script_component.hpp"

params ["_tree", "_particles", "_damageDistance"];
if !(_tree in GVAR(burningObjects)) exitWith {
    {deleteVehicle _x} forEach _particles;
};
private _nearbyUnits = _tree nearEntities ["Man", _damageDistance];
{
    [_x] remoteExecCall [QFUNC(fireDamage), _x];
} forEach _nearbyUnits;
[{_this call FUNC(fireLoopServer)}, _this, 1] call CBA_fnc_waitAndExecute;
