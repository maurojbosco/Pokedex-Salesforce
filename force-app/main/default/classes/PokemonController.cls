public with sharing class PokemonController {
    @AuraEnabled(cacheable=true scope='global')
    public static Pokemon__c[] getAllPokemons() {
        return [
            SELECT
                Id,
                Name,
                Tipos__c,
                Altura__c,
                Peso__c,
                Generacion__c,
                Imagen__c,
                ExtId__c
            FROM Pokemon__c
            WITH SECURITY_ENFORCED
            ORDER BY ExtId__c
        ];
    }

    @AuraEnabled(cacheable=true scope='global')
    public static Pokemon__c[] searchPokemons(String searchTerm) {
        // Return all pokemons when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllPokemons();
        }
        // Prepare query paramters
        searchTerm = '%' + searchTerm + '%';
        // Execute search query
        return [
            SELECT
                Id,
                Name,
                Tipos__c,
                Altura__c,
                Peso__c,
                Generacion__c,
                Imagen__c,
                ExtId__c
            FROM Pokemon__c
            WHERE Name LIKE :searchTerm
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];
    }
    @AuraEnabled(cacheable=true scope='global')
    public static Pokemon__c[] searchGeneration(Integer searchTerm) {
        // Execute search query
        return [
            SELECT
                Id,
                Name,
                Tipos__c,
                Altura__c,
                Peso__c,
                Generacion__c,
                Imagen__c,
                ExtId__c
            FROM Pokemon__c
            WHERE Generacion__c = :searchTerm
            WITH SECURITY_ENFORCED
            ORDER BY ExtId__c
        ];
    }
}
