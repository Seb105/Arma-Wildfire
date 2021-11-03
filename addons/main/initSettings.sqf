[
    QGVAR(spreadDistance),  // varName
    "SLIDER",               // type
    [LLString(SpreadDistTitle), LLSTRING(SpreadDistTooltip)],        // title
    LLString(Wildfire),  // Category
    [15, 100, 35, 0],       // Values 
    true,                   // isGlobal?
    {  
        GVAR(spreadSleep) = (GVAR(spreadDistance)/GVAR(spreadSpeed))/2
    },                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;

[
    QGVAR(spreadSpeed),  // varName
    "SLIDER",               // type
    [LLString(SpreadSpeedTitle), LLSTRING(SpreadSpeedTooltip)],        // title
    LLString(Wildfire),  // Category
    [15, 100, 35, 0],       // Values 
    true,                   // isGlobal?
    {  
        GVAR(spreadSleep) = (GVAR(spreadDistance)/GVAR(spreadSpeed))/2
    },                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;

[
    QGVAR(burnBuildings),  // varName
    "SLIDER",               // type
    LLString(BurnBuildings),        // title
    LLString(Wildfire),  // Category
    false,                  // Values 
    true,                   // isGlobal?
    {  
        GVAR(burnableTypes) = if (GVAR(burnBuildings)) then {
            ["TREE", "SMALL TREE", "BUSH", "BUILDING", "HOUSE", "CHURCH", "CHAPEL", "FUELSTATION"]
        } else {
            ["TREE", "SMALL TREE", "BUSH"]
        };
    },                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;

[
    QGVAR(maxBurningObjects),  // varName
    "SLIDER",               // type
    LLString(MaxBurningObjects),        // title
    LLString(Wildfire),  // Category
    [0, 600, 3000, 0],       // Values 
    true,                   // isGlobal?
    nil,                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;

[
    QGVAR(burnTime),  // varName
    "SLIDER",               // type
    [LLString(BurnTimeTitle), LLSTRING(BurnTimeTooltip)],        // title
    LLString(Wildfire),  // Category
    [30, 90, 300, 0],       // Values 
    true,                   // isGlobal?
    nil,                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;