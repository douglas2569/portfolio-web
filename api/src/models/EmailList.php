<?php
namespace src\models;
use \core\Model;

class EmailList extends Model { 

    public static function updateDecrementLastReserveDatetime($id){             
        $data = array(
            'id' => $id
        );                 
        
        return ListValidationCodes::query("CALL sp_update_emaillist('$data[id]')");        
        
    }
}