<?php

class Author extends Controller
{
    public function getAllAuthor($params = false)
    {
        $model = new AuthorModel();
        $data = $model->getAllAuthors();
        return $data;
    }
    
    public function getItemAuthor($params)
    {
        if(count($params) != 1 || !((int)$params[0]>0)){
            return ['status'=>400, 'clientCode'=>'0001'];
        }
        $model = new AuthorModel();
        return $model->getfullInfoAuthor(['id'=>$params[0]]);
    }
    
    public function postAuthor($params)
    {
        if(count($params) != 2){
            return ['status'=>400, 'clientCode'=>'0001'];
        }
        $model = new AuthorModel();
        $isAuthor = $model->isAuthorExists($params);
        if($isAuthor)
            return $model->insert($params);
        else 
            return ['status'=>200, 'err'=>true, 'data'=>'this author already exists'];
    }
    
    

    public function putAuthor($params)
    {
        $model = new AuthorModel();
        return $model->updateAuthor([
                                      'name'=>$params->name,
                                      'surname'=>$params->surname, 
                                      'id'=>$params->id
                                    ]);
    }
    
    public function deleteAuthor($params)
    {
        if(count($params) == 1 && (int)$params[0]>0){
            $model = new AuthorModel();
            return $model->delete("id=:id",['id'=>$params[0]]); 
        }
        return ['status'=>400, 'clientCode'=>'001'];
    }
}

