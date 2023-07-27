import config from '../../../../config.js';
import ModelAdmin from '../../../models/admin/index.js';

class LayoutSandwichMenu{

    constructor(){}

    getAdminEmail(){

        let modelAdmin = new ModelAdmin();
        let formData = new FormData();
        formData.append('hash', localStorage.getItem('hash')); 

        return modelAdmin.getByHash(formData);
    }

    async create(container){ 
        let divSandwichMenuBody = document.createElement("div");   
        divSandwichMenuBody.setAttribute('class','sandwich-menu-body');                                  

        let imgCloseModal = document.createElement("img"); 
        imgCloseModal.setAttribute('class','material-symbols-rounded');                   
        imgCloseModal.src = `${config.urlBase}/assets/imgs/icons/close_FILL0_wght300_GRAD0_opsz24.svg`;
        imgCloseModal.alt = 'Fechar menu';          
              

        let divBodyModal = document.createElement("div"); 
        divBodyModal.setAttribute('class','body-modal');           

        let divProfileImg = document.createElement("div");            

        let profileImg = document.createElement("img");  
        profileImg.src = `${config.urlBase}/assets/imgs/icons/account_circle_FILL1_wght300_GRAD0_opsz40.svg`;
        profileImg.alt = 'Administrador';          

        let divSeparator= document.createElement("div");            
        let divSeparatorProfileImgParent= document.createElement("div");            

        let h3Admin = document.createElement("h3"); 
        h3Admin.textContent = 'Administrador';                       

        let h4Email = document.createElement("h4");                    
                                        
        (this.getAdminEmail()).then((response)=>{
            h4Email.textContent = response.result.email;            
        });
        

        let btnProfileManager = document.createElement("button"); 
        btnProfileManager.textContent = 'Gerenciar perfil';
        btnProfileManager.setAttribute('class','profile-button');           

        let divModalTask = document.createElement("div");
        divModalTask.setAttribute('class','modal-task'); 
        

        let spanDiscardIcon = document.createElement('img');
        spanDiscardIcon.setAttribute('class','material-symbols-rounded');            
        spanDiscardIcon.setAttribute('alt','Botão discartes');            
        spanDiscardIcon.setAttribute('src',`${config.urlBase}/assets/imgs/icons/delete_FILL0_wght300_GRAD0_opsz24.svg`);            
        let spanDiscardText = document.createElement('span');
        spanDiscardText.textContent = 'Descartes';
        
        let spanEditCategoryIcon= document.createElement('img');
        spanEditCategoryIcon.setAttribute('class','material-symbols-rounded');            
        spanEditCategoryIcon.setAttribute('alt','Botão gerenciar categorias');            
        spanEditCategoryIcon.setAttribute('src',`${config.urlBase}/assets/imgs/icons/edit_FILL0_wght300_GRAD0_opsz24.svg`);            
        let spanEditTextCategory = document.createElement('span');
        spanEditTextCategory.textContent = 'Gerenciar categorias';

        let spanReturnedIcon= document.createElement('span');
        spanReturnedIcon.setAttribute('class','material-symbols-rounded');
        spanReturnedIcon.textContent = 'returned';
        let spanTextReturned = document.createElement('span');
        spanTextReturned.textContent = 'Devolvidos';


        let ul = document.createElement("ul"); 

        let li1 = document.createElement("li"); 
        li1.setAttribute('class','discard-things-button');  
        li1.appendChild(spanDiscardIcon);
        li1.appendChild(spanDiscardText);

        let li2 = document.createElement("li");  
        li2.setAttribute('class','category-manager-button');  
        li2.appendChild(spanEditCategoryIcon);
        li2.appendChild(spanEditTextCategory);
                    
        let li3 = document.createElement("li");
        li3.setAttribute('class','returned-things-button');            
        li3.appendChild(spanReturnedIcon);
        li3.appendChild(spanTextReturned);
        
        ul.appendChild(li1);
        ul.appendChild(li2);

        divProfileImg.appendChild(profileImg);

        divSeparator.appendChild(h3Admin);
        divSeparator.appendChild(h4Email);
        
        divSeparatorProfileImgParent.appendChild(divProfileImg);
        divSeparatorProfileImgParent.appendChild(divSeparator);
        
        divBodyModal.appendChild(divSeparatorProfileImgParent);

        divBodyModal.appendChild(btnProfileManager);
        // divCloseModal.appendChild(imgCloseModal);
        divSandwichMenuBody.appendChild(imgCloseModal);            
        divSandwichMenuBody.appendChild(divBodyModal);  
        divModalTask.appendChild(ul);            
        divSandwichMenuBody.appendChild(divModalTask);                  
        
        container.appendChild(divSandwichMenuBody);   
    
    }

}

export default LayoutSandwichMenu;