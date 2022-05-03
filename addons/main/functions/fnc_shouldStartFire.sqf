#include "script_component.hpp"

params [
    "_burningObject",
    "_toBurnObject",
    "_rainCoef",
    "_spreaddistancewind"
];

private _baseSpreadChance = 0.25;
private _distanceCoef = linearConversion [
    0,
    _spreaddistancewind,
    _toBurnObject distance2D _burningObject,
    1,
    0,
    true
];
random 100 < _rainCoef * _distanceCoef * 100 * _baseSpreadChance
