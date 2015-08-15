////////////////////////////////////////////////////////
//                                                    //
//               2013 Arma 3 Demo                     //
//                by Lynx of <G.I.D>                  //
//           - http://www.clan-gid.fr -               //
//                                                    //
////////////////////////////////////////////////////////

// here is the code required to spawn captured objects
if (isServer) then {call compile preprocessFile "addons\extraSites\initBuildings.sqf";};

if (hasInterface || isServer) then
{
[] execVM "addons\AUXOPS\init.sqf"; //Cael817, Init AUXOPS
};







