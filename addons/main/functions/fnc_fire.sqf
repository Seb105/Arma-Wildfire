#include "script_component.hpp"

params [
    "_tree",
    ["_source", objNull] // Should only be used to spread fire from burning object to object, not start fires.
];
if (!isNull _source && {
    !(_source in GVAR(burningObjects))
}) exitwith {};
// Tree has gone out since spreading fire.

_bbr = boundingBoxReal _tree;
_p1 = _bbr select 0;
_p2 = _bbr select 1;
_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
_maxLength = abs ((_p2 select 1) - (_p1 select 1));
_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
private _basePos = (getPosATL _tree) vectorAdd [0, 0, 1];
private _particles = [];

private _createLight = count (_tree nearObjects ["#lightPoint", 35]) isEqualto 0;
private _light = if (_createLight) then {
    _light = "#lightpoint" createvehiclelocal _basePos;
    _light setLightColor [0, 0, 0];
    _light setLightAmbient [1, 0.45, 0.3];
    _light setLightIntensity 300;
    _light setLightUseFlare false;
    _light setLightAttenuation [35, 1, 0, 0.005];
    _particles pushBack _light;
    _light
};

private _particlesize = _maxLength max _maxWidth;
private _fire = "#particleSource" createvehiclelocal _basePos;
_fire setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 10, 32, 1], "", "Billboard", 3, 8, [0, 0, _maxHeight/3], [0, 0, 0.5], 0, 1.27, 1, 0, [_particlesize/2, _particlesize/2], [[1, 1, 1, -100], [1, 1, 1, -100], [0, 0, 0, 0]], [1], 0, 0, "", "", "", 0, false, 0, [[0, 0, 0, 0]]];
_fire setParticleRandom [
    2,
    [_maxWidth/4, _maxWidth/4, _maxHeight/3],
    [0.05, 0.05, 0.25],
    0,
    0,
    [0.1, 0.1, 0.1, 0],
    0,
    0,
    0.25,
    0
];
// setParticleFire causes lag
// _fire setParticleFire [0.25, 15, 0.1];
_fire setDropInterval 1.5*0.9 + 1.5*(random 0.2);
_particles pushBack _fire;

private _smoke = "#particleSource" createvehiclelocal _basePos;
_smoke setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d", 8, 0, 40, 1], "", "Billboard", 1, 25, [0, 0, _maxHeight/1.5], [0, 0, 3], 1, 0.045, 0.04, 0.05, [_particlesize, _particlesize*2], [[0.85, 0.85, 0.85, 0.9], [0.35, 0.35, 0.35, 0.75], [0.35, 0.35, 0.35, 0.45], [0.42, 0.42, 0.42, 0.28], [0.42, 0.42, 0.42, 0.16], [0.42, 0.42, 0.42, 0.09], [0.42, 0.42, 0.42, 0.06], [0.5, 0.5, 0.5, 0.02], [0.5, 0.5, 0.5, 0]], [0, 0.55, 0.35], 0.3, 0.2, "", "", "", 0, false, 0, [[0, 0, 0, 0]]];
_smoke setParticleRandom [2, [_maxWidth/3, _maxLength/3, 0.15], [-0, 0, 0], 0.5, 0, [0, 0, 0, 0.25], 0, 0, 0.5, 0];
_smoke setDropInterval 2*0.9 + 2*(random 0.2);
_particles pushBack _smoke;

private _damageDistance = (_maxLength max _maxWidth) + GVAR(damageDistance);
// https://laist.com/news/how-to-survive-a-wildfire-tips
if (isServer) then {
    private _sound = createSoundSource [QGVAR(Sound_fire), _tree, [], 0];
    _particles pushBack _sound;
    GVAR(burningObjects) pushBackUnique _tree;
    publicVariable QGVAR(burningObjects);
    private _endtime = time + GVAR(burntime);
    private _nearbyObjects = nearestTerrainObjects [_tree, GVAR(burnabletypes), GVAR(spreaddistance)];
    GVAR(treeHash) set [hashValue _tree, [_endtime, _nearbyObjects, _damagedistance]];
};

[
    {
        _this call FUNC(fireLoop)
    }, [_tree, _particles, _damagedistance * 1.25], 10 // Allow time for this object to appear in burningObjects array
] call CBA_fnc_waitandexecute;
