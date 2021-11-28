#include "script_component.hpp"

params ["_tree"];
if (typeOf _tree isEqualTo "") then {
    _tree hideObjectGlobal true;
    if (GVAR(placeBurnedTrees)) then {
        private _firstLetter = ((getModelInfo _tree)#0) select [0,1];
        private _treePos = getPosASL _tree;
        switch _firstLetter do {
            case "t": { // tree
                private _newTreeType = selectRandom [
                    "a3\vegetation_f_enoch\tree\d_betula_pendula_stem.p3d", 
                    "a3\vegetation_f_enoch\tree\d_betula_pendula_stump.p3d"
                ];
                private _newTree = createSimpleObject [_newTreeType, [0,0,0]];
                private _scale = (((0 boundingBoxReal _tree)#2)/((0 boundingBoxReal _newTree)#2));
                if (_newTreeType isEqualTo "a3\vegetation_f_enoch\tree\d_betula_pendula_stem.p3d") then {
                    _y = random 360; 
                    _p = 0; 
                    _r = -90;
                    _newTree setVectorDirAndUp [
                        [sin _y * cos _p, cos _y * cos _p, sin _p],
                        [[sin _r, -sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D
                    ];
                    _newTree setObjectScale _scale;
                    _newTree setPosASL (_treePos vectorAdd [0, 0, ((random 7) - 3.5) * _scale]);
                } else {
                    _scale = _scale/3;
                    _newTree setDir (random 360);
                    _newTree setObjectScale _scale;
                    _newTree setPosASL (_treePos vectorAdd [0, 0, -((random 2.5) * _scale)]);
                };
            };
            case "b": { // bush
                private _newBush = createSimpleObject ["\a3\plants_f\Bush\b_ficusC2d_F.p3d", [0,0,0]];
                private _scale = (((0 boundingBoxReal _tree)#2)/((0 boundingBoxReal _newBush)#2));
                _newBush setDir (random 360);
                _newBush setObjectScale _scale;
                _newBush setPosASL _treePos;
            };
        };
    };
} else {
    _tree setDamage ((random 1) + 0.55);
};
GVAR(burnedObjects) pushBack _tree;
GVAR(burningObjects) deleteAt (GVAR(burningObjects) find _tree);
