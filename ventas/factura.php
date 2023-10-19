<?php



//require_once('tcpdf_include.php');
require_once('../app/TCPDF-main/tcpdf.php');
include ('../app/config.php');
include ('../app/controllers/ventas/literal.php');

session_start();
if(isset($_SESSION['sesion_email'])){
    // echo "si existe sesion de ".$_SESSION['sesion_email'];
    $email_sesion = $_SESSION['sesion_email'];
    $sql = "SELECT us.id_usuario as id_usuario, us.nombres as nombres, us.email as email, rol.rol as rol 
                  FROM tb_usuarios as us INNER JOIN tb_roles as rol ON us.id_rol = rol.id_rol WHERE email='$email_sesion'";
    $query = $pdo->prepare($sql);
    $query->execute();
    $usuarios = $query->fetchAll(PDO::FETCH_ASSOC);
    foreach ($usuarios as $usuario){
        $id_usuario_sesion = $usuario['id_usuario'];
        $nombres_sesion = $usuario['nombres'];
        $rol_sesion = $usuario['rol'];
    }
}else{
    echo "no existe sesion";
    header('Location: '.$URL.'/login');
}



$id_venta_get = $_GET['id_venta'];
$nro_venta_get = $_GET['nro_venta'];

$sql_ventas = "SELECT *,cli.nombre_cliente AS nombre_cliente,cli.nit_ci_cliente AS nit_ci_cliente 
FROM tb_ventas AS ve INNER JOIN tb_clientes AS cli ON cli.id_cliente = ve.id_cliente 
WHERE  ve.id_venta = '$id_venta_get'";

               
$query_ventas = $pdo->prepare($sql_ventas);
$query_ventas->execute();
$ventas_datos = $query_ventas->fetchAll(PDO::FETCH_ASSOC);

foreach($ventas_datos as $ventas_dato){
    $fyh_creacion = $ventas_dato['fyh_creacion'];
    $nit_ci_cliente = $ventas_dato['nit_ci_cliente'];
    $nombre_cliente = $ventas_dato['nombre_cliente'];
    $total_pagado = $ventas_dato['total_pagado'];
}
//Convierte precio total a literal
$monto_literal = numtoletras($total_pagado);

$fecha = date("d/m/Y",strtotime($fyh_creacion));


// create new PDF document
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, array(	210 , 297), true, 'UTF-8', false);

// set document information
$pdf->setCreator(PDF_CREATOR);
$pdf->setAuthor('Sistema');
$pdf->setTitle('Factura de Venta');
$pdf->setSubject('Factura de Venta');
$pdf->setKeywords('TCPDF, PDF, example, test, guide');

//remove default header/footer
$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false);

// set default monospaced font
$pdf->setDefaultMonospacedFont(PDF_FONT_MONOSPACED);

// set margins
$pdf->setMargins( 5 , 10, 5);

// set auto page breaks
$pdf->setAutoPageBreak(TRUE, 5);

// set image scale factor
$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
 
// set some language-dependent strings (optional)
if (@file_exists(dirname(__FILE__).'/lang/eng.php')) {
	require_once(dirname(__FILE__).'/lang/eng.php');
	$pdf->setLanguageArray($l);
}

// ---------------------------------------------------------
$pdf->setFont('Helvetica', '', 12, '', true);

$pdf->AddPage();

// set text shadow effect
$pdf->setTextShadow(array('enabled'=>true, 'depth_w'=>0.2, 'depth_h'=>0.2, 'color'=>array(196,196,196), 'opacity'=>1, 'blend_mode'=>'Normal'));

// Set some content to print
$html = '
<table border = "0" style = "font-size: 13px;">
    <tr>
        <td style = "text-align: center;width: 230px">
            <img src="../public/images/logo.jpg" width="80px" alt=""><br><br>
            <b>SISTEMA DE VENTAS</b><br>
            Direccion <br>
            Telefono - Celular<br>
            TACNA - PERU
        </td>

        <td style="width: 200px"></td>
        <td style="font-size: 16px;width: 300px"><br><br><br><br>
            <b>NIT: </b>2898898198 <br>
            <b>Nro factura: </b>'.$id_venta_get.'<br>
            <b>Nro de autorizacion: </b>2898898198 <br>
            <p style="text-align: center;"><b>Original</b></p>
        </td>
    </tr>
</table>

<p style="text-align: center;font-size: 25px;"><b>FACTURA</b></p>

<div style="border: 1px solid #000000;font-size:16px">
    <table border= "0" cellspacing="7px">
        <tr>
            <td ><b>Fecha: </b>'.$fecha.'</td>
            <td></td>
            <td ><b>Nit/CI: </b>'.$nit_ci_cliente.'</td>
        </tr>
        <tr>
            <td colspan="3"><b>Señor(es): </b> '.$nombre_cliente.'</td>
        </tr>
    </table>
</div>
<br><br>
<table border = "1" cellpadding = "5" style="font-size:12px">
    <tr style="text-align: center;background-color: #d6d6d6;">
        <td style="width: 40px;">Nro</td>
        <td style="width: 150px;">Producto</td>
        <td style="width: 248px;">Descripcion</td>
        <td style="width: 75px;">Cantidad</td>
        <td style="width: 120px;">Precio Unitario</td>
        <td style="width: 69px;">Subtotal</td>
    </tr>
    ';

    $contador_de_carrito = 0;
    $cantidad_total = 0;
    $precio_unitario_total =  0;
    $precio_total = 0;

    $sql_carrito = "SELECT *,pro.nombre AS nombre_producto,pro.descripcion 
        AS descripcion,pro.precio_venta AS precio_venta, pro.stock AS stock, pro.id_producto AS id_producto 
        FROM tb_carrito AS car  INNER JOIN tb_almacen AS pro ON car.id_producto = pro.id_producto WHERE nro_venta = '$nro_venta_get' ORDER BY id_carrito ASC";
        $query_carrito =$pdo->prepare($sql_carrito);
        $query_carrito->execute();
        $carrito_datos = $query_carrito->fetchAll(PDO::FETCH_ASSOC);

        foreach ($carrito_datos as $carrito_dato) {
            $id_carrito = $carrito_dato['id_carrito'];
            $contador_de_carrito = $contador_de_carrito+1;
            $cantidad_total = $cantidad_total + $carrito_dato['cantidad'];
            $precio_unitario_total = $precio_unitario_total + floatval($carrito_dato['precio_venta']);
            $subtotal = $carrito_dato['cantidad']* $carrito_dato['precio_venta'];
            $precio_total = $precio_total + $subtotal;
        
                                                        
    $html .= '    
    <tr>
        <td style="text-align: center;">'.$contador_de_carrito.'</td>
        <td>'.$carrito_dato['nombre_producto'].'</td>
        <td>'.$carrito_dato['descripcion'].'</td>
        <td style="text-align: center;">'.$carrito_dato['cantidad'].'</td>
        <td style="text-align: center;">S/. '.$carrito_dato['precio_venta'].'</td>
        <td style="text-align: center;">S/. '.$subtotal.'</td>
    </tr>
    ';
}
    $html .= '  
    <tr>
        <td colspan="3" style="text-align: right;background-color: #d6d6d6;"><b>TOTAL</b></td>
        <td style="text-align: center;background-color: #d6d6d6;">'.$cantidad_total.'</td>
        <td style="text-align: center;background-color: #d6d6d6;">S/. '.$precio_unitario_total.'</td>
        <td style="text-align: center;background-color: #d6d6d6;">S/. '.$precio_total.'</td>
    </tr>
</table>

<p style="text-align: right;">
    <b>Monto Total: </b>S/. '.$precio_total.'
    </p>
    <p>
        <b>Son :</b> '.$monto_literal.'
    </p>
    <br>
    ---------------------------------------------------------------------------- <br>
    <b>USUARIO: </b>'.$nombres_sesion.' <br>

    <p style="text-align: center;"></p>
    <p style="text-align: center;">"ESTA FACTURA CONTRIBUYE AL DESARROLLO DEL PAIS, EL USO ILÍCITO DE ÉSTA SERÁ SANCIONADO DE ACUERDO A LEY"</p>
    <p style="text-align: center;"><b>GRACIAS POR SU PREFERENCIA</b></p>


';

$pdf->writeHTML($html, true, false,true, false, '');
$style = array(
    'border' => 0,
    'vpadding' => '3',
    'hpadding' => '3',
    'fgcolor' => array(0,0,0),
    'bgcolor' => false,
    'module_width' =>  1,
    'module_height' => 1 
);
$QR='Factura realizada por el sistema de ventas, al cliente '.$nombre_cliente.' con nit:'.$nit_ci_cliente.' 
en '.$fecha.' con el monto total de '.$precio_total.'.';
$pdf->write2DBarcode($QR,'QRCODE,L',170,240,40,40,$style);
$pdf->Output('example_001.pdf', 'I');

