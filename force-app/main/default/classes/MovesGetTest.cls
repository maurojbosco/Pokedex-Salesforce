@isTest
private class MovesGetTest {
    @testSetup
    static void setup() {
    }
    @isTest 
    static void testEffectChanceNull() {
         // Set mock callout class 
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               '{"accuracy":100,"effect_chance":null,"effect_entries":[{"effect":"Inflicts regular damage.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Inflicts regular damage with no additional effect."}],"id":1,"name":"pound","power":40,"pp":35,"priority":0,"target":{"name":"selected-pokemon","url":"https://pokeapi.co/api/v2/move-target/10/"},"type":{"name":"normal","url":"https://pokeapi.co/api/v2/type/1/"}}',
                                                                null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
        List<Integer> num = new List<Integer>();
        for(Integer i = 1 ; i <= 1; i++){
            num.add(i);
        }
        MovesGet numero = new MovesGet(num);
        Id batchId = Database.executeBatch(numero,1);
        Test.stopTest();
        Movimiento__c movi = [SELECT Id, Name, ExtId__c, pp__C, Punteria__c, Prioridad__c, Poder__c, Chance_de_Efecto__c, Efecto__c
                             FROM Movimiento__c
                             LIMIT 1];
        // after the testing stops, assert records were inserted properly
        System.assertEquals('Pound', movi.Name );
        System.assertEquals(1, movi.ExtId__c);
        System.assertEquals(35, movi.pp__c);
        System.assertEquals(100, movi.Punteria__c);
        System.assertEquals(0, movi.Prioridad__c);
        System.assertEquals(40, movi.Poder__c);
        System.assertEquals(null, movi.Chance_de_Efecto__c);
        System.assertEquals('Inflicts regular damage with no additional effect.', movi.Efecto__c);
    }
    @isTest 
    static void testEffectChanceNotNull() {
         // Set mock callout class 
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               '{"accuracy":100,"effect_chance":10,"effect_entries":[{"effect":"Inflicts regular damage.  Has a $effect_chance% chance to freeze the target.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Has a $effect_chance% chance to freeze the target."}],"id":8,"name":"ice-punch","power":75,"pp":15,"priority":0,"target":{"name":"selected-pokemon","url":"https://pokeapi.co/api/v2/move-target/10/"},"type":{"name":"ice","url":"https://pokeapi.co/api/v2/type/15/"}}',
                                                                null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
        List<Integer> num = new List<Integer>();
        for(Integer i = 8 ; i <= 8; i++){
            num.add(i);
        }
        MovesGet numero = new MovesGet(num);
        Id batchId = Database.executeBatch(numero,1);
        Test.stopTest();
        Movimiento__c movi = [SELECT Id, Name, ExtId__c, pp__C, Punteria__c, Prioridad__c, Poder__c, Chance_de_Efecto__c, Efecto__c
                             FROM Movimiento__c
                             LIMIT 1];
        // after the testing stops, assert records were inserted properly
        System.assertEquals('Ice-punch', movi.Name );
        System.assertEquals(8, movi.ExtId__c);
        System.assertEquals(15, movi.pp__c);
        System.assertEquals(100, movi.Punteria__c);
        System.assertEquals(0, movi.Prioridad__c);
        System.assertEquals(75, movi.Poder__c);
        System.assertEquals(10, movi.Chance_de_Efecto__c);
        System.assertEquals('Has a 10% chance to freeze the target.', movi.Efecto__c);
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
        for(Integer i = 990 ; i <= 990; i++){
            num.add(i);
        }
        MovesGet numero = new MovesGet(num);
        Id batchId = Database.executeBatch(numero,1);
        Test.stopTest();
        
        // after the testing stops, assert no records were inserted
        System.assertEquals(0, [SELECT count() FROM Movimiento__c] );
    }
}