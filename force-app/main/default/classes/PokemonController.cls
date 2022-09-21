public with sharing class PokemonController {
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getPokemons(
        String nombre,
        String generacion,
        string tipo1,
        String tipo2){
        String query;

        String condicion ='';
        if (String.isNotBlank(nombre)){
            condicion = 'Name LIKE \''+'%' + nombre + '%\'';
        }
        if (String.isNotBlank(generacion)) {
            if (String.isNotBlank(condicion)){
                condicion +=' AND Generacion__c = ' + generacion +'';
            } else {
                condicion +=' Generacion__c = ' + generacion +'';
            }
        }
        if (String.isNotBlank(tipo1)) {
            if(String.isNotBlank(condicion)) {
                condicion += ' AND Tipos__c INCLUDES ' + '(\'' +tipo1 +'\')';
            } else {
                condicion += ' Tipos__c INCLUDES ' + '(\'' +tipo1 +'\')';
            }
        }
        if (String.isNotBlank(tipo2)) {
            if(String.isNotBlank(condicion)) {
                condicion += ' AND Tipos__c INCLUDES ' + '(\'' +tipo2 +'\')';
            } else {
                condicion += ' Tipos__c INCLUDES ' + '(\'' +tipo2 +'\')';
            }
        }
        if (String.isNotBlank(condicion)) {
            query =
                'SELECT Generacion__c, Imagen__c, Name, ExtId__c, Tipos__c, Peso__c, Altura__c FROM Pokemon__c WHERE ' +
                condicion +
                ' ORDER BY ExtId__c';
        } else {
            query = 'SELECT Generacion__c, Imagen__c, Name, ExtId__c, Tipos__c, Peso__c, Altura__c FROM Pokemon__c ORDER BY ExtId__c';
        }
        List<Pokemon__c> pokemons = Database.query(query);
        return pokemons;
    }
}