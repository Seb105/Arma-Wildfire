#include "script_component.hpp"


private _sleep = random GVAR(spreadSleep);

if (GVAR(maxBurningObjects) isEqualTo 0 || {count GVAR(burningObjects) < GVAR(maxBurningObjects)}) then {
    private _trees = +GVAR(burningObjects); // don't modify array whilst iterating over it.
    private _rainCoef = (1.1-rain) min 1;
    private _spreadDistWind = (1 + windStr) * GVAR(spreadDistance);
    private _windAreaBase = _spreadDistWind call FUNC(getWindArea);
    private _windAreaBasePos = _windAreaBase#0;
    {
        private _tree = _x;
        if ( // Nearby player check
            GVAR(minDistanceToPlayer) isNotEqualTo 0 
            && {(allPlayers) findIf {_x distance2D _tree < GVAR(minDistanceToPlayer)} isEqualTo -1}
        ) then {
            continue
        };
        private _windArea = +_windAreaBase;
        _windArea set [0, _windAreaBasePos vectorAdd getPosWorld _tree];
        private _treeDetails = GVAR(treeHash) get (hashValue _tree);
        _treeDetails params ["_endTime", "_nearbyObjects", "_damageDistance"];
        if (time > _endTime) then {
            [_tree, false] call FUNC(removeObject);
            continue;
        };
        _nearbyObjects = _nearbyObjects select {_x call FUNC(canBurn)}; // Removes objects that could never be burned, and saves result
        GVAR(treeHash) set [hashValue _tree, [_endTime, _nearbyObjects, _damageDistance]];
        private _burn = (_nearbyObjects inAreaArray _windArea) select {[_tree, _x, _rainCoef, _spreadDistWind] call FUNC(shouldStartFire)}; // Selects a sample of burnable objects
        {
            private _toBurn = _x;
            [
                {
                    params ["_toBurn", "_spreadSource"];
                    if (_toBurn in GVAR(burningObjects)) exitWith {}; // Could have already caught fire from wait.
                    [_toBurn, _spreadSource] remoteExecCall [QFUNC(fire)];
                },
                [_toBurn, _tree],
                random _sleep
            ] call CBA_fnc_waitAndExecute;
        } forEach _burn;
        for "_i" from 0 to _sleep step 1 do {
            [
                {
                    params ["_tree", "_damageDistance"];
                    if !(_tree in GVAR(burningObjects)) exitWith {}; // Tree could have gone out after this loop was made
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
