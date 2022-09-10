public class PokeapiMoveJSON{
	public String accuracy;	//100
	public String effect_chance;
	public String id;	//1
	public String name;	//pound
	public String power;	//40
	public String pp;	//35
	public String priority;	//0

	public static PokeapiMoveJSON parse(String json){
		return (PokeapiMoveJSON) System.JSON.deserialize(json, PokeapiMoveJSON.class);
	}
}