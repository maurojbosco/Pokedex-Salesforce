public class PokeapiJSON{
	public String height;
	public String id;
	public String name;
	public String weight;
    public String order;
 
	public static PokeapiJSON parse(String json){
		return (PokeapiJSON) System.JSON.deserialize(json, PokeapiJSON.class);
	}

}