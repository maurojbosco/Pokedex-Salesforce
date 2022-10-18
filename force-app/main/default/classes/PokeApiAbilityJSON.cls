public class PokeApiAbilityJSON {
    public String id;
    public String name;   
    public static PokeApiAbilityJSON parse(String json){
        return (PokeApiAbilityJSON) System.JSON.deserialize(json, PokeApiAbilityJSON.class);
    }
}