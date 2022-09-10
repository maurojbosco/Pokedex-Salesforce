public class PokeApiAbilityJSON {
    public String id;	//1
    public String name;	//stench
   
    public static PokeApiAbilityJSON parse(String json){
        return (PokeApiAbilityJSON) System.JSON.deserialize(json, PokeApiAbilityJSON.class);
    }
}