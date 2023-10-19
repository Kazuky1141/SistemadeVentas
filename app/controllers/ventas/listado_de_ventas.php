<?php

$sql_ventas = "SELECT *,cli.nombre_cliente AS nombre_cliente FROM tb_ventas AS ve INNER JOIN tb_clientes AS cli ON cli.id_cliente = ve.id_cliente";

               
$query_ventas = $pdo->prepare($sql_ventas);
$query_ventas->execute();
$ventas_datos = $query_ventas->fetchAll(PDO::FETCH_ASSOC);