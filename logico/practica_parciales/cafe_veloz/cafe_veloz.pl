%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Cafe Veloz
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).

% Punto 1a
tomo(passarella, Cosa):-not(tomo(maradona, Cosa)).
% Punto 1b
tomo(pedemonti, Sustancia):-tomo(chamot, Sustancia).
tomo(pedemonti, Sustancia):-tomo(maradona, Sustancia).
% Punto 1c
% Por el Principio del universo cerrado no se modela, ya que todo lo que no esta
% en la base de conocimiento se considera falso.


% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3).
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina).
sustanciaProhibida(cocaina).


% Punto 2
puedeSerSuspendido(Jugador):-
  distinct(Jugador, tomo(Jugador, Cosa)),
  estaProhibido(Cosa).

estaProhibido(sustancia(Sustancia)):-
  sustanciaProhibida(Sustancia).
estaProhibido(compuesto(Compuesto)):-
  composicion(Compuesto, SustanciasDeCompuesto),
  member(Sustancia, SustanciasDeCompuesto),
  sustanciaProhibida(Sustancia).
estaProhibido(producto(Producto, Cantidad)):-
  maximo(Producto, MaximoPermitido),
  Cantidad > MaximoPermitido.


% Punto 3
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

malaInfluencia(Jugador, JugadorPerjudicado):-
  puedeSerSuspendido(Jugador),
  puedeSerSuspendido(JugadorPerjudicado),
  conoce(Jugador, JugadorPerjudicado).

conoce(Jugador, OtroJugador):-
  amigo(Jugador, OtroJugador).
conoce(Jugador, OtroJugador):-
  amigo(Jugador, UnJugador),
  conoce(UnJugador, OtroJugador).


% Punto 4
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

chanta(Medico):-
  medico(Medico),
  forall(atiende(Medico, Jugador), puedeSerSuspendido(Jugador)).

medico(Medico):-distinct(Medico, atiende(Medico, _)).

% Punto 5
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

cuantaFalopaTiene(Jugador, Cantidad):-
  jugador(Jugador),
  findall(Nivel, (tomo(Jugador, Cosa), nivelDeAlteracion(Cosa, Nivel)), Niveles),
  sum_list(Niveles, Cantidad).

nivelDeAlteracion(producto(_, _), 0).
nivelDeAlteracion(sustancia(Sustancia), Nivel):-
  nivelFalopez(Sustancia, Nivel).
nivelDeAlteracion(compuesto(Compuesto), Nivel):-
  composicion(Compuesto, Sustancias),
  findall(Valor, (member(Sustancia, Sustancias), nivelFalopez(Sustancia, Valor)), Valores),
  sum_list(Valores, Nivel).


% Punto 6
medicoConProblemas(Medico):-
  medico(Medico),
  findall(Jugador, (atiende(Medico, Jugador), jugadorConflictivo(Jugador)), Jugadores),
  length(Jugadores, Cantidad),
  Cantidad >= 3.

jugadorConflictivo(Jugador):-puedeSerSuspendido(Jugador).
jugadorConflictivo(Jugador):-conoce(Jugador, maradona).


% Punto 7
programaTVFantinesco(JugadoresPosibles):-
  findall(Jugador, puedeSerSuspendido(Jugador), Jugadores),
  combinacionDeJugadores(Jugadores, JugadoresPosibles).

combinacionDeJugadores([], []).
combinacionDeJugadores([Jugador|Jugadores], [Jugador|Posibles]):-
  combinacionDeJugadores(Jugadores, Posibles).
combinacionDeJugadores([_|Jugadores], Posibles):-
  combinacionDeJugadores(Jugadores, Posibles).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(cafe_veloz).

  test(fakeTest):-
    true.

:- end_tests(cafe_veloz).
