@isTest
private class AbilitiesGetTest {
    @testSetup
    static void setup() {
    }
    @isTest 
    static void testLangnameEnSecondPlace() {
         // Set mock callout class 
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               '{"effect_entries":[{"effect":"Attacken die Schaden","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"short_effect":"Mit jedem Treffer"},{"effect":"This Pokemons damaging move.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Has a 10% chance of making target Pokémon flinch with each hit."}],"id":1,"name":"stench"}',
                                                                null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
        List<Integer> num = new List<Integer>();
        for(Integer i = 1 ; i <= 1; i++){
            num.add(i);
        }
        AbilitiesGet numero = new AbilitiesGet(num);
        Id batchId = Database.executeBatch(numero,1);
        Test.stopTest();
        Habilidad__c habil = [SELECT Id, Name, ExtId__c, Efecto__c 
                              FROM Habilidad__c 
                              LIMIT 1];
        // after the testing stops, assert records were inserted properly
        System.assertEquals('Stench', habil.Name );
        System.assertEquals(1, habil.ExtId__c);
        System.assertEquals('Has a 10% chance of making target Pokémon flinch with each hit.', habil.Efecto__c);
    }
    @isTest 
    static void testLangnameEnFirstPlace() {
         // Set mock callout class 
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               '{"effect_entries":[{"effect":"Whenever a Pokémon.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Damages opponents using leeching moves for as much as they would heal."},{"effect":"Wenn ein Pokémon.","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"short_effect":"Gegnern die absorbierende."}],"id":64,"name":"liquid-ooze"}',
                                                                null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
        List<Integer> num = new List<Integer>();
        for(Integer i = 64 ; i <= 64; i++){
            num.add(i);
        }
        AbilitiesGet numero = new AbilitiesGet(num);
        Id batchId = Database.executeBatch(numero,1);
        Test.stopTest();
        Habilidad__c habil = [SELECT Id, Name, ExtId__c, Efecto__c 
                              FROM Habilidad__c 
                              LIMIT 1];
        // after the testing stops, assert records were inserted properly
        System.assertEquals('Liquid-ooze', habil.Name );
        System.assertEquals(64, habil.ExtId__c);
        System.assertEquals('Damages opponents using leeching moves for as much as they would heal.', habil.Efecto__c);
         // Verify mock response is not null
        //System.assertNotEquals(null,fakeResponse, 'The callout returned a null response.');
    }
    @isTest 
    static void testNoResponse() {
         // Set mock callout class 
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                               'Not Found',
                                                               '',
                                                                null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        
        Test.startTest();
        List<Integer> num = new List<Integer>();
        for(Integer i = 64 ; i <= 64; i++){
            num.add(i);
        }
        AbilitiesGet numero = new AbilitiesGet(num);
        Id batchId = Database.executeBatch(numero,1);
        Test.stopTest();
        
        // after the testing stops, assert no records were inserted
        System.assertEquals(0, [SELECT count() FROM Habilidad__c] );
    }
}