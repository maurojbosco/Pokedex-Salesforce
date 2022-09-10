global class AbilitiesGet implements Database.Batchable<Integer>, Database.AllowsCallouts {
    private List<Integer> habi;
    public AbilitiesGet(List<Integer> habi){
        this.habi = habi;
    }
    global List<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return habi;
    }
    global void execute(Database.BatchableContext bc, List<Integer> scope){
        // process each batch of records  
        try{
            HttpRequest req = new HttpRequest();
            req.setHeader('Accept', 'application/json');
            req.setEndpoint('https://pokeapi.co/api/v2/ability/' + scope[0]);
            req.setMethod('GET');
            HTTPResponse res = new Http().send(req);
            //Se instancia un objeto de tipo Habilidad__c, también uno de tipo PokeapiAbilityJSON y se llama al método 
            //parse de este último para deserializar el JSON que devuelve como respuesta la API. A continuación 
            //se procede a asignar los valores correspondientes a los campos Name y ExtId__c del objeto de tipo Habilidad__c
            PokeapiAbilityJSON pokeapiab = PokeapiAbilityJSON.parse(res.getBody());
            Habilidad__c ability = new Habilidad__c();
            ability.Name = pokeapiab.name.Capitalize();
            ability.ExtId__c = Integer.valueOf(pokeapiab.id);
            //Se Deserializa el JSON completo que devuelve la API, luego se obtiene el valor de 'effect_entries' y se evalúa
            //si la lista no está vacía. De ser así se obtiene el primer elemento de la misma para buscar dentro deeste la key
            //'language' y posteriormente la key 'name' en su interior. Posteriormente se evalúa si el valor de esta es 'en',
            //de ser así se retrocede hasta la raíz del primer elemento de la lista y dentro esta se obtiene el valor de
            //'short_effect' para asignarselo al campo Efecto__c. Si el valor no es 'en' significa que el elemento que necesitamos
            //es es segundo, entonces se obtiene el valor se short_effect' del mismo y se le asigna al campo Efecto__c.
            Map<String,Object> abil =(Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            List<Object> effectentries =(List<Object>) abil.get('effect_entries');
            if (effectentries.size() > 0 ){
                Map<String,Object> searchenglish = (Map<String,Object>) effectentries.get(0);
                Map<String,Object> language = (Map<String,Object>) searchenglish.get('language');
                String langname = (String) language.get('name');
                if (langname.equals('en')){
                    String shorteffect = (String) searchenglish.get('short_effect');
                    ability.Efecto__c = shorteffect;
                } else {
                    Map<String,Object> english = (Map<String,Object>) effectentries.get(1);
                    String shorteffect = (String) english.get('short_effect');
                    ability.Efecto__c = shorteffect;
                }
                
            }
            //Se inserta el objeto de tipo Habilidad__c en la base de datos
            insert ability;
        }catch(Exception e){
            system.debug(e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        system.debug('Terminó el batch');
    }
}