#include "script_component.hpp"

params ["_tree", "_sources"];
if (isObjectHidden _tree || damage _tree >= 0.55) exitWith {
    {deleteVehicle _x} forEach _sources;
    GVAR(burnedObjects) pushBack _tree;
    GVAR(burningObjects) deleteAt (GVAR(burningObjects) find _tree);
};

[{_this call FUNC(fireLoopParticles)}, _this, 5] call CBA_fnc_waitAndExecute;
