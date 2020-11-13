<?php
$fileJSON = file_get_contents("./account.json");
$arrAccount = json_decode($fileJSON);
function findUserByUsername($username){
    global $arrAccount;
    if(!$arrAccount){
        return null;
    }else{
        for($i=0;$i<count($arrAccount);$i++){
            $user=$arrAccount[$i];
            if($user->username == $username){
                return $user;
            }
        }
    }
   
    return null;

}
function addAccountToDB($username,$pwd){
    global $arrAccount;
    $arrAccount[] = ['username'=>$username,'pwd'=>$pwd];

    $json = json_encode($arrAccount);

    file_put_contents("./account.json",$json);
}
function getCurrentUser(){
    if(isset($_SESSION['username'])){
        $user = findUserByUsername($_SESSION['username']);
        return $user;
    }
    return null;
}