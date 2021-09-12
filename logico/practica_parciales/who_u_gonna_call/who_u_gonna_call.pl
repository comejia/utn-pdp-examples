%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Who you gonna call?
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% herramientasRequeridas(Tarea, Herramientas)
%herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
%% Agregado necesario Punto 6a
herramientasRequeridas(ordenarCuarto, [[escoba, aspiradora(100)], trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% Punto 1a,b,c
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(peter, bordedadora).
tiene(winston, varitaDeNeutrones).
% Punto 1d: Nadie tiene una bordeadora.
% No se modela ya que por el principio de universo cerrado, todo lo que no esta en la
% base de conocimiento se considera falso.

% Punto 2
satisfaceNecesidad(Persona, Herramienta):-
  tiene(Persona, Herramienta).
satisfaceNecesidad(Persona, aspiradora(PotenciaRequerida)):-
  tiene(Persona, aspiradora(Potencia)),
  Potencia >= PotenciaRequerida.

%% Agregado necesario Punto 6b
satisfaceNecesidad(Persona, ListaRemplazables):-
	member(Herramienta, ListaRemplazables),
	satisfaceNecesidad(Persona, Herramienta).

% Punto 3
puedeRealizarTarea(Tarea, Persona):-
  tarea(Tarea),
  tiene(Persona, varitaDeNeutrones).
puedeRealizarTarea(Tarea, Persona):-
  persona(Persona),
  tarea(Tarea),
  forall(requiereHerramienta(Tarea, Herramienta), satisfaceNecesidad(Persona, Herramienta)).

persona(Persona):-tiene(Persona, _).
tarea(Tarea):-herramientasRequeridas(Tarea, _).

requiereHerramienta(Tarea, Herramienta):-
  herramientasRequeridas(Tarea, Herramientas),
  member(Herramienta, Herramientas).

% Punto 4
% tareaPedida(Cliente, Tarea, MetrosCuadrados)
tareaPedida(pedro, ordenarCuarto, 15).
tareaPedida(pedro, limpiarBanio, 10).
tareaPedida(luis, encerarPisos, 20).
tareaPedida(ana, cortarPasto, 30).

% precio(Tarea, PrecioPorMetroCuandrado)
precio(ordenarCuarto, 30).
precio(limpiarTecho, 50).
precio(cortarPasto, 20).
precio(limpiarBanio, 100).
precio(encerarPisos, 80).

precioACobrar(Cliente, PrecioFinal):-
  cliente(Cliente),
  findall(Precio, precioPorTareaPedida(Cliente, _, Precio), Precios),
  sum_list(Precios, PrecioFinal).

precioPorTareaPedida(Cliente, Tarea, Precio):-
  tareaPedida(Cliente, Tarea, Metros), 
  precio(Tarea, PrecioPorMetro),
  Precio is PrecioPorMetro * Metros.

cliente(Cliente):-tareaPedida(Cliente, _, _).

% Punto 5
aceptaPedido(Persona, Cliente):-
  puedeHacerPedido(Persona, Cliente),
  estaDispuestoAHacer(Persona, Cliente).

puedeHacerPedido(Persona, Cliente):-
  persona(Persona),
  cliente(Cliente),
  forall((tareaPedida(Cliente, Tarea, _)), puedeRealizarTarea(Tarea, Persona)).

estaDispuestoAHacer(ray, Cliente):-
  not(tareaPedida(Cliente, limpiarTecho, _)).
estaDispuestoAHacer(winston, Cliente):-
  precioACobrar(Cliente, PrecioFinal),
  PrecioFinal > 500.
estaDispuestoAHacer(egon, Cliente):-
  not((tareaPedida(Cliente, Tarea, _), tareaCompleja(Tarea))).
estaDispuestoAHacer(peter, _).

tareaCompleja(Tarea):-
  herramientasRequeridas(Tarea, Herramientas),
  length(Herramientas, Cantidad),
  Cantidad > 2.
tareaCompleja(limpiarTecho).

% Punto 6a
% herramientasRequeridas(ordenarCuarto, [[escoba, aspiradora(100)], trapeador, plumero]).
% Punto 6b
% satisfaceNecesidad(Persona, ListaRemplazables):-
% 	member(Herramienta, ListaRemplazables),
% 	satisfaceNecesidad(Persona, Herramienta).
% Punto 6c
% Se elige la solución de agrupar en una lista las herramientas remplazables, 
% y agregar una nueva definición a satisfaceNecesidad, que era el predicado que 
% usabamos para tratar directamente con las herramientas. De esta forma se trata
% polimorficamente tanto a nuestros hechos sin herramientas remplazables, como a aquellos que 
% sí las tienen. También se podría haber planteado con un functor en vez de lista.
% Cual es la ventaja? Cada vez que aparezca una nueva herramienta
% remplazable, bastará sólo con agregarla a la lista de herramientas
% remplazables, y no deberá modificarse el resto de la solución.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(who_u_gonna_call).

  test(fakeTest):-
    true.

:- end_tests(who_u_gonna_call).
