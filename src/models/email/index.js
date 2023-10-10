import Model from '../../core/model/index.js';

export default class ModelEmail extends Model{
   constructor() {
        super('email');
   }    
  

 async sendQRCodeEmail(formData){
    const endpoint = `${this.path}${this.nameController}/sendqrcodeemail`;   
    
      try {
        let response = await fetch(endpoint, {
          method: "POST",            
          body:  formData          
        });  
        
        response = await response.json();            
        return response;                 
        
      } catch (error) {
        console.log('Erro no codigo do sistema: '+error);
      }   
  }
     

  async sendVerificationEmail(formData){
    
    const endpoint = `${this.path}${this.nameController}/sendverificationemail`;                        
      try {
        let response = await fetch(endpoint, {
          method: "POST",            
          body:  formData          
        });  
        
        response = await response.json();        
        return response;                 
        
      } catch (error) {
        console.log('Erro no codigo do sistema: '+error);
      }   
  }

}