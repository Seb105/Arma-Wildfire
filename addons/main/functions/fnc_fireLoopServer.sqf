#include "script_component.hpp"


private _sleep = random GVAR(spreadSleep);

if ({GVAR(maxBurningObjects) isEqualTo 0 || {count GVAR(burningObjects) < GVAR(maxBurningObjects)}) then {
    private _trees = +GVAR(burningObjects); // don't modify array whilst iterating over it.
    private _rainCoef = (1.1-rain) min 1;
    private _spreadDistWind = (1 + windStr) * GVAR(spreadDistance);
    private _windAreaBase = _spreadDistWind call FUNC(getWindArea);

    {
        private _tree = _x;
        if ( // Nearby player check
            GVAR(minDistanceToPlayer) isNotEqualTo 0 
            && {(allPlayers) find {_x distance2D _tree < GVAR(minDistanceToPlayer)} isEqualTo -1}
        ) then {continue};
        private _windArea = _windAreaBase vectorAdd getPosWorld _tree;
        private _treeDetails = GVAR(treeHash) get (hashValue _tree);
        _treeDetails params ["_endTime", "_nearbyObjects", "_damageDistance"];
        if (time > _endTime) then {
            GVAR(burningObjects) deleteAt (GVAR(burningObjects) find _tree);
            continue;
        };

        _nearbyObjects = _nearbyObjects select {_x call FUNC(canBurn)}; // Removes objects that could never be burned, and saves result
        GVAR(treeHash) set [hashValue _tree, [_endTime, _nearbyObjects, _damageDistance]];
        private _burn = (_nearbyObjects inAreaArray _windArea) select {[_tree, _x, _rainCoef, _spreadDistWind] call FUNC(shouldStartFire)}; // Selects a sample of burnable objects
        {
            private _toBurn = _x;
            [
                {
                    params ["_toBurn"];
                    if (_toBurn in GVAR(burningObjects)) exitWith {}; // Object is already burning
                    [_toBurn] remoteExecCall [QFUNC(fire)];
                },
                _toBurn,
                random _sleep
            ] call CBA_fnc_waitAndExecute;
        } forEach _burn;
        
        for "_i" from 0 to _sleep step 1 do {
            [
                {
                    params ["_tree", "_damageDistance"];
                    private _nearbyUnits = _tree nearEntities ["Man", _damageDistance]; 
                    {
                        [_x] remoteExecCall [QFUNC(fireDamage), _x];
                    } forEach _nearbyUnits;
                },
                [_tree, _damageDistance],
                _i
            ] call CBA_fnc_waitAndExecute;
        };
    } forEach _trees;

    publicVariable QGVAR(burningObjects);
};

[
    {call FUNC(fireLoopServer)},
    nil, 
    _sleep
] call CBA_fnc_waitAndExecute;
