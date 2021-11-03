#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main",
            "A3_Data_F",
            "A3_Sounds_F"
        };
        author = "Seb";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

class CfgSFX {
    class Fire;
    class Wildfire_Fire: Fire {
        name = "Sound: Wildfire";
        sound0[] = {"A3\Sounds_F\sfx\fire1_loop",1.25,1,150,1,0,0,0};
    };
};

class CfgVehicles {
    class Sound_Fire;
    class Wildfire_Sound_Wildfire: Sound_Fire {
        author = "Seb";
        scope = 1;
        sound = "wildfire_fire";
        displayName = "Wildfire";
    };

    class Module_F: Logic {
        class AttributesBase
        {
            class Default;
            class Edit;					// Default edit box (i.e., text input field)
            class Combo;				// Default combo box (i.e., drop-down menu)
            class Checkbox;				// Default checkbox (returned value is Boolean)
            class CheckboxNumber;		// Default checkbox (returned value is Number)
            class ModuleDescription;	// Module description
            class Units;				// Selection of units on which the module is applied
        };
        // Description base classes, for more information see below
        class ModuleDescription
        {
            class AnyBrain;
        };
    };

    class Wildfire_ModuleStartFire: Module_F
    {
        author = "Seb";
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(ModuleStartFireName);
        category = "Wildfire_Category";
        function = QFUNC(moduleFire);
        isGlobal = 1;
        isTriggerActivated = 1;
        class ModuleDescription: ModuleDescription
        {
            position = 1;
            description = CSTRING(ModuleStartFireDescription);
        };
    };

    class Wildfire_ModuleEmergencyStop: Wildfire_ModuleStartFire {
        displayName = CSTRING(ModuleEmergencyStopName);
        isTriggerActivated = 0;
        function = QFUNC(emergencyStop);
    };
};

class CfgFactionClasses {
    class NO_CATEGORY;
    class Wildfire_Category: NO_CATEGORY {
        displayName = CSTRING(Wildfire)
    };
};