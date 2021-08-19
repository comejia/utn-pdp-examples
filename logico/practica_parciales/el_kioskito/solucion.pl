%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: El Kioskito
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Punto 1: calentando motores

atiende(dodain, lunes, horario(9, 15)).
atiende(dodain, miercoles, horario(9, 15)).
atiende(dodain, viernes, horario(9, 15)).
atiende(lucas, martes, horario(10, 20)).
atiende(juanC, sabados, horario(18, 22)).
atiende(juanC, domingos, horario(18, 22)).
atiende(juanF, jueves, horario(10, 20)).
atiende(juanF, viernes, horario(12, 20)).
atiende(leoC, lunes, horario(14, 18)).
atiende(leoC, miercoles, horario(14, 18)).
atiende(martu, miercoles, horario(23, 24)).

% vale atiende los mismos dias y horarios que dodain y juanC.
atiende(vale, Dia, Horario):-atiende(dodain, Dia, Horario).
atiende(vale, Dia, Horario):-atiende(juanC, Dia, Horario).

% nadie hace el mismo horario que leoC
% Por el Principio del universo cerrado no se modela, ya que todo
% lo que no esta en la base de conocimiento se considera falso

% maiu está pensando si hace el horario de 0 a 8 los martes y miércoles
% Por el Principio del universo cerrado no se modela, ya que todo
% lo que no esta en la base de conocimiento se considera falso


% Punto 2: quien atiende el kiosko
quienAtiende(Quien, Dia, Hora):-
  atiende(Quien, Dia, horario(HorarioInicial, HorarioFinal)), 
  between(HorarioInicial, HorarioFinal, Hora).


% Punto 3: Forever alone
foreverAlone(Persona, Dia, Horario):-
  quienAtiende(Persona, Dia, Horario),
  not((quienAtiende(Socio, Dia, Horario), Persona \= Socio)).


% Punto 4: Posibilidades de atencion
posibleAtencion(Dia, KiosquerosPosibles):-
  findall(Kiosquero, distinct(Kiosquero, quienAtiende(Kiosquero, Dia, _)), Kiosqueros),
  quioskerosPosibles(Kiosqueros, KiosquerosPosibles).

quioskerosPosibles([], []).
quioskerosPosibles([Kiosquero|Kiosqueros], [Kiosquero|Posibles]):-
  quioskerosPosibles(Kiosqueros, Posibles).
quioskerosPosibles([_|Kiosqueros], Posibles):-
  quioskerosPosibles(Kiosqueros, Posibles).

% Punto extra
% findall para generar el conjunto de soluciones que satisfacen un predicado
% Ademas se utiliza mecanismo de backtracking de Prolog que permite encontrar todas las soluciones posibles.


% Punto 5: ventas / suertudas
venta(dodain, lunes, fecha(10, agosto), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
venta(dodain, miercoles, fecha(12, agosto), [bebidas(8, alcoholica), bebidas(1, noAlcoholica), golosinas(10)]).
venta(martu, miercoles, fecha(12, agosto), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, martes, fecha(11, agosto), [golosinas(600)]).
venta(lucas, martes, fecha(18, agosto), [bebidas(2, noAlcoholica), cigarrillos([derby])]).

vendedorSuertudo(Persona):-
  venta(Persona, _, _, _),
  forall(venta(Persona, _, _, [Producto|_]), esImportante(Producto)).

esImportante(golosinas(Precio)):-Precio > 100.
esImportante(cigarrillos(Marcas)):-length(Marcas, Cantidad), Cantidad > 2.
esImportante(bebidas(_, alcoholica)).
esImportante(bebidas(Cantidad, _)):-Cantidad > 5.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(kioskito).

  test(fakeTest):-
    true.

:- end_tests(kioskito).
