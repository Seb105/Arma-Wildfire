#include "script_component.hpp"

!(_this in GVAR(burningObjects) || {_this in GVAR(burnedObjects) }|| {isObjectHidden _this} || {damage _this >= 0.55})