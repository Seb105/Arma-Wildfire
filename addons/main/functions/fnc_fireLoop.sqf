#include "script_component.hpp"

params ["_tree", "_particles", "_warningdistance"];
if !(_tree in GVAR(burningObjects)) exitwith {
    {
        deletevehicle _x
    } forEach _particles;
};
if (hasinterface && {
    (call CBA_fnc_currentUnit) distance _tree < _warningdistance
}) then {
    if (QGVAR(onfire) in allCutLayers) exitwith {};
    // don't overwrite "IM BURNinG" text
    QGVAR(nearfire) cuttext [
        format [
            "<t color='#ffa500' font='PuristaBold' size='2'>%1</t>",
            LLstrinG(ImNearfire)
        ],
        "PLAin",
        0.5,
        true,
        true
    ];
};
[{
    _this call FUNC(fireLoop)
}, _this, 4.5 + (random 1)] call CBA_fnc_waitandexecute;
