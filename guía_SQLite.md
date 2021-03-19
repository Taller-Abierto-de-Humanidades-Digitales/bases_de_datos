# Guía SQLite


# Tipos de datos en SQLite

- NULL -> Valor vacío o nulo
- INTEGER -> Valor de número entero, positivo o negativo
- REAL -> Valor de número decimal.
- TEXT -> Valor de texto, correspondiente al `encoding` de la base de datos (p. ej. UTF-8)
- BLOB -> Archivos almacenados como binarios.


# Esquema de la base de datos

<img src="images\esquema_db.jpg">


# Crear una base de datos en SQLite3

```sql
sqlite3 bibliografia_hd.db
```

# Crear tablas

```
CREATE TABLE IF NOT EXISTS autores (
    id_autores INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100) NOT NULL,
    nacionalidad TEXT
)
```

> ¿Qué tabla crear a continuación?

Creamos la tabla vinculada a `obras` pero que no contiene ninguna clave foránea

```
CREATE TABLE IF NOT EXISTS tipos_de_obras (
    id_tdo INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo TEXT
)
```

> Crear una tabla relacionada. Relación muchos a uno (muchas obras = un autor y un tipo)

```
CREATE TABLE IF NOT EXISTS obras (
    id_obra INTEGER PRIMARY KEY AUTOINCREMENT,
    id_autores INTEGER,
    id_tdo INTEGER NOT NULL,
    titulo VARCHAR(100),
    lenguaje VARCHAR(10),
    FOREIGN KEY (id_autores) REFERENCES autores(id_autores) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tdo) REFERENCES tipos_de_obras(id_obras) ON DELETE SET NULL ON UPDATE CASCADE
)
```

# Insertar y leer información

> Sintáxis básica

* Escribir

```
INSERT INTO tabla (columna1, columna2) VALUES ('valor 1a', 'valor 2a'), ('valor 1b', 'valor 2b')
```

* Leer

```
SELECT * FROM columna WHERE columna = 1
```

> Crear lista de autores:

```
INSERT INTO autores (nombre, apellido, nacionalidad)
VALUES
("Alan", "Liu", "USA"),
("Ian", "Milligan", "Canada"),
("Franco", "Moretti", "Italia"),
("Dominique", "Vinck", "Francia"),
("Anaclet", "Pons", "España")
```

> Comprobar que la información haya sido guardada

```
SELECT * FROM autores
```

> Crear una serie de tipos de obras

```
INSERT INTO tipos_de_obras (tipo)
VALUES
("Ensayo"),
("Manual"),
("Resultado de investigación")
```

> Teniendo los id_autores y id_tdo creados, podemos proceder a ingresar la información de las obras.
Para no hacer este ingreso de información manual, podemos crear una regla que facilite la recuperación de las fuentes foráneas.

```
INSERT INTO obras (id_autores, id_tdo, titulo, lenguaje)
VALUES
((SELECT autores.id_autores FROM autores WHERE autores.apellido = "Moretti"), (SELECT tipos_de_obras.id_tdo FROM tipos_de_obras WHERE tipos_de_obras.tipo = "Ensayo"), "Lectura distante", "es"),
((SELECT autores.id_autores FROM autores WHERE autores.apellido = "Vinck"), (SELECT tipos_de_obras.id_tdo FROM tipos_de_obras WHERE tipos_de_obras.tipo = "Ensayo"), "Humanidades Digitales", "es"),
((SELECT autores.id_autores FROM autores WHERE autores.apellido = "Milligan"), (SELECT tipos_de_obras.id_tdo FROM tipos_de_obras WHERE tipos_de_obras.tipo = "Manual"), "History in the Age of Abundance", "en"),
((SELECT autores.id_autores FROM autores WHERE autores.apellido = "Liu"), (SELECT tipos_de_obras.id_tdo FROM tipos_de_obras WHERE tipos_de_obras.tipo = "Ensayo"), "Friending the Past", "en")
```

> Comprobar que la información ha sido guardada correctamente

```
SELECT *  FROM obras
```

# Realizar una búsqueda en múltiples tablas de la base de datos

> Búsqueda: Recuperar el autor y el tipo de obra del título "Humanidades Digitales"

```
SELECT autores.apellido, autores.nombre, obras.titulo, tipos_de_obras.tipo FROM autores, obras, tipos_de_obras WHERE obras.titulo = "Humanidades Digitales" AND autores.id_autores = obras.id_autores AND tipos_de_obras.id_tdo = obras.id_tdo
```

> Podemos hacer la misma búsqueda pero buscando por parte de la palabra del título usando 'expresiones regulares'

Por ejemplo, buscar títulos que inicien con "Hum"

```
WHERE obras.titulo LIKE "Hum%"
```

O palabras que contenga la expresión "dig"

```
WHERE obras.titulo LIKE "%dig%"
```

Y en caso de querer limitarlo, por ejemplo, a las obras en español, añadimos esa condición con el operador lógico AND

```
WHERE obras.titulo LIKE "%dig%" AND obras.lenguaje LIKE "es%"
```

# Añadir una columna a la tabla

> En la tabla `obras` añadiremos la columna "subtítulo"

```
ALTER TABLE obras ADD COLUMN subtitulo TEXT
```

# Actualizar la tabla para que incluya la nueva información

> Una forma relativamente segura de actualizar la información de la tabla es la siguiente:

```
UPDATE obras SET subtitulo = "How the web is transforming historical research" WHERE titulo = "History in the Age of Abundance"
```

> Modificar una tabla basándose en reglas (*solamente como referencia*)

```
UPDATE obras SET id_autores = (SELECT autores.id_autores FROM autores WHERE autores.apellido = "Liu") WHERE obras.titulo = "Friending the Past"
```

# Eliminar tabla

De manera similar a la forma de crear tablas:

```
DROP TABLE IF EXISTS demo 
```

