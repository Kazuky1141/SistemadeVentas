<?php
    $sql_compras    = "CALL listado_de_compras()";
    $query_compras  = $pdo->prepare($sql_compras);
    $query_compras->execute();
    $compras_datos  = $query_compras->fetchAll(PDO::FETCH_ASSOC);
    $query_compras->closeCursor();
?>