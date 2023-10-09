<?php
namespace core;

use \src\Config;
use DateTimeZone;

class Controller {
    public $array = [
        'error' => '',
        'result' => []
    ];

    protected DateTimeZone $UTCTimeZone;
    protected DateTimeZone $timeZone;

    public function __construct(){
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
        header("Content-Type: application/json");

        $this->UTCTimeZone =   new DateTimeZone("UTC");
        $this->timeZone =  new DateTimeZone('America/Fortaleza');
    }
    
    protected function redirect($url) {
        header("Location: ".$this->getBaseUrl().$url);
        exit;
    }

    private function getBaseUrl() {
        $base = (isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) == 'on') ? 'https://' : 'http://';
        $base .= $_SERVER['SERVER_NAME'];
        if($_SERVER['SERVER_PORT'] != '80') {
            $base .= ':'.$_SERVER['SERVER_PORT'];
        }
        $base .= Config::BASE_DIR;
        
        return $base;
    }    

}