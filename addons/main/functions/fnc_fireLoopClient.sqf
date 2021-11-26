#include "script_component.hpp"

params ["_tree", "_particles"];
if !(_tree in GVAR(burningObjects)) exitWith {
    {deleteVehicle _x} forEach _particles;
};




[{_this call FUNC(fireLoopClient)}, _this, 5] call CBA_fnc_waitAndExecute;
