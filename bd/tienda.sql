/*
 Navicat MySQL Dump SQL

 Source Server         : Local-Host
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42-0ubuntu0.24.10.1)
 Source Host           : 127.0.0.1:3306
 Source Schema         : tienda

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42-0ubuntu0.24.10.1)
 File Encoding         : 65001

 Date: 26/12/2025 16:57:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for abonos_credito
-- ----------------------------
DROP TABLE IF EXISTS `abonos_credito`;
CREATE TABLE `abonos_credito` (
  `id` int NOT NULL,
  `empleado_id` int NOT NULL,
  `credito_id` int NOT NULL,
  `monto` double(11,0) NOT NULL,
  `create_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `empleado_id` (`empleado_id`),
  KEY `credito_id` (`credito_id`),
  CONSTRAINT `abonos_credito_ibfk_1` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `abonos_credito_ibfk_2` FOREIGN KEY (`credito_id`) REFERENCES `creditos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for cajas
-- ----------------------------
DROP TABLE IF EXISTS `cajas`;
CREATE TABLE `cajas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sucursal_id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `saldo_real` double(11,3) NOT NULL,
  `saldo_retiros` double(11,3) NOT NULL,
  `saldo_prestamo` double(11,3) NOT NULL,
  `status` int NOT NULL,
  `create_at` date NOT NULL,
  `update_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`) USING BTREE,
  KEY `sucursal_id` (`sucursal_id`),
  CONSTRAINT `cajas_ibfk_1` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(150) NOT NULL DEFAULT '0.00',
  `limite` double(11,2) NOT NULL DEFAULT '0.00',
  `estatus` int NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for creditos
-- ----------------------------
DROP TABLE IF EXISTS `creditos`;
CREATE TABLE `creditos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `venta_id` int NOT NULL,
  `create_at` date NOT NULL,
  `status` int NOT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `venta_id` (`venta_id`),
  CONSTRAINT `creditos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `creditos_ibfk_2` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for dia_semana
-- ----------------------------
DROP TABLE IF EXISTS `dia_semana`;
CREATE TABLE `dia_semana` (
  `id` int NOT NULL,
  `nombre` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for direcciones
-- ----------------------------
DROP TABLE IF EXISTS `direcciones`;
CREATE TABLE `direcciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `municipio_id` int NOT NULL,
  `calle` varchar(60) NOT NULL,
  `numero_exterior` varchar(10) NOT NULL,
  `numero_interior` varchar(10) DEFAULT NULL,
  `colonia` varchar(60) NOT NULL,
  `codigo_postal` varchar(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `municipio_id` (`municipio_id`),
  CONSTRAINT `direcciones_ibfk_1` FOREIGN KEY (`municipio_id`) REFERENCES `municipios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for empleados
-- ----------------------------
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `persona_id` int NOT NULL,
  `sucursal_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `numero_empleado` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `status` int NOT NULL,
  `creat_at` date NOT NULL,
  `update_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_empleado` (`numero_empleado`),
  KEY `persona_id` (`persona_id`),
  KEY `sucursal_id` (`sucursal_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `empleados_ibfk_2` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `empleados_ibfk_4` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `empleados_ibfk_5` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for entradas_mercancia
-- ----------------------------
DROP TABLE IF EXISTS `entradas_mercancia`;
CREATE TABLE `entradas_mercancia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `proveedor_id` int NOT NULL,
  `empleado_id` int NOT NULL,
  `monto` double(11,0) NOT NULL,
  `detalle` text NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proveedor_id` (`proveedor_id`),
  KEY `empleado_id` (`empleado_id`),
  CONSTRAINT `entradas_mercancia_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entradas_mercancia_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for estados
-- ----------------------------
DROP TABLE IF EXISTS `estados`;
CREATE TABLE `estados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(2) NOT NULL COMMENT 'CVE_ENT - Clave de la entidad',
  `nombre` varchar(40) NOT NULL COMMENT 'NOM_ENT - Nombre de la entidad',
  `abrev` varchar(10) NOT NULL COMMENT 'NOM_ABR - Nombre abreviado de la entidad',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COMMENT='Estados de la República Mexicana';

-- ----------------------------
-- Table structure for movimientos_caja
-- ----------------------------
DROP TABLE IF EXISTS `movimientos_caja`;
CREATE TABLE `movimientos_caja` (
  `id` int NOT NULL AUTO_INCREMENT,
  `caja_id` int NOT NULL,
  `empleado_id` int NOT NULL,
  `tipo_movimiento_id` int NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `monto` double NOT NULL,
  `status` tinyint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `saldo` double DEFAULT NULL,
  `saldo_anterior` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `caja_id` (`caja_id`),
  KEY `empleado_id` (`empleado_id`),
  KEY `tipo_movimiento_id` (`tipo_movimiento_id`),
  CONSTRAINT `movimientos_caja_ibfk_1` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `movimientos_caja_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `movimientos_caja_ibfk_3` FOREIGN KEY (`tipo_movimiento_id`) REFERENCES `tipo_movimiento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for municipios
-- ----------------------------
DROP TABLE IF EXISTS `municipios`;
CREATE TABLE `municipios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estado_id` int NOT NULL COMMENT 'Relación: estados -> id',
  `clave` varchar(3) NOT NULL COMMENT 'CVE_MUN – Clave del municipio',
  `nombre` varchar(100) NOT NULL COMMENT 'NOM_MUN – Nombre del municipio',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `estado_id` (`estado_id`),
  CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2464 DEFAULT CHARSET=utf8mb3 COMMENT='Municipios de la República Mexicana';

-- ----------------------------
-- Table structure for personas
-- ----------------------------
DROP TABLE IF EXISTS `personas`;
CREATE TABLE `personas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `direccion_id` int NOT NULL DEFAULT '0',
  `nombre` varchar(40) NOT NULL,
  `apellido_paterno` varchar(70) DEFAULT NULL,
  `apellido_materno` varchar(70) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `direccion_id` (`direccion_id`),
  CONSTRAINT `personas_ibfk_2` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `proveedor_id` int NOT NULL,
  `codigo_barras` varchar(30) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `precio_compra` double(11,2) NOT NULL,
  `precio_venta` double(11,2) NOT NULL,
  `stock` int NOT NULL,
  `stock_minimo` int NOT NULL,
  `stock_maximo` int DEFAULT NULL,
  `imagen` varchar(30) DEFAULT NULL,
  `status` int NOT NULL,
  `create_at` date NOT NULL,
  `update_at` date DEFAULT NULL,
  `tipo_venta` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_barras` (`codigo_barras`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1037 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for proveedores
-- ----------------------------
DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marca` varchar(60) NOT NULL,
  `create_at` datetime NOT NULL,
  `status` int NOT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for proveedores_dias
-- ----------------------------
DROP TABLE IF EXISTS `proveedores_dias`;
CREATE TABLE `proveedores_dias` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `proveedor_id` int NOT NULL,
  `dia_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proveedor_id` (`proveedor_id`),
  KEY `dia_id` (`dia_id`),
  CONSTRAINT `proveedores_dias_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proveedores_dias_ibfk_2` FOREIGN KEY (`dia_id`) REFERENCES `dia_semana` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `description` varchar(70) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for sucursales
-- ----------------------------
DROP TABLE IF EXISTS `sucursales`;
CREATE TABLE `sucursales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `direccion_id` int NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `creat_at` date NOT NULL,
  `update_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `direccion_id` (`direccion_id`),
  CONSTRAINT `sucursales_ibfk_1` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_movimiento
-- ----------------------------
DROP TABLE IF EXISTS `tipo_movimiento`;
CREATE TABLE `tipo_movimiento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(70) NOT NULL,
  `password` varchar(70) NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime DEFAULT NULL,
  `estatus` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for users_roles
-- ----------------------------
DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE `users_roles` (
  `user_id` int NOT NULL,
  `role_id` int unsigned NOT NULL,
  KEY `FK_usuarios_roles_usuarios` (`user_id`),
  KEY `FK_usuarios_roles_rol` (`role_id`),
  CONSTRAINT `FK_usuarios_roles_rol` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_usuarios_roles_usuarios` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for ventas
-- ----------------------------
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `monto` double(10,3) NOT NULL,
  `cliente_id` int NOT NULL,
  `empleado_id` int NOT NULL,
  `detalle` text,
  `status` int NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `vendedor_id` (`empleado_id`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8mb3;

SET FOREIGN_KEY_CHECKS = 1;


BEGIN;
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (1, '01', 'Aguascalientes', 'Ags.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (2, '02', 'Baja California', 'BC', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (3, '03', 'Baja California Sur', 'BCS', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (4, '04', 'Campeche', 'Camp.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (5, '05', 'Coahuila de Zaragoza', 'Coah.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (6, '06', 'Colima', 'Col.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (7, '07', 'Chiapas', 'Chis.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (8, '08', 'Chihuahua', 'Chih.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (9, '09', 'Ciudad de México', 'CDMX', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (10, '10', 'Durango', 'Dgo.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (11, '11', 'Guanajuato', 'Gto.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (12, '12', 'Guerrero', 'Gro.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (13, '13', 'Hidalgo', 'Hgo.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (14, '14', 'Jalisco', 'Jal.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (15, '15', 'México', 'Mex.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (16, '16', 'Michoacán de Ocampo', 'Mich.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (17, '17', 'Morelos', 'Mor.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (18, '18', 'Nayarit', 'Nay.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (19, '19', 'Nuevo León', 'NL', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (20, '20', 'Oaxaca', 'Oax.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (21, '21', 'Puebla', 'Pue.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (22, '22', 'Querétaro', 'Qro.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (23, '23', 'Quintana Roo', 'Q. Roo', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (24, '24', 'San Luis Potosí', 'SLP', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (25, '25', 'Sinaloa', 'Sin.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (26, '26', 'Sonora', 'Son.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (27, '27', 'Tabasco', 'Tab.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (28, '28', 'Tamaulipas', 'Tamps.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (29, '29', 'Tlaxcala', 'Tlax.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (30, '30', 'Veracruz de Ignacio de la Llave', 'Ver.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (31, '31', 'Yucatán', 'Yuc.', 1);
INSERT INTO `estados` (`id`, `clave`, `nombre`, `abrev`, `activo`) VALUES (32, '32', 'Zacatecas', 'Zac.', 1);
COMMIT;


BEGIN;
INSERT INTO `roles` (`id`, `name`, `description`) VALUES (1, 'ROLE_ADMIN', 'Gerente');
INSERT INTO `roles` (`id`, `name`, `description`) VALUES (2, 'ROLE_CAJERO', 'Cajero');
COMMIT;

BEGIN;
INSERT INTO `dia_semana` (`id`, `nombre`) VALUES (1, 'DOMINGO');
INSERT INTO `dia_semana` (`id`, `nombre`) VALUES (2, 'LUNES');
INSERT INTO `dia_semana` (`id`, `nombre`) VALUES (3, 'MARTES');
INSERT INTO `dia_semana` (`id`, `nombre`) VALUES (4, 'MIÉRCOLES');
INSERT INTO `dia_semana` (`id`, `nombre`) VALUES (5, 'JUEVES');
INSERT INTO `dia_semana` (`id`, `nombre`) VALUES (6, 'VIERNES');
INSERT INTO `dia_semana` (`id`, `nombre`) VALUES (7, 'SÁBADO');
COMMIT;


BEGIN;
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (1, 1, '001', 'Aguascalientes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (2, 1, '002', 'Asientos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (3, 1, '003', 'Calvillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (4, 1, '004', 'Cosío', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (5, 1, '005', 'Jesús María', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (6, 1, '006', 'Pabellón de Arteaga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (7, 1, '007', 'Rincón de Romos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (8, 1, '008', 'San José de Gracia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (9, 1, '009', 'Tepezalá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (10, 1, '010', 'El Llano', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (11, 1, '011', 'San Francisco de los Romo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (12, 2, '001', 'Ensenada', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (13, 2, '002', 'Mexicali', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (14, 2, '003', 'Tecate', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (15, 2, '004', 'Tijuana', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (16, 2, '005', 'Playas de Rosarito', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (17, 3, '001', 'Comondú', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (18, 3, '002', 'Mulegé', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (19, 3, '003', 'La Paz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (20, 3, '008', 'Los Cabos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (21, 3, '009', 'Loreto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (22, 4, '001', 'Calkiní', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (23, 4, '002', 'Campeche', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (24, 4, '003', 'Carmen', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (25, 4, '004', 'Champotón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (26, 4, '005', 'Hecelchakán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (27, 4, '006', 'Hopelchén', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (28, 4, '007', 'Palizada', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (29, 4, '008', 'Tenabo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (30, 4, '009', 'Escárcega', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (31, 4, '010', 'Calakmul', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (32, 4, '011', 'Candelaria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (33, 5, '001', 'Abasolo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (34, 5, '002', 'Acuña', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (35, 5, '003', 'Allende', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (36, 5, '004', 'Arteaga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (37, 5, '005', 'Candela', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (38, 5, '006', 'Castaños', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (39, 5, '007', 'Cuatro Ciénegas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (40, 5, '008', 'Escobedo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (41, 5, '009', 'Francisco I. Madero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (42, 5, '010', 'Frontera', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (43, 5, '011', 'General Cepeda', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (44, 5, '012', 'Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (45, 5, '013', 'Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (46, 5, '014', 'Jiménez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (47, 5, '015', 'Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (48, 5, '016', 'Lamadrid', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (49, 5, '017', 'Matamoros', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (50, 5, '018', 'Monclova', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (51, 5, '019', 'Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (52, 5, '020', 'Múzquiz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (53, 5, '021', 'Nadadores', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (54, 5, '022', 'Nava', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (55, 5, '023', 'Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (56, 5, '024', 'Parras', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (57, 5, '025', 'Piedras Negras', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (58, 5, '026', 'Progreso', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (59, 5, '027', 'Ramos Arizpe', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (60, 5, '028', 'Sabinas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (61, 5, '029', 'Sacramento', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (62, 5, '030', 'Saltillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (63, 5, '031', 'San Buenaventura', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (64, 5, '032', 'San Juan de Sabinas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (65, 5, '033', 'San Pedro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (66, 5, '034', 'Sierra Mojada', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (67, 5, '035', 'Torreón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (68, 5, '036', 'Viesca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (69, 5, '037', 'Villa Unión', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (70, 5, '038', 'Zaragoza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (71, 6, '001', 'Armería', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (72, 6, '002', 'Colima', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (73, 6, '003', 'Comala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (74, 6, '004', 'Coquimatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (75, 6, '005', 'Cuauhtémoc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (76, 6, '006', 'Ixtlahuacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (77, 6, '007', 'Manzanillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (78, 6, '008', 'Minatitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (79, 6, '009', 'Tecomán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (80, 6, '010', 'Villa de Álvarez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (81, 7, '001', 'Acacoyagua', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (82, 7, '002', 'Acala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (83, 7, '003', 'Acapetahua', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (84, 7, '004', 'Altamirano', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (85, 7, '005', 'Amatán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (86, 7, '006', 'Amatenango de la Frontera', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (87, 7, '007', 'Amatenango del Valle', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (88, 7, '008', 'Angel Albino Corzo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (89, 7, '009', 'Arriaga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (90, 7, '010', 'Bejucal de Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (91, 7, '011', 'Bella Vista', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (92, 7, '012', 'Berriozábal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (93, 7, '013', 'Bochil', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (94, 7, '014', 'El Bosque', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (95, 7, '015', 'Cacahoatán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (96, 7, '016', 'Catazajá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (97, 7, '017', 'Cintalapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (98, 7, '018', 'Coapilla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (99, 7, '019', 'Comitán de Domínguez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (100, 7, '020', 'La Concordia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (101, 7, '021', 'Copainalá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (102, 7, '022', 'Chalchihuitán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (103, 7, '023', 'Chamula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (104, 7, '024', 'Chanal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (105, 7, '025', 'Chapultenango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (106, 7, '026', 'Chenalhó', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (107, 7, '027', 'Chiapa de Corzo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (108, 7, '028', 'Chiapilla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (109, 7, '029', 'Chicoasén', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (110, 7, '030', 'Chicomuselo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (111, 7, '031', 'Chilón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (112, 7, '032', 'Escuintla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (113, 7, '033', 'Francisco León', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (114, 7, '034', 'Frontera Comalapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (115, 7, '035', 'Frontera Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (116, 7, '036', 'La Grandeza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (117, 7, '037', 'Huehuetán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (118, 7, '038', 'Huixtán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (119, 7, '039', 'Huitiupán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (120, 7, '040', 'Huixtla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (121, 7, '041', 'La Independencia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (122, 7, '042', 'Ixhuatán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (123, 7, '043', 'Ixtacomitán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (124, 7, '044', 'Ixtapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (125, 7, '045', 'Ixtapangajoya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (126, 7, '046', 'Jiquipilas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (127, 7, '047', 'Jitotol', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (128, 7, '048', 'Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (129, 7, '049', 'Larráinzar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (130, 7, '050', 'La Libertad', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (131, 7, '051', 'Mapastepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (132, 7, '052', 'Las Margaritas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (133, 7, '053', 'Mazapa de Madero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (134, 7, '054', 'Mazatán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (135, 7, '055', 'Metapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (136, 7, '056', 'Mitontic', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (137, 7, '057', 'Motozintla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (138, 7, '058', 'Nicolás Ruíz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (139, 7, '059', 'Ocosingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (140, 7, '060', 'Ocotepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (141, 7, '061', 'Ocozocoautla de Espinosa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (142, 7, '062', 'Ostuacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (143, 7, '063', 'Osumacinta', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (144, 7, '064', 'Oxchuc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (145, 7, '065', 'Palenque', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (146, 7, '066', 'Pantelhó', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (147, 7, '067', 'Pantepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (148, 7, '068', 'Pichucalco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (149, 7, '069', 'Pijijiapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (150, 7, '070', 'El Porvenir', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (151, 7, '071', 'Villa Comaltitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (152, 7, '072', 'Pueblo Nuevo Solistahuacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (153, 7, '073', 'Rayón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (154, 7, '074', 'Reforma', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (155, 7, '075', 'Las Rosas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (156, 7, '076', 'Sabanilla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (157, 7, '077', 'Salto de Agua', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (158, 7, '078', 'San Cristóbal de las Casas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (159, 7, '079', 'San Fernando', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (160, 7, '080', 'Siltepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (161, 7, '081', 'Simojovel', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (162, 7, '082', 'Sitalá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (163, 7, '083', 'Socoltenango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (164, 7, '084', 'Solosuchiapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (165, 7, '085', 'Soyaló', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (166, 7, '086', 'Suchiapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (167, 7, '087', 'Suchiate', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (168, 7, '088', 'Sunuapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (169, 7, '089', 'Tapachula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (170, 7, '090', 'Tapalapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (171, 7, '091', 'Tapilula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (172, 7, '092', 'Tecpatán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (173, 7, '093', 'Tenejapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (174, 7, '094', 'Teopisca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (175, 7, '096', 'Tila', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (176, 7, '097', 'Tonalá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (177, 7, '098', 'Totolapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (178, 7, '099', 'La Trinitaria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (179, 7, '100', 'Tumbalá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (180, 7, '101', 'Tuxtla Gutiérrez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (181, 7, '102', 'Tuxtla Chico', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (182, 7, '103', 'Tuzantán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (183, 7, '104', 'Tzimol', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (184, 7, '105', 'Unión Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (185, 7, '106', 'Venustiano Carranza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (186, 7, '107', 'Villa Corzo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (187, 7, '108', 'Villaflores', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (188, 7, '109', 'Yajalón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (189, 7, '110', 'San Lucas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (190, 7, '111', 'Zinacantán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (191, 7, '112', 'San Juan Cancuc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (192, 7, '113', 'Aldama', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (193, 7, '114', 'Benemérito de las Américas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (194, 7, '115', 'Maravilla Tenejapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (195, 7, '116', 'Marqués de Comillas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (196, 7, '117', 'Montecristo de Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (197, 7, '118', 'San Andrés Duraznal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (198, 7, '119', 'Santiago el Pinar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (199, 7, '120', 'Capitán Luis Ángel Vidal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (200, 7, '121', 'Rincón Chamula San Pedro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (201, 7, '122', 'El Parral', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (202, 7, '123', 'Emiliano Zapata', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (203, 7, '124', 'Mezcalapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (204, 8, '001', 'Ahumada', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (205, 8, '002', 'Aldama', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (206, 8, '003', 'Allende', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (207, 8, '004', 'Aquiles Serdán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (208, 8, '005', 'Ascensión', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (209, 8, '006', 'Bachíniva', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (210, 8, '007', 'Balleza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (211, 8, '008', 'Batopilas de Manuel Gómez Morín', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (212, 8, '009', 'Bocoyna', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (213, 8, '010', 'Buenaventura', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (214, 8, '011', 'Camargo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (215, 8, '012', 'Carichí', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (216, 8, '013', 'Casas Grandes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (217, 8, '014', 'Coronado', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (218, 8, '015', 'Coyame del Sotol', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (219, 8, '016', 'La Cruz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (220, 8, '017', 'Cuauhtémoc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (221, 8, '018', 'Cusihuiriachi', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (222, 8, '019', 'Chihuahua', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (223, 8, '020', 'Chínipas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (224, 8, '021', 'Delicias', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (225, 8, '022', 'Dr. Belisario Domínguez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (226, 8, '023', 'Galeana', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (227, 8, '024', 'Santa Isabel', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (228, 8, '025', 'Gómez Farías', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (229, 8, '026', 'Gran Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (230, 8, '027', 'Guachochi', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (231, 8, '028', 'Guadalupe', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (232, 8, '029', 'Guadalupe y Calvo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (233, 8, '030', 'Guazapares', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (234, 8, '031', 'Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (235, 8, '032', 'Hidalgo del Parral', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (236, 8, '033', 'Huejotitán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (237, 8, '034', 'Ignacio Zaragoza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (238, 8, '035', 'Janos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (239, 8, '036', 'Jiménez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (240, 8, '037', 'Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (241, 8, '038', 'Julimes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (242, 8, '039', 'López', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (243, 8, '040', 'Madera', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (244, 8, '041', 'Maguarichi', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (245, 8, '042', 'Manuel Benavides', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (246, 8, '043', 'Matachí', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (247, 8, '044', 'Matamoros', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (248, 8, '045', 'Meoqui', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (249, 8, '046', 'Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (250, 8, '047', 'Moris', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (251, 8, '048', 'Namiquipa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (252, 8, '049', 'Nonoava', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (253, 8, '050', 'Nuevo Casas Grandes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (254, 8, '051', 'Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (255, 8, '052', 'Ojinaga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (256, 8, '053', 'Praxedis G. Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (257, 8, '054', 'Riva Palacio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (258, 8, '055', 'Rosales', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (259, 8, '056', 'Rosario', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (260, 8, '057', 'San Francisco de Borja', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (261, 8, '058', 'San Francisco de Conchos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (262, 8, '059', 'San Francisco del Oro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (263, 8, '060', 'Santa Bárbara', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (264, 8, '061', 'Satevó', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (265, 8, '062', 'Saucillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (266, 8, '063', 'Temósachic', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (267, 8, '064', 'El Tule', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (268, 8, '065', 'Urique', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (269, 8, '066', 'Uruachi', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (270, 8, '067', 'Valle de Zaragoza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (271, 9, '002', 'Azcapotzalco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (272, 9, '003', 'Coyoacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (273, 9, '004', 'Cuajimalpa de Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (274, 9, '005', 'Gustavo A. Madero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (275, 9, '006', 'Iztacalco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (276, 9, '007', 'Iztapalapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (277, 9, '008', 'La Magdalena Contreras', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (278, 9, '009', 'Milpa Alta', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (279, 9, '010', 'Álvaro Obregón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (280, 9, '011', 'Tláhuac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (281, 9, '012', 'Tlalpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (282, 9, '013', 'Xochimilco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (283, 9, '014', 'Benito Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (284, 9, '015', 'Cuauhtémoc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (285, 9, '016', 'Miguel Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (286, 9, '017', 'Venustiano Carranza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (287, 10, '001', 'Canatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (288, 10, '002', 'Canelas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (289, 10, '003', 'Coneto de Comonfort', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (290, 10, '004', 'Cuencamé', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (291, 10, '005', 'Durango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (292, 10, '006', 'General Simón Bolívar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (293, 10, '007', 'Gómez Palacio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (294, 10, '008', 'Guadalupe Victoria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (295, 10, '009', 'Guanaceví', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (296, 10, '010', 'Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (297, 10, '011', 'Indé', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (298, 10, '012', 'Lerdo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (299, 10, '013', 'Mapimí', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (300, 10, '014', 'Mezquital', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (301, 10, '015', 'Nazas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (302, 10, '016', 'Nombre de Dios', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (303, 10, '017', 'Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (304, 10, '018', 'El Oro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (305, 10, '019', 'Otáez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (306, 10, '020', 'Pánuco de Coronado', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (307, 10, '021', 'Peñón Blanco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (308, 10, '022', 'Poanas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (309, 10, '023', 'Pueblo Nuevo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (310, 10, '024', 'Rodeo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (311, 10, '025', 'San Bernardo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (312, 10, '026', 'San Dimas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (313, 10, '027', 'San Juan de Guadalupe', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (314, 10, '028', 'San Juan del Río', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (315, 10, '029', 'San Luis del Cordero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (316, 10, '030', 'San Pedro del Gallo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (317, 10, '031', 'Santa Clara', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (318, 10, '032', 'Santiago Papasquiaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (319, 10, '033', 'Súchil', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (320, 10, '034', 'Tamazula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (321, 10, '035', 'Tepehuanes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (322, 10, '036', 'Tlahualilo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (323, 10, '037', 'Topia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (324, 10, '038', 'Vicente Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (325, 10, '039', 'Nuevo Ideal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (326, 11, '001', 'Abasolo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (327, 11, '002', 'Acámbaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (328, 11, '003', 'San Miguel de Allende', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (329, 11, '004', 'Apaseo el Alto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (330, 11, '005', 'Apaseo el Grande', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (331, 11, '006', 'Atarjea', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (332, 11, '007', 'Celaya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (333, 11, '008', 'Manuel Doblado', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (334, 11, '009', 'Comonfort', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (335, 11, '010', 'Coroneo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (336, 11, '011', 'Cortazar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (337, 11, '012', 'Cuerámaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (338, 11, '013', 'Doctor Mora', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (339, 11, '014', 'Dolores Hidalgo Cuna de la Independencia Nacional', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (340, 11, '015', 'Guanajuato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (341, 11, '016', 'Huanímaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (342, 11, '017', 'Irapuato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (343, 11, '018', 'Jaral del Progreso', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (344, 11, '019', 'Jerécuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (345, 11, '020', 'León', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (346, 11, '021', 'Moroleón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (347, 11, '022', 'Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (348, 11, '023', 'Pénjamo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (349, 11, '024', 'Pueblo Nuevo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (350, 11, '025', 'Purísima del Rincón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (351, 11, '026', 'Romita', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (352, 11, '027', 'Salamanca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (353, 11, '028', 'Salvatierra', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (354, 11, '029', 'San Diego de la Unión', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (355, 11, '030', 'San Felipe', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (356, 11, '031', 'San Francisco del Rincón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (357, 11, '032', 'San José Iturbide', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (358, 11, '033', 'San Luis de la Paz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (359, 11, '034', 'Santa Catarina', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (360, 11, '035', 'Santa Cruz de Juventino Rosas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (361, 11, '036', 'Santiago Maravatío', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (362, 11, '037', 'Silao de la Victoria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (363, 11, '038', 'Tarandacuao', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (364, 11, '039', 'Tarimoro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (365, 11, '040', 'Tierra Blanca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (366, 11, '041', 'Uriangato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (367, 11, '042', 'Valle de Santiago', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (368, 11, '043', 'Victoria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (369, 11, '044', 'Villagrán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (370, 11, '045', 'Xichú', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (371, 11, '046', 'Yuriria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (372, 12, '001', 'Acapulco de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (373, 12, '002', 'Ahuacuotzingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (374, 12, '003', 'Ajuchitlán del Progreso', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (375, 12, '004', 'Alcozauca de Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (376, 12, '005', 'Alpoyeca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (377, 12, '006', 'Apaxtla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (378, 12, '007', 'Arcelia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (379, 12, '008', 'Atenango del Río', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (380, 12, '009', 'Atlamajalcingo del Monte', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (381, 12, '010', 'Atlixtac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (382, 12, '011', 'Atoyac de Álvarez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (383, 12, '012', 'Ayutla de los Libres', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (384, 12, '013', 'Azoyú', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (385, 12, '014', 'Benito Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (386, 12, '015', 'Buenavista de Cuéllar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (387, 12, '016', 'Coahuayutla de José María Izazaga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (388, 12, '017', 'Cocula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (389, 12, '018', 'Copala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (390, 12, '019', 'Copalillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (391, 12, '020', 'Copanatoyac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (392, 12, '021', 'Coyuca de Benítez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (393, 12, '022', 'Coyuca de Catalán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (394, 12, '023', 'Cuajinicuilapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (395, 12, '024', 'Cualác', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (396, 12, '025', 'Cuautepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (397, 12, '026', 'Cuetzala del Progreso', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (398, 12, '027', 'Cutzamala de Pinzón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (399, 12, '028', 'Chilapa de Álvarez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (400, 12, '029', 'Chilpancingo de los Bravo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (401, 12, '030', 'Florencio Villarreal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (402, 12, '031', 'General Canuto A. Neri', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (403, 12, '032', 'General Heliodoro Castillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (404, 12, '033', 'Huamuxtitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (405, 12, '034', 'Huitzuco de los Figueroa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (406, 12, '035', 'Iguala de la Independencia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (407, 12, '036', 'Igualapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (408, 12, '037', 'Ixcateopan de Cuauhtémoc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (409, 12, '038', 'Zihuatanejo de Azueta', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (410, 12, '039', 'Juan R. Escudero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (411, 12, '040', 'Leonardo Bravo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (412, 12, '041', 'Malinaltepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (413, 12, '042', 'Mártir de Cuilapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (414, 12, '043', 'Metlatónoc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (415, 12, '044', 'Mochitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (416, 12, '045', 'Olinalá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (417, 12, '046', 'Ometepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (418, 12, '047', 'Pedro Ascencio Alquisiras', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (419, 12, '048', 'Petatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (420, 12, '049', 'Pilcaya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (421, 12, '050', 'Pungarabato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (422, 12, '051', 'Quechultenango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (423, 12, '052', 'San Luis Acatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (424, 12, '053', 'San Marcos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (425, 12, '054', 'San Miguel Totolapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (426, 12, '055', 'Taxco de Alarcón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (427, 12, '056', 'Tecoanapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (428, 12, '057', 'Técpan de Galeana', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (429, 12, '058', 'Teloloapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (430, 12, '059', 'Tepecoacuilco de Trujano', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (431, 12, '060', 'Tetipac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (432, 12, '061', 'Tixtla de Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (433, 12, '062', 'Tlacoachistlahuaca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (434, 12, '063', 'Tlacoapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (435, 12, '064', 'Tlalchapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (436, 12, '065', 'Tlalixtaquilla de Maldonado', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (437, 12, '066', 'Tlapa de Comonfort', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (438, 12, '067', 'Tlapehuala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (439, 12, '068', 'La Unión de Isidoro Montes de Oca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (440, 12, '069', 'Xalpatláhuac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (441, 12, '070', 'Xochihuehuetlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (442, 12, '071', 'Xochistlahuaca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (443, 12, '072', 'Zapotitlán Tablas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (444, 12, '073', 'Zirándaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (445, 12, '074', 'Zitlala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (446, 12, '075', 'Eduardo Neri', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (447, 12, '076', 'Acatepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (448, 12, '077', 'Marquelia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (449, 12, '078', 'Cochoapa el Grande', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (450, 12, '079', 'José Joaquín de Herrera', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (451, 12, '080', 'Juchitán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (452, 12, '081', 'Iliatenco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (453, 13, '001', 'Acatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (454, 13, '002', 'Acaxochitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (455, 13, '003', 'Actopan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (456, 13, '004', 'Agua Blanca de Iturbide', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (457, 13, '005', 'Ajacuba', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (458, 13, '006', 'Alfajayucan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (459, 13, '007', 'Almoloya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (460, 13, '008', 'Apan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (461, 13, '009', 'El Arenal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (462, 13, '010', 'Atitalaquia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (463, 13, '011', 'Atlapexco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (464, 13, '012', 'Atotonilco el Grande', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (465, 13, '013', 'Atotonilco de Tula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (466, 13, '014', 'Calnali', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (467, 13, '015', 'Cardonal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (468, 13, '016', 'Cuautepec de Hinojosa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (469, 13, '017', 'Chapantongo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (470, 13, '018', 'Chapulhuacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (471, 13, '019', 'Chilcuautla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (472, 13, '020', 'Eloxochitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (473, 13, '021', 'Emiliano Zapata', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (474, 13, '022', 'Epazoyucan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (475, 13, '023', 'Francisco I. Madero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (476, 13, '024', 'Huasca de Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (477, 13, '025', 'Huautla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (478, 13, '026', 'Huazalingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (479, 13, '027', 'Huehuetla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (480, 13, '028', 'Huejutla de Reyes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (481, 13, '029', 'Huichapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (482, 13, '030', 'Ixmiquilpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (483, 13, '031', 'Jacala de Ledezma', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (484, 13, '032', 'Jaltocán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (485, 13, '033', 'Juárez Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (486, 13, '034', 'Lolotla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (487, 13, '035', 'Metepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (488, 13, '036', 'San Agustín Metzquititlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (489, 13, '037', 'Metztitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (490, 13, '038', 'Mineral del Chico', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (491, 13, '039', 'Mineral del Monte', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (492, 13, '040', 'La Misión', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (493, 13, '041', 'Mixquiahuala de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (494, 13, '042', 'Molango de Escamilla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (495, 13, '043', 'Nicolás Flores', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (496, 13, '044', 'Nopala de Villagrán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (497, 13, '045', 'Omitlán de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (498, 13, '046', 'San Felipe Orizatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (499, 13, '047', 'Pacula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (500, 13, '048', 'Pachuca de Soto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (501, 13, '049', 'Pisaflores', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (502, 13, '050', 'Progreso de Obregón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (503, 13, '051', 'Mineral de la Reforma', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (504, 13, '052', 'San Agustín Tlaxiaca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (505, 13, '053', 'San Bartolo Tutotepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (506, 13, '054', 'San Salvador', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (507, 13, '055', 'Santiago de Anaya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (508, 13, '056', 'Santiago Tulantepec de Lugo Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (509, 13, '057', 'Singuilucan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (510, 13, '058', 'Tasquillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (511, 13, '059', 'Tecozautla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (512, 13, '060', 'Tenango de Doria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (513, 13, '061', 'Tepeapulco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (514, 13, '062', 'Tepehuacán de Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (515, 13, '063', 'Tepeji del Río de Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (516, 13, '064', 'Tepetitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (517, 13, '065', 'Tetepango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (518, 13, '066', 'Villa de Tezontepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (519, 13, '067', 'Tezontepec de Aldama', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (520, 13, '068', 'Tianguistengo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (521, 13, '069', 'Tizayuca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (522, 13, '070', 'Tlahuelilpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (523, 13, '071', 'Tlahuiltepa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (524, 13, '072', 'Tlanalapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (525, 13, '073', 'Tlanchinol', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (526, 13, '074', 'Tlaxcoapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (527, 13, '075', 'Tolcayuca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (528, 13, '076', 'Tula de Allende', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (529, 13, '077', 'Tulancingo de Bravo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (530, 13, '078', 'Xochiatipan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (531, 13, '079', 'Xochicoatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (532, 13, '080', 'Yahualica', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (533, 13, '081', 'Zacualtipán de Ángeles', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (534, 13, '082', 'Zapotlán de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (535, 13, '083', 'Zempoala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (536, 13, '084', 'Zimapán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (537, 14, '001', 'Acatic', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (538, 14, '002', 'Acatlán de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (539, 14, '003', 'Ahualulco de Mercado', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (540, 14, '004', 'Amacueca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (541, 14, '005', 'Amatitán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (542, 14, '006', 'Ameca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (543, 14, '007', 'San Juanito de Escobedo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (544, 14, '008', 'Arandas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (545, 14, '009', 'El Arenal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (546, 14, '010', 'Atemajac de Brizuela', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (547, 14, '011', 'Atengo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (548, 14, '012', 'Atenguillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (549, 14, '013', 'Atotonilco el Alto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (550, 14, '014', 'Atoyac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (551, 14, '015', 'Autlán de Navarro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (552, 14, '016', 'Ayotlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (553, 14, '017', 'Ayutla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (554, 14, '018', 'La Barca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (555, 14, '019', 'Bolaños', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (556, 14, '020', 'Cabo Corrientes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (557, 14, '021', 'Casimiro Castillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (558, 14, '022', 'Cihuatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (559, 14, '023', 'Zapotlán el Grande', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (560, 14, '024', 'Cocula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (561, 14, '025', 'Colotlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (562, 14, '026', 'Concepción de Buenos Aires', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (563, 14, '027', 'Cuautitlán de García Barragán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (564, 14, '028', 'Cuautla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (565, 14, '029', 'Cuquío', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (566, 14, '030', 'Chapala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (567, 14, '031', 'Chimaltitán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (568, 14, '032', 'Chiquilistlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (569, 14, '033', 'Degollado', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (570, 14, '034', 'Ejutla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (571, 14, '035', 'Encarnación de Díaz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (572, 14, '036', 'Etzatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (573, 14, '037', 'El Grullo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (574, 14, '038', 'Guachinango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (575, 14, '039', 'Guadalajara', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (576, 14, '040', 'Hostotipaquillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (577, 14, '041', 'Huejúcar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (578, 14, '042', 'Huejuquilla el Alto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (579, 14, '043', 'La Huerta', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (580, 14, '044', 'Ixtlahuacán de los Membrillos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (581, 14, '045', 'Ixtlahuacán del Río', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (582, 14, '046', 'Jalostotitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (583, 14, '047', 'Jamay', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (584, 14, '048', 'Jesús María', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (585, 14, '049', 'Jilotlán de los Dolores', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (586, 14, '050', 'Jocotepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (587, 14, '051', 'Juanacatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (588, 14, '052', 'Juchitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (589, 14, '053', 'Lagos de Moreno', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (590, 14, '054', 'El Limón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (591, 14, '055', 'Magdalena', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (592, 14, '056', 'Santa María del Oro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (593, 14, '057', 'La Manzanilla de la Paz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (594, 14, '058', 'Mascota', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (595, 14, '059', 'Mazamitla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (596, 14, '060', 'Mexticacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (597, 14, '061', 'Mezquitic', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (598, 14, '062', 'Mixtlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (599, 14, '063', 'Ocotlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (600, 14, '064', 'Ojuelos de Jalisco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (601, 14, '065', 'Pihuamo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (602, 14, '066', 'Poncitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (603, 14, '067', 'Puerto Vallarta', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (604, 14, '068', 'Villa Purificación', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (605, 14, '069', 'Quitupan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (606, 14, '070', 'El Salto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (607, 14, '071', 'San Cristóbal de la Barranca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (608, 14, '072', 'San Diego de Alejandría', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (609, 14, '073', 'San Juan de los Lagos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (610, 14, '074', 'San Julián', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (611, 14, '075', 'San Marcos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (612, 14, '076', 'San Martín de Bolaños', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (613, 14, '077', 'San Martín Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (614, 14, '078', 'San Miguel el Alto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (615, 14, '079', 'Gómez Farías', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (616, 14, '080', 'San Sebastián del Oeste', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (617, 14, '081', 'Santa María de los Ángeles', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (618, 14, '082', 'Sayula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (619, 14, '083', 'Tala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (620, 14, '084', 'Talpa de Allende', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (621, 14, '085', 'Tamazula de Gordiano', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (622, 14, '086', 'Tapalpa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (623, 14, '087', 'Tecalitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (624, 14, '088', 'Tecolotlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (625, 14, '089', 'Techaluta de Montenegro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (626, 14, '090', 'Tenamaxtlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (627, 14, '091', 'Teocaltiche', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (628, 14, '092', 'Teocuitatlán de Corona', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (629, 14, '093', 'Tepatitlán de Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (630, 14, '094', 'Tequila', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (631, 14, '095', 'Teuchitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (632, 14, '096', 'Tizapán el Alto', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (633, 14, '097', 'Tlajomulco de Zúñiga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (634, 14, '098', 'San Pedro Tlaquepaque', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (635, 14, '099', 'Tolimán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (636, 14, '100', 'Tomatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (637, 14, '101', 'Tonalá', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (638, 14, '102', 'Tonaya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (639, 14, '103', 'Tonila', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (640, 14, '104', 'Totatiche', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (641, 14, '105', 'Tototlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (642, 14, '106', 'Tuxcacuesco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (643, 14, '107', 'Tuxcueca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (644, 14, '108', 'Tuxpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (645, 14, '109', 'Unión de San Antonio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (646, 14, '110', 'Unión de Tula', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (647, 14, '111', 'Valle de Guadalupe', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (648, 14, '112', 'Valle de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (649, 14, '113', 'San Gabriel', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (650, 14, '114', 'Villa Corona', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (651, 14, '115', 'Villa Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (652, 14, '116', 'Villa Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (653, 14, '117', 'Cañadas de Obregón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (654, 14, '118', 'Yahualica de González Gallo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (655, 14, '119', 'Zacoalco de Torres', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (656, 14, '120', 'Zapopan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (657, 14, '121', 'Zapotiltic', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (658, 14, '122', 'Zapotitlán de Vadillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (659, 14, '123', 'Zapotlán del Rey', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (660, 14, '124', 'Zapotlanejo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (661, 14, '125', 'San Ignacio Cerro Gordo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (662, 15, '001', 'Acambay de Ruíz Castañeda', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (663, 15, '002', 'Acolman', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (664, 15, '003', 'Aculco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (665, 15, '004', 'Almoloya de Alquisiras', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (666, 15, '005', 'Almoloya de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (667, 15, '006', 'Almoloya del Río', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (668, 15, '007', 'Amanalco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (669, 15, '008', 'Amatepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (670, 15, '009', 'Amecameca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (671, 15, '010', 'Apaxco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (672, 15, '011', 'Atenco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (673, 15, '012', 'Atizapán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (674, 15, '013', 'Atizapán de Zaragoza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (675, 15, '014', 'Atlacomulco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (676, 15, '015', 'Atlautla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (677, 15, '016', 'Axapusco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (678, 15, '017', 'Ayapango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (679, 15, '018', 'Calimaya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (680, 15, '019', 'Capulhuac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (681, 15, '020', 'Coacalco de Berriozábal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (682, 15, '021', 'Coatepec Harinas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (683, 15, '022', 'Cocotitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (684, 15, '023', 'Coyotepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (685, 15, '024', 'Cuautitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (686, 15, '025', 'Chalco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (687, 15, '026', 'Chapa de Mota', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (688, 15, '027', 'Chapultepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (689, 15, '028', 'Chiautla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (690, 15, '029', 'Chicoloapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (691, 15, '030', 'Chiconcuac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (692, 15, '031', 'Chimalhuacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (693, 15, '032', 'Donato Guerra', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (694, 15, '033', 'Ecatepec de Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (695, 15, '034', 'Ecatzingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (696, 15, '035', 'Huehuetoca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (697, 15, '036', 'Hueypoxtla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (698, 15, '037', 'Huixquilucan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (699, 15, '038', 'Isidro Fabela', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (700, 15, '039', 'Ixtapaluca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (701, 15, '040', 'Ixtapan de la Sal', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (702, 15, '041', 'Ixtapan del Oro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (703, 15, '042', 'Ixtlahuaca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (704, 15, '043', 'Xalatlaco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (705, 15, '044', 'Jaltenco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (706, 15, '045', 'Jilotepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (707, 15, '046', 'Jilotzingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (708, 15, '047', 'Jiquipilco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (709, 15, '048', 'Jocotitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (710, 15, '049', 'Joquicingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (711, 15, '050', 'Juchitepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (712, 15, '051', 'Lerma', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (713, 15, '052', 'Malinalco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (714, 15, '053', 'Melchor Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (715, 15, '054', 'Metepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (716, 15, '055', 'Mexicaltzingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (717, 15, '056', 'Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (718, 15, '057', 'Naucalpan de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (719, 15, '058', 'Nezahualcóyotl', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (720, 15, '059', 'Nextlalpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (721, 15, '060', 'Nicolás Romero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (722, 15, '061', 'Nopaltepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (723, 15, '062', 'Ocoyoacac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (724, 15, '063', 'Ocuilan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (725, 15, '064', 'El Oro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (726, 15, '065', 'Otumba', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (727, 15, '066', 'Otzoloapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (728, 15, '067', 'Otzolotepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (729, 15, '068', 'Ozumba', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (730, 15, '069', 'Papalotla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (731, 15, '070', 'La Paz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (732, 15, '071', 'Polotitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (733, 15, '072', 'Rayón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (734, 15, '073', 'San Antonio la Isla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (735, 15, '074', 'San Felipe del Progreso', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (736, 15, '075', 'San Martín de las Pirámides', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (737, 15, '076', 'San Mateo Atenco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (738, 15, '077', 'San Simón de Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (739, 15, '078', 'Santo Tomás', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (740, 15, '079', 'Soyaniquilpan de Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (741, 15, '080', 'Sultepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (742, 15, '081', 'Tecámac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (743, 15, '082', 'Tejupilco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (744, 15, '083', 'Temamatla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (745, 15, '084', 'Temascalapa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (746, 15, '085', 'Temascalcingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (747, 15, '086', 'Temascaltepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (748, 15, '087', 'Temoaya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (749, 15, '088', 'Tenancingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (750, 15, '089', 'Tenango del Aire', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (751, 15, '090', 'Tenango del Valle', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (752, 15, '091', 'Teoloyucan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (753, 15, '092', 'Teotihuacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (754, 15, '093', 'Tepetlaoxtoc', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (755, 15, '094', 'Tepetlixpa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (756, 15, '095', 'Tepotzotlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (757, 15, '096', 'Tequixquiac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (758, 15, '097', 'Texcaltitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (759, 15, '098', 'Texcalyacac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (760, 15, '099', 'Texcoco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (761, 15, '100', 'Tezoyuca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (762, 15, '101', 'Tianguistenco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (763, 15, '102', 'Timilpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (764, 15, '103', 'Tlalmanalco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (765, 15, '104', 'Tlalnepantla de Baz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (766, 15, '105', 'Tlatlaya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (767, 15, '106', 'Toluca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (768, 15, '107', 'Tonatico', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (769, 15, '108', 'Tultepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (770, 15, '109', 'Tultitlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (771, 15, '110', 'Valle de Bravo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (772, 15, '111', 'Villa de Allende', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (773, 15, '112', 'Villa del Carbón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (774, 15, '113', 'Villa Guerrero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (775, 15, '114', 'Villa Victoria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (776, 15, '115', 'Xonacatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (777, 15, '116', 'Zacazonapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (778, 15, '117', 'Zacualpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (779, 15, '118', 'Zinacantepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (780, 15, '119', 'Zumpahuacán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (781, 15, '120', 'Zumpango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (782, 15, '121', 'Cuautitlán Izcalli', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (783, 15, '122', 'Valle de Chalco Solidaridad', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (784, 15, '123', 'Luvianos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (785, 15, '124', 'San José del Rincón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (786, 15, '125', 'Tonanitla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (787, 16, '001', 'Acuitzio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (788, 16, '002', 'Aguililla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (789, 16, '003', 'Álvaro Obregón', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (790, 16, '004', 'Angamacutiro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (791, 16, '005', 'Angangueo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (792, 16, '006', 'Apatzingán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (793, 16, '007', 'Aporo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (794, 16, '008', 'Aquila', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (795, 16, '009', 'Ario', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (796, 16, '010', 'Arteaga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (797, 16, '011', 'Briseñas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (798, 16, '012', 'Buenavista', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (799, 16, '013', 'Carácuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (800, 16, '014', 'Coahuayana', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (801, 16, '015', 'Coalcomán de Vázquez Pallares', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (802, 16, '016', 'Coeneo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (803, 16, '017', 'Contepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (804, 16, '018', 'Copándaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (805, 16, '019', 'Cotija', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (806, 16, '020', 'Cuitzeo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (807, 16, '021', 'Charapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (808, 16, '022', 'Charo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (809, 16, '023', 'Chavinda', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (810, 16, '024', 'Cherán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (811, 16, '025', 'Chilchota', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (812, 16, '026', 'Chinicuila', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (813, 16, '027', 'Chucándiro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (814, 16, '028', 'Churintzio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (815, 16, '029', 'Churumuco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (816, 16, '030', 'Ecuandureo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (817, 16, '031', 'Epitacio Huerta', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (818, 16, '032', 'Erongarícuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (819, 16, '033', 'Gabriel Zamora', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (820, 16, '034', 'Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (821, 16, '035', 'La Huacana', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (822, 16, '036', 'Huandacareo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (823, 16, '037', 'Huaniqueo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (824, 16, '038', 'Huetamo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (825, 16, '039', 'Huiramba', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (826, 16, '040', 'Indaparapeo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (827, 16, '041', 'Irimbo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (828, 16, '042', 'Ixtlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (829, 16, '043', 'Jacona', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (830, 16, '044', 'Jiménez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (831, 16, '045', 'Jiquilpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (832, 16, '046', 'Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (833, 16, '047', 'Jungapeo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (834, 16, '048', 'Lagunillas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (835, 16, '049', 'Madero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (836, 16, '050', 'Maravatío', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (837, 16, '051', 'Marcos Castellanos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (838, 16, '052', 'Lázaro Cárdenas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (839, 16, '053', 'Morelia', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (840, 16, '054', 'Morelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (841, 16, '055', 'Múgica', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (842, 16, '056', 'Nahuatzen', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (843, 16, '057', 'Nocupétaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (844, 16, '058', 'Nuevo Parangaricutiro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (845, 16, '059', 'Nuevo Urecho', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (846, 16, '060', 'Numarán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (847, 16, '061', 'Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (848, 16, '062', 'Pajacuarán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (849, 16, '063', 'Panindícuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (850, 16, '064', 'Parácuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (851, 16, '065', 'Paracho', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (852, 16, '066', 'Pátzcuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (853, 16, '067', 'Penjamillo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (854, 16, '068', 'Peribán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (855, 16, '069', 'La Piedad', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (856, 16, '070', 'Purépero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (857, 16, '071', 'Puruándiro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (858, 16, '072', 'Queréndaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (859, 16, '073', 'Quiroga', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (860, 16, '074', 'Cojumatlán de Régules', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (861, 16, '075', 'Los Reyes', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (862, 16, '076', 'Sahuayo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (863, 16, '077', 'San Lucas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (864, 16, '078', 'Santa Ana Maya', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (865, 16, '079', 'Salvador Escalante', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (866, 16, '080', 'Senguio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (867, 16, '081', 'Susupuato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (868, 16, '082', 'Tacámbaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (869, 16, '083', 'Tancítaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (870, 16, '084', 'Tangamandapio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (871, 16, '085', 'Tangancícuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (872, 16, '086', 'Tanhuato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (873, 16, '087', 'Taretan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (874, 16, '088', 'Tarímbaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (875, 16, '089', 'Tepalcatepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (876, 16, '090', 'Tingambato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (877, 16, '091', 'Tingüindín', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (878, 16, '092', 'Tiquicheo de Nicolás Romero', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (879, 16, '093', 'Tlalpujahua', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (880, 16, '094', 'Tlazazalca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (881, 16, '095', 'Tocumbo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (882, 16, '096', 'Tumbiscatío', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (883, 16, '097', 'Turicato', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (884, 16, '098', 'Tuxpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (885, 16, '099', 'Tuzantla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (886, 16, '100', 'Tzintzuntzan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (887, 16, '101', 'Tzitzio', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (888, 16, '102', 'Uruapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (889, 16, '103', 'Venustiano Carranza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (890, 16, '104', 'Villamar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (891, 16, '105', 'Vista Hermosa', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (892, 16, '106', 'Yurécuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (893, 16, '107', 'Zacapu', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (894, 16, '108', 'Zamora', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (895, 16, '109', 'Zináparo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (896, 16, '110', 'Zinapécuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (897, 16, '111', 'Ziracuaretiro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (898, 16, '112', 'Zitácuaro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (899, 16, '113', 'José Sixto Verduzco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (900, 17, '001', 'Amacuzac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (901, 17, '002', 'Atlatlahucan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (902, 17, '003', 'Axochiapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (903, 17, '004', 'Ayala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (904, 17, '005', 'Coatlán del Río', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (905, 17, '006', 'Cuautla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (906, 17, '007', 'Cuernavaca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (907, 17, '008', 'Emiliano Zapata', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (908, 17, '009', 'Huitzilac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (909, 17, '010', 'Jantetelco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (910, 17, '011', 'Jiutepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (911, 17, '012', 'Jojutla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (912, 17, '013', 'Jonacatepec de Leandro Valle', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (913, 17, '014', 'Mazatepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (914, 17, '015', 'Miacatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (915, 17, '016', 'Ocuituco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (916, 17, '017', 'Puente de Ixtla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (917, 17, '018', 'Temixco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (918, 17, '019', 'Tepalcingo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (919, 17, '020', 'Tepoztlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (920, 17, '021', 'Tetecala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (921, 17, '022', 'Tetela del Volcán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (922, 17, '023', 'Tlalnepantla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (923, 17, '024', 'Tlaltizapán de Zapata', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (924, 17, '025', 'Tlaquiltenango', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (925, 17, '026', 'Tlayacapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (926, 17, '027', 'Totolapan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (927, 17, '028', 'Xochitepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (928, 17, '029', 'Yautepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (929, 17, '030', 'Yecapixtla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (930, 17, '031', 'Zacatepec', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (931, 17, '032', 'Zacualpan de Amilpas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (932, 17, '033', 'Temoac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (933, 18, '001', 'Acaponeta', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (934, 18, '002', 'Ahuacatlán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (935, 18, '003', 'Amatlán de Cañas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (936, 18, '004', 'Compostela', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (937, 18, '005', 'Huajicori', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (938, 18, '006', 'Ixtlán del Río', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (939, 18, '007', 'Jala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (940, 18, '008', 'Xalisco', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (941, 18, '009', 'Del Nayar', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (942, 18, '010', 'Rosamorada', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (943, 18, '011', 'Ruíz', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (944, 18, '012', 'San Blas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (945, 18, '013', 'San Pedro Lagunillas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (946, 18, '014', 'Santa María del Oro', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (947, 18, '015', 'Santiago Ixcuintla', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (948, 18, '016', 'Tecuala', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (949, 18, '017', 'Tepic', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (950, 18, '018', 'Tuxpan', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (951, 18, '019', 'La Yesca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (952, 18, '020', 'Bahía de Banderas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (953, 19, '001', 'Abasolo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (954, 19, '002', 'Agualeguas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (955, 19, '003', 'Los Aldamas', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (956, 19, '004', 'Allende', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (957, 19, '005', 'Anáhuac', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (958, 19, '006', 'Apodaca', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (959, 19, '007', 'Aramberri', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (960, 19, '008', 'Bustamante', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (961, 19, '009', 'Cadereyta Jiménez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (962, 19, '010', 'El Carmen', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (963, 19, '011', 'Cerralvo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (964, 19, '012', 'Ciénega de Flores', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (965, 19, '013', 'China', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (966, 19, '014', 'Doctor Arroyo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (967, 19, '015', 'Doctor Coss', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (968, 19, '016', 'Doctor González', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (969, 19, '017', 'Galeana', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (970, 19, '018', 'García', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (971, 19, '019', 'San Pedro Garza García', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (972, 19, '020', 'General Bravo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (973, 19, '021', 'General Escobedo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (974, 19, '022', 'General Terán', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (975, 19, '023', 'General Treviño', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (976, 19, '024', 'General Zaragoza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (977, 19, '025', 'General Zuazua', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (978, 19, '026', 'Guadalupe', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (979, 19, '027', 'Los Herreras', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (980, 19, '028', 'Higueras', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (981, 19, '029', 'Hualahuises', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (982, 19, '030', 'Iturbide', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (983, 19, '031', 'Juárez', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (984, 19, '032', 'Lampazos de Naranjo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (985, 19, '033', 'Linares', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (986, 19, '034', 'Marín', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (987, 19, '035', 'Melchor Ocampo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (988, 19, '036', 'Mier y Noriega', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (989, 19, '037', 'Mina', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (990, 19, '038', 'Montemorelos', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (991, 19, '039', 'Monterrey', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (992, 19, '040', 'Parás', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (993, 19, '041', 'Pesquería', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (994, 19, '042', 'Los Ramones', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (995, 19, '043', 'Rayones', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (996, 19, '044', 'Sabinas Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (997, 19, '045', 'Salinas Victoria', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (998, 19, '046', 'San Nicolás de los Garza', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (999, 19, '047', 'Hidalgo', 1);
INSERT INTO `municipios` (`id`, `estado_id`, `clave`, `nombre`, `activo`) VALUES (1000, 19, '048', 'Santa Catarina', 1);
COMMIT;

BEGIN;
INSERT INTO `tienda`.`direcciones` (`id`, `municipio_id`, `calle`, `numero_exterior`, `numero_interior`, `colonia`, `codigo_postal`) VALUES (1, 275, 'PRUEBA', 'N7A', '23', 'prueba', '00000');
INSERT INTO `tienda`.`direcciones` (`id`, `municipio_id`, `calle`, `numero_exterior`, `numero_interior`, `colonia`, `codigo_postal`) VALUES (2, 275, 'PRUEBA', 'N7A', '23', 'prueba', '00000');
INSERT INTO `tienda`.`personas` (`id`, `direccion_id`, `nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `telefono`) VALUES (1, 1, 'Admin', 'Admin', 'Admin', '1991-01-01', '5555555555');
INSERT INTO `tienda`.`users` (`id`, `username`, `email`, `password`, `create_at`, `update_at`, `estatus`) VALUES (1, 'admin', 'admin@gmail.com', '$2a$12$MObkFfu.cnSJTh53Akof4eg4NuxVXvl3.NwX0w9Qye49CFv2KBvB6', '2025-11-19 00:00:00', '2025-11-19 00:00:00', 1);
INSERT INTO `tienda`.`sucursales` (`id`, `direccion_id`, `nombre`, `status`, `creat_at`) VALUES (1, 2, 'Prueba', 1, now());
INSERT INTO `tienda`.`empleados` (`id`, `persona_id`, `sucursal_id`, `usuario_id`, `numero_empleado`, `status`, `creat_at`, `update_at`) VALUES (1, 1, 1, 1, '000001', 1, '2024-12-31', '2025-11-19');
INSERT INTO `tienda`.`users_roles` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `tienda`.`users_roles` (`user_id`, `role_id`) VALUES (1, 2);
INSERT INTO `tienda`.`clientes` (`id`, `nombre`, `email`, `limite`, `estatus`, `create_at`, `update_at`) VALUES (1, 'publico en general', 'publicoGeneral@dominio.com', '0.00', 1, '1991-12-31 21:35:53', NULL);
COMMIT;

