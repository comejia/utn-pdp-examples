%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Las Casas de Hogwarts
% NOMBRE: Cesar Mejia (comejia)
% Nota: El enunciado se encuentra en la pagina de pdp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parte 1: Sombrero seleccionador

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

% mago(Mago, TipoDeSangre, Caracteristica).
sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).
sangre(ron, pura).
sangre(luna, pura).

mago(Mago):-sangre(Mago, _).

% tieneCaracteristica(Mago, Caracteristica)
tieneCaracteristica(harry, coraje).
tieneCaracteristica(harry, amistad).
tieneCaracteristica(harry, orgullo).
tieneCaracteristica(harry, inteligencia).
tieneCaracteristica(draco, inteligencia).
tieneCaracteristica(draco, orgullo).
tieneCaracteristica(hermione, inteligencia).
tieneCaracteristica(hermione, orgullo).
tieneCaracteristica(hermione, responsabilidad).
tieneCaracteristica(ron, responsabilidad).
tieneCaracteristica(ron, coraje).
tieneCaracteristica(ron, amistad).
tieneCaracteristica(luna, amistad).
tieneCaracteristica(luna, inteligencia).
tieneCaracteristica(luna, responsabilidad).

% odia(Mago, CasaQueOdia).
odia(harry, slytherin).
odia(draco, hufflepuff).

% consideracionDeSombrero(Casa, Caracteristica).
consideracionDeSombrero(gryffindor, coraje).
consideracionDeSombrero(slytherin, orgullo).
consideracionDeSombrero(slytherin, inteligencia).
consideracionDeSombrero(ravenclaw, inteligencia).
consideracionDeSombrero(ravenclaw, responsabilidad).
consideracionDeSombrero(hufflepuff, amistad).

% Punto 1
permiteEntrar(Casa, Mago):-
  casa(Casa),
  mago(Mago),
  Casa \= slytherin.
permiteEntrar(slytherin, Mago):-
  sangre(Mago, TipoDeSangre),
  TipoDeSangre \= impura.

% Punto 2
tieneCaracterApropiado(Mago, Casa):-
  casa(Casa),
  mago(Mago),
  forall(consideracionDeSombrero(Casa, Caracteristica), tieneCaracteristica(Mago, Caracteristica)).

% Punto 3
enQueCasaPuedeQuedar(Mago, Casa):-
  tieneCaracterApropiado(Mago, Casa),
  permiteEntrar(Casa, Mago),
  not(odia(Mago, Casa)).
enQueCasaPuedeQuedar(hermione, gryffindor).

% Punto 4
cadenaDeAmistades(Magos):-
  todosAmistosos(Magos),
  cadenaDeCasas(Magos).

todosAmistosos(Magos):-
  forall(member(Mago, Magos), tieneCaracteristica(Mago, amistad)).

cadenaDeCasas([_]).
cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
  enQueCasaPuedeQuedar(Mago1, Casa),
  enQueCasaPuedeQuedar(Mago2, Casa),
  Mago1 \= Mago2,
  cadenaDeCasas([Mago2 | MagosSiguientes]).


% Parte 2: La copa de las casa
% accion(Mago, AccionRealizada, Puntaje)
accion(harry, estarFueraDeLaCama, (-50)).
accion(harry, irBosque, (-50)).
accion(harry, irTercerPiso, (-75)).
accion(harry, vencerAVolvermort, 60).
accion(hermione, irTercerPiso, (-75)).
accion(hermione, irSeccionRestringida, (-10)).
accion(hermione, usarIntelecto, 50).
accion(ron, ganarPartida, 50).
accion(draco, irAMazmorras, 0).

malaAccion(estarFueraDeLaCama).
malaAccion(irBosque).
malaAccion(irSeccionRestringida).
malaAccion(irTercerPiso).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

esBuenAlumno(Mago):-
  mago(Mago),
  not((accion(Mago, Accion, _), malaAccion(Accion))).

accionRecurrente(Accion):-
  accion(Mago, Accion, _),
  accion(OtroMago, Accion, _),
  Mago \= OtroMago.

puntajeTotal(Casa, Total):-
  casa(Casa),
  findall(Punto, (esDe(Mago, Casa), accion(Mago, _, Punto)), Puntos),
  sum_list(Puntos, Total).


casaGanadora(Ganador):-
  findall(Casa, casa(Casa), Casas),
  vence(Casas, Ganador).

vence([Casa, OtraCasa], Cual):-
  vencedor(Casa, OtraCasa, Cual).
vence([Casa, OtraCasa|Casas], Cual):-
  vencedor(Casa, OtraCasa, Ganador),
  vence([Ganador| Casas], Cual).

vencedor(Casa, OtraCasa, Ganador):-
  puntajeTotal(Casa, Total1),
  puntajeTotal(OtraCasa, Total2),
  Mayor is max(Total1, Total2),
  puntajeTotal(Ganador, Mayor).


respondio(hermione, dondeEstaBezoar, 20, snape).
respondio(hermione, comoLevitarPluma, 25, flitwick).

sumarPuntos(Mago, Puntaje):-respondio(Mago, _, Puntaje, Profesor), Profesor \= snape.
sumarPuntos(Mago, Puntaje):-respondio(Mago, _, Puntos, Profesor), Profesor = snape, Puntaje is Puntos * 0.5.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(hogwarts).

  test(fakeTest):-
    true.

:- end_tests(hogwarts).
