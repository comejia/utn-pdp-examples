%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Vocaloid
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% vocaloid(Cantante, Cancion)
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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(vocaloid).

  test(fakeTest):-
    true.

:- end_tests(vocaloid).
