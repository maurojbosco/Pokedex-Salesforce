global class PokemonGet implements Database.Batchable<Integer>, Database.AllowsCallouts {
    private List<Integer> pokemons;
    public PokemonGet(List<Integer> pokemons){
        this.pokemons = pokemons;
    }
    global List<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return pokemons;
    }
    global void execute(Database.BatchableContext bc, List<Integer> scope){
        // process each batch of records  
        try{
            HttpRequest req = new HttpRequest();
            req.setHeader('Accept', 'application/json');
            req.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + scope[0]);
            req.setMethod('GET');
            HTTPResponse res = new Http().send(req);
            /*Se instancia un objeto de tipo Pokemon__c, también uno de tipo PokeapiJSON y se llama al método 
            parse de este último para deserializar el JSON que devuelve como respuesta la API. A continuación 
            se procede a asignar los valores correspondientes a los campos Name, Altura__c, ExtId__c, 
            Numero_de_Pokemon__c y Peso__c del objeto de tipo Pokemon__c*/
            PokeapiJSON pokeapi = PokeapiJSON.parse(res.getBody());
            Pokemon__c pokemon = new Pokemon__c();
            pokemon.Name = pokeapi.name.capitalize();
            pokemon.Altura__c = Double.valueOf(pokeapi.height)/10;
            pokemon.ExtId__c = Integer.valueOf(pokeapi.id);
            pokemon.Numero_de_Pokemon__c = Integer.valueof(pokeapi.order);
            pokemon.Peso__c = Double.valueOf(pokeapi.weight)/10;
            //Mapa que contiene el JSON completo que devuelve como respuesta la API, deserializado
            Map<String,Object> pok =(Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            /*Se procede a obtener el valor de 'types', dentro de este el de 'type' y finalmente el de'name',
            del primer elemento de la lista para luego asignarselo al campo Tipos__c. A continuación se
            evalúa si hay más de un elemento en la lista y de ser así se vuelve a asignar el valor al
            campo Tipos__c, pero esta vez concatenando el valor del primer elemento con el valor del segundo.*/
            List<Object> types =(List<Object>) pok.get('types');
            Map<String,Object> type0 =(Map<String,Object>) types.get(0);
            Map<String,Object> type00 = (Map<String,Object>) type0.get('type');
            String typename0 = (String) type00.get('name');
            pokemon.Tipos__c = typename0.capitalize();
            if (types.size() > 1){
                Map<String,Object> type1 =(Map<String,Object>) types.get(1);
                Map<String,Object> type01 = (Map<String,Object>) type1.get('type');
                String typename1 = (String) type01.get('name');
                pokemon.Tipos__c = typename0.capitalize()+';'+typename1.capitalize();
            }
            //Lista que contiene el valor de la key 'stats' dentro del JSON
            List<Object> stats = (List<Object>) pok.get('stats');
            //Se procede a obtener el valor del primer elemento de la lista 'stats' y dentro de este el de
            //'base_stats, para luego asignarselo al campo Vida__c. 
            Map<String,Object> stat0 = (Map<String,Object>) stats.get(0);
            Integer hpvalue = (Integer) stat0.get('base_stat');
            pokemon.Vida__c = hpvalue;
            //Se procede a obtener el valor del segundo elemento de la lista 'stats' y dentro de este el de 
            //'base_stats', para luego asignarselo al campo Ataque__c. 
            Map<String,Object> stat1 = (Map<String,Object>) stats.get(1);
            Integer attackvalue = (Integer) stat1.get('base_stat');
            pokemon.Ataque__c = attackvalue;
            //Se procede a obtener el valor del tercer elemento de la lista 'stats' y dentro de este el de
            //'base_stats', para luego asignarselo al campo Defensa__c. 
            Map<String,Object> stat2 = (Map<String,Object>) stats.get(2);
            Integer defensevalue = (Integer) stat2.get('base_stat');
            pokemon.Defensa__c = defensevalue;
            //Se procede a obtener el valor del sexto elemento de la lista 'stats' y dentro de este el de 
            //'base_stats', para luego asignarselo al campo Velocidad__c. 
            Map<String,Object> stat5 = (Map<String,Object>) stats.get(5);
            Integer speedvalue = (Integer) stat5.get('base_stat');
            pokemon.Velocidad__c = speedvalue;
            //Se procede a obtener el valor de 'sprites', dentro de este el de 'other', dentro de este el
            //de 'Official_artwork' y finalmente el de'front-default', para luego asignarselo al campo Imagen__c.
            Map<String,Object> sprites = (Map<String,Object>) pok.get('sprites');
            Map<String,Object> other = (Map<String,Object>) sprites.get('other');
            Map<String,Object> official_artwork = (Map<String,Object>) other.get('official-artwork');
            String front_default = (String) official_artwork.get('front_default');
            pokemon.Imagen__c = front_default;
            /*Se procede a obtener el valor de 'abilities', dentro de este el de un elemento al azar de la lista,
            dentro de este el de 'ability' y dentro de este el de 'name'. Luego se hace una query a la base
            de datos para poder obtener el objeto de tipo Habilidad__c que coincida su nombre con el valor de
            'name'. Luego se le extrae el número de id para poder asignarselo al campo Habilidad__c de
            tipo lookup al objeto Habilidad__c.*/
            List<Object> abilities = (List<Object>) pok.get('abilities');
            Map<String,Object> abilitiesn = (Map<String,Object>) abilities.get(Integer.valueOf(Math.random()*abilities.size()));
            Map<String,Object> ability = (Map<String,Object>) abilitiesn.get('ability');
            String abilityname = (String) ability.get('name');
            Habilidad__c habid = [SELECT Id 
                                  FROM Habilidad__c 
                                  WHERE Name = :abilityname.capitalize()
                                  LIMIT 1];
            
            pokemon.Habilidad__c = habid.id;
            /*Se procede a obtener el valor de 'moves'. A continuación se ejecuta un bucle mientras un contador 
            iniciado en 0, que se irá incrementando cada vez que se asigne un campo al objeto de tipo pokemon
			dentro del bucle sea menor al tamaño de la lista 'moves' y al mismo tiempo sea menor a 4. Se obtiene
			el valor de un elemento al azar de la lista, dentro de este el de 'move' y dentro de este el de 'name'. 
			Luego se hace una query a la base de datos para poder obtener el objeto de tipo Movimiento__c que
			coincida su nombre con el valor de 'name'. Luego se le extrae el número de id para poder asignarselo al campo 
			Slot(n)__c de tipo lookup al objeto Movimiento__c. El número de Slot es asignado por el contador, además 
			se valida que no se vaya a asignar un objeto de tipo Movimiento__c previamente asignado a otro slot*/
            List<Object> moves = (List<Object>) pok.get('moves');
            Integer count = 0;
            while ( count < moves.size() && count < 4 ){
                Map<String,Object> movesn = (Map<String,Object>) moves.get(Integer.valueOf(Math.random()*moves.size()));
                Map<String,Object> move = (Map<String, Object>) movesn.get('move');
                String movename = (String) move.get('name');
                Movimiento__c movi = [SELECT Id 
                                      FROM Movimiento__c 
                                      WHERE Name = :movename.capitalize()
                                      LIMIT 1];
               
                if (count == 0){
                    pokemon.Slot1__c = movi.id;
                    count++;
                }
                if (count == 1 && movi.Id != pokemon.Slot1__c){
                    pokemon.Slot2__c = movi.Id;
                    count++;
                }
                if (count == 2 && movi.Id != pokemon.Slot1__c && movi.Id != pokemon.Slot2__c){
                    pokemon.Slot3__c = movi.Id;
                    count++;
                }
                if (count == 3 && movi.Id != pokemon.Slot1__c && movi.Id != pokemon.Slot2__c && movi.Id != pokemon.Slot3__c){
                    pokemon.Slot4__c = movi.Id;
                    count++;
                }
            }
            //Se inserta el objeto de tipo Pokemon__c en la base de datos
            insert pokemon;
            
            
        }catch(Exception e){
            system.debug(e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        system.debug('Termino el batch');
    }
}