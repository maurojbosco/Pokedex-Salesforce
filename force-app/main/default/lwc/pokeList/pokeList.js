import { NavigationMixin } from 'lightning/navigation';
import { LightningElement, wire, track } from 'lwc';
/** PokemonController.searchPokemons(searchTerm) Apex method */
import getPokemons from '@salesforce/apex/PokemonController.getPokemons';
import TIPOS_FIELD from '@salesforce/schema/Pokemon__c.Tipos__c';
import StayInTouchSubject from '@salesforce/schema/User.StayInTouchSubject';
import CustomerSignedTitle from '@salesforce/schema/Contract.CustomerSignedTitle';
export default class PokeList extends NavigationMixin(LightningElement) {
	nombre = '';
	generacion = null;
    tipo1 = '';  // aca si la pongo null me anda, asi no.
	tipo2 = '';
	pokemons;
	/*pokemons;*/

	//generacionPickListValues;

    @wire(getPokemons, {
        nombre: "$nombre",
        generacion: "$generacion",
        tipo1: "$tipo1",
		tipo2: "$tipo2"
    })
	pokemons;
	
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.nombre = searchTerm;
		}, 300);
	}
	get hasResults() {
		return (this.pokemons.data.length > 0);
	}
	handlePokemonView(event) {
		// Get pokemon record id from pokemonview event
		const PokemonId = event.detail;
		// Navigate to pokemon record page
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: PokemonId,
				objectApiName: 'Pokemon__c',
				actionName: 'view',
			},
		});
	}
	handleChange(event) {
        this[event.target.name] = event.target.value;
        console.log("change", this[event.target.name]);
    }
	@track value;
	@track tiposOptions = [
		{ label : 'Todos', value: 'Todos'},
		{ label : 'Normal', value: 'Normal'},
		{ label : 'Fighting', value: 'Fighting'},
		{ label : 'Flying', value: 'Flying'},
		{ label : 'Poison', value: 'Poison'},
		{ label : 'Ground', value: 'Ground'},
		{ label : 'Rock', value: 'Rock'},
		{ label : 'Bug', value: 'Bug'},
		{ label : 'Ghost', value: 'Ghost'},
		{ label : 'Steel', value: 'Steel'},
		{ label : 'Fire', value: 'Fire'},
		{ label : 'Water', value: 'Water'},
		{ label : 'Grass', value: 'Grass'},
		{ label : 'Electric', value: 'Electric'},
		{ label : 'Psychic', value: 'Psychic'},
		{ label : 'Ice', value: 'Ice'},
		{ label : 'Dragon', value: 'Dragon'},
		{ label : 'Dark', value: 'Dark'},
		{ label : 'Fairy', value: 'Fairy'},
	]
	@track allTiposValues = [];

	handleTiposChange(event) {
		if(!this.allTiposValues.includes(event.target.name)
		& event.detail.value != 'Todos'
		& this.tipo2 != event.detail.value
		& this.tipo1==''){
			this.tipo1 = event.detail.value;
			this.allTiposValues.push(event.detail.value);
		} 
		if(!this.allTiposValues.includes(event.target.name)
		& event.detail.value != 'Todos' 
		& this.tipo1 != event.detail.value
		& this.tipo2==''){
			this.tipo2 = event.detail.value;
			this.allTiposValues.push(event.detail.value);
		}
		if(event.detail.value == 'Todos'){
			this.tipo1 = '';
			this.tipo2 = '';
			this.allTiposValues = [];
		}

		console.log('tipo 1 change='+this.tipo1);
		console.log('tipo 2 change='+this.tipo2);
		console.log(JSON.stringify(this.allTiposValues));
	}

	handleTiposRemove(event){
		const valueRemoved = event.target.name;
		
		if (this.tipo1 == valueRemoved){
			this.tipo1 = '';
		}
		if (this.tipo2 == valueRemoved){
			this.tipo2 = '';
		}
		this.allTiposValues.splice(this.allTiposValues.indexOf(valueRemoved),1);
		console.log('tipo 1 remove='+this.tipo1);
		console.log('tipo 2 remove='+this.tipo2);
		console.log(JSON.stringify(this.allTiposValues));

	}
	@track generacionOptions = [
			{ label: 'Todas', value: ''},
            { label: 'generacion 1', value: '1' },
            { label: 'generacion 2', value: '2' },
            { label: 'generacion 3', value: '3' },
            { label: 'generacion 4', value: '4' },
            { label: 'generacion 5', value: '5' },
            { label: 'generacion 6', value: '6' },
            { label: 'generacion 7', value: '7' },
            { label: 'generacion 8', value: '8' }
        ]

    handleGeneracionChange(event){
        this.generacion = event.detail.value
    }
}