<?php

class AuthorModel extends Model
{

    public function getAllAuthors()
    {
        try{
            $sth = $this->pdo->query("SELECT id, name, surname FROM author"); 
            $collection = $this->getFetchAccoss($sth);
            return ['status'=>200, 'data'=>$collection];
        }catch(PDOException $err){
            file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
            return ['status'=>500, 'clientCode'=>'0006'];
        }
    }

  
       public function isAuthorExists($params){
        try{
            $sth = $this->pdo->prepare("SELECT COUNT(*) FROM author WHERE name = :name AND surname=:surname"); 
            $sth->execute($params);
            $res = $sth->fetch(\PDO::FETCH_NUM);
            if($res[0]>0) return false;
            return true;
        }catch(PDOException $err){
            file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
            return ['status'=>500, 'clientCode'=>'0006'];
        }
    }

    public function getfullInfoAuthor($params)
    {
        try{
            $sth = $this->pdo->prepare("SELECT id, name, surname FROM author WHERE id = :id");
            $sth->execute($params);
            $info = $sth->fetch(\PDO::FETCH_ASSOC);
            return ['status'=>200, 'data'=>$info];
        }catch(PDOException $err){
            file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
            return ['status'=>500, 'clientCode'=>'0006'];
        } 
    }
    
     public function updateAuthor($params)
    {
        try{
            $sth = $this->pdo->prepare("UPDATE author "
                    . "SET name = :name, surname = :surname  "
                    . "WHERE id = :id LIMIT 1");
            $sth->execute($params);
            $count =  $sth->rowCount();
            if($count>0)
                return ['status'=>200, 'data'=>$count];
             else 
                return ['status'=>500, 'clientCode'=>'0009'];
        }catch(PDOException $err){
            file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
            return ['status'=>500, 'clientCode'=>'0006'];
        }
    }
    
  
}
