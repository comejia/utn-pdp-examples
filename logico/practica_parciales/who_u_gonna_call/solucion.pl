%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: Who you gonna call?
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% herramientasRequeridas(Tarea, Herramientas)
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
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

% Punto 3
puedeRealizarTarea(Tarea, Persona):-
  tiene(Persona, varitaDeNeutrones),
  tarea(Tarea).
puedeRealizarTarea(Tarea, Persona):-
  persona(Persona),
  tarea(Tarea),
  forall(herramientaNecesaria(Tarea, Herramienta), satisfaceNecesidad(Persona, Herramienta)).

persona(Persona):-tiene(Persona, _).
tarea(Tarea):-herramientasRequeridas(Tarea, _).
herramientaNecesaria(Tarea, Herramienta):-
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

cuantoCobrar(Cliente, PrecioFinal):-
  cliente(Cliente),
  findall(Precio, precioDeTareaPedida(Cliente, Precio), Precios),
  sum_list(Precios, PrecioFinal).

precioDeTareaPedida(Cliente, PrecioTotal):-
  tareaPedida(Cliente, Tarea, Metros), 
  precio(Tarea, PrecioPorMetro),
  PrecioTotal is PrecioPorMetro * Metros.

cliente(Cliente):-tareaPedida(Cliente, _, _).

% Punto 5
aceptaPedido(Persona, Cliente):-
  persona(Persona),
  acepta(Persona, Cliente),
  forall((tareaPedida(Cliente, Tarea, _)), puedeRealizarTarea(Tarea, Persona)).

acepta(ray, Cliente):-
  tareaPedida(Cliente, Tarea, _),
  Tarea \= limpiarTecho.
acepta(winston, Cliente):-
  cuantoCobrar(Cliente, PrecioFinal),
  PrecioFinal > 500.
acepta(egon, Cliente):-
  tareaPedida(Cliente, Tarea, _),
  not(tareaCompleja(Tarea)).
acepta(peter, Cliente):-tareaPedida(Cliente, _, _).

tareaCompleja(Tarea):-
  herramientasRequeridas(Tarea, Herramientas),
  length(Herramientas, Cantidad),
  Cantidad > 2.
tareaCompleja(limpiarTecho).

% Punto 6a
% herramientasRequeridas(ordenarCuarto, [escoba, trapeador, plumero]).
% Punto 6b


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(who_u_gonna_call).

  test(fakeTest):-
    true.

:- end_tests(who_u_gonna_call).
