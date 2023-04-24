# Utilizando los comandos GRANT y REVOKE en PostgreSQL - Parte II

Continuando con el post acerca de los comandos GRANT y REVOKE , estos comandos adicionalmente cuentan con las opciones de:

ALL PRIVILEGES Otorga todos los privilegios al usuario sobre un particular objeto.
PUBLIC En vez de asignar los privilegios a cada usuario (uno por uno) , se utiliza esta palabra para asignar los privilegios a cada uno de los usuarios autentificados en la base de datos, incluso a aquellos que no han sido creados.
Además para el comando GRANT tenemos la opción de:

WITH GRANT OPTION Cuando se crea un objeto en la base de datos, el creador de ese objeto es el único que puede otorgar privilegios al objeto para que otros usuarios lo utilicen, con esta opción el propietario del objeto permite que otros usuarios puedan asignar privilegios a un objeto de sus propiedad.
Mostraré unos ejemplos:

ALL PRIVILEGES
Primero el uso de GRANT con la opción ALL PRIVILEGES.

Mostramos los privilegios del usuario martin en la tabla authors con el comando \z authors



Ahora con el usuario postgres (propietario del objeto) le asignamos todos los privilegios al usuario martin. con el siguiente comando:

  GRANT ALL PRIVILEGES ON authors TO martin;
  


Vuelvo a mostrar todos los privilegios del usuario martin y compruebo que todos los permisos le han sido otorgados.



Para retirar todos los privilegios ejecuto como el usuario postgres el siguiente comando:

  REVOKE ALL PRIVILEGES ON authors FROM martin;
  


Muestro nuevamente los privilegios de la tabla y compruebo que el usuario martin no tiene ningún privilegio asignado.



PUBLIC
Ahora con el usuario postgres ejecuto el siguiente comando

  GRANT SELECT ON authors TO PUBLIC;
  
El cual otorga el privilegio SELECT a todos los usuarios incluso a aquellos que no se han creado dentro de la DBMS.

  GRANT SELECT ON authors TO PUBLIC;
  


Para comprobar este privilegio ejecuto una consulta SELECT con un usuario llamado docencia, quien no necesito que se le otorgaran privilegios de manera especifica.



WITH GRANT OPTION
Únicamente el creador del objeto puede usar el comando GRANT para otorgar privilegios a otros usuarios, sin embargo con la opción WITH GRANT OPTION del comando GRANT puede delegarle la capacidad de otorgarle privilegios sobre su objeto a otros usuarios.

Para este ejemplo creo una tabla llamada books con el usuario postgres

  create table Books
(
        bookid serial not null primary key,
        isbn varchar(13) not null,
        title varchar(512) not null,
        numpages integer null,
        year smallint not null
);
  
Ahora bien, el usuario postgres requiere que el usuario martin tenga los privilegios de SELECT e INSERT, pero que también martin tenga la capacidad de otorgarlos a otros usuarios, ejecutamos los siguientes comandos:

  GRANT INSERT, SELECT ON Books TO martin WITH GRANT OPTION;

  GRANT UPDATE ON books_bookid_seq TO martin WITH GRANT OPTION;
  


Ahora martin tiene la capacidad de poder otorgarle los privilegios a docencia en la tabla y en la secuencia.

   GRANT INSERT,SELECT ON Books TO docencia;

   GRANT UPDATE ON books_bookid_seq TO docencia;
   


Para que este usuario pueda ahora ejecutar la consulta y la creación de nuevos registros en la tabla.

