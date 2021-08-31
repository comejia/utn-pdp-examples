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

% hizo(Mago, Accion)
hizo(harry, estarFueraDeLaCama).
hizo(harry, irBosque).
hizo(harry, irTercerPiso).
hizo(harry, vencerAVolvermort).
hizo(hermione, irTercerPiso).
hizo(hermione, irSeccionRestringida).
hizo(hermione, usarIntelecto).
hizo(ron, ganarPartida).
hizo(draco, irAMazmorras).
hizo(luna, usarIntelecto).
hizo(hermione, responderPregunta).

% puntajeQueGenera(Mago, Puntaje)
puntajeQueGenera(estarFueraDeLaCama, -50).
puntajeQueGenera(irBosque, -50).
puntajeQueGenera(irTercerPiso, -75).
puntajeQueGenera(vencerAVolvermort, 60).
puntajeQueGenera(irSeccionRestringida, -10).
puntajeQueGenera(usarIntelecto, 50).
puntajeQueGenera(ganarPartida, 50).
puntajeQueGenera(irAMazmorras, 0).
puntajeQueGenera(responderPregunta, Puntaje):-pregunta(_, Puntaje, Profesor), Profesor \= snape.
puntajeQueGenera(responderPregunta, Puntaje):-pregunta(_, Puntos, snape), Puntaje is Puntos // 2.

hizoAlgunaAccion(Mago):-
  hizo(Mago, _).

hizoMalaAccion(Mago):-
  hizo(Mago, Accion),
  puntajeQueGenera(Accion, Puntaje),
  Puntaje < 0.

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% Punto 1a
esBuenAlumno(Mago):-
  hizoAlgunaAccion(Mago), 
  not(hizoMalaAccion(Mago)).

% Punto 1b
accionRecurrente(Accion):-
  hizo(Mago, Accion),
  hizo(OtroMago, Accion),
  Mago \= OtroMago.

% Punto 2
puntajeTotal(Casa, Total):-
  esDe(_, Casa),
  findall(Punto, (esDe(Mago, Casa), hizo(Mago, Accion), puntajeQueGenera(Accion, Punto)), Puntos),
  sum_list(Puntos, Total).

% Punto 3
casaGanadora(Casa):-
  puntajeTotal(Casa, PuntajeMayor),
  forall((puntajeTotal(OtraCasa, PuntajeMenor), Casa \= OtraCasa), PuntajeMayor > PuntajeMenor).
casaGanadora2(Casa):-
  puntajeTotal(Casa, PuntajeMayor),
  not((puntajeTotal(_, OtroPuntaje), OtroPuntaje > PuntajeMayor)).

% Punto 4
pregunta(dondeEstaBezoar, 20, snape).
pregunta(comoLevitarPluma, 25, flitwick).

% NOTA: una alternativa interesante es plantear las acciones como functores

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(hogwarts).

  test(fakeTest):-
    true.

:- end_tests(hogwarts).
