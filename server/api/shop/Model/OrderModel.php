<?php

class OrderModel extends Model{

public function createOrder($params)
{
    //return ['status'=>200, 'data'=>$params];
    try{
        $sth = $this->pdo->prepare('INSERT INTO order_book (client_id, payment_id, discount_client, status_id, total_price) '
                . 'VALUES (:client_id, :payment_id, :discount_client, :status_id, :total_price)');
        $sth->execute($params);
        $order_id = $this->pdo->lastInsertId();
        if( $order_id>0)
             return ['status'=>200, 'data'=> $order_id];
         else 
             return ['status'=>500, 'clientCode'=>'0009'];
    }catch(PDOException $err){
        file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
        return ['status'=>500, 'clientCode'=>'0009'];
    }
}


public function getOrdersByClient($client_id)
{
    try{
        $sth = $this->pdo->prepare(
                'SELECT order_book.id, payment.name as payment, '
                . 'statusorder.name as status, discount_client, date_order_create, total_price'
                . ' FROM payment JOIN (order_book JOIN statusorder ON statusorder.id = order_book.status_id) '
                . 'ON payment.id = order_book.payment_id '
                . 'WHERE client_id=:client_id');
        $sth->execute(['client_id' => $client_id]);
        $collection = $this->getFetchAccoss($sth);
        return ['status'=>200, 'data'=> $collection];
    }catch(PDOException $err){
        file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
        return ['status'=>500, 'clientCode'=>'0009'];
    }
 
}

public function getAllOrders(){
    try{
        
        $sth = $this->pdo->query('SELECT order_book.id, '
            . ' UPPER(CONCAT(client.surname," ",LEFT(TRIM(client.name),1))) as client, ' 
            .'payment.name as payment, status_id, discount_client, date_order_create, total_price '
            .'FROM payment JOIN (order_book JOIN client ON client.id = order_book.client_id) '
            .'ON payment.id = order_book.payment_id'); 
       
        $collection = $this->getFetchAccoss($sth);
        return ['status'=>200, 'data'=>$collection];
    }catch(PDOException $err){
        file_put_contents('errors.txt', $err->getMessage(), FILE_APPEND); 
        return ['status'=>500, 'clientCode'=>'0006'];
    }
}




public function updateOrder($params)
{
    try{
        $sth = $this->pdo->prepare("UPDATE order_book SET status_id = :status_id WHERE id = :id LIMIT 1");
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
