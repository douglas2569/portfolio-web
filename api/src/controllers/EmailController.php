<?php
namespace src\controllers;
use \core\Controller;
use \src\models\ListValidationCodes;
use \src\models\EmailList;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use chillerlan\QRCode\{QRCode, QROptions};
use \src\services\AuthService;

require '../vendor/autoload.php';

class EmailController extends Controller{ 
    private $mail = null;
    public function __construct(){
        parent::__construct();

        $this->mail = new PHPMailer(true);
        $this->mail->SMTPSecure = 'plain';
        $this->mail->isSMTP();
        $this->mail->Host = 'smtp.gmail.com';
        $this->mail->Port = 465;
        $this->mail->SMTPAuth = true;
        $this->mail->Username = 'tworeba'; 
        $this->mail->Password = 'ddfaajjaafnkfkwg'; 
        $this->mail->SMTPSecure = 'ssl';
        $this->mail->setFrom('tworeba@gmail.com');                                                        
                                             
        $this->mail->isHTML(true);
        $this->mail->CharSet = 'utf-8';
        $this->mail->FromName = 'Achaí';
        
    }
    
    private function manageEmailList($resultsetEmail, $userEmail){
        // var_dump($resultsetEmail[0]); exit;
        
        try { 
            if (count($resultsetEmail) <= 0) {
                EmailList::insert(['addr'=>$userEmail])->execute();
            }else{ 
                EmailList::update()->set([
                        'reserve_quantity' => ++$resultsetEmail[0]['reserve_quantity']
                    ]
                    )->where('id', $resultsetEmail[0]['id'])->execute();
                $this->array['result'] = 'E-mail enviado e objeto reservado com sucesso';
            }

        } catch (Exception $e) {
            $this->array['error'] = "Erro ao inserirEmaillist";
        }
    }
        
    public function sendQRCodeEmail(){
        $userEmail = filter_input(INPUT_POST, 'useremail', FILTER_VALIDATE_EMAIL);
        $id = filter_input(INPUT_POST, 'id');        
        
        $validationCode = filter_input(INPUT_POST, 'validationCode');               
        $code = ListValidationCodes::select()->where('code',$validationCode)->where('thing_id',$id)->get();
        if(count($code) <= 0 ){  
            $this->array['error'] = "Codigo invalido"; 
            echo json_encode($this->array);       
            exit;
        }
        
        $resultsetEmail = EmailList::select()->where('addr',$userEmail)->get();           
        if (count($resultsetEmail) > 0 && !$resultsetEmail[0]['status']) {
            $this->array['error'] = "Você foi bloqueado. Entrar em contato com a secretaria"; 
            echo json_encode($this->array);       
            exit;
        }

        $adminEmail = 'equipeanti404@gmail.com';
        $local = filter_input(INPUT_POST, 'local');
        $description = filter_input(INPUT_POST, 'description');
        $userName = filter_input(INPUT_POST, 'username');
        $subject = filter_input(INPUT_POST, 'subject');        
        $path = filter_input(INPUT_POST, 'path'); 
        
        
        if($adminEmail && $userEmail && $userName && $id && $local && $path && $validationCode){

            $options = new QROptions([
                'version'      => 10,
                'outputType'   => QRCode::OUTPUT_IMAGE_JPG,
                'eccLevel'     => QRCode::ECC_H,
                'scale'        => 5,
                'imageBase64'  => false
            ]);     
             
            $this->mail->addAddress("{$adminEmail}");                                      
            $this->mail->addAddress("{$userEmail}");                                      
                                            
            $nameImg = md5(time().rand(0,99));
            
            (new QRcode($options))->render($path,'../assets/imgs/'.$nameImg.'.jpg');   
            $this->mail->addAttachment('../assets/imgs/'.$nameImg.'.jpg','QRCodeObjetoPerdido.jpeg');                                                                                              

            $this->mail->Body = "<p>
                                Código:". $id." <br>
                                Local:".$local." <br>
                                Descrição:".$description."<br>                                                                                                                                        
                        </p>";
                        
            $this->mail->Subject = $subject;
            $this->mail->AltBody = 'O objeto de código '.$id.' foi encontrado no(a) '.$local.'. Descrição: '.$description;

            try {     
                $this->mail->send();
                if(file_exists('../assets/imgs/'.$nameImg.'.jpg'))
                        unlink('../assets/imgs/'.$nameImg.'.jpg');

                $this->array['result'] = 'E-mail enviado e objeto reservado com sucesso';
            }catch (Exception $e) {
                $this->array['error'] = "Erro ao enviar o e-mail: {$this->mail->ErrorInfo}";
            }
        
            $this->manageEmailList($resultsetEmail, $userEmail);            

        }else{
            $this->array['error'] = 'Dados obrigatórios não enviados';
        }
        
        echo json_encode($this->array);       
        exit;
    }

    public function sendVerificationEmail(){  
    
        $userEmail = filter_input(INPUT_POST, 'useremail', FILTER_VALIDATE_EMAIL, FILTER_SANITIZE_EMAIL);
        $thingId = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT, FILTER_SANITIZE_NUMBER_INT);

        $code = rand(1000,9999);
        $msg = "Expira em 5 minutos.";
        $subject = "Verificação de email";

        if($userEmail){
            try {                                   
                                                   
               $this->mail->addAddress("{$userEmail}");
               $this->mail->Subject = $subject;
               $this->mail->Body = " Codigo de validação: <br> <h1>$code</h1> $msg";
               $this->mail->send();           

                ListValidationCodes::insertSP($code, $thingId);
                
                $this->array['result'] = 'E-mail de validação enviado com sucesso'; 

           } catch (Exception $e) {
               $this->array['error'] = "Erro ao enviar o e-mail: {$this->mail->ErrorInfo}";
           }
           

       }else{
           $this->array['error'] = 'Dados obrigatórios não enviados';
       }
       

       echo json_encode($this->array);       
       exit;

    }


    function changeStatusEmail(){        
        $hash = filter_input(INPUT_POST, 'hash');          
        if(!(AuthService::checkHash($hash))){
            $this->array['error'] = 'Acesso negado. Contate o Administrador';
            
            echo json_encode($this->array);
            exit;
        }
                
        $id = filter_input(INPUT_POST, 'id');        
        $status = filter_input(INPUT_POST, 'status');        
        $resultsetEmail = EmailList::select()->where('id',$id)->get(); 

        try { 
            if (count($resultsetEmail[0]) > 0) { 

                EmailList::update()->set([
                    'status' => $status
                ]
                )->where('id', $resultsetEmail[0]['id'])->execute();
                $this->array['result'] = 'Atividade executada com sucesso';
               
            }

        } catch (Exception $e) {
            $this->array['error'] = "Erro ao tentar atualizar o registro";
        }

        echo json_encode($this->array);       
        exit;
    }

}
