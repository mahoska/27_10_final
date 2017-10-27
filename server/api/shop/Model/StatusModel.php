<?php

class StatusModel extends Model{


public function getAllStatuses(){
    try{
        $sth = $this->pdo->query('SELECT id, name FROM statusorder '); 
        $collection = $this->getFetchAccoss($sth);
        return ['status'=>200, 'data'=>$collection];
    }catch(PDOException $err){
        file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
        return ['status'=>500, 'clientCode'=>'0006'];
    }
}


}
