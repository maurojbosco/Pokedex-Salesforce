import { NavigationMixin } from 'lightning/navigation';
import { LightningElement, wire, track } from 'lwc';
import getPokemons from '@salesforce/apex/PokemonController.getPokemons';

export default class PokeList extends NavigationMixin(LightningElement) {
	nombre = '';
	generacion = null;
    tipo1 = ''; 
	tipo2 = '';
	@track pokemons = [];
	numberOfPoks;
	error;

    @wire(getPokemons, {
        nombre: "$nombre",
        generacion: "$generacion",
        tipo1: "$tipo1",
		tipo2: "$tipo2"
    })
	wiredPokemons({error, data}) {
		if (data) {
            this.pokemons = data;
            this.error = undefined;
			
        } else if (error) {
            this.error = error;
            this.pokemons = undefined;
        }
		this.numberOfPoks = this.pokemons.length;

	}

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
		return (this.numberOfPoks > 0);
	}
	handlePokemonView(event) {
		// Get pokemon record id from pokemonview event
		const PokemonId = event.target;
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
	
	get tiposOptions() {
		return [
		{ label : 'Todos', value: 'Todos'},
		{ label : 'Normal (Normal)', value: 'Normal'},
		{ label :'Fighting (Luchador)', value: 'Fighting'},
		{ label : 'Flying (Volador)', value: 'Flying'},
		{ label : 'Poison (Veneno)', value: 'Poison'},
		{ label : 'Ground (Tierra)', value: 'Ground'},
		{ label : 'Rock (Roca)', value: 'Rock'},
		{ label : 'Bug (Bicho)', value: 'Bug'},
		{ label : 'Ghost (Fantasma)', value: 'Ghost'},
		{ label : 'Steel (Acero)', value: 'Steel'},
		{ label : 'Fire (Fuego)', value: 'Fire'},
		{ label : 'Water (Agua)', value: 'Water'},
		{ label : 'Grass (Planta)', value: 'Grass'},
		{ label : 'Electric (Eléctrico)', value: 'Electric'},
		{ label : 'Psychic (Psíquico)', value: 'Psychic'},
		{ label : 'Ice (Hielo)', value: 'Ice'},
		{ label : 'Dragon (Dragón)', value: 'Dragon'},
		{ label : 'Dark (Oscuro)', value: 'Dark'},
		{ label : 'Fairy (Hada)', value: 'Fairy'},
	]}
	@track allTiposValues = [];

	handleTiposChange(event) {
		if(!this.allTiposValues.includes(event.target.name)
		& event.target.value != 'Todos'
		& this.tipo2 != event.target.value
		& this.tipo1==''){
			this.tipo1 = event.target.value;
			this.allTiposValues.push(event.target.value);
		} 
		if(!this.allTiposValues.includes(event.target.name)
		& event.target.value != 'Todos' 
		& this.tipo1 != event.target.value
		& this.tipo2==''){
			this.tipo2 = event.target.value;
			this.allTiposValues.push(event.target.value);
		}
		if(event.target.value == 'Todos'){
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
	get generacionOptions () {
		return [
			{ label: 'Todas', value: ''},
            { label: 'Generación 1', value: '1' },
            { label: 'Generación 2', value: '2' },
            { label: 'Generación 3', value: '3' },
            { label: 'Generación 4', value: '4' },
            { label: 'Generación 5', value: '5' },
            { label: 'Generación 6', value: '6' },
            { label: 'Generación 7', value: '7' },
            { label: 'Generación 8', value: '8' }
        ]}

    handleGeneracionChange(event){
        this.generacion = event.target.value
    }
}