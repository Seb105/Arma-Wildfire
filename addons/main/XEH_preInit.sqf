#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf"

if (isServer) then {
    GVAR(burningObjects) = [];
    GVAR(burnedObjects) =  [];
    GVAR(emergencyExtinguish) = false;
};

ADDON = true;