#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf"

if (isServer) then {
    GVAR(burningObjects) = [];
    GVAR(burnedObjects) =  [];
    GVAR(emergencyExtinquish) = false;
};

ADDON = true;