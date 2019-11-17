CREATE DATABASE temp_relaciones_varios_a_varios_cascada CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use temp_relaciones_varios_a_varios_cascada;

create table alumno(
	dni int(8) not null,
    nombre varchar(128),
    PRIMARY KEY (dni)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci; 

create table asignatura(
	codigo_asignatura varchar(5) not null,
	cuat int(8),
    PRIMARY KEY(codigo_asignatura)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

create table matricula(
	dni int(8),
    codigo_asignatura varchar(5),
    PRIMARY KEY(dni,codigo_asignatura),
    FOREIGN KEY (dni) REFERENCES alumno(dni)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (codigo_asignatura) REFERENCES asignatura(codigo_asignatura)
    ON DELETE CASCADE 
    ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

insert into alumno values (11111111,'David Berruezo');
insert into alumno values (11111112,'Carlos Berruezo');
insert into alumno values (11111113,'Sara Berruezo');


insert into asignatura values ('AAAAA',1);
insert into asignatura values ('AAAAB',2);
insert into asignatura values ('AAAAC',3);


insert into matricula values (11111111,'AAAAA');
insert into matricula values (11111111,'AAAAB');
insert into matricula values (11111112,'AAAAC');


# Test delete on cascade
delete from alumno where dni=11111111;
delete from asignatura where codigo_asignatura='AAAAC';
