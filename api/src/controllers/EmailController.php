<?php
namespace src\controllers;
use \core\Controller;
use \src\models\ListValidationCodes;
use \src\models\EmailList;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use chillerlan\QRCode\{QRCode, QROptions};
use DateTime;

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
        
    public function sendQRCodeEmail(){
        $id = filter_input(INPUT_POST, 'id');        
        $adminEmail = 'equipeanti404@gmail.com';
        $local = filter_input(INPUT_POST, 'local');
        $description = filter_input(INPUT_POST, 'description');
        $userName = filter_input(INPUT_POST, 'username');
        $userEmail = filter_input(INPUT_POST, 'useremail', FILTER_VALIDATE_EMAIL);
        $subject = filter_input(INPUT_POST, 'subject');        
        $path = filter_input(INPUT_POST, 'path');        
        $validationCode = filter_input(INPUT_POST, 'validationCode');        
               
        $options = new QROptions([
            'version'      => 10,
            'outputType'   => QRCode::OUTPUT_IMAGE_JPG,
            'eccLevel'     => QRCode::ECC_H,
            'scale'        => 5,
            'imageBase64'  => false
        ]);
        
        if($adminEmail && $userEmail && $userName && $id && $local && $path && $validationCode){
            // verificar se o code realmente existe e do banco e esta atrelado aquele email.
            //verificar se o codigo existe
            //verificar sem esse email ultrapasou 3 reservas em 24hrs
            // O codigo e valido por 5 min

            try { 

                $code = ListValidationCodes::select()->where('code',$validationCode)->get();                 
                if(count($code) <= 0 &&
                 !$this->checkDateDifference($code[0]['create_at'], 300) //300s = 5min
                ){                   
                    
                    EmailList::insert(
                        [                     
                            'addr'=>$userEmail
                        ]
                        )->execute();
                    
                    $this->array['result'] = 'Reservado com sucesso'; 

                }else { 
                    
                    $this->array['error'] = "Codigo invalido"; 
                    
                }

 
            } catch (Exception $e) {
                $this->array['error'] = "Erro ao enviar o e-mail: {$this->mail->ErrorInfo}";
            }

             try { 

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
                
                
                $this->mail->send();                 
                $this->array['result'] = 'E-mail enviado com sucesso';
                unlink('../assets/imgs/'.$nameImg.'.jpg'); 

            } catch (Exception $e) {
                $this->array['error'] = "Erro ao enviar o e-mail: {$this->mail->ErrorInfo}";
            }
            

        }else{
            $this->array['error'] = 'Dados obrigatórios não enviados';
        }
        

        echo json_encode($this->array);       
        exit;
    }

    public function sendVerificationEmail(){  
    
        $userEmail = filter_input(INPUT_POST, 'useremail', FILTER_VALIDATE_EMAIL, FILTER_SANITIZE_EMAIL);
        $code = rand(1000,9999);
        $msg = "Expira em 5 minutos.";
        $subject = "Verificação de email";

        if($userEmail){
            try {                                   
                                                   
               $this->mail->addAddress("{$userEmail}");
               $this->mail->Subject = $subject;
               $this->mail->Body = " Codigo de validação: <br> <h1>$code</h1> $msg";
               $this->mail->send();
                
               ListValidationCodes::insert(
                [                     
                    'code'=>$code
                ]
                )->execute();
                
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

    private function checkDateDifference($date, $daysLimit){        
        $dateThing = new DateTime($date);
        $now = new DateTime('now', $this->UTCTimeZone);                               
        $now->setTimezone($this->timeZone);                              
        $diffDates =  $now->format('U') - $dateThing->format('U');        
        return ($diffDates >= $daysLimit);
    }
    
   
    
}
