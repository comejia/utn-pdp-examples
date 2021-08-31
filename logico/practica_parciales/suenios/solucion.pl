%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Sueños
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Punto 1a
% cree(Persona, Personaje)
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).
% "Diego no cree en nadie", no se modela por el principio del Universo Cerrado,
% ya que todo lo que no esta en la base de conocimiento se considera falso.

% quiere(Persona, Suenio)
quiere(gabriel, ganarLoteria([5, 9])).
quiere(gabriel, futbolista(arsenal)).
quiere(juan, cantante(100000)).
quiere(macarena, cantante(10000)).

% Punto 1b
% Entraron en juego el Principio del Universo Cerrado.
% Hecho individuales y compuestos


% Punto 2
ambisioso(Persona):-
  dificultadTotalDeSuenios(Persona, Total),
  Total > 20.

dificultadTotalDeSuenios(Persona, Total):-
  quiere(Persona, _),
  findall(Dificultad, dificultadDeSuenio(Persona, _, Dificultad), Dificultades),
  sum_list(Dificultades, Total).

dificultadDeSuenio(Persona, Suenio, Dificultad):-
  quiere(Persona, Suenio),
  dificultad(Suenio, Dificultad).

dificultad(cantante(Ventas), 6):-Ventas > 500000.
dificultad(cantante(Ventas), 4):-Ventas =< 500000.
dificultad(ganarLoteria(Numeros), Dificultad):-length(Numeros, Cantidad), Dificultad is 10 * Cantidad.
dificultad(futbolista(Equipo), 3):-equipoChico(Equipo).
dificultad(futbolista(Equipo), 16):-not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).


% Punto 3
tieneQuimica(Personaje, Persona):-
  cree(Persona, Personaje),
  esCompatible(Persona, Personaje).

esCompatible(Persona, campanita):-
  dificultadDeSuenio(Persona, _, Dificultad),
  Dificultad < 5.

esCompatible(Persona, Personaje):-
  Personaje \= campanita,
  tieneSueniosPuros(Persona),
  not(ambisioso(Persona)).

tieneSueniosPuros(Persona):-forall(quiere(Persona, Suenio), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(Ventas)):-Ventas < 200000.


% Punto 4
esAmigo(campanita, reyesMagos).
esAmigo(campanita, conejoDePascua).
esAmigo(conejoDePascua, cavenaghi).

alegra(Personaje, Persona):-
  quiere(Persona, _),
  tieneQuimica(Personaje, Persona),
  apto(Personaje).

apto(Personaje):-
  not(enfermo(Personaje)).
apto(Personaje):-
  amistades(Personaje, OtroPersonaje),
  not(enfermo(OtroPersonaje)).

amistades(Personaje, OtroPersonaje):-
  esAmigo(Personaje, OtroPersonaje).
amistades(Personaje, OtroPersonaje):-
  esAmigo(Personaje, UnPersonaje),
  amistades(UnPersonaje, OtroPersonaje).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(suenios).

  test(fakeTest):-
    true.

:- end_tests(suenios).
