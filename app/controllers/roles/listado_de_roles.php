<?php

    $query_roles = $pdo->prepare("CALL listado_de_roles()");
    $query_roles->execute();

    $roles_datos = $query_roles->fetchAll(PDO::FETCH_ASSOC);
    $query_roles->closeCursor();
    
?>