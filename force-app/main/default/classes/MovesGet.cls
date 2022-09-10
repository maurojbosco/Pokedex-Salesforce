global class MovesGet implements Database.Batchable<Integer>, Database.AllowsCallouts {
    private List<Integer> movi;
    public MovesGet(List<Integer> movi){
        this.movi = movi;
    }
    global List<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return movi;
    }
    global void execute(Database.BatchableContext bc, List<Integer> scope){
        // process each batch of records  
        try{
            HttpRequest req = new HttpRequest();
            req.setHeader('Accept', 'application/json');
            req.setEndpoint('https://pokeapi.co/api/v2/move/' + scope[0]);
            req.setMethod('GET');
            HTTPResponse res = new Http().send(req);
            /*Se instancia un objeto de tipo Movimiento__c, también uno de tipo PokeapiMoveJSON y se llama al método
			parse de este último para deserializar el JSON que devuelve como respuesta la API. A continuación se 
			procede a asignar los valores correspondientes a los campos Name, ExtId__c, pp__c, Punteria__c
			y Prioridad__c del objeto de tipo Movimiento__c. Por último se evalúa si el valor de 'power' no es nulo 
			para poder asignarselo al campo Poder__c*/
            PokeapiMoveJSON pokeapim = PokeapiMoveJSON.parse(res.getBody());
            Movimiento__c move = new Movimiento__c();
            move.Name = pokeapim.name.Capitalize();
            move.ExtId__c = Integer.valueOf(pokeapim.id);
            move.pp__c = Integer.valueof(pokeapim.pp);
            move.Punteria__c = Integer.valueOf(pokeapim.accuracy);
            move.Prioridad__c = Integer.valueOf(pokeapim.priority);
            if (pokeapim.power != null){
                move.Poder__c = Integer.valueOf(pokeapim.power);
            }
            // Mapa que contiene el JSON completo que devuelve como respuesta la API, deserializado
            Map<String,Object> mov =(Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            /* Se procede a obtener el valor de 'effect_entries' y se evalúa si la lista obtenida no está vacía.
            De ser ser así se obtiene el valor de 'short_effect', para luego asignárselo al campo Efecto__c.
			También se evalúa si el valor de 'effect_chance' no es nulo para poder asignarselo al campo 
			Chance_de_Efecto__c y se usa la función replace de la clase String para remplazar la subcadena
			'$effect_chance' dentro de short_effect por el valor del campo Chance_de_Efecto__c.*/ 
            List<Object> effectentrieslist =(List<Object>) mov.get('effect_entries');
            if (effectentrieslist.size() > 0){
                Map<String,Object> effectentries0 =(Map<String,Object>) effectentrieslist.get(0);
                String short_effect = (String) effectentries0.get('short_effect');
                if (pokeapim.effect_chance != null){
                    move.Chance_de_Efecto__c = Integer.valueOf(pokeapim.effect_chance);
                    move.Efecto__c = short_effect.replace('$effect_chance', pokeapim.effect_chance);
                } else{
                    move.Efecto__c = short_effect;
                }
            }
            // Se procede a obtener el valor de 'target' y dentro de este el de 'name', para luego asignarselo al campo Objetivo__c 
            Map<String,Object> target = (Map<String,Object>) mov.get('target');
            String targetname = (String) target.get('name');
            move.Objetivo__c = targetname;
            //Se procede a obtener el valor de 'type' y dentro de este el de 'name', para luego asignarselo al campo Tipo__c 
            Map<String,Object> type = (Map<String,Object>) mov.get('type');
            String typename = (String) type.get('name');
            move.Tipo__c = typename.capitalize();
            //Se inserta el objeto de tipo Movimiento__c en la base de datos
            insert move;
        }catch(Exception e){
            system.debug(e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        system.debug('Termino el batch');
    }
}