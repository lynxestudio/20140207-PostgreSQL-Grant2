# Utilizando los comandos GRANT y REVOKE en PostgreSQL - Parte II

<ul>
<li><b>ALL PRIVILEGES:</b> Otorga todos los privilegios al usuario sobre un particular objeto.</li>
<li><b>PUBLIC:</b> En vez de asignar los privilegios a cada usuario (uno por uno) , se utiliza esta palabra para asignar los privilegios a cada uno de los usuarios autentificados en la base de datos, incluso a aquellos que no han sido creados.</li>
</ul>
<p>
Además para el comando GRANT tenemos la opción de:
</p>
<ul>
<li>WITH GRANT OPTION Cuando se crea un objeto en la base de datos, el creador de ese objeto es el único que puede otorgar privilegios al objeto para que otros usuarios lo utilicen, con esta opción el propietario del objeto permite que otros usuarios puedan asignar privilegios a un objeto de sus propiedad.</li>
</ul>
<p>
Mostraré unos ejemplos:
</p>
<p>
<b>ALL PRIVILEGES</b>
</p>
<p>
Primero el uso de <b>GRANT</b> con la opción <b>ALL PRIVILEGES</b>.
</p>
<p>
Mostramos los privilegios del usuario martin en la tabla authors con el comando \z authors
</p>
<div>
<img src="images/fig1.png" width="694" height="401" alt="">
</div>
<p>
Ahora con el usuario postgres (propietario del objeto) le asignamos todos los privilegios al usuario martin. con el siguiente comando:
</p>
<pre>
 GRANT ALL PRIVILEGES ON authors TO martin;
 </pre>
 <img src="images/fig2.png" width="694" height="401" alt="">
<p>
Vuelvo a mostrar todos los privilegios del usuario <b>martin</b> y compruebo que todos los permisos le han sido otorgados.
</p>
<img src="images/fig3.png" width="694" height="401" alt="">
<p>
Para retirar todos los privilegios ejecuto como el usuario postgres el siguiente comando:
</p>
<pre>
REVOKE ALL PRIVILEGES ON authors FROM martin;
</pre>
<img src="images/fig4.png" width="694" height="401" alt="">
<p>
Muestro nuevamente los privilegios de la tabla y compruebo que el usuario <b>martin</b> no tiene ningún privilegio asignado.
</p>
<img src="images/fig5.png" width="694" height="401" alt="">
<h3>PUBLIC</h3>
<p>
Ahora con el usuario postgres ejecuto el siguiente comando
</p>
<pre>
GRANT SELECT ON authors TO PUBLIC;
</pre>
<img src="images/fig6.png" width="694" height="401" alt="">
<p>
El cual otorga el privilegio SELECT a todos los usuarios incluso a aquellos que no se han creado dentro de la DBMS.
</p>
<pre>
GRANT SELECT ON authors TO PUBLIC;
</pre>
<p>
Para comprobar este privilegio ejecuto una consulta SELECT con un usuario llamado docencia, quien no necesito que se le otorgaran privilegios de manera especifica.
</p>
<img src="images/fig8.png" width="723" height="401" alt="">
<h3>WITH GRANT OPTION</H3>
<p>
Únicamente el creador del objeto puede usar el comando GRANT para otorgar privilegios a otros usuarios, sin embargo con la opción WITH GRANT OPTION del comando GRANT puede delegarle la capacidad de otorgarle privilegios sobre su objeto a otros usuarios.
</p>
<p>
Para este ejemplo utilizaremos el script para crear una tabla <i>Books</i>.

Ahora bien, el usuario postgres requiere que el usuario martin tenga los privilegios de SELECT e INSERT, pero que también martin tenga la capacidad de otorgarlos a otros usuarios, ejecutamos los siguientes comandos:
</p>
<pre>
GRANT INSERT, SELECT ON Books TO martin WITH GRANT OPTION;
GRANT UPDATE ON books_bookid_seq TO martin WITH GRANT OPTION;
</pre>
<img src="images/fig9.png" width="723" height="401" alt="">
<p>
Ahora martin tiene la capacidad de poder otorgarle los privilegios a docencia en la tabla y en la secuencia.
</p>
<pre>
GRANT INSERT,SELECT ON Books TO docencia;
</pre>
<pre>
GRANT UPDATE ON books_bookid_seq TO docencia;
</pre>
<img src="images/fig10.png" width="723" height="401" alt="">
<p>
Para que este usuario pueda ahora ejecutar la consulta y la creación de nuevos registros en la tabla.
</p>
<img src="images/fig11.png" width="723" height="401" alt="">