<?php
    $sql_usuarios = "CALL listado_de_usuarios()";
    $query_usuarios = $pdo->prepare($sql_usuarios);
    $query_usuarios->execute();
    $usuarios_datos = $query_usuarios->fetchAll(PDO::FETCH_ASSOC);

    $query_usuarios->closeCursor();
?>