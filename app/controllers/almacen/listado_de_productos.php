<?php
    
    $sql_productos   = "CALL listado_de_productos()";
    $query_productos = $pdo->prepare($sql_productos);
    $query_productos->execute();
    $productos_datos = $query_productos->fetchAll(PDO::FETCH_ASSOC);
    //$sql_productos = "CALL listado_de_productos()";
    //$query_productos = $pdo->prepare($sql_productos);
    $query_productos->closeCursor();

?>