<?php
namespace src\models;
use \core\Model;

class EmailList extends Model { 
    //o email que excedeu as 3 reservas so pode reservar depois de 2hrs
    public static function updateDecrementLastReserveDatetime($id, $expirationTime = '02:00:00'){             
        $data = array(
            'id' => $id,
            'expiration_time' => $expirationTime
        );                 
        
        return ListValidationCodes::query("CALL sp_update_emaillist('$data[id]','$data[expiration_time]')");        
        
    }
}