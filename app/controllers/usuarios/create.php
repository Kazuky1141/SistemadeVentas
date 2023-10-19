<?php

    include ('../../config.php');

    $nombres            = $_POST['nombres'];
    $email              = $_POST['email'];
    $rol                = $_POST['rol'];
    $password_user      = $_POST['password_user'];
    $password_repeat    = $_POST['password_repeat'];

    if($password_user == $password_repeat){
        $password_user = password_hash($password_user, PASSWORD_DEFAULT);
        $sentencia = $pdo->prepare("CALL create_usuarios(:nombres, :email, :id_rol, :password_user, :fyh_creacion)");

        $sentencia->bindParam(':nombres'        , $nombres);
        $sentencia->bindParam(':email'          , $email);
        $sentencia->bindParam(':id_rol'         , $rol);
        $sentencia->bindParam(':password_user'  , $password_user);
        $sentencia->bindParam(':fyh_creacion'   , $fechaHora);
        $sentencia->execute();

        $sentencia->closeCursor();
        session_start();
        $_SESSION['mensaje'] = "Se registro al usuario de la manera correcta";
        header('Location: '.$URL.'/usuarios/');

    }else{
        // echo "error las contraseñas no son iguales";
        session_start();
        $_SESSION['mensaje'] = "Error las contraseñas no son iguales";
        header('Location: '.$URL.'/usuarios/create.php');
    }

?>


