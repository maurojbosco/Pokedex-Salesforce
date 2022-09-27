HISTORIAS DE USUARIO CON LOS PASOS PARA REALIZAR EL PROYECTO

# Documentacion para PokeOrg

## Objetos
TODO tarea para crear objetos

    COMO usuario de Salesforce
    NECESITO Guardar la informacion de los Pokemon
    PARA tener la informacion cuando la necesite

    DADO que necesito guardar los pokemon
    CUANDO obtenga los datos
    ENTONCES debo crear el siguiente Objeto : Pokemon__c
---
    COMO usuario de Salesforce
    NECESITO identificar los Movimientos
    PARA tener la informacion guardada

    DADO que necesito identificar los movimientos
    CUANDO obtenga los datos
    ENTONCES debo crear el siguiente Objeto : Movimiento__c
---
        COMO usuario de Salesforce
    NECESITO identificar las Habilidades
    PARA tener la informacion guardada

    DADO que necesito identificar las habilidades
    CUANDO obtenga los datos
    ENTONCES debo crear el siguiente Objeto : Habilidad__c
---


## Campos
    TODO tarea para crear campos
    ---
    COMO usuario de Salesforce
    NECESITO identificar los detalles de los Pokemon
    PARA tener la informacion guardada

    DADO que necesito campos para identificar los detalles de los pokemon
    CUANDO inserte el objeto        
    ENTONCES debo crear los siguientes campos:
        -. ExtId__c (Id de referencia con API) * (ID)
        -. Numero_de_Pokemon__c (Numero ) * (order)
        -. Generacion__c (Campo formula devolucion numero) * (formula con ExtId__c)
        -. Habilidad__c (LookUp habilidad) 
        -. Altura__c (heigth)
        -. Peso__c (weigth)
        -. Imagen__c (URL) (a eleccion en sprites)
        -. Tipos__c (Multi Picklist) * (types)
            Normal
            Fighting
            Flying
            Poison
            Ground
            Rock
            Bug
            Ghost
            Steel
            Fire
            Water
            Grass
            Electric
            Psychic
            Ice
            Dragon
            Dark
            Fairy
        -. Vida__c (stats-hp)
        -. Velocidad__c (stats-speed)
        -. Defensa__c (stats-defense)
        -. Ataque__c (stats-attack)
        -. Slot1__c (lookup movimiento)
        -. Slot2__c (lookup movimiento)
        -. Slot3__c (lookup movimiento)
        -. Slot4__c (lookup movimiento)
---
    COMO usuario de Salesforce
    NECESITO identificar en los detalles de los Movimientos
    PARA tener la informacion guardada

    DADO que necesito campos para identificar los detalles de los movimientos
    CUANDO inserte el objeto
    ENTONCES debo crear los siguientes campos:
        -. ExtId__c (Id de referencia con API) (id)
        -. Punteria__c (accuracy)
        -. Chance_de_Efecto__c (effect_chance)
        -. Objetivo__c (target-name)
        -. Prioridad__c (priority)
        -. Efecto__c (effect_entries-short_effect)
        -. Poder__c (power)
        -. Pp__c (pp)
        -. Tipo__c (Multi Picklist)  (type-name)
            Normal
            Fighting
            Flying
            Poison
            Ground
            Rock
            Bug
            Ghost
            Steel
            Fire
            Water
            Grass
            Electric
            Psychic
            Ice
            Dragon
            Dark
            Fairy
            Unknown
            Shadow
---
    COMO usuario de Salesforce
    NECESITO identificar en los detalles de las Habilidades
    PARA tener la informacion guardada

    DADO que necesito campos para identificar los detalles de las habilidades
    CUANDO inserte el objeto
    ENTONCES debo crear los siguientes campos:
        -. ExtId__c (Id de referencia con API)
        -. Efecto__c (Effect_Entries-short_effect en ingles EN)
---

## Layout
    TODO tarea para editar el layout

        COMO usuario
        NECESITO tener un layout de Pokemon
        PARA poder acceder a la data mas facilmente

        DADO que necesito poder ver la data de los Pokemon
        CUANDO ingrese al detalle
        ENTONCES debo crear un layout para organizar la informacion de los Pokemon

        COMO usuario
        NECESITO tener un layout de Habilidad
        PARA poder acceder a la data mas facilmente

        DADO que necesito poder ver la data de las Habilidades
        CUANDO ingrese al detalle
        ENTONCES debo crear un layout para organizar la informacion de las Habilidades

        COMO usuario
        NECESITO tener un layout de Movimiento
        PARA poder acceder a la data mas facilmente

        DADO que necesito poder ver la data de los Movimientos
        CUANDO ingrese al detalle
        ENTONCES debo crear un layout para organizar la informacion de los Movimientos

## Fichas
    COMO usuario
    NECESITO tener una ficha de Pokemon
    PARA poder acceder a la data mas facilmente

    DADO que necesito poder ver los Pokemon
    CUANDO ingrese al detalle
    ENTONCES debo crear una ficha para los Pokemon

    COMO usuario
    NECESITO tener una ficha de Habilidad
    PARA poder acceder a la data mas facilmente

    DADO que necesito poder ver las Habilidades
    CUANDO ingrese al detalle
    ENTONCES debo crear una ficha las Habilidades

    COMO usuario
    NECESITO tener una ficha de Movimiento
    PARA poder acceder a la data mas facilmente

    DADO que necesito poder verconf los Movimientos
    CUANDO ingrese al detalle
    ENTONCES debo crear una ficha para los Movimientos

## App
    COMO administrador de Salesforce
    QUIERO crear la APP PokeAPP y Tab Pokedex
    PARA visualizar registros

    Criterios de aceptación
    Incluir la Tab Pokedex dentro de la APP PokeAPP

## RemoteSiteSettings
    COMO administrador de Salesforce
    QUIERO conectarme a https://pokeapi.co/
    PARA obtener registros

    Criterios de aceptación
    DADO que quiero conectarme a https://pokeapi.co/
    CUANDO se realice la conexión
    ENTONCES Salesforce deberá de tener los permisos necesarios

## Clases
TODO tarea para crear clases
    COMO desarrollador
    NECESITO una clase
    PARA obtener todos los pokemons (hasta el indice 898 inclusive)

    DADO que necesito obtener los pokemon
    CUANDO ejecute la clase
    ENTONCES debo crear una clase la cual me permita consultar la api POKEAPI.ORG, obtener los pokemons e insertar los datos en los objetos correspondientes.

    COMO desarrollador
    NECESITO una clase
    PARA obtener todos los movimientos de un pokemon

    DADO que necesito obtener los movimientos de un pokemon
    CUANDO -
    ENTONCES debo crear una clase la cual me permita consultar la api POKEAPI.ORG, insertar los movimientos y relacionarlos a los pokemon correspondientes (cada pokemon tendra un maximo 4 movimientos elegidos al azar)

    COMO desarrollador
    NECESITO una clase
    PARA obtener todos las Habilididades de los pokemon

    DADO que necesito obtener las Habilididades de un pokemon
    CUANDO -
    ENTONCES debo crear una clase la cual me permita consultar la api POKEAPI.ORG insertar las habilidades y relacionarlas a los pokemon correspondientes (cada pokemon tendra un maximo de 1 habilidad elegida al azar)






## LWC
TODO tarea para crear LWC (puede realizarse con LWC anidados)

HU -Visualización de registros-

COMO administrador de Salesforce
QUIERO visualizar registros
PARA armar mi Pokedex

Criterios de aceptación
DADO que cuento con los 898 registros insertados correctamente en mi Org
CUANDO ingrese a la tab Pokedex
ENTONCES deberé de visualizarlos en filas, siguiendo el orden del índice propio de cada registro


HU -Filtrado por picklist-

COMO administrador de Salesforce
QUIERO filtrar registros
PARA refinar mi búsqueda

Criterios de Aceptación
DADO que visualizo todos los Pokémon
CUANDO quiera acotar mi búsqueda
ENTONCES deberé de tener dos picklist para refinar mi búsqueda

- filtrar resultados por Tipo (recordar que tipo es multi picklist)
- filtrar resultados por generación

* Deberé de tener opción seleccionar "Todos" en los filtros
* Podre realizar ambos filtrados en simultaneo. Ej. podre buscar todos los Pokémon de Tipo Normal de la generación 5


HU -Filtrado por nombre-

COMO administrador de Salesforce
QUIERO filtrar registros
PARA refinar mi búsqueda

Criterios de aceptación
DADO que visualizo todos los Pokémon
CUANDO quiera acotar mi búsqueda
ENTONCES deberé de tener un campo input para refinar mi búsqueda

* Este filtrado podrá realizarse en simultaneo con los filtros previamente creados
Ej. ingreso la letra "a", la búsqueda deberá devolverme todos los Pokémon que CONTENGAN la letra "a", no necesariamente que empiecen por la letra "a".


HU -Contador de registros-

COMO administrador de Salesforce
QUIERO mostrar el numero de registros 
PARA saber cuantos Pokémon pertenecen a una generación, a un tipo, etc

Criterios de Aceptación
*Debo de visualizar un contador que cuando aplique un filtro, cuente el numero de resultados
-hint- Investigar la función Object.keys en JavaScript


HU -Estilos-

Criterios de Aceptación
Deberé aplicar estilos sobre el trabajo previamente construido para una visualización mas bella.
*Los estilos que se utilizaran son a criterio personal, dejen volar la imaginación. Preferentemente apegarse a SLDS


HU -Redirección a Record Page-

COMO administrador de Salesforce
QUIERO hacer click sobre la imagen de mi Pokémon
PARA redirigirme hacia el registro de mi Pokémon

Criterios de aceptación
Una vez que realice click sobre la imagen de mi Pokémon, deberá de redirigirme a la página de su registro
-hint- Investigar la función de NavigationMixin en JavaScript
