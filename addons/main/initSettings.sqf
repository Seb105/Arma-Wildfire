[
    QGVAR(spreadDistance),  // varName
    "SLIDER",               // type
    [LLSTRING(SpreadDistTitle), LLSTRING(SpreadDistTooltip)],        // title
    LLSTRING(Wildfire),  // Category
    [15, 100, 35, 0],       // Values 
    true,                   // isGlobal?
    {  
        GVAR(spreadSleep) = GVAR(spreadDistance)/GVAR(spreadSpeed)
    },                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;

[
    QGVAR(spreadSpeed),  // varName
    "SLIDER",               // type
    [LLSTRING(SpreadSpeedTitle), LLSTRING(SpreadSpeedTooltip)],        // title
    LLSTRING(Wildfire),  // Category
    [0.25, 10, 0.25, 2],       // Values 
    true,                   // isGlobal?
    {  
        GVAR(spreadSleep) = GVAR(spreadDistance)/GVAR(spreadSpeed)
    },                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;

[
    QGVAR(burnBuildings),  // varName
    "CHECKBOX",               // type
    LLSTRING(BurnBuildings),        // title
    LLSTRING(Wildfire),  // Category
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
    LLSTRING(MaxBurningObjects),        // title
    LLSTRING(Wildfire),  // Category
    [0, 3000, 600, 0],       // Values 
    true,                   // isGlobal?
    nil,                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;

[
    QGVAR(burnTime),  // varName
    "SLIDER",               // type
    [LLSTRING(BurnTimeTitle), LLSTRING(BurnTimeTooltip)],        // title
    LLSTRING(Wildfire),  // Category
    [30, 300, 90, 0],       // Values 
    true,                   // isGlobal?
    nil,                      // Script executed
    false                   // Requires restart?
] call CBA_fnc_addSetting;