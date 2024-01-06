<?php
namespace src\models;
use \core\Model;

class ListValidationCodes extends Model { 

    
    public static function insertSP($code, $thingId){             
        $data = array(
            'code' => $code,
            'thing_id' => $thingId
        ); 
                
        
        return ListValidationCodes::query("CALL sp_register_listvalidationcodes('$data[code]','$data[thing_id]')");        
        
    }

}