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
	@track allTiposValues = [];

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
	
	tiposOptions = [
		{ label : 'Todos', value: 'Todos'},
		{ label : 'Bug (Bicho)', value: 'Bug'},
		{ label : 'Dark (Oscuro)', value: 'Dark'},
		{ label : 'Dragon (Dragón)', value: 'Dragon'},
		{ label : 'Electric (Eléctrico)', value: 'Electric'},
		{ label : 'Fairy (Hada)', value: 'Fairy'},
		{ label : 'Fighting (Luchador)', value: 'Fighting'},
		{ label : 'Fire (Fuego)', value: 'Fire'},
		{ label : 'Flying (Volador)', value: 'Flying'},
		{ label : 'Ghost (Fantasma)', value: 'Ghost'},
		{ label : 'Grass (Planta)', value: 'Grass'},
		{ label : 'Ground (Tierra)', value: 'Ground'},
		{ label : 'Ice (Hielo)', value: 'Ice'},
		{ label : 'Normal (Normal)', value: 'Normal'},
		{ label : 'Poison (Veneno)', value: 'Poison'},
		{ label : 'Psychic (Psíquico)', value: 'Psychic'},
		{ label : 'Rock (Roca)', value: 'Rock'},
		{ label : 'Steel (Acero)', value: 'Steel'},
		{ label : 'Water (Agua)', value: 'Water'}
	]

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
	}

	generacionOptions = [
			{ label: 'Todas', value: ''},
            { label: 'Generación 1', value: '1' },
            { label: 'Generación 2', value: '2' },
            { label: 'Generación 3', value: '3' },
            { label: 'Generación 4', value: '4' },
            { label: 'Generación 5', value: '5' },
            { label: 'Generación 6', value: '6' },
            { label: 'Generación 7', value: '7' },
            { label: 'Generación 8', value: '8' }
    ]

    handleGeneracionChange(event){
        this.generacion = event.target.value
    }
}