%tiene(Persona, Bicicleta).
% Bicicletas:
%   mountainBike(Marca,CantidadDeCambios)
%   playera(Marca)
%   carrera(Marca,Peso)
tiene(santi, mountainBike(zenith,21)).
tiene(fede, mountainBike(peugeot,6)).
tiene(cecilia, playera(zenith)).
tiene(juan, carrera(venzo,15)).
tiene(cecilia, carrera(gt,12)).

% Implementar:

% esGrosa/1
esGrosa(mountainBike(_, CantidadDeCambios)):-CantidadDeCambios >= 18.
esGrosa(carrera(gt, _)).
esGrosa(carrera(_, Peso)):-Peso < 15.

% corredorProfesional/1
corredorProfesional(Persona):-
	corredor(Persona),
	forall(tiene(Persona, Bicicleta), esGrosa(Bicicleta)).

% corredor/1: Generador
corredor(Persona):-tiene(Persona, _).

% corredorAmateur/1
corredorAmateur(Persona):-
	corredor(Persona),
	not((tiene(Persona, Bicicleta), esGrosa(Bicicleta))).


:- begin_tests(ciclistas).
test(mountainBike__de_muchos_cambios_es_grosa) :-
	esGrosa(mountainBike(marcaLoca,18)).
test(mountainBike__de_pocos_cambios_no_es_grosa, fail) :-
	esGrosa(mountainBike(marcaLoca,17)).
test(carrera_marca_gt_es_grosa,nondet) :-
	esGrosa(carrera(gt,2)).
test(carrera_liviana_es_grosa) :-
	esGrosa(carrera(venzo,10)).
test(carrera_pesada_no_es_grosa, fail) :-
	esGrosa(carrera(venzo,17)).
test(corredores_profesionales,set(Persona == [santi])) :-
	corredorProfesional(Persona).
test(corredores_amateur,set(Persona == [juan, fede])) :-
	corredorAmateur(Persona).

:- end_tests(ciclistas).