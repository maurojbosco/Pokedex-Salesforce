public class PokeapiMoveJSON{
	public String accuracy;
	public String effect_chance;
	public String id;
	public String name;
	public String power;
	public String pp;
	public String priority;

	public static PokeapiMoveJSON parse(String json){
		return (PokeapiMoveJSON) System.JSON.deserialize(json, PokeapiMoveJSON.class);
	}
}