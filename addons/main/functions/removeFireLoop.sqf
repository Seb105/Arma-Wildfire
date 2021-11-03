#include "script_component.hpp"

params ["_tree", "_sources"];
if (isObjectHidden _tree || damage _tree >= 0.55) exitWith {
    {deleteVehicle _x} forEach _sources;
    seb_burnedObjects pushBack _tree;
    seb_burningObjects deleteAt (seb_burningObjects find _tree);
};

[{_this call seb_fnc_removeFireLoop}, _this, random(2)+2] call CBA_fnc_waitAndExecute;
