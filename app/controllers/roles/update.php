<?php
    include ('../../config.php');

    $id_rol     = $_POST['id_rol'];
    $rol        = $_POST['rol'];
    $sentencia  = $pdo->prepare("CALL update_update_roles(:id_rol, :rol, :fyh_actualizacion)");

    $sentencia->bindParam(':rol'                , $rol);
    $sentencia->bindParam(':fyh_actualizacion'  , $fechaHora);
    $sentencia->bindParam(':id_rol'             , $id_rol);

    if ($sentencia->execute()) {
        $sentencia->closeCursor();
        session_start();
        $_SESSION['mensaje']    = "Se actualizó el rol de la manera correcta";
        $_SESSION['icono']      = "success";
        header('Location: ' . $URL . '/roles/');
    } else {
        session_start();
        $_SESSION['mensaje']    = "Error, no se pudo actualizar en la base de datos";
        $_SESSION['icono']      = "error";
        header('Location: ' . $URL . '/roles/update.php?id=' . $id_rol);
    }
?>








