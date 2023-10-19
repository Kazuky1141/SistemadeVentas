<?php

    include ('../../config.php');

    $codigo         = $_POST['codigo'];
    $id_categoria   = $_POST['id_categoria'];
    $nombre         = $_POST['nombre'];
    $id_usuario     = $_POST['id_usuario'];
    $descripcion    = $_POST['descripcion'];
    $stock          = $_POST['stock'];
    $stock_minimo   = $_POST['stock_minimo'];
    $stock_maximo   = $_POST['stock_maximo'];
    $precio_compra  = $_POST['precio_compra'];
    $precio_venta   = $_POST['precio_venta'];
    $fecha_ingreso  = $_POST['fecha_ingreso'];
    $id_producto    = $_POST['id_producto'];
    $image_text     = $_POST['image_text'];


    if($_FILES['image']['name'] != null){
        //echo "hay imagen nueva";
        $nombreDelArchivo = date("Y-m-d-h-i-s");
        $image_text = $nombreDelArchivo."__".$_FILES['image']['name'];
        $location = "../../../almacen/img_productos/".$image_text;
        move_uploaded_file($_FILES['image']['tmp_name'],$location);
    }else{
    // echo "no hay imagen";
    }


    $sentencia = $pdo->prepare("CALL update_almacen(:p_id_producto, :p_nombre, :p_descripcion, :p_stock,
                                                    :p_stock_minimo, :p_stock_maximo, :p_precio_compra, 
                                                    :p_precio_venta, :p_fecha_ingreso, :p_imagen, :p_id_usuario,
                                                    :p_id_categoria, :p_fyh_actualizacion)");

    $sentencia->bindParam(':p_nombre'           ,$nombre);
    $sentencia->bindParam(':p_descripcion'      ,$descripcion);
    $sentencia->bindParam(':p_stock'            ,$stock);
    $sentencia->bindParam(':p_stock_minimo'     ,$stock_minimo);
    $sentencia->bindParam(':p_stock_maximo'     ,$stock_maximo);
    $sentencia->bindParam(':p_precio_compra'    ,$precio_compra);
    $sentencia->bindParam(':p_precio_venta'     ,$precio_venta);
    $sentencia->bindParam(':p_fecha_ingreso'    ,$fecha_ingreso);
    $sentencia->bindParam(':p_imagen'           ,$image_text);
    $sentencia->bindParam(':p_id_usuario'       ,$id_usuario);
    $sentencia->bindParam(':p_id_categoria'     ,$id_categoria);
    $sentencia->bindParam(':p_fyh_actualizacion',$fechaHora);
    $sentencia->bindParam(':p_id_producto'      ,$id_producto);

    if($sentencia->execute()){

        $sentencia->closeCursor();

        session_start();
        $_SESSION['mensaje'] = "Se actualizo el producto de la manera correcta";
        $_SESSION['icono'] = "success";
        header('Location: '.$URL.'/almacen/');
    }else{
        session_start();
        $_SESSION['mensaje'] = "Error no se pudo actualizar en la base de datos";
        $_SESSION['icono'] = "error";
        header('Location: '.$URL.'/almacen/update.php?id='.$id_producto);
    }

?>



