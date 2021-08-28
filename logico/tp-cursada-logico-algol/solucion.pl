%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TP
% NOMBRES: Mercedes Madsen
%          Cesar Mejia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parte 1: Las materias
% materia(Materia, HorasCursada)
% nivel 1
materia(analisisMatematico1, 50).
materia(algebraYGeometriaAnalitica, 60).
materia(matematicaDiscreta, 70).
materia(sistemasYOrganizaciones, 170).
materia(algoritmosYEstructuraDeDatos, 110).
materia(arquitecturaDeComputadoras, 80).
materia(ingenieriaYSociedad, 30).
materia(fisica1, 110).
materia(ingles1, 20).
% nivel 2
materia(quimica, 80).
materia(analisisMatematico2, 100).
materia(fisica2, 130).
materia(analisisDeSistemas, 100).
materia(sintaxisYSemanticaLenguajes, 140).
materia(paradigmasDeProgramacion, 150).
materia(sistemasOperativos, 250).
materia(probabilidadYEstadistica, 90).
% nivel 3
materia(sistemasDeRepresentacion, 40).
materia(disenioDeSistemas, 100).
materia(comunicaciones, 90).
materia(matematicaSuperior, 100).
materia(gestionDeDatos, 130).
materia(economia, 100).
materia(ingles2, 30).

materiaIntegradora(sistemasYOrganizaciones).
materiaIntegradora(analisisDeSistemas).
materiaIntegradora(disenioDeSistemas).
materiaIntegradora(administracionDeRecursos).
materiaIntegradora(proyectoFinal).

materiaLibre(ingles1).
materiaLibre(ingles2).

% correlativa(Materia, Correlativa)
correlativa(analisisMatematico2, analisisMatematico1).
correlativa(analisisMatematico2, algebraYGeometriaAnalitica).
correlativa(fisica2, fisica1).
correlativa(fisica2, analisisMatematico1).
correlativa(analisisDeSistemas, sistemasYOrganizaciones).
correlativa(analisisDeSistemas, algoritmosYEstructuraDeDatos).
correlativa(sintaxisYSemanticaLenguajes, matematicaDiscreta).
correlativa(sintaxisYSemanticaLenguajes, algoritmosYEstructuraDeDatos).
correlativa(paradigmasDeProgramacion, matematicaDiscreta).
correlativa(paradigmasDeProgramacion, algoritmosYEstructuraDeDatos).
correlativa(probabilidadYEstadistica, analisisMatematico1).
correlativa(probabilidadYEstadistica, algebraYGeometriaAnalitica).
correlativa(probabilidadYEstadistica, analisisMatematico1).
correlativa(probabilidadYEstadistica, algebraYGeometriaAnalitica).
correlativa(sistemasOperativos, matematicaDiscreta).
correlativa(sistemasOperativos, algoritmosYEstructuraDeDatos).
correlativa(sistemasOperativos, arquitecturaDeComputadoras).

correlativa(disenioDeSistemas, analisisDeSistemas).
correlativa(disenioDeSistemas, paradigmasDeProgramacion).
correlativa(comunicaciones, arquitecturaDeComputadoras).
correlativa(comunicaciones, analisisMatematico2).
correlativa(comunicaciones, fisica2).
correlativa(matematicaSuperior, analisisMatematico2).
correlativa(gestionDeDatos, analisisDeSistemas).
correlativa(gestionDeDatos, sintaxisYSemanticaLenguajes).
correlativa(gestionDeDatos, paradigmasDeProgramacion).
correlativa(economia, analisisDeSistemas).

% Punto 1
materiaPesada(Materia):-materia(Materia, HorasCursada), HorasCursada > 100, materiaIntegradora(Materia).
materiaPesada(Materia):-materia(Materia, _), atom_length(Materia, LargoNombre), LargoNombre > 25.

% Punto 2.1
materiaInicial(Materia):- materia(Materia, _), not(correlativa(Materia, _)).

% Punto 2.2
materiasNecesariasParaCursar(Materia, Correlativa):-
  correlativa(Materia, Correlativa).
materiasNecesariasParaCursar(Materia, Correlativa):-
  correlativa(Materia, OtraCorrelativa),
  materiasNecesariasParaCursar(OtraCorrelativa, Correlativa).

% Punto 2.3
materiasQueHabilita(Materia, MateriaHabilitada):-
  materiasNecesariasParaCursar(MateriaHabilitada, Materia).


% Parte 2: Cursada

% cursada(Persona, Materia, Modalidad, Nota)
% Modalidad:
%     cuatrimestral(Anio, Cuatrimestre)
%     anual(Anio)
%     verano(AnioCalendario, Mes)
cursada(juana, paradigmasDeProgramacion, cuatrimestral(2015, 2), 8).
cursada(tarciso, paradigmasDeProgramacion, anual(2020), 9).
cursada(tarciso, paradigmasDeProgramacion, cuatrimestral(2014, 2), 4).
cursada(pepe, ingles1, verano(2018, 2), 8).
cursada(carlos, ingles2, verano(2018, 1), 3).
cursada(carlos, comunicaciones, cuatrimestral(2020, 1), 6).
cursada(vanina, comunicaciones, cuatrimestral(2020, 2), 8).
cursada(vanina, sistemasOperativos, cuatrimestral(2021), 7).

% Requerimientos base
curso(Persona, Materia, Anio):-cursada(Persona, Materia, cuatrimestral(Anio, _), _).
curso(Persona, Materia, Anio):-cursada(Persona, Materia, anual(Anio), _).
curso(Persona, Materia, Anio):-cursada(Persona, Materia, verano(AnioCalendario, _), _), Anio is AnioCalendario - 1.

parioMateria(Persona, Materia):-
  curso(Persona, Materia, AnioPrimerCursada), 
  curso(Persona, Materia, AnioSegundaCursada), 
  AnioPrimerCursada \= AnioSegundaCursada.

aproboCursada(Persona, Materia):-cursada(Persona, Materia, _, Nota), Nota >= 6.

% Desempeño académico
desempenioAcademico(Persona, Materia, Indice):-
  cursada(Persona, Materia, _, _),
  findall(Valoracion, valoracion(Persona, Materia, Valoracion), ListaDeValoraciones),
  sum_list(ListaDeValoraciones, Indice).

valoracion(Persona, Materia, Valoracion):- cursada(Persona, Materia, anual(_), Valoracion).
valoracion(Persona, Materia, Valoracion):- cursada(Persona, Materia, cuatrimestral(_, 1), Valoracion).
valoracion(Persona, Materia, Valoracion):- cursada(Persona, Materia, cuatrimestral(_, 2), Nota), Valoracion is Nota - 1.
valoracion(Persona, Materia, Valoracion):- cursada(Persona, Materia, verano(_, _), Nota), Nota >= 8, Valoracion is 8.
valoracion(Persona, Materia, Valoracion):- cursada(Persona, Materia, verano(_, _), Nota), Nota < 8, Valoracion is Nota.


% Parte 3: Personas que estudian
notaFinal(carlos, comunicaciones, 5).
notaFinal(vanina, sistemasOperativos, 4).

promociona(Persona, Materia):-cursada(Persona, Materia, _, Nota), Nota >=8.

aproboFinal(Persona, Materia):-notaFinal(Persona, Materia, Nota), Nota >= 6.
aproboFinal(Persona, Materia):-promociona(Persona, Materia).
aproboFinal(Persona, Materia):-notaFinal(Persona, Materia, aprobada).

procrastinador(Persona):-
  aproboCursada(Persona, _),
  not((aproboCursada(Persona, Materia), aproboFinal(Persona, Materia))).

materiaFiltro(Materia):-
  cursada(_, Materia, _, _),
  not((cursada(Persona, Materia, _, _), promociona(Persona, Materia))).

% aproboCursada(Quien, Materia).
% aproboFinal(Quien, Materia).
% Se utiliza el concepto de inversibilidad


% Parte 4: Juego de cursadas
materiaLinda(vanina, paradigmasDeProgramacion).
materiaLinda(vanina, sistemasOperativos).
materiaLinda(vanina, gestionDeDatos).

sugerirMaterias(Persona, Sugeridas):-
  materiaLinda(Persona, MateriaLinda),
  materiaPesada(MateriaPesada),
  materiaIntegradora(MateriaIntegradora),
  list_to_set([MateriaLinda, MateriaPesada, MateriaIntegradora], Materias),
  alternativas(Materias, Sugeridas).

alternativas([Materia1, Materia2], [Posible1, Posible2]):-Posible1 = Materia1, Posible2 = Materia2.
alternativas([Materia|Materias], [Materia|Posibles]):-alternativas(Materias, Posibles).
alternativas([_|Materias], Posibles):-alternativas(Materias, Posibles).


materiasQuePuedeCursar(Persona, MateriasPosibles):-
  findall(Materia, (materia(Materia, _), not(aproboCursada(Persona, Materia))), TodasLasMaterias),
  materiasPosibles(TodasLasMaterias, Persona, MateriasPosibles).

materiasPosibles([], _, []).
materiasPosibles([Materia|Materias], Persona, [Materia|Posibles]):-
  puedeCursar(Materia, Persona),
  materiasPosibles(Materias, Persona, Posibles).  
materiasPosibles([_|Materias], Persona, Posibles):-
  materiasPosibles(Materias, Persona, Posibles).

puedeCursar(Materia, Persona):-
  forall(materiasNecesariasParaCursar(Materia, Correlativas), aproboCursada(Persona, Correlativas)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consultas a resolver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- begin_tests(utneanos).

  % -------------- Parte 1 --------------
  test(correlativas_directas_de_una_materia, set(Correlativas = [matematicaDiscreta, algoritmosYEstructuraDeDatos])):-
    correlativa(paradigmasDeProgramacion, Correlativas).
  test(materias_libres, set(Libres = [ingles1, ingles2])):-
    materiaLibre(Libres).
  test(materias_integradoras, set(Integradoras = [sistemasYOrganizaciones, analisisDeSistemas, disenioDeSistemas, administracionDeRecursos, proyectoFinal])):-
    materiaIntegradora(Integradoras).

  % Punto 1
  test(que_materias_son_pesadas, set(Materias = [sistemasYOrganizaciones, algebraYGeometriaAnalitica, algoritmosYEstructuraDeDatos, arquitecturaDeComputadoras, sintaxisYSemanticaLenguajes])):-
    materiaPesada(Materias).
  test(una_materia_con_nombre_corto_no_puede_ser_pesada, fail):-
    materiaPesada(comunicaciones).

  % Punto 2
  test(que_materias_son_iniciales, set(Materias = [analisisMatematico1, algebraYGeometriaAnalitica, matematicaDiscreta, sistemasYOrganizaciones, algoritmosYEstructuraDeDatos, arquitecturaDeComputadoras,ingenieriaYSociedad, fisica1, ingles1, quimica, sistemasDeRepresentacion, ingles2])):-
    materiaInicial(Materias).
  test(ingles1_es_materia_inicial):-
    materiaInicial(ingles1).
  test(materias_necesarias_para_cursar_una_materia, set(Materias =[matematicaDiscreta, algoritmosYEstructuraDeDatos, arquitecturaDeComputadoras])):-
    materiasNecesariasParaCursar(sistemasOperativos, Materias).
  test(materias_que_habilitan_una_materia, set(Materias = [comunicaciones, matematicaSuperior])):-
    materiasQueHabilita(analisisMatematico2, Materias).
  
  % -------------- Parte 2 --------------
  % Punto 3
  test(anio_que_curso_una_persona_una_materia, set(Anio = [2015])):-
    curso(juana, paradigmasDeProgramacion, Anio).
  test(persona_que_pario_una_materia, set(Personas = [tarciso])):-
    parioMateria(Personas, paradigmasDeProgramacion).
  test(persona_que_aprobo_una_materia_especifica, set(Personas = [pepe])):-
    aproboCursada(Personas, ingles1).
  test(desempenio_academico_de_una_materia_para_una_persona, set(Indice = [12])):-
    desempenioAcademico(tarciso, paradigmasDeProgramacion, Indice).

  % -------------- Parte 3 --------------
  test(quienes_son_procrastinadores, set(Persona = [carlos])):-
    procrastinador(Persona).
  test(que_materias_son_filtro, set(Materias = [ingles2, sistemasOperativos])):-
    materiaFiltro(Materias).
  test(una_materia_que_alguien_promociono_no_puede_ser_filtro, fail):-
    materiaFiltro(comunicaciones).

  % -------------- Parte 4 --------------
  % test(posibilidades_de_cursar, set(Materias =  [[algebraYGeometriaAnalitica,administracionDeRecursos],[algebraYGeometriaAnalitica,analisisDeSistemas],[algebraYGeometriaAnalitica,disenioDeSistemas],[algebraYGeometriaAnalitica,proyectoFinal],[algebraYGeometriaAnalitica,sistemasYOrganizaciones],[algoritmosYEstructuraDeDatos,administracionDeRecursos],[algoritmosYEstructuraDeDatos,analisisDeSistemas],[algoritmosYEstructuraDeDatos,disenioDeSistemas],[algoritmosYEstructuraDeDatos,proyectoFinal],[algoritmosYEstructuraDeDatos,sistemasYOrganizaciones],[arquitecturaDeComputadoras,administracionDeRecursos],[arquitecturaDeComputadoras,analisisDeSistemas],[arquitecturaDeComputadoras,disenioDeSistemas],[arquitecturaDeComputadoras,proyectoFinal],[arquitecturaDeComputadoras,sistemasYOrganizaciones],[paradigmasDeProgramacion,algebraYGeometriaAnalitica,administracionDeRecursos],[paradigmasDeProgramacion,algebraYGeometriaAnalitica,analisisDeSistemas],[paradigmasDeProgramacion,algebraYGeometriaAnalitica,disenioDeSistemas],[paradigmasDeProgramacion,algebraYGeometriaAnalitica,proyectoFinal],[paradigmasDeProgramacion,algebraYGeometriaAnalitica,sistemasYOrganizaciones],[paradigmasDeProgramacion,algoritmosYEstructuraDeDatos,administracionDeRecursos],[paradigmasDeProgramacion,algoritmosYEstructuraDeDatos,analisisDeSistemas],[paradigmasDeProgramacion,algoritmosYEstructuraDeDatos,disenioDeSistemas],[paradigmasDeProgramacion,algoritmosYEstructuraDeDatos,proyectoFinal],[paradigmasDeProgramacion,algoritmosYEstructuraDeDatos,sistemasYOrganizaciones],[paradigmasDeProgramacion,arquitecturaDeComputadoras,administracionDeRecursos],[paradigmasDeProgramacion,arquitecturaDeComputadoras,analisisDeSistemas],[paradigmasDeProgramacion,arquitecturaDeComputadoras,disenioDeSistemas],[paradigmasDeProgramacion,arquitecturaDeComputadoras,proyectoFinal],[paradigmasDeProgramacion,arquitecturaDeComputadoras,sistemasYOrganizaciones],[paradigmasDeProgramacion,sintaxisYSemanticaLenguajes,administracionDeRecursos],[paradigmasDeProgramacion,sintaxisYSemanticaLenguajes,analisisDeSistemas],[paradigmasDeProgramacion,sintaxisYSemanticaLenguajes,disenioDeSistemas],[paradigmasDeProgramacion,sintaxisYSemanticaLenguajes,proyectoFinal],[paradigmasDeProgramacion,sintaxisYSemanticaLenguajes,sistemasYOrganizaciones],[paradigmasDeProgramacion,sistemasYOrganizaciones],[paradigmasDeProgramacion,sistemasYOrganizaciones,administracionDeRecursos],[paradigmasDeProgramacion,sistemasYOrganizaciones,analisisDeSistemas],[paradigmasDeProgramacion,sistemasYOrganizaciones,disenioDeSistemas],[paradigmasDeProgramacion,sistemasYOrganizaciones,proyectoFinal],[sintaxisYSemanticaLenguajes,administracionDeRecursos],[sintaxisYSemanticaLenguajes,analisisDeSistemas],[sintaxisYSemanticaLenguajes,disenioDeSistemas],[sintaxisYSemanticaLenguajes,proyectoFinal],[sintaxisYSemanticaLenguajes,sistemasYOrganizaciones],[sistemasYOrganizaciones,administracionDeRecursos],[sistemasYOrganizaciones,analisisDeSistemas],[sistemasYOrganizaciones,disenioDeSistemas],[sistemasYOrganizaciones,proyectoFinal]])):-
  %    sugerirMaterias(vanina, Materias).
  % test(materias_que_puede_cursar, set(Materias = [[gestionDeDatos, economia, ingles2],[gestionDeDatos, economia],[gestionDeDatos, ingles2],[gestionDeDatos],[economia, ingles2],[economia],[ingles2],[]])):-
  %   materiasQuePuedeCursar(vanina, Materias). 

:- end_tests(utneanos).

