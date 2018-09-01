/*
 * Author : [LM] Cheitan
 * (Un)Mount SLAT on given part
 *
 * Arguments :
 * 0: Vehicle <OBJECT>
 * 1: Part <STRING>
 * 2: (un)mount <NUMBER>
 *
 * Return Value :
 * None
 *
 * Example :
 * [vehicle, "hull", 1] call LM_fnc_doSLAT
 *
 */

params["_vehicle", "_part", "_mount"];

// On récupère les sources liées (en général yen a qu'une)
_anim = switch (_part) do {
	case "hull": { "showSLATHull" };
	case "turret": { "showSLATTurret" };
	default { [""] };
};

[player] call ace_common_fnc_goKneeling;

// Callback succès
_success = {
	(_this select 0) params["_vehicle", "_anim", "_mount"];
	_vehicle animateSource [_anim, _mount];
};

// Barre de chargement
_time = 30;
if(_part isEqualTo "turret") then {_time = 15};
[_time, [_vehicle, _anim, _mount], _success, {}, localize "STR_slat_inprogress"] call ace_common_fnc_progressBar;

