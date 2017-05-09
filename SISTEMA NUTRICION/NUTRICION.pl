:- use_module(library(pce)).
:- pce_image_directory('./img').
:- use_module(library(pce_style_item)).
:- dynamic color/2.

/*Sistema experto encontrado en la dirección url: http://documents.mx/documents/sistema-experto-de-licuados-nutritivos-y-medicinales.html.
Este se tomo como base para adecuarlo a nuestras necesidades.
Quienes desarrollaron este sistema tienen el credito total ya que
nosotros solo lo modificamos.
Fecha de modificación: 08/05/2017 12:36:25 a.m
La información que se utilizo para establecer los padecimientos y el
como evitarlos se tomaron de una página web, este es el url:
https://www.lifeder.com/enfermedades-nutricionales/.
*/
resource(nutricion, image, image('nu.jpg')).
resource(man, image, image('nutri.jpg')).
resource(enfermo, image, image('nutri.jpg')).
resource(fruta, image, image('licuados.jpg')).
resource(jugo1, image, image('doc.jpeg')).
resource(se, image, image('nuevo1.jpg')).
nueva_imagen2(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
			        send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(100,80)).

botones :- borrado,
		send(@boton, free),
                send(@btntratamiento,free),
		hipotesis(Enfermedad),
		send(@texto, selection('De acuerdo a sus datos proporcionados su enfermedad es:')),
		send(@resp1, selection(Enfermedad)),
		new(@boton, button('Iniciar consulta',
		message(@prolog, botones)
		)),
		%**************
		new(@btntratamiento,button('Descripcion y recomendaciones',
			message(@prolog, cual,Enfermedad)
		)),
                %**********
		send(@dial, display,@boton,point(40,50)),
		%******************
		send(@dial, display,@btntratamiento,point(200,50)),
		%*****************
		deshacer.

/* codigo para cual tratamiento seguir*/
cual(X):-
           new(Dlgtratamiento, dialog('Descripcion y recomendaciones')),
			send(Dlgtratamiento, append, label(nombre, 'Explicacion: ')),
			send(Dlgtratamiento, display,@lblExp1,point(70,51)),
			send(Dlgtratamiento, display,@lblExp2,point(50,80)),
			tratamiento_imagen(Dlgtratamiento,man),
			tratamiento(X),
			send(Dlgtratamiento, transient_for, @dial),
			send(Dlgtratamiento, open_centered).

/****************************************************************************************/
tratamiento_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
				send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(190,270)).


/***************************************/

%hipotesis




hipotesis(obesidad) :- obesidad,!.


hipotesis(enfermedades_cardiovasculares) :- enfermedades_cardiovasculares,!.


hipotesis(diabetes) :-diabetes,!.

hipotesis(osteoporosis) :- osteoporosis,!.

/*
hipotesis(licuado_de_zanahoria_y_apio) :- licuado_de_zanahoria_y_apio,!.

hipotesis(licuado_de_col_toronja_y_apio) :- licuado_de_col_toronja_y_apio,!.

hipotesis(licuado_redu_mess) :- licuado_redu_mess,!.*/

hipotesis(licuado_de_naranja_mandarina_piña_limon_y_miel) :- licuado_de_naranja_mandarina_piña_limon_y_miel,!.

hipotesis(licuado_de_manzana_lechuga_y_ajonjoli) :- licuado_de_manzana_lechuga_y_ajonjoli,!.

hipotesis(licuado_de_kiwi_manzana_naranja_y_fresa) :- licuado_de_kiwi_manzana_naranja_y_fresa,!.

hipotesis(licuado_de_manzana_y_zanahoria) :- licuado_de_manzana_y_zanahoria,!.

hipotesis(licuado_de_zanahoria_y_espinacas) :- licuado_de_zanahoria_y_espinacas,!.

hipotesis(licuado_de_piña_apio_y_durazno) :- licuado_de_piña_apio_y_durazno,!.

hipotesis(licuado_de_yoghurt_y_almendras) :- licuado_de_yoghurt_y_almendra,!.

hipotesis(licuado_de_naranja_pepino_y_jicama) :- licuado_de_naranja_pepino_y_jicama,!.

hipotesis(licuado_de_valeriana_manzanilla_y_menta) :- licuado_de_valeriana_manzanilla_y_menta,!.

hipotesis(desconocido). /* no existe*/


/*% reglas de identificación*/

/*diabetes*/

obesidad :- obesidadd,

		verifica('¿Consume comidas ricas en grasas y azúcares?'),
		verifica('¿Se saltea alguna comida durante el día?'),
		verifica('¿Comienza la jornada laboral sin desayunar?'),
		verifica('¿Toma bebidas alcohólicas?'),
		verifica('¿No realiza alguna actividad fisica?'),
		verifica('¿Consume energía(calorias) superior al gasto energético?'),
		verifica('¿Usted lleva una vida sedentaria?').


/*estreñimiento, enfermedades_cardiovasculares*/

enfermedades_cardiovasculares :- enfermedades_cardio ,
		verifica('¿Consumo frecuente de alimentos ricos en grasas de origen animal?'),
		verifica('¿Tiene el hábito de fumar?'),
		verifica('¿No realiza alguna actividad fisica?'),
		verifica('¿Padece hipertensión?'),
                verifica('¿Tiene familiares que padecen esta enfermedad?').







/*sobre_peso, diabetes*/

diabetes :- diabet,

		verifica('¿Tiene frecuencia en orinar?'),
                verifica('¿Tiene sensación de hambre inusual?'),
		verifica('¿Tiene sensación excesiva de sed?'),
                verifica('¿Padece de pérdida de peso?').
/*
licuado_de_zanahoria_y_apio :- sobre_peso,
		verifica('¿fatiga con poco esfuerzo?'),
		verifica('¿sensacion excesiva de sed?').

licuado_de_col_toronja_y_apio :- sobre_peso,
		verifica('¿fatiga con poco esfuerzo?'),
		verifica('¿sensacion excesiva de sed?').

licuado_redu_mess :- sobre_peso,
		verifica('¿fatiga con poco esfuerzo?'),
		verifica('¿sensacion excesiva de sed?').

*/


/*resfriado*/

licuado_de_naranja_mandarina_piña_limon_y_miel :- resfriado,
		verifica('¿goteo y congestion de la nariz?'),
		verifica('¿cosquilleo en la garganta?'),
		verifica('¿tiene estornudos?'),
		verifica('¿ojos llorosos?'),
		verifica('¿fiebre baja?'),
		verifica('¿dolor de garganta?'),
		verifica('¿tos seca y leve?'),
		verifica('¿dolor de cabeza?'),
		verifica('¿tiene escalofrios?').



/*depresion*/
licuado_de_manzana_lechuga_y_ajonjoli :- depresion,
		verifica('¿te sientes irritable?'),
		verifica('¿tienes dificultades para conciliar el sueño por las noches?'),
		verifica('¿te sientes sin valor o insignificante?'),
		verifica('¿te sientes irritable?'),
		verifica('¿ya no disfrutas las cosas que antes te gustaba hacer?'),
		verifica('¿te sientes molesto o ansioso sin saber porqué?').

licuado_de_kiwi_manzana_naranja_y_fresa :- depresion,
		verifica('¿te sientes irritable?'),
		verifica('¿tienes dificultades para conciliar el sueño por las noches?'),
		verifica('¿te sientes sin valor o insignificante?'),
		verifica('¿te sientes irritable?'),
		verifica('¿ya no disfrutas las cosas que antes te gustaba hacer?'),
		verifica('¿te sientes molesto o ansioso sin saber porqué?').




/*colitis*/
licuado_de_manzana_y_zanahoria :- colitis,
		verifica('¿tiene nauseas?'),
		verifica('¿tiene colicos?'),
		verifica('¿ruidos en el abdomen?'),
		verifica('¿estreñimiento o diarrea frecuentemente?').




/*hemorroides*/
licuado_de_zanahoria_y_espinacas :- hemorroides,

		verifica('¿tiene tension?').




/*colesterol*/
licuado_de_piña_apio_y_durazno :- colesterol,

		verifica('¿infarto agudo?'),
		verifica('¿tiene usted hipertension?').



/*vistas_cansada*/
licuado_de_yoghurt_y_almendra :- vista_cansada,
                verifica('¿le cuesta ver nítidamente objetos cercanos?').



/*infeccion_de_riñones*/
licuado_de_naranja_pepino_y_jicama :- infeccion_de_riñones,

                verifica('¿necesidad de orinar con mucha frecuencia?'),
                verifica('¿dolor de espalda baja?').



/*insomnio*/
licuado_de_valeriana_manzanilla_y_menta :- insomnio,
                verifica('¿dificultad para conciliar el sueño?'),
                verifica('¿ansiedad?').






/*******************************************Reglas de Clasificacion************************************/

obesidadd :- verifica('¿Comes más de tres comidas al dia y no haces ejercicio?'),!.
enfermedades_cardio :- verifica('¿Tienes altos niveles de colesterol?'),!.
diabet :- verifica('¿Sensación de malestar en el estómago y vómitos.?'),!.
resfriado :- verifica('¿goteo y congestion de la nariz?'),!.
depresion :- verifica('¿te sientes irritable?'),!.
colitis :- verifica('¿dolor abdominal?'),!.
hemorroides :- verifica('¿esta usted estresado?'),!.
colesterol :- verifica('¿angina de pecho?'),!.
vista_cansada :- verifica('¿Necesita más luz de la acostumbrada para leer?'),!.
infeccion_de_riñones :- verifica('¿dolor o ardor al orinar?'),!.
insomnio :- verifica('¿se despierta constantemente durante la madrugada?'),!.



/*diabetes*/
tratamiento(obesidad) :-
		        send(@lblExp1, selection(' ENFERMEDAD OBESIDAD.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
			Saltea comidas durante el dia, comienza la jornada laboral sin desayunar,tomar bebidas alcohólicas,no realiza alguna actividad fisica,consume energía(calorias) superior al gasto energético, \n usted lleva una vida sedentaria.COMO PREVENIR LA OBESIDAD                                      \n\n ')),
			send(@lblExp2, selection('	\n\n *Comiendo más verduras y frutas naturales,de preferencia crudas.Las frutas en conserva tienen azúcar.  \n\n *Consumiendo leche y yogurt descremados o con bajo contenido de grasa. \n\n  *Comiendo cantidades moderadas de pan,carne,cereales y papas, en lo posible preferir productos integrales. \n\n *Reduciendo al mínimo el consumo de azúcar, dulces,bebidas azúcaradas tales como soda y otros alimentos dulces. \n\n  *Realizando actividades que aumenten el gasto energético para reducir la grasa corporal.\n Por ejemplo: caminar, subir y bajar escaleras, hacer deporte, jugar, bailar,entre otros. Esto significa dedicar menos tiempo a ver televisión y a las actividades sedentarias. ')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





/*estreñimiento  */

tratamiento(enfermedades_cardiovasculares) :-
		        send(@lblExp1, selection(' ENFERMEDAD CARDIOVASCULAR.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
Consumo frecuente de alimentos ricos en grasas de origen animal, tiene el hábito de fumar,no realiza alguna actividad fisica, padece hipertensión, tiene familiares que padecen esta enfermedad.
			\n COMO PREVENIR LAS ENFERMEDADES CARDIOVASCULARES \n\n *Comiendo más verduras y frutas, de preferencia crudas. \n\n *Comiendo menos carnes rojas,cecinas, cualquier alimento de origen animal. \n\n *Comer más carnes blancas como pescado, pavo o pollo. \n\n *Aumentando el ejercicio físico para fortalecer el corazón.')),
			send(@lblExp2, selection('\n\n ')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
                        /*
tratamiento(licuado_de_pera_naranja_y_linaza) :-
		        send(@lblExp1, selection(' ENFERMEDAD ESTREÑIMIENTO.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
			dificultad y dolor al defecar, defecarmenos de 3 veces por semana, sentirse perezoso, dolor abdominal
			\n\n TRATAMIENTO A SEGUIR: LICUADO DE PERA, NARANJA Y LINAZA\n\n')),
			send(@lblExp2, selection('\n\n PRE.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tratamiento(licuado_de_esparragos_fresa_y_kiwi) :-
		        send(@lblExp1, selection(' ENFERMEDAD ESTREÑIMIENTO.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
			dificultad y dolor al defecar, defecarmenos de 3 veces por semana, sentirse perezoso, dolor abdominal
			\n\n TRATAMIENTO A SEGUIR: LICUADO DE ESPARRAGOS, FRESA Y KIWI\n\n')),
			send(@lblExp2, selection('\n\n REPARACION: 2 esparragos, 5 fresas y 2 kiwi, licua y bebe al instante.
			\n\n FUNCION: Acelera tu metabolismo.')).
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






/*sobre_peso*/
tratamiento(diabetes) :-
		send(@lblExp1, selection(' ENFERMEDAD DIABETES.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
Sensación de malestar en el estómago y vómitos, frecuencia en orinar, sensación de hambre inusual, sensacion excesiva de sed, pérdida de peso.
		\n\n COMO PREVENIR LA DIABETES \n\n')),
		send(@lblExp2, selection('\n\n\n\n\n *Manteniendo el peso normal. \n *Comiendo más verduras, frutas y leguminosas. \n *Comiendo menos alimentos ricos en grasas y azúcar. \n *Realizando actividades físicas diariamente.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tratamiento(licuado_de_zanahoria_y_apio) :-
		send(@lblExp1, selection(' ENFERMEDAD SOBRE PESO.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
		sudor excesivo, fatiga con poco esfuerzo, sensacion excesiva de sed
		\n\n TRATAMIENTO A SEGUIR: LICUADO DE ZANAHORIA Y APIO\n\n')),
		send(@lblExp2, selection('\n\n PREPARACION: 1 vaso de jugo de zanahoria, 1 vaso 1/2 de jugo de apio.
\n\n FUNCION: El jugo de zanahoria y apio ayuda a combatir el sobrepeso, inhibe el apetito entre comidas, es diurético, combate la obesidad.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tratamiento(licuado_de_col_toronja_y_apio) :-
		send(@lblExp1, selection(' ENFERMEDAD SOBRE PESO.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
		sudor excesivo, fatiga con poco esfuerzo, sensacion excesiva de sed
		\n\n TRATAMIENTO A SEGUIR: LICUADO DE COL, TORONJA Y APIO\n\n')),
		send(@lblExp2, selection('\n\n PREPARACION: 1/2 taza de col picada, 1 taza de jugo de toronja y 1 tallo de apio.
\n\n FUNCION: Ayuda a bajar de peso, desintoxica el higado y quema grasas, debido a que regula el funcionamiento de la vesicula; mejora el metabolismo de las grasas, combate depresion y previene enfermedades circulatorias.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tratamiento(licuado_redu_mess) :-
		send(@lblExp1, selection(' ENFERMEDAD SOBRE PESO.\n DEBIDO A LOS SIGUIENTES SINTOMAS QUE USTED PRESENTA DETERMINAMOS SU TRATAMIENTO:
		sudor excesivo, fatiga con poco esfuerzo, sensacion excesiva de sed
		\n\n TRATAMIENTO A SEGUIR: LICUADO REDU MESS\n\n')),
		send(@lblExp2, selection('\n\n PREPARACION: 1 piña, 3 pepinos, una hoja de sabila, 3 vasos de agua.
\n\n FUNCION: tomar el primero en ayunas, el segundo por la tarde y el tercero antes de dormir. No es necesario hacer dieta, reduce el colesterol')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





/*resfriado*/

tratamiento(licuado_de_naranja_mandarina_piña_limon_y_miel) :-
			      send(@lblExp1, selection('licuado_de_naranja_mandarina_piña_limon_y_miel')),
			      send(@lblExp2,selection('USTED SUFRE DE RESFRIADO.
PREPARACION: 2 naranjas, 2 mandarinas, 1 rebanada grue de miel de abejasa de piña, 1 limon y una cucharad.
\n DESCRIPCION: Contiene vitamina B,C,D y ayuda a mantener excelentemente el sistema inmunologico, excelente para las afecciones de las vias respiratorias')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



/*depresion*/


tratamiento(licuado_de_manzana_lechuga_y_ajonjoli) :-
		        send(@lblExp1, selection('USTED SUFRE DE DEPRESION.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: Te sientes irritable, Tienes dificultades para conciliar el sueño por las noches,
Te sientes sin valor o insignificante, Te sientes irritable, Ya no disfrutas las cosas que antes te gustaba hacer,
Te sientes molesto o ansioso sin saber porqué.')),
			send(@lblExp2, selection('LE RECOMIENDO TOMAR: Licuado de manzana, lechuga y ajonjoli.
n\n\nPREPARACION: 2 manzanas, 6 hojas de lechuga y 2 cucharadas de anjonjoli.
\n DESCRIPCION: Prepara este jugo una hora antes de ir a la cama en caso de insomnio y también puedes tomar una tacita de té de tila con valeriana. Sigue nuestras recomendaciones y tendrás felices sueños.')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tratamiento(licuado_de_kiwi_manzana_naranja_y_fresa) :-
		        send(@lblExp1, selection('USTED SUFRE DE DEPRESION.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: Te sientes irritable, Tienes dificultades para conciliar el sueño por las noches, Te sientes sin valor o insignificante,
Te sientes molesto o ansioso sin saber porqué, ya no disfrutas las cosas que antes te gustaba hacer.')),
			send(@lblExp2, selection('LE RECOMIENDO TOMAR: Licuado de kiwi, manzana, naranja y fresa.
n\n\nPREPARACION: 2 kiwis, 2 manzanas, zumo de naranja y 4 fresas.
\n DESCRIPCION: Prepara este jugo una hora antes de ir a la cama en caso de insomnio y también puedes tomar una tacita de té de tila con valeriana. Sigue nuestras recomendaciones y tendrás felices sueños.')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





/*colitis*/

tratamiento(licuado_de_manzana_y_zanahoria) :-
			send(@lblExp1, selection('USTED SUFRE DE COLITIS.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: Dolor abdominal, Tiene nauseas, Tiene cólicos, Ruidos en el abdomen, Estreñimiento o diarrea frecuentemente .')),
			send(@lblExp2, selection('LE RECOMIENDO TOMAR: Licuado de manzana y zanahoria.
\n\n\nPREPARACION: 1 taza de jugo de manzana y 1/2 taza de zanahoria picada, licua hasta desaparecer los grumos cuela y bebe enseguida.
\n DESCRIPCION: es depurativo y diuretico, ademas de un suave laxante eficaz en el tratamiento de la colitis. auxiliar en casos de
inflamacion estomacal, estreñimiento y obesidad. actua como regulador de las funciones intestinales.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






/*hemorroides*/

tratamiento(licuado_de_zanahoria_y_espinacas) :-
		        send(@lblExp1, selection('USTED SUFRE DE HEMORROIDES.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: tiene tensión y esta estresado.')),
			send(@lblExp2, selection('LE RECOMIENDO TOMAR: Licuado de zanahoria y espinacas.
\n\n\nPREPARACION: 8 zanahorias, 1 vaso de jugo de espinaca,consumir un por la mañana una vez por semana durante 1 mes.
\n DESCRIPCION: alivia las molestias de las hemorroides, es astrigente, cicatrizante y ablanda las partes inflamadas. mejora la digestion
   para evitar estreñimiento, una de las causas de las hemorroides. nutre la piel, combate la comezon, mejora la formacion de placas en las arterias.')).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




/*colesterol*/

tratamiento(licuado_de_piña_apio_y_durazno) :-
		        send(@lblExp1, selection('USTED SUFRE DE COLESTEROL.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: Hipertensión, Infarto agudo y Angina de pecho.')),
			send(@lblExp2, selection('LE RECOMIENDO TOMAR: Licuado de piña, apio y durazno.
\n\n\n\nPREPARACION: 1 vaso de jugo de piña, 1 tallo de apio, 1 durazno, licuar y tomar sin colar.
\n DESCRIPCION: El consumo frecuente de apio en jugos o ensaladas, limpia la sangre, baja los niveles de colesterol, además de dar un efecto
   refrescante y tonificante al cuerpo. Debido a su riqueza en sales minerales de reacción alcalina. Si el apio se prepara en caldo combinado
   con cebolla neutraliza el exceso de acidez de la sangre, y facilita la eliminación de orina, previniendo la formación de piedras en el riñón
   y la retención de líquidos.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*vista cansada*/

tratamiento(licuado_de_almendra_yoghurt_y_trigo) :-
		        send(@lblExp1, selection('USTED SUFRE DE VISTA CANSADA.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: Necesita mas luz de la acostrumbrada para leer y Le cuesta ver nitidamente objetos cercanos.')),
			send(@lblExp2, selection('LE RECOMINEDO TOMAR: Licuado de almendra, yoghurt y trigo.
\n\n\n\nPREPARACION: 1 vaso de leche fría o un vaso de yoghurt natural, 7 almendras peladas, 1 cucharada de pasitas, 1 cucharada de salvado,
        1 cucharada de germen de trigo, 1 cucharada de miel de abeja, Se licuan todos los ingredientes y se toma todos los días
        en la mañana a la hora del desayuno.

\n      DESCRIPCION: Este licuado es muy nutritivo, pues fortalece la vista y lo pueden tomar desde los niños hasta las personas de cualquier edad.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




/*infeccino de riñones*/

tratamiento(licuado_de_naranja_pepino_y_jicama) :-
		        send(@lblExp1, selection('USTED SUFRE DE INFECCION DE RIÑONES.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: dolor de espalda baja,necesidad de orinar con mucha frecuencia, dolor o ardor al orinar.')),
			send(@lblExp2, selection('LE RECOMIENDO TOMAR: Licuado de naranja, pepino y jicama.
\n\n\n\nPREPARACION: PREPARACION: 1 vaso de jugo de naranja, Medio pepino, ¼ de jícama, 1 tallo de apio, ½ manzana, 2 ramas de perejil.
\n      DESCRIPCION: Puede preparar un vaso de jugo de naranja licuado con medio pepino pelado y picado y un trozo de jícama pelada y picada,
        o ponga a licuar el jugo de naranja con un tallo de apio, media manzana pelada y dos ramas de perejil. Es mejor tomar estos jugos
        sin colar para que las fibras de las verduras ayuden a evitar también el estreñimiento.')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



/*insomnio*/

tratamiento(licuado_de_valeriana_manzanilla_y_menta) :-
		         send(@lblExp1, selection('USTED SUFRE DE INSOMNIO.
\n\n\nYA QUE PADESE LOS SIGUIENTES SINTOMAS: ansiedad, se despierta constantemente durante la madrugada, dificultad para conciliar el sueño.')),
			send(@lblExp2, selection('LE RECOMIENDO TOMAR: Licuado de valeriana, manzanilla y menta.
\n\n\n\nPREPARACION: 1 cucharada sopera de lopulo, 1 cucharada sopera de valeriana, 2 cucharadas soperas de manzanilla, 2 cucharadas soperas de menta piperita.
\n DESCRIPCION: Colocar 1 cucharada sopera bien colmada de esa mezcla, en una taza de agua hirviendo, tapar y
   dejar reposar 20 minutos, luego tomar edulcorando a gusto y a roncar se ha dicho.Se debe ingerir al menos 2 horas antes de acostarse
   y varios días seguidos hasta comprobar sus efectos.')).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*desconocido*/

tratamiento(desconocido) :-
			send(@lblExp1, selection('Solucion no encontrada.')),
			send(@lblExp2, selection('lo sentimos pero a un no hay una respuesta para su sintoma, DISCULPE LAS MOLESTIAS, FAVOR DE CONSULTAR A SU MEDICO')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-dynamic si/1,no/1.

preguntar(Problema):-	new(Di,dialog('Diagnostico de enfermedades')),
			nueva_imagen(Di, jugo1),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
			new(La,label(prob,Problema)),
			new(B1,button(si,and(message(Di,return,si)))),
			new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25, 25)),
			send(Di,append(L2)),
                        send(Di,append(La)),
			send(Di,append(B1)),
			send(Di,append(B2)),
			send(Di,default_button,si),
			send(Di,open_centered),get(Di,confirm,Answer),
			write(Answer),send(Di,destroy),
			((Answer==si)->assert(yes(Problema));
			assert(no(Problema)),fail).

verifica(S):-(si(S)->true; (no(S)->fail; preguntar(S))).

deshacer:-retract(si(_)),fail.
deshacer:-retract(no(_)),fail.
deshacer.

nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
				send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).

/* Aqui El Codigo Para La Interface Principal*/

main :-new(@dial, dialog('SISTEMA EXPERTO - Nutriología', size(1000,1000))),
	new(L, label(nombre,'BIENVENIDO A SU CONSULTA')),
	new(@texto, label(nombre,'Deacuerdo a los datos proporcionados el remedio es:')),
	new(@resp1, label(nombre,'')),
	new(@lblExplica1, label(nombre,'')),
	new(@lblExplica2, label(nombre,'')),
	new(@lblExp1, label(nombre,'')),
	new(@lblExp2, label(nombre,'')),
	new(@salir,button('SALIR',and(message(@dial,destroy),message(@dial,free)))),
	new(@boton, button('Iniciar consulta',
	 message(@prolog, botones)
	)),
	new(@btnExplica,button('¿Qué es éste remedio?'	)),
	send(@dial, append(L)),


	new(@btntratamiento,button('¿Tratamiento?'	)),



	nueva_imagen(@dial, nutricion),

	send(@dial, display,L,point(200,30)),
	send(@dial, display,@boton,point(20,25)),
	send(@dial, display,@texto,point(20,100)),
	send(@dial, display,@salir,point(20,400)),
	send(@dial, display,@resp1,point(20,130)),
	send(@dial,open_centered).

borrado:-	send(@resp1, selection('')).


iniciar:-	new(@principal,dialog('SISTEMA EXPERTO DE LICUADOS NUTRITIVOS Y MEDICINALES ',size(700,300))),
		new(L2,label(text,'                  INSTITUTO TECNOLÓGICO DE CHIHUAHUA II         ')),
/*new(L3,label(text,'      \n\n                ')),*/
new(L4,label(text,'                  ING. SISTEMAS COMPUTACIONALES')),nl,nl,
new(L5,label(text,'                  SEMESTRE: 8vo')),nl,nl,
new(L6,label(text,'                          INTEGRANTES DE EQUIPO:')),
new(L7,label(text,'                    ADRIAN EDUARDO BARRIOS LOPEZ')),
new(L8,label(text,'                    JUAN HUMBERTO CHACON HOLGUIN')),
new(L9,label(text,'                    RAFAEL GRADO BARRAZA')),
new(L10,label(text,'                  ')),
new(L11,label(text,'            ')),
		nueva_imagen2(@principal, se),
		send(@principal,append(L2)),
/*send(@principal,append(L3)),*/
send(@principal,append(L4)),
send(@principal,append(L5)),
send(@principal,append(L6)),
send(@principal,append(L7)),
send(@principal,append(L8)),
send(@principal,append(L9)),
send(@principal,append(L10)),
send(@principal,append(L11)),
		new(But2,button('COMENZAR',and(message(@prolog,main) ,and(message(@principal,destroy),message(@principal,free)) ))),
		new(But1,button('SALIDA',and(message(@principal,destroy),message(@principal,free)))),
		send(@principal,append(But2)),
		send(@principal,append(But1)),
		send(@principal,open_centered).


:-iniciar.
fin :- halt.

%Metodo transient_for
/*Indica que este cuadro es solo un marco de apoyo para el argumento, esta declaración tiene los siguientes efector
Informar a un gestor de ventanas: fuente: http://64.233.179.104/translate_c?hl=es&u=http://gollem.science.uva.nl:8080
/class%3Fname%3Dframe&prev=/search%3Fq%3Dtransient_for%26hl%3Des%26sa%3DG*/














