<?php

    include ('../../config.php');

    $id_usuario = $_POST['id_usuario'];
    $sentencia  = $pdo->prepare("CALL delete_usuario(:id_usuario)");
    $sentencia->bindParam('id_usuario',$id_usuario);

    $sentencia->execute();
    $sentencia->closeCursor();

    session_start();
    $_SESSION['mensaje']    = "Se elimino al usuario de la manera correcta";
    $_SESSION['icono']      = "success";
    header('Location: '.$URL.'/usuarios/');
    
?>
