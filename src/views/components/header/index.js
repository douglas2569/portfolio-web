import config from '../../../../config.js'
import dataStyles from './style.js'


class Header extends HTMLElement{
    constructor(){
        super() 
        const shadow = this.attachShadown({mode:'open'})
        const configComponent = {
            flagSearchButton:true, 
            flagSandwichMenu:false, 
            flagBreadcrumb:false, 
            flagInfo:true, 
            flagArrow:true
        }
        shadow.appendChild(this.create(configComponent))
        shadow.appendChild(this.styles())
    }

    create(configComponent){
        const header = document.createElement('header')

        const container = document.createElement('div')
        container.setAttribute('class','container')

        const headerTop = this.headerTop(configComponent)       

        const headerBody = this.headerBody(configComponent)
        
        const headerFooter = this.headerFooter()

        container.appendChild(headerTop)
        container.appendChild(headerBody)
        container.appendChild(headerFooter)

        header.appendChild(container)

        return header
    }

    headerTop({flagArrow, flagSearchButton, flagSandwichMenu, flagInfo}){
        const headerTop = document.createElement('div')
        headerTop.setAttribute('class','header-top')
        
        const headerTopHeader = document.createElement('div')
        headerTopHeader.setAttribute('class','header-top-header')
        
        const link = document.createElement('a')
        link.setAttribute('class','logo')
        
        const logo = document.createElement('img')
        logo.setAttribute('src',`${config.urlBase}/assets/imgs/logo.png`);
        logo.setAttribute('alt','logo Achaí - link painel de controle')

        const arrowButton = document.createElement("img");
        arrowButton.setAttribute('class','material-symbols-rounded arrow-button');        
        arrowButton.setAttribute('alt','Botão voltar');        
        arrowButton.src = `${config.urlBase}/assets/imgs/icons/arrow_back_FILL0_wght300_GRAD0_opsz24.svg`;  
        
        link.appendChild(logo)        

        const headerTopBody = document.createElement("div");
        headerTopBody.setAttribute('class','header-top-body');

        const searchButton = document.createElement("img");
        searchButton.setAttribute('class','material-symbols-rounded search-button');        
        searchButton.src = `${config.urlBase}/assets/imgs/icons/search_FILL0_wght300_GRAD0_opsz24.svg`;        
        searchButton.alt = `Botão pesquisar`; 

        const sandwichMenu = document.createElement("img");
        sandwichMenu.setAttribute('class','material-symbols-rounded sandwich-menu-button');
        sandwichMenu.src= `${config.urlBase}/assets/imgs/icons/menu_FILL0_wght300_GRAD0_opsz24.svg`;        
        sandwichMenu.style.width = "35px";
        sandwichMenu.style.height = "35px";
        sandwichMenu.alt = "Menu botão";

        const infoButton = document.createElement("img");
        infoButton.setAttribute('class','material-symbols-rounded info-button');        
        infoButton.src = `${config.urlBase}/assets/imgs/icons/info_FILL0_wght300_GRAD0_opsz24.svg`; 
        infoButton.alt = `botão informação`; 

        flagArrow && headerTopHeader.appendChild(arrowButton)
        headerTopHeader.appendChild(link)

        flagSearchButton && headerTopBody.appendChild(searchButton)
        flagSandwichMenu && headerTopBody.appendChild(sandwichMenu)
        flagInfo && headerTopBody.appendChild(infoButton)

        headerTop.appendChild(headerTopHeader)
        headerTop.appendChild(headerTopBody)

        return headerTop
    }

    headerBody({flagBreadcrumb}){
        const headerBody = document.createElement('div')
        headerBody.setAttribute('class','header-body')

        const breadcrump = document.createElement('ul');
        breadcrump.setAttribute('class', 'breadcrumb')      
        breadcrump.setAttribute('role', 'breadcrumb')  

        flagBreadcrumb && headerBody.appendChild(breadcrump);

        return headerBody
    }

    headerFooter(){
        const headerFooter = document.createElement('div')
        headerFooter.setAttribute('class','header-footer')

        const categories = document.createElement("div");
        categories.setAttribute('class','categories');

        headerFooter.appendChild(categories)
        return headerFooter
    }

    styles(){
        const elementStyle = document.createElement('style');
        elementStyle.textContent(dataStyles)
        return elementStyle  
    }
}

customElements.define('header-comp', Header)