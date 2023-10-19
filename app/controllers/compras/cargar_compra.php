<?php
    $id_compra_get = $_GET['id'];

    $sql_compras = "CALL cargar_compra($id_compra_get)";
    $query_compras = $pdo->prepare($sql_compras);
    $query_compras->execute();
    $compras_datos = $query_compras->fetchAll(PDO::FETCH_ASSOC);

    foreach ($compras_datos as $compras_dato){
        $id_compra                  = $compras_dato['id_compra'];
        $id_producto                = $compras_dato['id_producto'];
        $id_proveedor_tabla         = $compras_dato['id_proveedor'];
        $nro_compra                 = $compras_dato['nro_compra'];
        $codigo                     = $compras_dato['codigo'];
        $nombre_categoria           = $compras_dato['nombre_categoria'];
        $nombre_producto            = $compras_dato['nombre_producto'];
        $nombres_usuario            = $compras_dato['nombres_usuario'];
        $descripcion                = $compras_dato['descripcion'];
        $stock                      = $compras_dato['stock'];
        $stock_minimo               = $compras_dato['stock_minimo'];
        $stock_maximo               = $compras_dato['stock_maximo'];
        $precio_compra_producto     = $compras_dato['precio_compra_producto'];
        $precio_venta_producto      = $compras_dato['precio_venta_producto'];
        $fecha_ingreso              = $compras_dato['fecha_ingreso'];
        $imagen                     = $compras_dato['imagen'];
        $nombre_proveedor_tabla     = $compras_dato['nombre_proveedor'];
        $celular_proveedor          = $compras_dato['celular_proveedor'];
        $telefono_proveedor         = $compras_dato['telefono_proveedor'];
        $empresa_proveedor          = $compras_dato['empresa_proveedor'];
        $email_proveedor            = $compras_dato['email_proveedor'];
        $direccion_proveedor        = $compras_dato['direccion_proveedor'];
        $fecha_compra               = $compras_dato['fecha_compra'];
        $comprobante                = $compras_dato['comprobante'];
        $precio_compra              = $compras_dato['precio_compra'];
        $cantidad                   = $compras_dato['cantidad'];
    }
?>