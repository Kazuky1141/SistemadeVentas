<?php

    $id_producto_get = $_GET['id'];

    $sql_productos = "CALL cargar_producto($id_producto_get)";
    $query_productos = $pdo->prepare($sql_productos);
    $query_productos->execute();
    $productos_datos = $query_productos->fetchAll(PDO::FETCH_ASSOC);

    $query_productos->closeCursor();

    foreach ($productos_datos as $productos_dato){
        $codigo             = $productos_dato['codigo'];
        $nombre_categoria   = $productos_dato['nombre_categoria'];
        $nombre             = $productos_dato['nombre'];
        $email              = $productos_dato['email'];
        $id_usuario         = $productos_dato['id_usuario'];
        $descripcion        = $productos_dato['descripcion'];
        $stock              = $productos_dato['stock'];
        $stock_minimo       = $productos_dato['stock_minimo'];
        $stock_maximo       = $productos_dato['stock_maximo'];
        $precio_compra      = $productos_dato['precio_compra'];
        $precio_venta       = $productos_dato['precio_venta'];
        $fecha_ingreso      = $productos_dato['fecha_ingreso'];
        $imagen             = $productos_dato['imagen'];
    }

?>