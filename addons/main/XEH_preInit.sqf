#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

private _ACEMedicalLoaded = !isNull (configFile >> "CfgPatches" >> "ace_medical");
if (_ACEMedicalLoaded) then {
    [QPATHTOF(functions\DOUBLES(fnc,fireDamageACE).sqf), QFUNC(fireDamage)] call CBA_fnc_compileFunction;
} else {
    [QPATHTOF(functions\DOUBLES(fnc,fireDamage).sqf), QFUNC(fireDamage)] call CBA_fnc_compileFunction;
};

#include "initSettings.sqf"

if (isServer) then {
    GVAR(burningObjects) = [];
    publicVariable QGVAR(burningObjects);
    GVAR(burnedObjects) =  [];
    GVAR(emergencyExtinguish) = false;
    GVAR(treeHash) = createHashMap;
    [
        {
            !isNil QGVAR(spreadSleep)
        },
        {
            call FUNC(managerLoop);
        }
    ] call CBA_fnc_waitUntilAndExecute;
};

ADDON = true;
