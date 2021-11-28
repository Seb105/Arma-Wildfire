#include "script_component.hpp"

params ["_unit"];
if (_unit == call CBA_fnc_currentUnit) then {
    "youreOnFire" cutText [
        format [
            "<t color='#ff0000' font='PuristaBold' size='2'>%1</t>",
            LLSTRING(ImBurning)
        ], 
        "PLAIN", 
        0.25, 
        true, 
        true
    ];
} else {
    _unit call FUNC(unitAvoidFire);
};
if (isDamageAllowed _unit) then {
    _unit setDamage (damage _unit + 0.05);
};
