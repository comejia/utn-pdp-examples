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
atiende(vale, Dias, Horario):-atiende(dodain, Dias, Horario).
atiende(vale, Dias, Horario):-atiende(juanC, Dias, Horario).

% nadie hace el mismo horario que leoC
% Por el Principio del universo cerrado no se modela, ya que todo
% lo que no esta en la base de conocimiento se considera falso

% maiu está pensando si hace el horario de 0 a 8 los martes y miércoles
atiende(maiu, martes, horario(0, 8)).
atiende(maiu, miercoles, horario(0, 8)).


% Punto 2: quien atiende el kiosko
atencion(Quien, Dia, Hora):-atiende(Quien, Dia, horario(Inicial, Final)), between(Inicial, Final, Hora).


% Punto 3: Forever alone
foreverAlone(Persona, Dia, Horario):-
  atencion(Persona, Dia, Horario),
  not((atencion(Socio, Dia, Horario), Persona \= Socio)).


% Punto 4: Posibilidades de atencion
posibleAtencion(Dia, KiosquerosPosibles):-
  findall(Kiosquero, atiende(Kiosquero, Dia, _), Kiosqueros),
  quioskerosPosibles(Kiosqueros, Dia, KiosquerosPosibles).

quioskerosPosibles([], _, []).
quioskerosPosibles([Kiosquero|Kiosqueros], Dia, [Kiosquero|Posibles]):-
  atiende(Kiosquero, Dia, _),
  quioskerosPosibles(Kiosqueros, Dia, Posibles).
quioskerosPosibles([_|Kiosqueros], Dia, Posibles):-
  quioskerosPosibles(Kiosqueros, Dia, Posibles).

% Punto extra
% Se utiliza Recursividad y pattern matching


% Punto 5: ventas / suertudas
venta(dodain, lunes, fecha(10, agosto), golosinas(1200)).
venta(dodain, lunes, fecha(10, agosto), cigarrillos([jockey])).
venta(dodain, lunes, fecha(10, agosto), golosinas(50)).
venta(dodain, miercoles, fecha(12, agosto), bebidas(8, alcoholica)).
venta(dodain, miercoles, fecha(12, agosto), bebidas(1, noAlcoholica)).
venta(dodain, miercoles, fecha(12, agosto), golosinas(10)).
venta(martu, miercoles, fecha(12, agosto), golosinas(1000)).
venta(martu, miercoles, fecha(12, agosto), cigarrillos([chesterfield, colorado, parisiennes])).
%venta(martu, miercoles, fecha(12, agosto), cigarrillos(colorado)).
%venta(martu, miercoles, fecha(12, agosto), cigarrillos(parisiennes)).
venta(lucas, martes, fecha(11, agosto), golosinas(600)).
venta(lucas, martes, fecha(18, agosto), bebidas(2, noAlcoholica)).
venta(lucas, martes, fecha(18, agosto), cigarrillos([derby])).

vendedorSuertudo(Persona):-
  venta(Persona, _, _, _),
  %forall((venta(Persona, Dia, _, Producto), primerVenta(Persona, Dia)), esImportante(Producto)).
  forall(venta(Persona, _, _, Producto), esImportante(Producto)).

primerVenta(Persona, Dia):-
  venta(Persona, Dia, _, _),
  not((venta(Persona, OtroDia, _, _), Dia \= OtroDia)).

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
