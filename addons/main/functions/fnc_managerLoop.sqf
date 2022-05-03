#include "script_component.hpp"

private _sleep = random GVAR(spreadsleep);
private _objectsAreBurning = count GVAR(burningObjects) > 0;
if (_objectsAreBurning) then {
    {
        private _tree = _x;
        private _treeDetails = GVAR(treeHash) get (hashValue _tree);
        _treeDetails params ["_endtime", "_nearbyObjects", "_damagedistance"];
        if (time > _endtime) then {
            [_tree, false] call FUNC(removeObject);
            continue;
        };
    } forEach GVAR(burningObjects);
    
    for "_i" from 0 to _sleep do {
        [
            {
                private _onfireunits = [];
                {
                    private _tree = _x;
                    private _treeDetails = GVAR(treeHash) get (hashValue _tree);
                    _treeDetails params ["_endtime", "_nearbyObjects", "_damagedistance"];
                    private _nearbyunits = _tree nearEntities ["Man", _damagedistance];
                    private _nearbyleaders = _nearbyunits apply {
                        leader _x
                    };
                    _onfireunits append _nearbyunits;
                    _nearbyleaders = _nearbyleaders arrayintersect _nearbyleaders;
                    {
                        [_x, _tree] remoteExecCall [QFUNC(unitAvoidfire)];
                    } forEach _nearbyleaders;
                } forEach GVAR(burningObjects);
                _onfireunits = _onfireunits arrayintersect _onfireunits;
                {
                    [_x] remoteExecCall [QFUNC(firedamage), _x];
                } forEach _onfireunits;
            },
            nil,
            _i
        ] call CBA_fnc_waitandexecute;
    };
};

if (
_objectsAreBurning
&& {
    GVAR(maxBurningObjects) isEqualto 0
    || {
        count GVAR(burningObjects) < GVAR(maxBurningObjects)
    }
}
) then {
    private _trees = +GVAR(burningObjects);
    // don't modify array whilst iterating over it.
    private _rainCoef = (1.1-rain) min 1;
    private _spreadDistwind = (1 + windStr) * GVAR(spreaddistance);
    private _windAreaBase = _spreadDistwind call FUNC(getwindArea);
    private _windAreaBasePos = _windAreaBase#0;
    {
        private _tree = _x;
        if ( // Nearby player check
        GVAR(mindistancetoplayer) isnotEqualto 0
        && {
            (allplayers) findif {
                _x distance2D _tree < GVAR(mindistancetoplayer)
            } isEqualto -1
        }
        ) then {
            continue
        };
        private _windArea = +_windAreaBase;
        _windArea set [0, _windAreaBasePos vectorAdd getPosWorld _tree];
        private _treeDetails = GVAR(treeHash) get (hashValue _tree);
        _treeDetails params ["_endtime", "_nearbyObjects", "_damagedistance"];
        _nearbyObjects = _nearbyObjects select {
            _x call FUNC(canBurn)
        };
        // Removes objects that could never be burned, and saves result
        GVAR(treeHash) set [hashValue _tree, [_endtime, _nearbyObjects, _damagedistance]];
        private _burn = (_nearbyObjects inAreaArray _windArea) select {
            [_tree, _x, _rainCoef, _spreadDistwind] call FUNC(shouldStartfire)
        };
        // selects a sample of burnable objects
        {
            private _toBurn = _x;
            [
                {
                    params ["_toBurn", "_spreadSource"];
                    [_toBurn, _spreadSource] remoteExecCall [QFUNC(fire)];
                },
                [_toBurn, _tree],
                random _sleep
            ] call CBA_fnc_waitandexecute;
        } forEach _burn;
    } forEach _trees;
    publicVariable QGVAR(burningObjects);
} else {
    _sleep = 5;
    // if no objects are burning, check more frequently so there is not a big delay at start of fires.
};

[
    {
        call FUNC(managerLoop)
    },
    nil,
    _sleep
] call CBA_fnc_waitandexecute;
