<?php

class Book_Ganre extends Controller
{
    
     public function putBook_Ganre($params  = false)
    {
        $ganres =  $params->book_ganres;
        $countRecGanre = count($ganres);
        if($countRecGanre!=0){
            $model = new Book_GanreModel();
            $model->deleteGanresByBookId(['book_id'=>$params->id]); 
            $kolGanre = 0;
            foreach ($ganres as $ganre) {
                if((int)$ganre>0){
                    $model->insert(['book_id'=>$params->id, 'ganre_id'=>$ganre]);
                    $kolGanre++;
                }
            }
        }
        
        return ['status'=>200, 'data'=>$kolGanre];
    }
    
    public function deleteBook_Ganre($params)
    {
        if(count($params) == 1 && (int)$params[0]>0){
            $model = new Book_GanreModel();
            return $model->delete("book_id=:book_id",['book_id'=>$params[0]]); 
        }
        return ['status'=>400, 'clientCode'=>'001'];
    }
}