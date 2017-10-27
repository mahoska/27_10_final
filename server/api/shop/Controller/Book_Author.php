<?php

class Book_Author extends Controller
{
    public function putBook_Author($params  = false)
    {
        $authors =  $params->book_authors;
        $countRecAuthor = count($authors);
        if($countRecAuthor!=0){
            $model = new Book_AuthorModel();
            $model->deleteAuthorsByBookId(['book_id'=>$params->id]); 
            $kolAuthr = 0;
            foreach ($authors as $author) {
                if((int)$author>0){
                    $model->insert(['book_id'=>$params->id, 'author_id'=>$author]);
                    $kolAuthr++;
                }
            }
        }
        
        return ['status'=>200, 'data'=>$kolAuthr];
    }
    
    public function deleteBook_Author($params)
    {
        if(count($params) == 1 && (int)$params[0]>0){
            $model = new Book_AuthorModel();
            return $model->delete("book_id=:book_id",['book_id'=>$params[0]]); 
        }
        return ['status'=>400, 'clientCode'=>'001'];
    }
}