import config from '../../../../config.js';

class LayoutModalSearch{

    constructor(){}

    async create(container, hrefLink=config.urlBase, flagSandwichMenu = false){  
            
            let divSearchModal = document.createElement("div");
            let divSearchBarModal = document.createElement("div");            
            let inputSearchItem  = document.createElement("input");
            let searchButton = document.createElement("img");           
            
           
            divSearchModal.setAttribute('id','search-modal');

            divSearchBarModal.setAttribute('class','search-bar-modal');

            inputSearchItem.setAttribute('type','search');
            inputSearchItem.setAttribute('class','search-item');
            inputSearchItem.setAttribute('placeholder','Ex: garrafa amarela');

            searchButton.setAttribute('class','material-symbols-rounded search-button');                   
            searchButton.src = `${config.urlBase}/assets/imgs/icons/search_FILL0_wght300_GRAD0_opsz24.svg`;  
            searchButton.alt = `Botão de pesquisar`;            

            divSearchBarModal.appendChild(inputSearchItem);
            divSearchBarModal.appendChild(searchButton);
            
            divSearchModal.appendChild(divSearchBarModal);

            container.appendChild(divSearchModal);            
    
    }

}

export default LayoutModalSearch;