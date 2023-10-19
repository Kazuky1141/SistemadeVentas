<?php
    include ('../app/config.php');
    include ('../layout/sesion.php');

    include ('../layout/parte1.php');
    include ('../app/controllers/almacen/listado_de_productos.php');
    include ('../app/controllers/categorias/listado_de_categoria.php');
    include ('../app/controllers/ventas/listado_de_ventas.php');
    include ('../app/controllers/compras/listado_de_compras.php');

?>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <h1 class="m-0"style=" font-weight: bold">Kardex de productos</h1>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-outline card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Kardex Entrada y Salida de Productos</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body" style="display: block;">
                            <div class="row">
                                <div class="col-md-4">
                                <form method="post" name="formRegistraFecha" id="formRegistraFecha">
                                    <div class="row">
                                    <div class="col-md-12">
                                        <label for="Nombre" class="form-label">Nombre del Producto</label>
                                        <input type="text" class="form-control" name="nombre" id="nombre" required='true' autofocus>
                                    </div>
                                        <div class="col mt-2">
                                            <label for="fechaInicio" class="form-label">Fecha Inicio</label>
                                            <input type="date" class="form-control" name="fechaInicio" id="fechaInicio" required='true'>
                                        </div>
                                        <div class="col mt-2">
                                            <label for="fechaFin" class="form-label">Fecha Fin</label>
                                            <input type="date" class="form-control" name="fechaFin" id="fechaFin" required='true'>
                                        </div>
                                    </div>
                                        <div class="row justify-content-center text-center mt-5">
                                            <div class="col-">
                                                <button class="btn btn-primary btn-block" id="btnEnviar">
                                                    Buscar
                                                </button>
                                            </div>
                                        </div>
                                </form>
                                </div>
                            </div>
                            <br>
                           <div class="table table-responsive">
                               <table id="example1" class="table table-bordered table-striped table-sm">
                                   <thead>
                                    <tr>
                                        <th colspan="5" ></th>
                                        <th colspan="4" class="bg-primary"><center>EN UNIDADES</center></th>
                                    </tr>
                                   <tr class="table-active">
                                       <th><center>Nro</center></th>
                                       <th><center>Código</center></th>
                                       <th><center>Categoría</center></th>
                                       <th><center>Producto</center></th>
                                       <th><center>Descripción</center></th>
                                       <th class="bg-danger"><center>Stock Anterior</center></th>
                                       <th class="bg-info"><center>Entradas/Compras</center></th>
                                       <th class="bg-warning"><center>Salidas/Ventas</center></th>
                                       <th class="bg-success"><center>Stock Actual</center></th>

                                   </tr>
                                   </thead>
                                   <tbody>
                                       
                                   </tbody>
                               </table>
                               EN  PROCESO ...
                           </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->
<?php include ('../layout/mensajes.php'); ?>
<?php include ('../layout/parte2.php'); ?>
