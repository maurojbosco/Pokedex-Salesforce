import { LightningElement, api } from 'lwc';
//import ursusResources from '@salesforce/resourceUrl/ursus_park';
export default class PokemonTile extends LightningElement {
	@api pokemon;
	//appResources = {
	//	bearSilhouette: `${ursusResources}/standing-bear-silhouette.png`,
	//};
    handleOpenRecordClick() {
        const selectEvent = new CustomEvent('pokemonview', {
            detail: this.pokemon.Id
        });
        this.dispatchEvent(selectEvent);
    }
}