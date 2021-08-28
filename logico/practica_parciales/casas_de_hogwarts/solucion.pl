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

% mago(Nombre, TipoDeSangre, Caracteristica, CasaQueOdia).
mago(harry, mestiza, coraje).
mago(harry, mestiza, amistad).
mago(harry, mestiza, orgullo).
mago(draco, pura, inteligencia).
mago(draco, pura, orgullo).
mago(hermione, impura, inteligencia).
mago(hermione, impura, orgullo).
mago(hermione, impura, responsabilidad).
mago(hermione, impura, amistad).%

odia(harry, slytherin).
odia(draco, hufflepuff).

consideracionDeSombrero(gryffindor, coraje).
consideracionDeSombrero(slytherin, orgullo).
consideracionDeSombrero(slytherin, inteligencia).
consideracionDeSombrero(ravenclaw, inteligencia).
consideracionDeSombrero(ravenclaw, responsabilidad).
consideracionDeSombrero(hufflepuff, amistad).

permiteEntrarMago(Casa, Mago):-
  casa(Casa),
  distinct(Mago, mago(Mago, Sangre, _)),
  not((Casa = slytherin, Sangre = impura)).

tieneCaracterApropiado(Casa, Mago):-
  casa(Casa),
  distinct(Mago, mago(Mago, _, _)),
  forall(consideracionDeSombrero(Casa, Caracteristica), mago(Mago, _, Caracteristica)).

enQueCasaPuedeQuedar(Casa, Mago):-
  tieneCaracterApropiado(Casa, Mago),
  permiteEntrarMago(Casa, Mago),
  not(odia(Mago, Casa)).

cadenaDeAmistades([Mago]):-mago(Mago, _, amistad).
cadenaDeAmistades([Mago|Magos]):-
  casa(Casa),
  mago(Mago, _, amistad),
  enQueCasaPuedeQuedar(Casa, Mago),
  cadenaDeAmistades(Magos).


%  findAll(Mago, mago(Mago, _, amistad), ListaDeMagos),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(hogwarts).

  test(fakeTest):-
    true.

:- end_tests(hogwarts).
