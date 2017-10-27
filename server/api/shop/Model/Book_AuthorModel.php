<?php

class Book_AuthorModel extends Model
{
    
    public function deleteAuthorsByBookId($param)
    {
        try{
            $sth = $this->pdo->prepare("DELETE FROM  book_author WHERE  book_id=:book_id");
            $sth->execute($param);
            $count =  $sth->rowCount();
            if($count>0)
                return ['status'=>200, 'data'=>1];
             else 
                return ['status'=>500, 'clientCode'=>'0012'];
        }catch(PDOException $err){
            file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
            return ['status'=>500, 'clientCode'=>'0006'];
        }
    }
}
