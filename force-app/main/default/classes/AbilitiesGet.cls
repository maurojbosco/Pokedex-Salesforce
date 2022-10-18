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

            PokeapiAbilityJSON pokeapiab = PokeapiAbilityJSON.parse(res.getBody());
            Habilidad__c ability = new Habilidad__c();

            // Campos Name y ExtId__c
            ability.Name = pokeapiab.name.Capitalize();
            ability.ExtId__c = Integer.valueOf(pokeapiab.id);

            // Campo Efecto__c
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

            // Se inserta el objeto de tipo Habilidad__c en la base de datos
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