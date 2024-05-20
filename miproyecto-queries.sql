-- 1. Mostrar los nombres de los equipos y el número total de goles marcados por cada uno en todos los partidos. 
select e.nombre_equipo, SUM(g.minuto) as goles_marcados
from equipo e inner join fichajes f
on e.nombre_equipo = f.EQUIPO_nombre_equipo inner join jugador j
on f.JUGADOR_dni = j.dni inner join gol g
on j.dni = g.jugador_marca
group by e.nombre_equipo
order by goles_marcados desc;


-- 2. Obtener el nombre del estadio y la cantidad total de partidos jugados en ese estadio
select nombre_estadio, count(*) as total_partidos
from estadio e left join juegan j
on e.nombre_estadio = j.ESTADIO_nombre_estadio left join partido p 
on j.EQUIPO_nombre_equipo = p.EQUIPO_nombre_local or j.EQUIPO_nombre_equipo = p.EQUIPO_nombre_visitante 
group by nombre_estadio;

-- 3. Obtener los arbitros que han arbitrado mas que la media de los partidos arbitrados
select a.id_arbitro, a.nombre, a.apellidos, count(p.id_partido) as partidos_arbitrados
from arbitro a inner join partido p
on a.id_arbitro = p.ARBITRO_id_arbitro
group by a.id_arbitro, a.nombre, a.apellidos
having count(p.id_partido) > (
   select count(p2.id_partido) / count(distinct p2.ARBITRO_id_arbitro)
   from partido p2
);


-- 4. Obtener la cantidad de partidos jugados por cada equipo en una temporada específica y el resultado de cada partido
select nombre_equipo, t.nombre_temporada, count(p.id_partido) as Partidos_jugados, group_concat(p.resultado) as Resultados  
from equipo e inner join partido p 
on e.nombre_equipo = p.EQUIPO_nombre_local or e.nombre_equipo = p.EQUIPO_nombre_visitante inner join temporada t 
on p.TEMPORADA_nombre_temporada = t.nombre_temporada 
group by nombre_equipo , nombre_temporada;

-- 5. Obtener la cantidad de goles marcados por cada jugador en una temporada
select nombre, nombre_temporada, count(g.jugador_marca) as Goles_marcados 
from jugador j inner join gol g 
on j.dni = g.jugador_marca inner join partido p 
on g.PARTIDO_id_partido = p.id_partido inner join temporada t 
on p.TEMPORADA_nombre_temporada = t.nombre_temporada 
group by j.dni, t.nombre_temporada ;

-- Primera vista
create view primera as
	select e.nombre_equipo, SUM(g.minuto) as goles_marcados
	from equipo e inner join fichajes f
	on e.nombre_equipo = f.EQUIPO_nombre_equipo inner join jugador j
	on f.JUGADOR_dni = j.dni inner join gol g
	on j.dni = g.jugador_marca
	group by e.nombre_equipo
	order by goles_marcados desc;

-- Segunda vista
create view segunda as 
	select nombre_estadio, count(*) as total_partidos
	from estadio e left join juegan j
	on e.nombre_estadio = j.ESTADIO_nombre_estadio left join partido p 
	on j.EQUIPO_nombre_equipo = p.EQUIPO_nombre_local or j.EQUIPO_nombre_equipo = p.EQUIPO_nombre_visitante 
	group by nombre_estadio;

-- Esta funcion toma el nombre del equipo como parámetro y devuelve la edad media de los jugadores del equipo
delimiter $$
create function edadMediaEquipo(nombre_equipo varchar(25))
returns decimal(10, 2)
begin
    declare edad_total decimal(10, 2);
    declare cantidad_jugadores int;
    
    select sum(year(curdate()) - year(fecha_nacimiento)) into edad_total
    from jugador
    where dni in (select jugador_dni from fichajes where equipo_nombre_equipo = nombre_equipo);
    
    select count(*) into cantidad_jugadores
    from fichajes
    where equipo_nombre_equipo = nombre_equipo;
    
    return edad_total / cantidad_jugadores;
end $$
delimiter ;

select edadMediaEquipo("Real Betis");

-- Esta funcion toma el id del arbitro y devuelve el número de partidos que ha arbitrado ese árbitro
delimiter $$
create function numeroPartidosArbitrados(arbitro_id int) returns int
begin
    declare num_partidos int;
    
    select count(*) into num_partidos
    from arbitro
    where id_arbitro = arbitro_id;
    
    if num_partidos > 0 then
        select count(*)
        into num_partidos
        from partido
        where arbitro_id_arbitro = arbitro_id;
        return num_partidos;
    else
        return null; 
    end if;
end $$
delimiter ;

select numeroPartidosArbitrados(5);

-- Procedimiento para seleccionar el nombre de los equipos, el nombre del entrenador y la cantidad de jugadores que tiene cada equipo
delimiter $$
create procedure consultarEquipos()
begin
    select 
        equipo.nombre_equipo,
        equipo.entrenador,
        count(jugador.dni) as cantidad_jugadores
    from 
        equipo
    left join 
        fichajes on equipo.nombre_equipo = fichajes.equipo_nombre_equipo
    left join 
        jugador on fichajes.jugador_dni = jugador.dni
    group by 
        equipo.nombre_equipo, equipo.entrenador;
end $$
delimiter ;

call consultarequipos();

-- Procedimiento que utiliza un cursor y muestra 5 estadios
delimiter $$
create procedure mostrarEstadios()
begin
    declare done int default false;
    declare estadio_nombre varchar(55);

    declare estadios_cursor cursor for 
        select nombre_estadio from estadio limit 5;

    declare continue handler for not found set done = true;

    open estadios_cursor;

    mostrar_loop: loop
        fetch estadios_cursor into estadio_nombre;

        if done then
            leave mostrar_loop;
        end if;

        select concat('Estadio: ', estadio_nombre) as mensaje;
    end loop;

    close estadios_cursor;
end $$
delimiter ;

call mostrarEstadios();

-- Procedimiento en el que se utiliza la funcion 'edadMediaEquipo' en el que se calcula la edad media del equipo que juega en el estadio que se recibe como parametro
delimiter $$
create procedure calcularEdadMediaEquipoEnEstadio(in nombre_estadio varchar(20))
begin
    declare nombre_equipo_en_estadio varchar(25);
    declare edad_media decimal(10, 2);
    
    select equipo_nombre_equipo into nombre_equipo_en_estadio
    from juegan
    where estadio_nombre_estadio = nombre_estadio;
    
    set edad_media = edadmediaequipo(nombre_equipo_en_estadio);

    select concat('La edad media de los jugadores del equipo que juega en el estadio ', nombre_estadio,' es: ', edad_media, ' años') as resultado;
end $$
delimiter ;

call calcularEdadMediaEquipoEnEstadio('Benito Villamarín');



-- Creamos un trigger que al insertar un jugador, en una nueva tabla "registro" se guardara si se ha insertado correctamente
create table registro (
  forma varchar(25) primary key
);

delimiter $$
create trigger registro_insert
after insert on jugador
for each row
begin
    insert into registro (forma)
    values ('insertado correctamente');
end $$
delimiter ;

insert into jugador (dni, nombre, apellidos, fecha_nacimiento, telefono)
values ('45672341f', 'Juan', 'Pérez', '1990-05-15', '098765432');

-- Creamos un trigger en el que despues de insertar un estadio, esa inserccion se guarda en una nueva tabla (insertados)
create table insertados (
  nombre_estadio varchar(20) primary key,
  ciudad varchar(20),
  telefono varchar(10)
);

delimiter $$
create trigger before_estadio_insert
before insert on estadio
for each row
begin
    insert into insertados (nombre_estadio, ciudad, telefono) values (new.nombre_estadio, new.ciudad, new.telefono);
end $$
delimiter ;

insert into estadio (nombre_estadio, ciudad, telefono) values ('La Rosaleda', 'Malaga', '123456789');

