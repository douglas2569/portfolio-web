import Model from '../../core/model/index.js';

export default class ModelCategories extends Model{
    constructor() {
        super('category');
     }

     async getCategoryByName(name){
        const endpoint = `${this.path}${this.nameController}/getcategorybyname/${name}`;
                
          try {            
              const response = await fetch(endpoint);           
              
              return response.json();
                          
            } catch(e) {
              console.log(e);
            }     
    }
   
    async update(addressRedirecting, formData){       
      const endpoint = `${this.path}${this.nameController}/update`;      
    

        try {
          let response = await fetch(endpoint, {
            method: "POST",            
            body:  formData,
          });  
          
          response = await response.json();
          
          if(response.error == ''){
            
            return "Editado com Sucesso";
                 

          }else{
            alert(response.error);                 
          }
          
        } catch (error) {
          console.log(error);
        }   
    }

    async delete(addressRedirecting, id, formData){
      const endpoint = `${this.path}${this.nameController}/delete/${id}`;
      
      try {
        let response = await fetch(endpoint, {
          method: "POST",
          body:  formData
  
        });  
        
        response = await response.json();
  
        if(response.error == ''){
          
          return "Excluido com Sucesso";                             
  
        }else{
          alert(response.error);                 
        }
      } catch (error) {
        alert(error);
      }
  
    }


}
