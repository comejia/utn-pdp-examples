%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: El asadito
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define quiénes son amigos de nuestro cliente
amigo(mati).
amigo(pablo).
amigo(leo).
amigo(fer).
amigo(flor).
amigo(ezequiel).
amigo(marina).

% define quiénes no se pueden ver
noSeBanca(leo, flor).
noSeBanca(pablo, fer).
noSeBanca(fer, leo).
noSeBanca(flor, fer).

% define cuáles son las comidas y cómo se componen
% functor achura contiene nombre, cantidad de calorías
% functor ensalada contiene nombre, lista de ingredientes
% functor morfi contiene nombre (el morfi es una comida principal)
comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)).
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])).
comida(ensalada(mixta, [lechuga, tomate, cebolla])).
comida(morfi(vacio)).
comida(morfi(mondiola)).
comida(morfi(asado)).

% relacionamos la comida que se sirvió en cada asado
% cada asado se realizó en una única fecha posible: functor fecha + comida
asado(fecha(22,9,2011), chori).
asado(fecha(15,9,2011), mixta).
asado(fecha(22,9,2011), waldorf).
asado(fecha(15,9,2011), mondiola).
asado(fecha(22,9,2011), vacio).
asado(fecha(15,9,2011), chinchu).

% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), flor).
asistio(fecha(22,9,2011), marina).
asistio(fecha(15,9,2011), pablo).
asistio(fecha(22,9,2011), pablo).
asistio(fecha(15,9,2011), leo).
asistio(fecha(22,9,2011), flor).
asistio(fecha(15,9,2011), fer).
asistio(fecha(22,9,2011), mati).

% definimos qué le gusta a cada persona
leGusta(mati, chori).
leGusta(fer, mondiola).
leGusta(pablo, asado).
leGusta(mati, vacio).
leGusta(fer, vacio).
leGusta(mati, waldorf).
leGusta(flor, mixta).

% Punto 1a
leGusta(ezequiel, Gusta):-leGusta(mati, Gusta).
leGusta(ezequiel, Gusta):-leGusta(fer, Gusta).
% Punto 1b
leGusta(marina, Gusta):-leGusta(flor, Gusta).
leGusta(marina, mondiola).
% Punto 1c
% No se modela ya que por el Principio del Universo Cerrado, todo lo que no esta
% en la base de conocimiento se considera falso.


% Punto 2
asadoViolento(FechaAsado):-
  asistio(FechaAsado, UnaPersona),
  asistio(FechaAsado, OtraPersona),
  noSeBanca(UnaPersona, OtraPersona).


% Punto 3
calorias(Comida, Calorias):-comida(achura(Comida, Calorias)).
calorias(Comida, Calorias):-
  comida(ensalada(Comida, Ingredientes)),
  length(Ingredientes, Calorias).
calorias(Comida, 200):-comida(morfi(Comida)).


% Punto 4
asadoFlojito(FechaAsado):-
  totalCaloriasDeAsado(FechaAsado, Calorias),
  Calorias < 400.

totalCaloriasDeAsado(Fecha, TotalCalorias):-
  asado(Fecha, _), 
  findall(Calorias, (asado(Fecha, Comida), calorias(Comida, Calorias)), ListaCalorias),
  sum_list(ListaCalorias, TotalCalorias).


% Punto 5
hablo(fecha(15,09,2011), flor, pablo).
hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(15,09,2011), pablo, leo).
hablo(fecha(22,09,2011), marina, pablo).
hablo(fecha(15,09,2011), leo, fer).
reservado(marina).

chismeDe(FechaAsado, ConoceChisme, CuentaChisme):-
  contoChisme(FechaAsado, CuentaChisme, ConoceChisme).

contoChisme(Fecha, Persona, OtraPersona):-
  hablo(Fecha, Persona, OtraPersona),
  not(reservado(Persona)).
contoChisme(Fecha, Persona, OtraPersona):-
  hablo(Fecha, Persona, UnaPersona),
  not(reservado(Persona)),
  contoChisme(Fecha, UnaPersona, OtraPersona).


% Punto 6
disfruto(Persona, FechaAsado):-
  asistio(FechaAsado, Persona),
  findall(Comida, (leGusta(Persona, Comida), asado(FechaAsado, Comida)), Comidas),
  length(Comidas, Cantidad),
  Cantidad >= 3.


% Punto 7
comidaRica(Comida):-comida(Comida),Comida = morfi(_).
comidaRica(Comida):-comida(Comida), Comida = ensalada(_, Ingredientes), length(Ingredientes, Cantidad), Cantidad > 3.
comidaRica(Comida):-comida(Comida), Comida = achura(chori, _).
comidaRica(Comida):-comida(Comida), Comida = achura(morci, _).

asadoRico(ComidasPosibles):-
  findall(Comida, comidaRica(Comida), ComidasRicas),
  asadosPosibles(ComidasRicas, ComidasPosibles).

asadosPosibles([ComidaRica], [ComidaPosible]):-comidaRica(ComidaRica), comidaRica(ComidaPosible).
asadosPosibles([ComidaRica|Ricas], [ComidaRica|Posibles]):-
  asadosPosibles(Ricas, Posibles).
asadosPosibles([_|Ricas], Posibles):-
  asadosPosibles(Ricas, Posibles).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(asadito).

  test(fakeTest):-
    true.

:- end_tests(asadito).
