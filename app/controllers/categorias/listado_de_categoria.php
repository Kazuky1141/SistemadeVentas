<?php

    $sql_categorias     = "CALL listado_de_categoria()";
    $query_categorias   = $pdo->prepare($sql_categorias);
    $query_categorias->execute();
    $categorias_datos   = $query_categorias->fetchAll(PDO::FETCH_ASSOC);
    $query_categorias->closeCursor();

?>