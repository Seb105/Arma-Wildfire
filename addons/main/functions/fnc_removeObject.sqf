#include "script_component.hpp"

params ["_tree"];
if (typeOf _tree isEqualTo "") then {
    _tree hideObjectGlobal true;
    _isTree = (toLower ((getModelInfo _tree)#0) select [0,1]) == "t";
    if (_isTree) then {
        private _treePos = getPosASL _tree;
        private _newTreeType = selectRandom [
            "a3\vegetation_f_enoch\tree\d_betula_pendula_stem.p3d", 
            "a3\vegetation_f_enoch\tree\d_betula_pendula_stump.p3d"
        ];
        private _newTree = createSimpleObject [_newTreeType, [0,0,0]];
        if (_newTreeType isEqualTo "a3\vegetation_f_enoch\tree\d_betula_pendula_stem.p3d") then {
            _y = random 360; 
            _p = 0; 
            _r = -90;
            _newTree setPosASL (_treePos vectorAdd [0, 0, (random 7) - 3.5]);
            _newTree setVectorDirAndUp [
                [sin _y * cos _p, cos _y * cos _p, sin _p],
                [[sin _r, -sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D
            ];
        } else {
            _newTree setPosASL (_treePos vectorAdd [0, 0, -(random 2.5)]);
            _newTree setDir (random 360);
        };
    };
} else {
    _tree setDamage ((random 1) + 0.55);
};
GVAR(burnedObjects) pushBack _tree;
GVAR(burningObjects) deleteAt (GVAR(burningObjects) find _tree);
