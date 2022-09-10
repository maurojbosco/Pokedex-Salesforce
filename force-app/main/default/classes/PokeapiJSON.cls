public class PokeapiJSON{
	public String height;	//3
	public String id;	//132
	public String name;	//ditto
	public String weight;	//40
    public String order;
 
	public static PokeapiJSON parse(String json){
		return (PokeapiJSON) System.JSON.deserialize(json, PokeapiJSON.class);
	}

}