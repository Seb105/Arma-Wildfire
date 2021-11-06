#include "script_component.hpp"

params ["_object", "_length"];

private _windStr = windStr;
private _width = GVAR(spreadDistance)/(1+_windStr);
private _offset = (vectorNormalized wind) vectorMultiply (_windStr * GVAR(spreadDistance) * 0.95);
private _pos = (getPosWorld _object) vectorAdd _offset;
private _return = [_pos, _width, _length, windDir, false];
// DEBUG_CENTRE = getPosWorld _object;
// DEBUG_ELLIPSE = [_pos, _width, _length, windDir, [1, 0, 0, 1]];

[_pos, _width, _length, windDir, false]
