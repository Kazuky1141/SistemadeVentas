-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-10-2023 a las 05:30:04
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistemadeventas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_stock` (IN `id_producto` INT, IN `nuevo_stock` INT)   BEGIN
    UPDATE tb_almacen SET stock = nuevo_stock WHERE id_producto = id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_carrito` (IN `id_carrito` INT)   BEGIN
    DELETE FROM tb_carrito WHERE id_carrito = id_carrito;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_venta` (IN `id_venta` INT)   BEGIN
    DELETE FROM tb_ventas WHERE id_venta = id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_venta_if` (IN `nro_venta` INT)   BEGIN
    DELETE FROM tb_carrito WHERE nro_venta = nro_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_cliente` (IN `id_cliente` INT)   BEGIN
    SELECT * FROM tb_clientes WHERE id_cliente = id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_compra` (IN `p_id_compra` INT)   BEGIN
    SELECT 
        co.*, 
        pro.precio_compra AS precio_compra, 
        pro.codigo AS codigo, 
        pro.nombre AS nombre_producto, 
        pro.descripcion AS descripcion, 
        pro.stock AS stock, 
        pro.stock_minimo AS stock_minimo, 
        pro.stock_maximo AS stock_maximo,
        pro.precio_compra AS precio_compra_producto,
        pro.precio_venta AS precio_venta_producto,
        pro.fecha_ingreso AS fecha_ingreso,
        pro.imagen AS imagen,
        cat.nombre_categoria AS nombre_categoria,
        us.nombres AS nombre_usuarios_producto,
        prov.nombre_proveedor AS nombre_proveedor,
        prov.celular AS celular_proveedor,
        prov.telefono AS telefono_proveedor,
        prov.empresa AS empresa_proveedor,
        prov.email AS email_proveedor,
        prov.direccion AS direccion_proveedor,
        us.nombres AS nombres_usuario
    FROM tb_compras AS co
    INNER JOIN tb_almacen AS pro ON co.id_producto = pro.id_producto
    INNER JOIN tb_categorias AS cat ON cat.id_categoria = pro.id_categoria
    INNER JOIN tb_usuarios AS us ON co.id_usuario = us.id_usuario
    INNER JOIN tb_proveedores AS prov ON co.id_proveedor = prov.id_proveedor
    WHERE co.id_compra = p_id_compra;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_producto` (IN `p_id_producto` INT)   BEGIN
    SELECT *, cat.nombre_categoria AS categoria, u.email AS email, u.id_usuario AS id_usuario
    FROM tb_almacen AS a
    INNER JOIN tb_categorias AS cat ON a.id_categoria = cat.id_categoria
    INNER JOIN tb_usuarios AS u ON u.id_usuario = a.id_usuario
    WHERE a.id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_venta` (IN `id_venta_get` INT)   BEGIN
    SELECT ve.*, cli.nombre_cliente AS nombre_cliente
    FROM tb_ventas AS ve
    INNER JOIN tb_clientes AS cli ON cli.id_cliente = ve.id_cliente
    WHERE ve.id_venta = id_venta_get;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_almacen` (IN `p_codigo` VARCHAR(255), IN `p_nombre` VARCHAR(255), IN `p_descripcion` TEXT, IN `p_stock` INT, IN `p_stock_minimo` INT, IN `p_stock_maximo` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_precio_venta` DECIMAL(10,2), IN `p_fecha_ingreso` DATE, IN `p_imagen` VARCHAR(255), IN `p_id_usuario` INT, IN `p_id_categoria` INT, IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_almacen (
        codigo, nombre, descripcion, stock, stock_minimo, stock_maximo,
        precio_compra, precio_venta, fecha_ingreso, imagen, id_usuario, id_categoria, fyh_creacion
    )
    VALUES (
        p_codigo, p_nombre, p_descripcion, p_stock, p_stock_minimo, p_stock_maximo,
        p_precio_compra, p_precio_venta, p_fecha_ingreso, p_imagen, p_id_usuario, p_id_categoria, p_fyh_creacion
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_compras` (IN `p_id_producto` INT, IN `p_nro_compra` VARCHAR(255), IN `p_fecha_compra` DATE, IN `p_id_proveedor` INT, IN `p_comprobante` VARCHAR(255), IN `p_id_usuario` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_cantidad` INT, IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_compras (
        id_producto, nro_compra, fecha_compra, id_proveedor, comprobante, id_usuario,
        precio_compra, cantidad, fyh_creacion
    ) VALUES (
        p_id_producto, p_nro_compra, p_fecha_compra, p_id_proveedor, p_comprobante, p_id_usuario,
        p_precio_compra, p_cantidad, p_fyh_creacion
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_proveedores` (IN `p_nombre_proveedor` VARCHAR(255), IN `p_celular` VARCHAR(20), IN `p_telefono` VARCHAR(20), IN `p_empresa` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_direccion` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_proveedores (nombre_proveedor, celular, telefono, empresa, email, direccion, fyh_creacion) 
    VALUES (p_nombre_proveedor, p_celular, p_telefono, p_empresa, p_email, p_direccion, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_rol` (IN `p_rol` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
  INSERT INTO tb_roles(rol, fyh_creacion) 
  VALUES (p_rol, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_usuarios` (IN `p_nombres` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_id_rol` INT, IN `p_password_user` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
  INSERT INTO tb_usuarios (nombres, email, id_rol, password_user, fyh_creacion)
  VALUES (p_nombres, p_email, p_id_rol, p_password_user, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_almacen` (IN `p_id_producto` INT)   BEGIN
    DELETE FROM tb_almacen WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_compras` (IN `id_compra_param` INT)   BEGIN
    DELETE FROM tb_compras WHERE id_compra = id_compra_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_usuario` (IN `p_id_usuario` INT)   BEGIN
  DELETE FROM tb_usuarios WHERE id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_proveedor` (IN `p_id_proveedor` INT)   BEGIN
    DELETE FROM tb_proveedores WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `guardar_clientes` (IN `p_nombre_cliente` VARCHAR(255), IN `p_nit_ci_cliente` VARCHAR(20), IN `p_celular_cliente` VARCHAR(20), IN `p_email_cliente` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_clientes (nombre_cliente, nit_ci_cliente, celular_cliente, email_cliente, fyh_creacion)
    VALUES (p_nombre_cliente, p_nit_ci_cliente, p_celular_cliente, p_email_cliente, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_categoria` ()   BEGIN
    SELECT * FROM tb_categorias;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_clientes` ()   BEGIN
    SELECT * FROM tb_clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_compras` ()   BEGIN
    SELECT *,
           pro.codigo as codigo, pro.nombre as nombre_producto, pro.descripcion as descripcion, pro.stock as stock,
           pro.stock_minimo as stock_minimo, pro.stock_maximo as stock_maximo, pro.precio_compra as precio_compra_producto,
           pro.precio_venta as precio_venta_producto, pro.fecha_ingreso as fecha_ingreso, pro.imagen as imagen,
           cat.nombre_categoria as nombre_categoria, us.nombres as nombre_usuarios_producto,
           prov.nombre_proveedor as nombre_proveedor, prov.celular as celular_proveedor, prov.telefono as telefono_proveedor,
           prov.empresa as empresa, prov.email as email_proveedor, prov.direccion as direccion_proveedor, us.nombres as nombres_usuario
    FROM tb_compras as co
    INNER JOIN tb_almacen as pro ON co.id_producto = pro.id_producto
    INNER JOIN tb_categorias as cat ON cat.id_categoria = pro.id_categoria
    INNER JOIN tb_usuarios as us ON co.id_usuario = us.id_usuario
    INNER JOIN tb_proveedores as prov ON co.id_proveedor = prov.id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_productos` ()   BEGIN
    SELECT *, cat.nombre_categoria AS categoria, u.email AS email
    FROM tb_almacen AS a
    INNER JOIN tb_categorias AS cat ON a.id_categoria = cat.id_categoria
    INNER JOIN tb_usuarios AS u ON u.id_usuario = a.id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_proveedores` ()   BEGIN
    SELECT * FROM tb_proveedores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_roles` ()   BEGIN
  SELECT * FROM tb_roles;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_usuarios` ()   BEGIN
  SELECT us.id_usuario AS id_usuario, us.nombres AS nombres, us.email AS email, rol.rol AS rol
  FROM tb_usuarios AS us
  INNER JOIN tb_roles AS rol ON us.id_rol = rol.id_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_ventas` ()   BEGIN
    SELECT *, cli.nombre_cliente AS nombre_cliente
    FROM tb_ventas AS ve
    INNER JOIN tb_clientes AS cli ON cli.id_cliente = ve.id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_carrito` (IN `p_nro_venta` INT, IN `p_id_producto` INT, IN `p_cantidad` INT, IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_carrito (nro_venta, id_producto, cantidad, fyh_creacion) 
    VALUES (p_nro_venta, p_id_producto, p_cantidad, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_de_categorias` (IN `p_nombre_categoria` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_categorias (nombre_categoria, fyh_creacion)
    VALUES (p_nombre_categoria, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_de_ventas` (IN `p_nro_venta` INT, IN `p_id_cliente` INT, IN `p_total_pagado` DECIMAL(10,2), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_ventas (nro_venta, id_cliente, total_pagado, fyh_creacion) 
    VALUES (p_nro_venta, p_id_cliente, p_total_pagado, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_usuarios` (IN `p_id_usuario` INT)   BEGIN
  SELECT us.id_usuario AS id_usuario, us.nombres AS nombres, us.email AS email, rol.rol AS rol
  FROM tb_usuarios AS us
  INNER JOIN tb_roles AS rol ON us.id_rol = rol.id_rol
  WHERE us.id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sql_carrito` (IN `nro_venta_param` INT)   BEGIN
    SELECT *, pro.nombre AS nombre_producto, pro.descripcion 
    AS descripcion, pro.precio_venta 
    AS precio_venta, pro.stock 
    AS stock, pro.id_producto 
    AS id_producto
    FROM tb_carrito AS car
    INNER JOIN tb_almacen AS pro 
    ON car.id_producto = pro.id_producto
    WHERE nro_venta = nro_venta_param
    ORDER BY id_carrito ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_almacen` (IN `p_id_producto` INT, IN `p_nombre` VARCHAR(255), IN `p_descripcion` TEXT, IN `p_stock` INT, IN `p_stock_minimo` INT, IN `p_stock_maximo` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_precio_venta` DECIMAL(10,2), IN `p_fecha_ingreso` DATE, IN `p_imagen` VARCHAR(255), IN `p_id_usuario` INT, IN `p_id_categoria` INT, IN `p_fyh_actualizacion` TIMESTAMP)   BEGIN
    UPDATE tb_almacen
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        stock = p_stock,
        stock_minimo = p_stock_minimo,
        stock_maximo = p_stock_maximo,
        precio_compra = p_precio_compra,
        precio_venta = p_precio_venta,
        fecha_ingreso = p_fecha_ingreso,
        imagen = p_imagen,
        id_usuario = p_id_usuario,
        id_categoria = p_id_categoria,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_compras` (IN `p_id_compra` INT, IN `p_id_producto` INT, IN `p_nro_compra` INT, IN `p_fecha_compra` DATE, IN `p_id_proveedor` INT, IN `p_comprobante` VARCHAR(255), IN `p_id_usuario` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_cantidad` INT, IN `p_fyh_actualizacion` DATETIME)   BEGIN
    UPDATE tb_compras 
    SET id_producto = p_id_producto,
        nro_compra = p_nro_compra,
        fecha_compra = p_fecha_compra,
        id_proveedor = p_id_proveedor,
        comprobante = p_comprobante,
        id_usuario = p_id_usuario,
        precio_compra = p_precio_compra,
        cantidad = p_cantidad,
        fyh_actualizacion = p_fyh_actualizacion 
    WHERE id_compra = p_id_compra;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_de_categorias` (IN `p_id_categoria` INT, IN `p_nombre_categoria` VARCHAR(255), IN `p_fyh_actualizacion` DATETIME)   BEGIN
    UPDATE tb_categorias
    SET nombre_categoria = p_nombre_categoria,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_categoria = p_id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_proveedor` (IN `p_id_proveedor` INT, IN `p_nombre_proveedor` VARCHAR(255), IN `p_celular` VARCHAR(15), IN `p_telefono` VARCHAR(15), IN `p_empresa` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_direccion` TEXT, IN `p_fyh_actualizacion` DATETIME)   BEGIN
    UPDATE tb_proveedores
    SET nombre_proveedor = p_nombre_proveedor,
        celular = p_celular,
        telefono = p_telefono,
        empresa = p_empresa,
        email = p_email,
        direccion = p_direccion,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_roles` (IN `p_id_rol` INT)   BEGIN
  SELECT * FROM tb_roles WHERE id_rol = p_id_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stock_almacen` (IN `p_stock` INT, IN `p_id_producto` INT)   BEGIN
    UPDATE tb_almacen SET stock = p_stock WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stock_compras` (IN `p_id_producto` INT, IN `p_stock` INT)   BEGIN
    -- Actualiza el stock en la tabla tb_almacen
    UPDATE tb_almacen
    SET stock = p_stock
    WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_update_roles` (IN `p_id_rol` INT, IN `p_rol` VARCHAR(255), IN `p_fyh_actualizacion` DATETIME)   BEGIN
  UPDATE tb_roles
  SET rol = p_rol, fyh_actualizacion = p_fyh_actualizacion
  WHERE id_rol = p_id_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_update_usuarios_else` (IN `p_nombres` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_id_rol` INT, IN `p_password_user` VARCHAR(255), IN `p_fyh_actualizacion` DATETIME, IN `p_id_usuario` INT)   BEGIN
    UPDATE tb_usuarios
    SET nombres = p_nombres,
        email = p_email,
        id_rol = p_id_rol,
        password_user = p_password_user,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_update_usuarios_if` (IN `p_nombres` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_id_rol` INT, IN `p_fyh_actualizacion` DATETIME, IN `p_id_usuario` INT)   BEGIN
    UPDATE tb_usuarios
    SET nombres = p_nombres,
        email = p_email,
        id_rol = p_id_rol,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_usuario` (IN `p_id_usuario` INT)   BEGIN
  SELECT us.id_usuario AS id_usuario, us.nombres AS nombres, us.email AS email, rol.rol AS rol
  FROM tb_usuarios AS us
  INNER JOIN tb_roles AS rol ON us.id_rol = rol.id_rol
  WHERE us.id_usuario = p_id_usuario;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_almacen`
--

CREATE TABLE `tb_almacen` (
  `id_producto` int(11) NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `stock_minimo` int(11) DEFAULT NULL,
  `stock_maximo` int(11) DEFAULT NULL,
  `precio_compra` varchar(255) NOT NULL,
  `precio_venta` varchar(255) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `imagen` text DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_almacen`
--

INSERT INTO `tb_almacen` (`id_producto`, `codigo`, `nombre`, `descripcion`, `stock`, `stock_minimo`, `stock_maximo`, `precio_compra`, `precio_venta`, `fecha_ingreso`, `imagen`, `id_usuario`, `id_categoria`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(17, 'P-00001', 'AIR JORDAN VARON DUB ZERO', 'Talla 38', 8, 1, 20, '449.00', '530.00', '2023-10-04', '2023-10-18-08-23-05__1.jpg', 1, 16, '2023-10-18 20:19:19', '2023-10-18 20:23:05'),
(18, 'P-00002', 'AIR JORDAN VARON LEGACY 312 LOW', 'Talla 36', 8, 1, 20, '359.00', '424.00', '2023-10-05', '2023-10-18-08-24-53__2.jpg', 1, 16, '2023-10-18 20:24:53', '2023-10-18 21:51:26'),
(19, 'P-00003', 'ASICS VARON GEL NIMBUS 25', 'Talla 38', 3, 1, 20, '439.00', '518.00', '2023-10-06', '2023-10-18-08-25-37__3.jpg', 1, 17, '2023-10-18 20:25:37', '2023-10-18 21:50:48'),
(20, 'P-00004', 'ASICS VARON GT-1000 11 BLUE', 'Talla 36', 6, 1, 20, '519.00', '612.00', '2023-10-07', '2023-10-18-08-26-46__4.jpg', 1, 17, '2023-10-18 20:26:46', '2023-10-18 21:50:04'),
(21, 'P-00005', 'ADIDAS HP6458 GOLETTO VIII FG NEGRO', 'Talla 36', 7, 1, 20, '299.00', '353.00', '2023-10-08', '2023-10-18-08-36-45__16.webp', 1, 18, '2023-10-18 20:27:48', '2023-10-18 21:52:17'),
(22, 'P-00006', 'ASICS DAMA NOVABLAST 3 – HALLOWEEN', 'Talla 38', 7, 1, 20, '349.00', '412.00', '2023-10-09', '2023-10-18-08-28-42__6.jpg', 1, 19, '2023-10-18 20:28:42', '2023-10-18 21:52:41'),
(23, 'P-00007', 'ASICS DAMA TRAIL SCOUT BK-DG', 'Talla 38', 2, 1, 20, '159.00', '188.00', '2023-10-10', '2023-10-18-08-31-11__7.jpg', 1, 17, '2023-10-18 20:29:09', '2023-10-18 21:55:28'),
(24, 'P-00008', 'ASICS DAMA GEL-VENTURE 8', 'Talla 37', 5, 1, 20, '129.00', '152.00', '2023-10-11', '2023-10-18-08-29-45__8.jpg', 1, 19, '2023-10-18 20:29:45', '2023-10-18 21:51:53'),
(25, 'P-00009', 'JORDAN 2 RETRO DAMA COOL GREY', 'Talla 38', 7, 1, 20, '379.00', '447.00', '2023-10-12', '2023-10-18-08-31-23__9.jpg', 1, 20, '2023-10-18 20:30:15', '2023-10-18 21:51:14'),
(26, 'P-00010', 'ZAPATILLAS HIKING HI-TEC PARA HOMBRE H007077051', 'Talla 39', 13, 1, 20, '499.00', '589.00', '2023-10-14', '2023-10-18-08-39-11__19.jpg', 1, 22, '2023-10-18 20:30:52', '2023-10-18 21:50:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_carrito`
--

CREATE TABLE `tb_carrito` (
  `id_carrito` int(11) NOT NULL,
  `nro_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_carrito`
--

INSERT INTO `tb_carrito` (`id_carrito`, `nro_venta`, `id_producto`, `cantidad`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(36, 1, 17, 2, '2023-10-18 21:57:55', '0000-00-00 00:00:00'),
(37, 1, 18, 1, '2023-10-18 21:57:58', '0000-00-00 00:00:00'),
(38, 2, 21, 1, '2023-10-18 21:58:11', '0000-00-00 00:00:00'),
(41, 3, 19, 1, '2023-10-18 22:01:24', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_categorias`
--

CREATE TABLE `tb_categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_categorias`
--

INSERT INTO `tb_categorias` (`id_categoria`, `nombre_categoria`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(16, 'DEPORTIVAS', '2023-10-17 23:47:10', '0000-00-00 00:00:00'),
(17, 'RUNNING', '2023-10-17 23:49:41', '0000-00-00 00:00:00'),
(18, 'FUTBOL', '2023-10-17 23:49:55', '0000-00-00 00:00:00'),
(19, 'CAMINAR', '2023-10-17 23:50:10', '0000-00-00 00:00:00'),
(20, 'SNEAKERS', '2023-10-17 23:50:35', '2023-10-18 17:41:54'),
(22, 'MONTAÑA', '2023-10-18 19:12:48', '2023-10-18 19:13:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_clientes`
--

CREATE TABLE `tb_clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `nit_ci_cliente` varchar(255) NOT NULL,
  `celular_cliente` varchar(255) NOT NULL,
  `email_cliente` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_clientes`
--

INSERT INTO `tb_clientes` (`id_cliente`, `nombre_cliente`, `nit_ci_cliente`, `celular_cliente`, `email_cliente`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(11, 'Fuensanta Nadal', '20552103816', '985653228', 'Fuensanta@gmail.com', '2023-10-18 21:21:00', '0000-00-00 00:00:00'),
(12, 'Belen Domenech', '20553856451', '958151476', 'Belen@gmail.com', '2023-10-18 21:25:45', '0000-00-00 00:00:00'),
(13, 'Narciso Alcala', '20480316259', '912568584', 'Narciso@gmail.com', '2023-10-18 21:26:02', '0000-00-00 00:00:00'),
(14, 'Nazaret Osuna ', '20542259117', '985653228', 'Nazaret@gmail.com', '2023-10-18 21:26:18', '0000-00-00 00:00:00'),
(15, 'Felisa Falcon ', '20547825781', '968537245', 'Felisa@gmail.com', '2023-10-18 21:26:32', '0000-00-00 00:00:00'),
(16, 'Otilia Vaquero', '20603498799', '987548114', 'Otilia@gmail.com', '2023-10-18 21:26:47', '0000-00-00 00:00:00'),
(17, 'Mario Carballo', '20606106883', '986688756', 'Mario@gmail.com', '2023-10-18 21:27:03', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_compras`
--

CREATE TABLE `tb_compras` (
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `nro_compra` int(11) NOT NULL,
  `fecha_compra` date NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `comprobante` varchar(255) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `precio_compra` varchar(50) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_compras`
--

INSERT INTO `tb_compras` (`id_compra`, `id_producto`, `nro_compra`, `fecha_compra`, `id_proveedor`, `comprobante`, `id_usuario`, `precio_compra`, `cantidad`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(16, 26, 1, '2023-09-29', 17, '1007-13258585', 1, '449.00', 3, '2023-10-18 20:58:17', '2023-10-18 21:31:15'),
(17, 18, 2, '2023-10-05', 18, '4568-51591974', 1, '424.00', 5, '2023-10-18 20:59:00', '0000-00-00 00:00:00'),
(18, 19, 3, '2023-09-25', 20, '5949-54915945', 1, '439.00', 4, '2023-10-18 20:59:43', '0000-00-00 00:00:00'),
(19, 21, 4, '2023-10-03', 21, '2919-94199778', 1, '299.00', 8, '2023-10-18 21:00:20', '0000-00-00 00:00:00'),
(20, 20, 5, '2023-09-27', 23, '5797-679569', 1, '519.00', 6, '2023-10-18 21:01:02', '0000-00-00 00:00:00'),
(21, 22, 6, '2023-09-21', 22, '9897-225988792', 1, '349.00', 7, '2023-10-18 21:02:00', '0000-00-00 00:00:00'),
(22, 26, 7, '2023-08-31', 20, '1254-346379', 1, '499.00', 10, '2023-10-18 21:02:33', '0000-00-00 00:00:00'),
(23, 25, 8, '2023-08-17', 23, '7895-7621724', 1, '379.00', 7, '2023-10-18 21:03:02', '0000-00-00 00:00:00'),
(24, 24, 9, '2023-09-10', 21, '1254-34164919', 1, '129.00', 5, '2023-10-18 21:03:55', '0000-00-00 00:00:00'),
(26, 17, 10, '2023-09-11', 18, '1234-45868595', 1, '449.00', 10, '2023-10-18 21:53:28', '0000-00-00 00:00:00'),
(27, 18, 11, '2023-10-01', 21, '4563-15264585', 1, '359.00', 4, '2023-10-18 21:54:29', '0000-00-00 00:00:00'),
(28, 23, 12, '2023-09-28', 21, '2325-95864591', 1, '159.00', 8, '2023-10-18 21:56:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_proveedores`
--

CREATE TABLE `tb_proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_proveedor` varchar(255) NOT NULL,
  `celular` varchar(50) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `empresa` varchar(255) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `direccion` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_proveedores`
--

INSERT INTO `tb_proveedores` (`id_proveedor`, `nombre_proveedor`, `celular`, `telefono`, `empresa`, `email`, `direccion`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(17, 'Ana Belen Navas', '958151476', '985653228', 'BONANZZA STORES S.A.C.', 'Ana@gmail.com', 'Cl. Delfina Carrion # 4', '2023-10-18 20:53:28', '0000-00-00 00:00:00'),
(18, 'Fatiha Gascon', '987152462', '968537245', 'FÁBRICA DE CALZADO TANGUIS S.R.L.', 'Fatiha@gmail.com', 'Jr. Luna Reynoso # 003', '2023-10-18 20:53:48', '0000-00-00 00:00:00'),
(19, 'Sabela Peiro', '912568584', '958151476', 'FORESTA INTERNACIONAL S.R.L.', 'Sabela@gmail.com', 'Cl. Pablo Ozuna # 9', '2023-10-18 20:54:03', '0000-00-00 00:00:00'),
(20, 'Valentina Sala', '985653228', '987548114', 'INDUSTRIAS LASTER S.A.C.', 'Valentina@gmail.com', 'Cl. Ana Paula Lozano # 01647', '2023-10-18 20:54:20', '0000-00-00 00:00:00'),
(21, 'Consolacion Marquez', '968537245', '987152462', 'INDUSTRIAS MANRIQUE S.A.C.', 'Consolacion@gmail.com', 'Av. Rafaela Yáñez # 1332 Piso 56', '2023-10-18 20:54:38', '0000-00-00 00:00:00'),
(22, 'Mia Iglesias', '987548114', '986688756', 'VERONA CALZADO', 'Mia@gmail.com', 'Jr. Joshua Valentín # 4', '2023-10-18 20:54:54', '0000-00-00 00:00:00'),
(23, 'Carla Sainz', '986688756', '912568584', 'WELLCO PERUANA', 'WELLCO PERUANA	Carla@gmail.com', 'Urb. Silvana Fonseca # 020', '2023-10-18 20:55:10', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_roles`
--

CREATE TABLE `tb_roles` (
  `id_rol` int(11) NOT NULL,
  `rol` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_roles`
--

INSERT INTO `tb_roles` (`id_rol`, `rol`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'ADMINISTRADOR', '2023-01-23 23:15:19', '2023-01-23 23:15:19'),
(3, 'VENDEDOR', '2023-01-23 19:11:28', '2023-01-23 20:13:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_usuarios`
--

CREATE TABLE `tb_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_user` text NOT NULL,
  `token` varchar(100) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_usuarios`
--

INSERT INTO `tb_usuarios` (`id_usuario`, `nombres`, `email`, `password_user`, `token`, `id_rol`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'Alexis Coaquira', 'Adcoaquiraq@unjbg.edu.pe', '$2y$10$AlAKhpTVMRGOMSZK.pDCw.JUrfS9yXhgckZOokhmX871jrrfSWLIO', '', 1, '2023-01-24 15:16:01', '2023-10-18 22:23:23'),
(8, 'Eduardo Patricio', 'Eypatricioc@unjbg.edu.pe', '$2y$10$1Hxlq7cWiSKusERAVWVzM.I64a5wqaaEr5GV0WkODDYrzCp2O0Q92', '', 1, '2023-10-18 16:28:42', '2023-10-18 22:20:05'),
(9, 'Oscar Mamani', 'Oemamanim@unjbg.edu.pe', '$2y$10$.d0QnlncJfJTnXpnS7QrYuyo9JYdQw66a4B0HpYQwGGdKDG874q1a', '', 1, '2023-10-18 22:18:47', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_ventas`
--

CREATE TABLE `tb_ventas` (
  `id_venta` int(11) NOT NULL,
  `nro_venta` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `total_pagado` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_ventas`
--

INSERT INTO `tb_ventas` (`id_venta`, `nro_venta`, `id_cliente`, `total_pagado`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(19, 1, 11, 1484, '2023-10-18 21:58:02', '0000-00-00 00:00:00'),
(20, 2, 17, 353, '2023-10-18 21:58:15', '0000-00-00 00:00:00'),
(22, 3, 15, 518, '2023-10-18 22:01:28', '0000-00-00 00:00:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `tb_carrito`
--
ALTER TABLE `tb_carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_venta` (`nro_venta`);

--
-- Indices de la tabla `tb_categorias`
--
ALTER TABLE `tb_categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `tb_clientes`
--
ALTER TABLE `tb_clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_proveedores`
--
ALTER TABLE `tb_proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `tb_roles`
--
ALTER TABLE `tb_roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `tb_ventas`
--
ALTER TABLE `tb_ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `nro_venta` (`nro_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `tb_carrito`
--
ALTER TABLE `tb_carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `tb_categorias`
--
ALTER TABLE `tb_categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `tb_clientes`
--
ALTER TABLE `tb_clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `tb_proveedores`
--
ALTER TABLE `tb_proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `tb_roles`
--
ALTER TABLE `tb_roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tb_ventas`
--
ALTER TABLE `tb_ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  ADD CONSTRAINT `tb_almacen_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_almacen_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_carrito`
--
ALTER TABLE `tb_carrito`
  ADD CONSTRAINT `tb_carrito_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_almacen` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  ADD CONSTRAINT `tb_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `tb_almacen` (`id_producto`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_compras_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_compras_ibfk_4` FOREIGN KEY (`id_proveedor`) REFERENCES `tb_proveedores` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD CONSTRAINT `tb_usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tb_roles` (`id_rol`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_ventas`
--
ALTER TABLE `tb_ventas`
  ADD CONSTRAINT `tb_ventas_ibfk_2` FOREIGN KEY (`nro_venta`) REFERENCES `tb_carrito` (`nro_venta`),
  ADD CONSTRAINT `tb_ventas_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `tb_clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
