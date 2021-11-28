#include "script_component.hpp"
#define SEARCH_DISTANCE 100

params ["_unit", "_source"];
private _grp = group _unit;
if (_grp getVariable [QGVAR(nextFlee), 0] > time) exitWith {};
_grp setVariable [QGVAR(nextFlee), time + 5];
private _unitPos = getPos _unit;
private _sourcePos = getPos _source;
// Line directly away from the source of fire.
private _fleePos = ((_sourcePos vectorFromTo _unitPos) vectorMultiply SEARCH_DISTANCE) vectorAdd _unitPos;
_fleePos set [2, 0];
(units _grp) doMove _fleePos;
