CREATE TABLE users(
  user_id int,
  name varchar(255) not null,
  mail varchar(255) not null,
  password_digest varchar(255) not null,
  PRIMARY KEY(user_id)
);

CREATE TABLE employees(
  employee_id int,
  name varchar(255) not null,
  mail varchar(255) not null,
  password_digest varchar(255) not null,
  PRIMARY KEY(employee_id)
);

CREATE TABLE catalogs(
  catalog_id int,
  area varchar(255),
  name varchar(255),
  PRIMARY KEY(catalog_id)
);

CREATE TABLE incidents(
  incident_id int,
  u_id int not null,
  encargado int DEFAULT null,
  catalog int DEFAULT null,
  descripcion varchar(1023) not null,
  fecha_inicio date, 
  fecha_final date DEFAULT null,
  estado char(15) not null DEFAULT 'ABIERTO'
    CHECK(estado in ('ABIERTO', 'OCUPADO', 'TERMINADO')),
  prioridad char(10) not null DEFAULT 'MEDIA'
    CHECK(prioridad in ('ALTA', 'BAJA', 'MEDIA')),
  PRIMARY KEY(incident_id),
  FOREIGN KEY(u_id) REFERENCES users(user_id),
  FOREIGN KEY(encargado) REFERENCES employees(employee_id),
  FOREIGN KEY(catalog) REFERENCES catalogs(catalog_id)
);

CREATE TABLE attempts(
  attempt_id int,
  fecha_inicio date,
  fecha_final date DEFAULT null,
  e_id int not null,
  i_id int not null,
  comentario varchar(1023) not null,
  PRIMARY KEY(attempt_id),
  FOREIGN KEY(e_id) REFERENCES employees(employee_id),
  FOREIGN KEY(i_id) REFERENCES incidents(incident_id)
);

