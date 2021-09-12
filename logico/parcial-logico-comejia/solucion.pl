%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial: NotiLogic
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Punto 1

% noticia(Autor, Articulo, Visitas)
% 	Articulo:
% 		articulo(Titulo, PersonajeInvolucrado)
% 			PersonajeInvolucrado:
% 				deportista(Nombre, TitulosGanados)
% 				farandula(Personaje, PersonajeRival)
% 				politico(Nombre, PartidoPolitico)
noticia(artVandelay, articulo("Nuevo título para Lloyd Braun", deportista(lloydBraun, 5)), 25).
noticia(elaineBenes, articulo("Primicia", farandula(jerrySeinfeld, kennyBania)), 16).
noticia(elaineBenes, articulo("El dólar bajó! … de un arbolito", farandula(jerrySeinfeld, newman)), 150).
noticia(bobSacamano, articulo("No consigue ganar ni una carrera", deportista(davidPuddy, 0)), 10).
noticia(bobSacamano, articulo("Cosmo Kramer encabeza las elecciones", politico(cosmoKramer, amigosDelPoder)), 155).
noticia(georgeCostanza, Articulo, Vistas):-noticia(bobSacamano, Articulo, Vistas).
noticia(georgeCostanza, articulo(Titulo, politico(Nombre, amigosDelPoder)), Vistas):-
	noticia(Autor, articulo(Titulo, farandula(Nombre, _)), VistasOriginal),
	Autor \= bobSacamano,
	Vistas is VistasOriginal / 2.

% Si bien George hace de las suyas, sabemos que Elaine Benes no roba las noticias de Art Vandelay.
% No se modela ya que por el Principio de Universo Cerrado todo lo que no esta en la
% base de conocimientos se considera falso.


% Punto 2
articuloAmarillista(articulo("Primicia", _)).
articuloAmarillista(articulo(_, Personaje)):-estaComplicado(Personaje).

estaComplicado(deportista(_, Titulos)):-Titulos < 3.
estaComplicado(farandula(_, jerrySeinfeld)).
estaComplicado(politico(_, _)).

% Solucion inversible!
% articulo(Articulo):-distinct(Articulo, noticia(_, Articulo, _)).
% articuloAmarillista(Articulo):-
% 	articulo(Articulo),
% 	causas(Articulo).
% causas(articulo("Primicia", _)).
% causas(articulo(_, deportista(_, Titulos))):-Titulos < 3.
% causas(articulo(_, farandula(_, jerrySeinfeld))).
% causas(articulo(_, politico(_, _))).


% Punto 3.1
autor(Autor):-distinct(Autor, noticia(Autor, _, _)).

noLeImportaNada(Autor):-
	autor(Autor),
	forall((noticia(Autor, Articulo, Visitas), muyVisitado(Visitas)), articuloAmarillista(Articulo)).

muyVisitado(Visitas):-Visitas > 15.

% Punto 3.2
esMuyOriginal(Autor):-
	noticia(Autor, articulo(Titulo, _), _),
	not((noticia(Autor, articulo(OtroTitulo, _), _), Titulo \= OtroTitulo)).

% Punto 3.3
tuvoTraspie(Autor):-
	noticia(Autor, _, Visitas),
	not(muyVisitado(Visitas)).


% Punto 4
articulo(Articulo):-distinct(Articulo, noticia(_, Articulo, _)).

edicionLoca(Vistas, ArticuloAmarillistas):-
	noticia(_, _, Vistas),
	findall(Articulo, (noticia(_, Articulo, _), articuloAmarillista(Articulo)), Articulos),
	combinacionAmarillasta(Articulos,  Vistas, ArticuloAmarillistas).

combinacionAmarillasta([], _, []).
combinacionAmarillasta([Articulo|Articulos], Vistas, [Articulo|Posibles]):-
	noticia(_, Articulo, VistasArticulo),
	Vistas < 50,
	VistasPosible is Vistas - VistasArticulo,
	combinacionAmarillasta(Articulos,  VistasPosible, Posibles).
combinacionAmarillasta([_|Articulos], Vistas, Posibles):-
	combinacionAmarillasta(Articulos,  Vistas, Posibles).

:- begin_tests(template).

test(fake_test) :-
	3 is 2 + 1.

:- end_tests(template).
