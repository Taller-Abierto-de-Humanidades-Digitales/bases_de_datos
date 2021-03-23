# Bases de HTML

HTML es un lenguaje de marcado que representa la base de la representación de la información en la Web. Sin temor a exagerar, toda la información disponible en la Web se muestra a través de etiquetas HTML.

## Algunas características de HTML

* HTML no es un lenguaje dinámico de programación. Es decir, no es posible hacer operaciones automáticamente ni programar tareas.

* Este lenguaje se enfoca en dos aspectos: modelar y enlazar información.

* HTML permite modelar de manera básica la información a través de etiquetas que indican estructuras del contenido de una página Web (por ejemplo `<h1>` para representar el título -header- de primer nivel).

* Enlaza diferentes sitios gracias a la creación de hipervínculos (links)

* Los elementos diferentes a texto (imágenes, videos, scripts, estilos, entre otros) se incrustan (embed) en la página Web, siendo el navegador el encargado de visualizarlos correctamente.

* Básicamente, un navegador es un interpretador del código HTML.


## ¿Por qué es importante conocer sobre HTML para modelar datos?

Aunque los datos son modelados en XML o JSON, al final del día serán visualizados dinámicamente a través de etiquetas HTML. Por otra parte, la escritura de HTML es muy parecida a XML (comparten un ancestro común, el lenguaje SGML). Además, es un lenguaje sumamente sencillo de aprender, por lo que nunca está de más estar familiarizado con él.


# Crear un archivo HTML

Un archivo HTML puede ser creado desde cualquier procesador de texto plano o editor de código. También existen sitios como https://codepen.io/ donde puedes escribir HTML y visualizar lo que escribes de manera dinámica.

HTML es un lenguaje basado en etiquetas, cada una de las cuales le dice al navegador cómo interpretar el texto. Estas se escriben rodeadas por corchetes angulares (`<`, `>`). La sintáxis básica de HTML es la siguiente:

``` <etiqueta>texto</etiqueta> ```

Para crear tu primer código HTML simplemente deberás escribir lo siguiente:

```html
<!DOCTYPE html>
<html>

</html>
```

Y guardar el archivo con la extensión `.html`. 

En este momento, obviamente, el documento está vacío, por lo que al abrirlo solamente mostrará una pantalla en blanco. Así que, empecemos a construir nuestro pequeño sitio Web.

## Estructura básica de un documento HTML

Además de la etiqueta `<html>` hay otras dos etiquetas fundamentales en cada página web:

* `<head>`: En la que se incluyen los metadatos, scripts y hojas de estilos añadidos a la página Web.
* `<body>`: En la que se inserta la información que será visualizada en el sitio Web.

Incluyamos estas etiquetas en nuestro anterior código. Y aprovechemos para incluir el título de la página:

```html
<!DOCTYPE html>
<html>
<head>
<title>Este es el título de la página</title>
</head>
<body>
Este es el cuerpo de la página
</body>
</html>
```

## Definir encoding

Si abriste el ejemplo anterior en un navegador habrás notado que las tildes se representan de manera incorrecta (`pÃ¡gina`). Esto se debe a que no hemos declarado la codificación propia de HTML para representar correctamente estos caracteres. Para ello, debemos incluir una etiqueta en la sección `<head>` que especifique que usamos la codificación 'UTF-8':

```html
<meta charset="UTF-8">
```

Como verás, los textos ya se muestran correctamente.

## Definir el idioma

Otro aspecto importante consiste en definir el idioma del sitio, lo que ayuda tanto a humanos como a buscadores a identificar la lengua principal del texto. Para ello simplemente declaramos el idioma general del sitio como un atributo de la etiqueta `<html>`

```html
<html lang="es">
```

Si quisieramos una variante más específica podríamos indicarla siguiendo el esquema de subetiquetas del [IANA](http://www.iana.org/assignments/language-subtag-registry/language-subtag-registry); por ejemplo: `es-MX`.


## Etiquetado básico de un texto

En HTML un texto es básicamente un conjunto de encabezados y párrafos. Por ejemplo:

```html
<h1>Este es un título</h1>
<h2>Este es un subtítulo</h2>
<p>Este es un párrafo. El cual puede continuar eternamente a menos que lo rompamos con una etiqueta <br /> break.</p>
```

HTML presenta el texto según el formato que demos en las etiquetas. Por esta razón, el código de arriba se presenta en el navegador igual que el siguiente código:

```html
<h1>Este es un título</h1>
<h2>Este es un subtítulo</h2>
<p>Este es un párrafo. 
    El cual puede continuar eternamente 
    a menos que lo rompamos con una 
    etiqueta <br /> break.</p>
```

De hecho, se representa igual que si lo escribiéramos así:

```html
<h1>Este es un título</h1><h2>Este es un subtítulo</h2><p>Este es un párrafo. El cual puede continuar eternamente a menos que lo rompamos con una etiqueta <br /> break.</p>
```

Las etiquetas le dicen al navegador cómo mostrar el contenido del sitio HTML, independientemente de cómo las escribamos. Por esta razón es útil escribir con ciertos criterios que hagan legible el código a todos aquellos que quieran revisarlo.

## Formato básico

HTML contiene una serie de elementos que permiten formatear el texto. Podemos verlo en el siguiente párrafo:

```html
<p>
    Podemos formatear el texto para que esté en <b>negrilla</b>, o en <i>itálica</i>.
    También se puede establecer que un texto es <strong>importante</strong>. 
    Si queremos, lo hacemos <small>pequeño</small>. <br />
    Otro elemento ampliamente usado es el subíndice, como en H<sub>2</sub>O. 
    De igual manera el superíndice, como en m<sup>2</sup>.
</p>
```

## Enlaces 

Una de las características fundamentales del HTML es su capacidad de enlazar diferentes sitios. Esta idea se resume en el concepto de *hipertexto*.

<img src="https://upload.wikimedia.org/wikipedia/commons/4/41/Sistema_hipertextual.jpg">

El hipertexto se construye a través de hiperenlaces con los cuales se conecta una porción de texto (por lo general una palabra o imagen) con un sitio u objeto.

Por ejemplo, construyamos un enlace para conectarnos con el *taller abierto de humanidades digitales*. La etiqueta para indicar un enlace es `<a>`, y el enlace se indica a través de atributo `href`:

```html
<a href="https://github.com/Taller-Abierto-de-Humanidades-Digitales">Taller abierto de humanidades digitales</a>
```

Podemos añadir un atributo adicional para indicar el *destino* de la página. Por ejemplo, si queremos que el sitio abra en otra ventana usamos el atributo `target` y el valor `_blank`:

```html
<a href="https://github.com/Taller-Abierto-de-Humanidades-Digitales" target="_blank">Taller abierto de humanidades digitales</a>
```

# Imágenes

Las imágenes son objetos muy sencillos de incorporar en HTML. Para ello existe la etiqueta `<img>` y el atributo `src` para determinar el origen.

Por ejemplo, podemos insertar una imagen directamente guardada en el servidor en el directorio `/imgs/`:

```html
<img src="imgs/HTML_img.jpg">
```

O directamente de una dirección URL

```html
<img src="https://github.com/Taller-Abierto-de-Humanidades-Digitales/bases_de_datos/blob/master/ejemplos/imgs/HTML_img.jpg">
```

Con este ejemplo, deberías poder mostrar en tu página la siguiente imagen:

<img src="https://github.com/Taller-Abierto-de-Humanidades-Digitales/bases_de_datos/blob/master/ejemplos/imgs/HTML_img.jpg">

Para cambiar el tamaño de la imagen podemos definir el ancho y el alto de esta con los parámetros `width` y `height`.

Estos deben usarse con precaución para no distorsionar la imagen. Por ejemplo, si usamos el siguiente parámetro, la imagen tendrá un ancho de 800px:

```html
<img src="imgs/HTML_img.jpg" width="800">
```

<img src="https://github.com/Taller-Abierto-de-Humanidades-Digitales/bases_de_datos/blob/master/ejemplos/imgs/HTML_img.jpg" width="800">

Pero si lo hacemos de la siguiente manera, incluyendo un alto de 200px, la imagen se distorsionará completamente:

```html
<img src="imgs/HTML_img.jpg" width="800" height="200">
```
<img src="https://github.com/Taller-Abierto-de-Humanidades-Digitales/bases_de_datos/blob/master/ejemplos/imgs/HTML_img.jpg" width="800" height="200">


# Introducción a los estilos en HTML (CSS) 

A través del atributo `style` es posible añadir una gran cantidad de propiedades a un elemento HTML (incluyendo la etiqueta `<body>`)

Por ejemplo, cambiemos el fondo de la página. HTML soporta [140 nombres de colores estándar](https://www.w3schools.com/colors/colors_names.asp), pero la gama se amplía significativamente si se tiene en cuenta que podemos incluir cualquier tono con valores RGB, HEX, RGBA, HSL o HSLA.

Por ejemplo, modifiquemos el fondo de la página. Para ello, agreguemos el valor del color al atributo `style` en la etiqueta `body`

```html
<body style="background-color: azure;">
```

De la misma manera, podemos modificar cualquier elemento HTML, por ejemplo, el título:

```html
<h1 style="color: rgba(165,89,89,.7);">Este es un título</h1>
```

Asimismo, podemos incluir varios parámetros dentro del atributo `style` simplemente separándolos por puntos y comas (`;`). Por ejemplo, centrar el texto del título:

```html
<h1 style="color: rgba(165,89,89,.7); text-align: center;">Este es un título</h1>
```

Otra forma de asignar el estilo global de un sitio, en lugar de determinar el estilo de cada etiqueta de manera individual, es a través de una cascada de estilos (*CSS*). Por ejemplo, para modificar el estilo del subtítulo y del texto en los párrafos, podemos modificar las etiquetas globalmente desde el grupo `<head>` así:

```html
<head>
    <style>
        h2 {text-align: center; color: brown;}
        p {text-align: justify; font-family: Verdana, Geneva, Tahoma, sans-serif;}
    </style>
<head>
```

# Tablas

Las tablas son elementos fundamentales para presentar información estructurada en HTML. Estas vienen definidas predeterminadamente por la etiqueta `<table>`. Las filas se forman con la etiqueta `<tr>` y las columnas son subgrupos de las filas representadas con la etiqueta `<td>` o `<th>` en caso de ser encabezados de la tabla.

En ese sentido, la estructura de la tabla es como sigue:

```html
<table>
    <tr>
        <td>
        </td>
    </tr>
</table>
```

Así, si por ejemplo queremos representar una tabla con autores, títulos y lenguajes tendremos que hacerlo de la siguiente manera:

```html
<table>
    <tr>
        <th>Autores</th>
        <th>Títulos</th>
        <th>Lenguajes</th>
    </tr>
    <tr>
        <td>Alan Liu</td>
        <td>Friending the Past</td>
        <td>inglés</td>
    </tr>
    <tr>
        <td>Patrick Juola y Stepehn Ramsay</td>
        <td>Six Setembers</td>
        <td>inglés</td>
    </tr>
    <tr>
        <td>Anaclet Pons</td>
        <td>El desorden digital</td>
        <td>español</td>
    </tr>
</table>
```

Las tablas son estructuras ampliamente utilizadas en la Web, pero como habrás notado, son difíciles de escribir y de leer en HTML. Aunque cuando son interpretadas por el navegador son fáciles de visualizar.

Las tablas también aceptan estilos. Podemos hacer más legible nuestra tabla si agregamos a la lista de atributos CSS los siguientes parámetros:

```css
    table {width: 600px; border: 1px solid black;}
    th {background-color: cornsilk; color: darkblue; text-align: center; border: 1px dotted grey;}
    td {border: 1px dotted grey; text-align: center;}
```

Con el parámetro `width` determinamos el ancho de la tabla. `border` nos permite establecer el ancho de la línea en pixeles, el estilo (`solid`, `dotted`) y el color.

# La etiqueta `<div>`

Los bloques organizados en las etiquetas `<div>` son ampliamente utilizados porque permiten definir secciones específicas dentro de un documento HTML. En términos simples, un `<div>` es un contenedor para otros elementos HTML, que pueden ser estilizados con *CSS* o manipulados mediante *JAvaScript*

Por ejemplo, podemos hacer un div para distinguir los elementos que hemos añadido hasta ahora:

```html
<div>
    <h2>Este es el encabezado de mi div</h2>
    <p>Y este párrafo está dentro del div :D</p>
</div>
```

Hasta ahora lo que hay contenido en el `div` hereda los estilos que hemos declarado en el `style`. Pero podemos modificar eso si incluimos una *clase* que incluya solamente a este div. Para ello, creamos una clase en el elemento `style` y la asociamos con el `div` que acabamos de crear:

```html
<head>
<style>
    .div_estilo {
        background-color: honeydew;
        align-items: center;
        width: 700px;
        height: 300px;
        margin-top: 15px;
        padding-top: 15px;
        border: 2px solid black;
    }

    .div_estilo h2 {
        color: black;
    }

    .div_estilo p {
        font-style: italic;
        color: gray;
        text-align: center;
        font-size: 16px;
        font-family: cursive;
    }
</style>
</head>
<body>
<div class="div_estilo">
    <h2>Este es el encabezado de mi div</h2>
    <p>Y este párrafo está dentro del div :D</p>
</div>
</body>
```

Al incluir estos cambios, el `div` ya se diferencia del resto del sitio.

# Conclusión

Con estas pocas etiquetas es posible construir un sitio Web con algo de imaginación, pero, sobre todo, de identificar una forma de modelar información. Puedes ver el documento HTML que hemos construido en el siguiente enlace: https://github.com/Taller-Abierto-de-Humanidades-Digitales/bases_de_datos/blob/master/ejemplos/ejemploHTML.html

Una página en sí misma puede ser diseñada con elementos semánticos que den cuenta de la posición de un elemento en su conjunto. Etiquetas como `<article>` pueden definir contenido independiente o auto-contenido dentro de un sitio Web; por ejemplo, las entradas de un blog. 

<img src="https://www.w3schools.com/html/img_sem_elements.gif">

Podría ser posible incluso modelar la información a partir de clases y atribuciones en divs, pero con esto tendríamos el inconveniente de no ajustarnos a un esquema o estándar. Por ello, para modelar semánticamente un texto u otros contenidos, las alternativas mas utilizadas son `XML` y `JSON`.