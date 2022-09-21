@isTest
private class PokemonControllerTest {
    @testSetup
    static void setup() {
        Pokemon__c pokemon1 = new Pokemon__c(Name='Rayquaza', ExtId__c=384, Tipos__c='Flying;Dragon');
        insert pokemon1;
        Pokemon__c pokemon2 = new Pokemon__c(Name='Salamence', ExtId__c=373, Tipos__c='Flying;Dragon');
        insert pokemon2;
        Pokemon__c pokemon3 = new Pokemon__c(Name='Altaria', ExtId__c=334, Tipos__c='Flying;Dragon');
        insert pokemon3;
        Pokemon__c pokemon4 = new Pokemon__c(Name='Pikachu', ExtId__c=25, Tipos__c='Electric');
        insert pokemon4;
        Pokemon__c pokemon5 = new Pokemon__c(Name='Calyrex', ExtId__c=898, Tipos__c='Grass;Psychic');
        insert pokemon5;
       
       
        }
    @istest
    static void queryWithEmptyParameters(){
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        
        Test.startTest();
        pokemons = PokemonController.getPokemons('','','','');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),5);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 25]);
        system.assertEquals(pokemons[1],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 334]);
        system.assertEquals(pokemons[2],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 373]);
        system.assertEquals(pokemons[3],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 384]);
        system.assertEquals(pokemons[4],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 898]);
    }
    @istest
    static void queryWhitFullParameters(){
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        
        Test.startTest();
        pokemons = PokemonController.getPokemons('a','3','Flying','Dragon');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),3);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 334]);
        system.assertEquals(pokemons[1],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 373]);
        system.assertEquals(pokemons[2],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 384]);
    }
    @istest
    static void queryWhithOneParameter(){
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        
        Test.startTest();
        pokemons = PokemonController.getPokemons('','','','Electric');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
		system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 25]);
    }
    @istest
    static void queryWhithTwoParameters(){
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        
        Test.startTest();
        pokemons = PokemonController.getPokemons('','','Flying','Dragon');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),3);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 334]);
        system.assertEquals(pokemons[1],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 373]);
        system.assertEquals(pokemons[2],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 384]);
    }
    @istest
    static void queryWhithThreeParameters(){
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        
        Test.startTest();
        pokemons = PokemonController.getPokemons('','8','Psychic','Grass');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 898]);
    }
}