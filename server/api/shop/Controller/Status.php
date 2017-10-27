<?php

class Status extends Controller
{
    public function getAllStatus($params = false)
    {
        $model = new StatusModel();
        return $model->getAllStatuses();
    }
}

