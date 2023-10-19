<?php

    $sql_clientes   = "CALL listado_de_clientes()";          
    $query_clientes = $pdo->prepare($sql_clientes);
    $query_clientes->execute();
    $clientes_datos = $query_clientes->fetchAll(PDO::FETCH_ASSOC);
    $query_clientes->closeCursor()

?>