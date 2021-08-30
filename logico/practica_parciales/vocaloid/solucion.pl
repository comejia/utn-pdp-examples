%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Vocaloid
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parte a)

% sabeCantar(Cantante, Cancion)
% Cancion:
%   cancion(Tema, Duracion)
sabeCantar(megurineLuka, cancion(nightFever, 4)).
sabeCantar(megurineLuka, cancion(foreverYoung, 5)).
sabeCantar(hatsuneMiku, cancion(tellYourWorld, 4)).
sabeCantar(gumi, cancion(foreverYoung, 4)).
sabeCantar(gumi, cancion(tellYourWorld, 5)).
sabeCantar(seeU, cancion(novemberRain, 6)).
sabeCantar(seeU, cancion(nightFever, 5)).

vocaloid(Cantante):-sabeCantar(Cantante, _).

% Punto 1
esNovedoso(Cantante):-
  sabeUnParDeTemas(Cantante),
  duracionTotalDeTemas(Cantante, Total),
  Total < 15.

sabeUnParDeTemas(Cantante):-
  sabeCantar(Cantante, cancion(Tema1, _)),
  sabeCantar(Cantante, cancion(Tema2, _)),
  Tema1 \= Tema2.

duracionTotalDeTemas(Cantante, Total):-
  findall(Duracion, sabeCantar(Cantante, cancion(_, Duracion)), ListaDuracion),
  sum_list(ListaDuracion, Total).

% Punto 2
esAcelerado(Cantante):-
  vocaloid(Cantante),
  not((sabeCantar(Cantante, cancion(_, Duracion)), Duracion > 4)).


% Parte b)

% Punto 1
% concierto(Nombre, Pais, CantidadDeFama, TipoDeConcierto)
% TipoDeConcierto
%   gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)
%   mediano(DuracionTotalMinima)
%   pequenio(DuracionMinimaDeCancion)
concierto(mikuExpo, eeuu, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

% Punto 2
puedeParticipar(Cantante, Concierto):-
  vocaloid(Cantante),
  concierto(Concierto, _, _, Requisito),
  cumpleRequisito(Cantante, Requisito).
puedeParticipar(hatsuneMiku, Concierto):-
  concierto(Concierto, _, _, _).

cumpleRequisito(Cantante, gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)):-
  cantidadDeTemas(Cantante, TotalCanciones), TotalCanciones > CantidadMinimaDeCanciones,
  duracionTotalDeTemas(Cantante, DuracionTotal), DuracionTotal > DuracionTotalMinima.
cumpleRequisito(Cantante, mediano(DuracionTotalMinima)):-
  duracionTotalDeTemas(Cantante, DuracionTotal), DuracionTotal > DuracionTotalMinima.
cumpleRequisito(Cantante, pequenio(DuracionMinima)):-
  sabeCantar(Cantante, cancion(_, Duracion)), Duracion > DuracionMinima.

cantidadDeTemas(Cantante, Total):-
  findall(Cancion, sabeCantar(Cantante, Cancion), ListaCanciones),
  length(ListaCanciones, Total).

% Punto 3
vocaloidMasFamoso(Cantante):-
  vocaloid(Cantante),
  famaTotalPorParticipar(Cantante, Total1),
  not((famaTotalPorParticipar(_, Total2), Total1 < Total2)).

famaTotalPorParticipar(Cantante, FamaTotal):-
  vocaloid(Cantante),
  findall(Fama, (puedeParticipar(Cantante, Concierto), concierto(Concierto, _, Fama, _)), ListaFama),
  sum_list(ListaFama, FamaObtenida),
  cantidadDeTemas(Cantante, TotalCanciones),
  FamaTotal is FamaObtenida * TotalCanciones.

% Punto 4
conoceA(megurineLuka, hatsuneMiku).
conoceA(megurineLuka, gumi).
conoceA(gumi, seeU).
conoceA(seeU, kaito).

unicoQueParticipaDeConcierto(Cantante, Concierto):-
  not(puedeParticipar(Cantante, Concierto)).
unicoQueParticipaDeConcierto(Cantante, Concierto):-
  puedeParticipar(Cantante, Concierto),
  conoceA(Cantante, Conocido),
  not(puedeParticipar(Conocido, Concierto)),
  unicoQueParticipaDeConcierto(Conocido, Concierto).

% Punto 5
% No tendria que hacer ningun cambio, solo agregar una regla mas de "cumpleRequisito"
% para validar si el cantante puede o no participar del concierto.
% Esto fue gracias al uso de functores en el hecho "concierto"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(vocaloid).

  test(fakeTest):-
    true.

:- end_tests(vocaloid).
