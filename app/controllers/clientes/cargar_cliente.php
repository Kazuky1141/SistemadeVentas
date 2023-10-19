<?php

    $sql_clientes = "CALL cargar_cliente($id_cliente)";

    $query_clientes = $pdo->prepare($sql_clientes);
    $query_clientes->execute();
    $clientes_datos = $query_clientes->fetchAll(PDO::FETCH_ASSOC);
    $query_clientes->closeCursor();

?>


