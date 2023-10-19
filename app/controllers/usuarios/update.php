<?php
    include ('../../config.php');

    $nombres            = $_POST['nombres'];
    $email              = $_POST['email'];
    $password_user      = $_POST['password_user'];
    $password_repeat    = $_POST['password_repeat'];
    $id_usuario         = $_POST['id_usuario'];
    $rol                = $_POST['rol'];

    if ($password_user == "") {
        if ($password_user == $password_repeat) {
            $password_user  = password_hash($password_user, PASSWORD_DEFAULT);
            $sentencia      = $pdo->prepare("CALL update_update_usuarios_if(:p_nombres, :p_email, :p_id_rol, :p_fyh_actualizacion, :p_id_usuario)");

            $sentencia->bindParam(':p_nombres'          , $nombres);
            $sentencia->bindParam(':p_email'            , $email);
            $sentencia->bindParam(':p_id_rol'           , $rol);
            $sentencia->bindParam(':p_fyh_actualizacion', $fechaHora);
            $sentencia->bindParam(':p_id_usuario'       , $id_usuario);
            
            $sentencia->execute();

            //$sentencia->closeCursor();

            session_start();
            $_SESSION['mensaje']    = "Se actualizó al usuario de la manera correcta";
            $_SESSION['icono']      = "success";
            header('Location: ' . $URL . '/usuarios/');
        } else {
            session_start();
            $_SESSION['mensaje']    = "Error, las contraseñas no son iguales";
            $_SESSION['icono']      = "error";
            header('Location: ' . $URL . '/usuarios/update.php?id=' . $id_usuario);
        }
    } else {
        if ($password_user == $password_repeat) {
            $password_user  = password_hash($password_user, PASSWORD_DEFAULT);
            $sentencia      = $pdo->prepare("CALL update_update_usuarios_else(:p_nombres, :p_email, :p_id_rol, :p_password_user, :p_fyh_actualizacion, :p_id_usuario)");

            $sentencia->bindParam(':p_nombres'          , $nombres);
            $sentencia->bindParam(':p_email'            , $email);
            $sentencia->bindParam(':p_id_rol'           , $rol);
            $sentencia->bindParam(':p_password_user'    , $password_user);
            $sentencia->bindParam(':p_id_usuario'       , $id_usuario);
            $sentencia->bindParam(':p_fyh_actualizacion', $fechaHora);
            $sentencia->execute();

            //$sentencia->closeCursor();

            session_start();
            $_SESSION['mensaje']    = "Se actualizó al usuario de la manera correcta";
            $_SESSION['icono']      = "success";
            header('Location: ' . $URL . '/usuarios/');
        } else {
            session_start();
            $_SESSION['mensaje']    = "Error, las contraseñas no son iguales";
            $_SESSION['icono']      = "error";
            header('Location: ' . $URL . '/usuarios/update.php?id=' . $id_usuario);
        }
    }
?>
