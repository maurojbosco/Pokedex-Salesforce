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

            PokeapiMoveJSON pokeapim = PokeapiMoveJSON.parse(res.getBody());
            Movimiento__c move = new Movimiento__c();

            // Campos Name, ExtId__c, pp__c, Punteria__c, Prioridad__c y Poder__c
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

            // Campos Chance_de_Efecto__c y Efecto__c
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
            
            // Campo Objetivo__c 
            Map<String,Object> target = (Map<String,Object>) mov.get('target');
            String targetname = (String) target.get('name');
            move.Objetivo__c = targetname;

            // Campo Tipo__c 
            Map<String,Object> type = (Map<String,Object>) mov.get('type');
            String typename = (String) type.get('name');
            move.Tipo__c = typename.capitalize();

            // Se inserta el objeto de tipo Movimiento__c en la base de datos
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