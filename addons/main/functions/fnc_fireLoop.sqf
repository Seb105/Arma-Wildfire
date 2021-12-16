#include "script_component.hpp"

params ["_tree", "_particles", "_warningDistance"];
if !(_tree in GVAR(burningObjects)) exitWith {
    {deleteVehicle _x} forEach _particles;
};
if (hasInterface && {(call CBA_fnc_currentUnit) distance _tree < _warningDistance}) then {
    if (QGVAR(onFire) in allCutLayers) exitWith {}; // Don't overwrite "IM BURNING" text
    QGVAR(nearFire) cutText [
        format [
            "<t color='#ffa500' font='PuristaBold' size='2'>%1</t>",
            LLSTRING(ImNearFire)
        ], 
        "PLAIN", 
        0.25,
        true, 
        true
    ];
};
[{_this call FUNC(fireLoop)}, _this, 4.5 + (random 1)] call CBA_fnc_waitAndExecute;
