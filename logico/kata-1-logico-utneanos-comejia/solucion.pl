%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KATA 1
% NOMBRE: Cesar Mejia (comejia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Diego, Hernán y Mary cursaron Paradigmas con Dodain
curso(diego, paradigmas, dodain).
curso(hernan, paradigmas, dodain).
curso(mary, paradigmas, dodain).
% Elías, Celeste y Mariano cursaron Paradigmas con Juan
curso(elias, paradigmas, juan).
curso(celeste, paradigmas, juan).
curso(mariano, paradigmas, juan).
% Mora cursó Paradigmas con Alf.
curso(mora, paradigmas, alf).

% Los que cursaron Paradigmas con Juan, cursaron Paradigmas con Dodain.
curso(Alumno, paradigmas, dodain):-curso(Alumno, paradigmas, juan).

% Los que cursan Paradigmas con Juan y Alf cursan Diseño con Gastón.
curso(Alumno, disenio, gaston):-curso(Alumno, paradigmas, juan).
curso(Alumno, disenio, gaston):-curso(Alumno, paradigmas, alf).

% Los que cursan Diseño con Gastón cursan Operativos con Adriano.
curso(Alumno, operativos, adriano):-curso(Alumno, disenio, gaston).

% La cursada de Paradigmas con Alf es buena. También la de Operativos con Adriano y la de Diseño con Gastón.
esBuena(paradigmas, alf).
esBuena(operativos, adriano).
esBuena(disenio, gaston).

buenaCursada(Quien):-esBuena(Materia, Profesor), curso(Quien, Materia, Profesor).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ¿Quiénes cursan Operativos con Adriano?
% curso(Quienes, operativos, adriano).

% ¿Quiénes dan con un profesor que de una buena cursada?
% buenaCursada(Quien).

% ¿Quiénes cursaron Paradigmas con Alf o con Juan?
% curso(Quienes, paradigmas, alf).
% curso(Quienes, paradigmas, juan).


:- begin_tests(utneanos).

  test(fakeTest):-
    true.

:- end_tests(utneanos).