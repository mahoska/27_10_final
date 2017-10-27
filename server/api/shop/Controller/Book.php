<?php 

class Book extends Controller
{
    public function getAllBook($params = false)
    {
        $model = new BookModel();
        $data = $model->getAllBooks();
        return $data;
    }
    
    public function getItemBook($param)
    {
        $model = new BookModel();
        $data = $model->getfullInfoBook($param[0]);
        return $data;
    }
    
    public function getDataBook($params)
    {
        $keysFilterParams = [];
        $i=0;
        $KEYS_FILTER_PARAMS=[
            'ganre', 
            'author'
        ];
        if(count($params)!= count($KEYS_FILTER_PARAMS)){
            return ['status'=>400, 'clientCode'=>'0001'];
        }
        //return ['status'=>200, 'data'=>$params];
        foreach ($params as &$value) {
            if($value == "-") $value=0;
            else{
                if (!($value = (int)$value)>0){
                    return ['status'=>400, 'clientCode'=>'0010'];
                }
                else{
                    $model = new BookModel();
                    $action = 'filterBooksBy'.ucfirst($KEYS_FILTER_PARAMS[$i]);
                    $data = $model->$action($value);
                    return $data;
                }
            }
            $keysFilterParams[$KEYS_FILTER_PARAMS[$i++]] = $value;
        }
        
        
    }
    
    public function getFullFilterBook($param)
    {
        //return ['status'=>200, 'data'=>$param];
        if(count($param) != 1){
            return ['status'=>400, 'clientCode'=>'0001'];
        }
        $model = new BookModel();
        $data = $model->fullFilterBooks($param[0]);
        return $data;
    }

    public function postBook($params){
        if(count($params) != 6){
            return ['status'=>400, 'clientCode'=>'0001'];
        }
        $model = new BookModel();
        $bookParams = [
            'name'=>$params['name'],
            'description'=>$params['description'],
            'price'=>$params['price'],
            'discount'=>$params['discount'],
            ];
        $resAddBook =  $model->insert($bookParams);
        $book_id = $resAddBook['data'];
        $ganres = explode(',', $params['book_ganres']);
        $countRecGanre = count($ganres);
        if($countRecGanre!=0){
            $model = new Book_GanreModel();
            $kolGan = 0;
            foreach ($ganres as $ganre) {
                if((int)$ganre>0){
                    $model->insert(['book_id'=>$book_id, 'ganre_id'=>$ganre]);
                    $kolGan++;
                }
            }
        }
        $authors = explode(',', $params['book_authors']);
        $countRecAuthor = count($authors);
        if($countRecAuthor!=0){
            $model = new Book_AuthorModel();
            $kolAuthr = 0;
            foreach ($authors as $author) {
                if((int)$author>0){
                    $model->insert(['book_id'=>$book_id, 'author_id'=>$author]);
                    $kolAuthr++;
                }
            }
        }

        return ['status'=>200, 'data'=>['bookAdd'=>1,'ganreAdd'=>$kolGan,'authorAdd'=>$kolAuthr]];
    }

    public function putBook($params  = false){
        $model = new BookModel();
        return  $model->updateBook([
            'name'=>$params->name,
            'description'=>$params->description,
            'price'=>(double)$params->price,
            'discount'=>(double)$params->discount,
            'id'=>$params->id
            ]);
    }

    public function deleteBook($params  = false){
        if(count($params) == 1 && (int)$params[0]>0){
            $model = new BookModel();
            return $model->delete("id=:id",['id'=>$params[0]]); 
        }
        return ['status'=>400, 'clientCode'=>'001'];
    }

}
