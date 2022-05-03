#include "script_component.hpp"

params ["_unit"];
if (_unit == call CBA_fnc_currentUnit) then {
    QGVAR(onfire) cuttext [
        format [
            "<t color='#ff0000' font='PuristaBold' size='2'>%1</t>",
            LLstrinG(ImBurning)
        ],
        "PLAin",
        0.25,
        true,
        true
    ];
};
_bodyPart = selectRandom ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
[_unit, 0.25, _bodyPart, "stab", _unit, [], false] call ace_medical_fnc_adddamagetoUnit;
