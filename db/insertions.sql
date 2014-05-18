# Usuarios y empleados no se pueden agregar aquí si se quieren accesar dado a que no es la clave lo que se graba en la base de datos, sino el digest.

# catalogs

INSERT INTO catalogs VALUES ( 1, "tecnologia", "proyectores");
INSERT INTO catalogs VALUES ( 2, "plomeria", "tuberias");
INSERT INTO catalogs VALUES ( 3, "logistica", "bancos");
INSERT INTO catalogs VALUES ( 4, "tecnologia", "IT");

# incidents


INSERT INTO incidents VALUES ( 1, 1, NULL, 1, "Proyector esta fallando en A1-304", 20140505, NULL, "ABIERTO", "MEDIA");

INSERT INTO incidents VALUES ( 2, 2, 2, 2, "Lavabos del segundo piso de biblioteca no estan funcionando", 20140510, 20140513, "CERRADO", "BAJA");

INSERT INTO incidents VALUES ( 3, 3, NULL, 3, "Necesitamos mas bancos para mañana en CIAP 602", 20140515, NULL, "ABIERTO", "MEDIA");

INSERT INTO incidents VALUES ( 4, 5, NULL, 4, "El internet no funciona en A3-101", 20140501, NULL, "ABIERTO", "ALTA");

# attempts

INSERT INTO attempts VALUES ( 7, 20140501, 20140501, 4, 4, "No supe como.. sorry!");
INSERT INTO attempts VALUES ( 1, 20140502, 20140502, 1, 4, "Creo que no jala el router mas cercano");
INSERT INTO attempts VALUES ( 2, 20140503, 20140503, 2, 4, "El router no sirve, hay que cambiarlo");


INSERT INTO attempts VALUES ( 3, 20140506, 20140506, 4, 1, "Hay que cambiarle el foco");

INSERT INTO attempts VALUES ( 4, 20140510, 20140511, 1, 2, "La tubería esta rota. Hay que traer otra pieza");
INSERT INTO attempts VALUES ( 5, 20140512, 20140513, 1, 2, "Terminado");

INSERT INTO attempts VALUES ( 6, 20140515, 20140515, 3, 3, "Le diré a logistica.");


