import { NavigationMixin } from 'lightning/navigation';
import { LightningElement, wire } from 'lwc';
/** PokemonController.searchPokemons(searchTerm) Apex method */
import searchPokemons from '@salesforce/apex/PokemonController.searchPokemons';
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import TIPOS_FIELD from '@salesforce/schema/Pokemon__c.Tipos__c';
export default class PokeList extends NavigationMixin(LightningElement) {
	searchTerm = '';
	pokemons;

	generacionPickListValues;
	tiposPickListValues;

    @wire(searchPokemons, {searchTerm: '$searchTerm'})
    loadPokemons(result) {
    this.pokemons = result;
    	if (result.data) {
        	const message = {
        	pokemons: result.data
    		};
    	}
	}
	@wire(getPicklistValues, {
        recordTypeId: "01I8c000005EQOD",
        fieldApiName: TIPOS_FIELD
	})
	tiposPickLists({ error, data }) {
        if (error) {
            console.error("error", error);
        } else if (data) {
            this.tiposPickListValues = [
                { label: "All", value: null },
                ...data.values
            ];
        }
    }
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
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
}