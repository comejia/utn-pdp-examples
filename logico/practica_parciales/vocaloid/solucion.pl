%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Vocaloid
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parte a)

% canta(Cantante, Cancion)
% Cancion:
%   cancion(Nombre, Duracion)
canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

vocaloid(Cantante):-canta(Cantante, _).

% Punto 1
esNovedoso(Cantante):-
  sabeUnParDeTemas(Cantante),
  duracionTotalDeCanciones(Cantante, Total),
  Total < 15.

sabeUnParDeTemas(Cantante):-
  canta(Cantante, UnaCancion),
  canta(Cantante, OtraCancion),
  UnaCancion \= OtraCancion.

duracionTotalDeCanciones(Cantante, Total):-
  findall(Duracion, duracionDeCancion(Cantante, Duracion), Duraciones),
  sum_list(Duraciones, Total).

duracionDeCancion(Cantante, Duracion):-
  canta(Cantante, cancion(_, Duracion)).

% Punto 2
esAcelerado(Cantante):-
  vocaloid(Cantante),
  not((duracionDeCancion(Cantante, Duracion), Duracion > 4)).
  %forall(duracionDeCancion(Cantante, Duracion), Duracion =< 4).

% Parte b)

% Punto 1
% concierto(Nombre, Pais, CantidadDeFama, TipoDeConcierto)
% TipoDeConcierto
%   gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)
%   mediano(DuracionTotalMaxima)
%   pequenio(DuracionMinimaDeCancion)
concierto(mikuExpo, eeuu, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

% Punto 2
puedeParticipar(Cantante, Concierto):-
  vocaloid(Cantante),
  Cantante \= hatsuneMiku,
  concierto(Concierto, _, _, Requisito),
  cumpleRequisitos(Cantante, Requisito).
puedeParticipar(hatsuneMiku, Concierto):-
  concierto(Concierto, _, _, _).

cumpleRequisitos(Cantante, gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)):-
  cantidadDeCanciones(Cantante, TotalCanciones), TotalCanciones > CantidadMinimaDeCanciones,
  duracionTotalDeCanciones(Cantante, DuracionTotal), DuracionTotal > DuracionTotalMinima.
cumpleRequisitos(Cantante, mediano(DuracionTotalMaxima)):-
  duracionTotalDeCanciones(Cantante, DuracionTotal), DuracionTotal < DuracionTotalMaxima.
cumpleRequisitos(Cantante, pequenio(DuracionMinimaDeCancion)):-
  duracionDeCancion(Cantante, Duracion), Duracion > DuracionMinimaDeCancion.

cantidadDeCanciones(Cantante, Cantidad):-
  findall(Cancion, canta(Cantante, Cancion), Canciones),
  length(Canciones, Cantidad).

% Punto 3
masFamoso(Cantante):-
  nivelDeFamoso(Cantante, NivelMasFamoso),
  not((nivelDeFamoso(_, OtroNivel), NivelMasFamoso < OtroNivel)).
  %forall(nivelFamoso(_, OtroNivel), NivelMasFamoso >= OtroNivel).

nivelDeFamoso(Cantante, Nivel):-
  famaTotalObtenida(Cantante, FamaTotal),
  cantidadDeCanciones(Cantante, TotalCanciones),
  Nivel is FamaTotal * TotalCanciones.

famaTotalObtenida(Cantante, FamaTotal):-
  vocaloid(Cantante),
  findall(Fama, famaDeConcierto(Cantante, Fama), ListaDeFama),
  sum_list(ListaDeFama, FamaTotal).

famaDeConcierto(Cantante, Fama):-
  puedeParticipar(Cantante, Concierto), concierto(Concierto, _, Fama, _).

% Punto 4
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

unicoQueParticipaDeConcierto(Cantante, Concierto):-
  puedeParticipar(Cantante, Concierto),
  not((conocido(Cantante, OtroCantante),
    puedeParticipar(OtroCantante, Concierto))).

%Conocido directo
conocido(Cantante, OtroCantante):-
  conoce(Cantante, OtroCantante).
%Conocido indirecto
conocido(Cantante, OtroCantante) :- 
  conoce(Cantante, UnCantante), 
  conocido(UnCantante, OtroCantante).

% Punto 5
% No tendria que hacer ningun cambio, solo agregar una regla mas de "cumpleRequisito/2"
% para validar si el cantante puede o no participar del concierto.
% El concepto que facilita los cambios para el nuevo requerimiento es el "polimorfismo", 
% que nos permite dar un tratamiento en particular a cada uno de los tipos de conciertos.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(vocaloid).

  test(fakeTest):-
    true.

:- end_tests(vocaloid).
