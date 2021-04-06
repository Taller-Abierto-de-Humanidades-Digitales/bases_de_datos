# Principios de XML para el modelado de datos

XML es un lenguaje de marcado similar a HTML que, a diferencia de este último, no tiene etiquetas predefinidas; es decir, cada usuario "modela" las etiquetas y su estructura en cada documento. Esto hace que sea un sistema sumamente flexible, pero a la vez, exige mayor cuidado de la estructura que HTML. 

## ¿Dónde practicar?

Al igual que HTML, XML puede ser escrito en un procesador de texto plano o en un editor de código. Sin embargo, los elementos de XML deben estar *bien formados* para poder interpretarse, por lo que es preferible utilizar un editor que pueda controlar la estructura del documento.

Un editor ampliamente utilizado es [Oxygen](https://www.oxygenxml.com/), ya que permite realizar la anterior tarea de manera guiada y, además, puede incorporar esquemas de gran complejidad, como TEI. El gran inconveniente de *Oxygen* es que es una herramienta propietario y de pago, por lo que es muy práctica para trabajar en proyectos con un presupuesto asignado a la adquisición de licencias de software, pero no tanto para ejercicio individuales o experimentaciones.

En la actualidad existen muy buenas aplicaciones en línea que facilitan la comprobación básica de XML para saber si está bien formado. Una de ellas es https://www.xmlviewer.org/, la cual permite validar el código, mostrar vistas de árbol y transformar el código XML en JSON.

# Sintaxis

La sintaxis de XML es similar a la de HTML:

> <miEtiqueta>mi texto</miEtiqueta>

No obstante, XML depende de dos cosas.

1. Que el documento esté "bien formado". Es decir, que toda etiqueta se cierre a sí misma:

```xml
<libro>
    <páginas>
        <párrafos>
            <oración>Este es un texto en HTML</oración>
        </párrafos>
    </páginas>
</libro>
```

Esta estructura se suele simbolizar como un árbol de etiquetas en las que se jerarquizan semánticamente. De allí se deriva la segunda regla.

2. El documento XML, para ser válido, debe cumplir con unas reglas semánticas definidas en un esquema XML. Hay varios lenguajes para definir un esquema XML, siendo DTD y XSD las más utilizadas (en especial esta última). Un ejemplo de un esquema XSD para el ejemplo anterior sería el siguiente:

```xsd
<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="libro">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs="0" name="páginas">
          <xs:complexType>
            <xs:sequence>
              <xs:element minOccurs="0" name="párrafos">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element minOccurs="0" name="oración" type="xs:string" />
                  </xs:sequence>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>
```

Como verás, un esquema XSD es en esencia una declaración de la jerarquía de las etiquetas y del tipo de datos que estas pueden contener (por ejemplo, texto para el elemento oración `<xs:element minOccurs="0" name="oración" type="xs:string" />`) Que el archivo XML tenga un esquema es fundamental, pero XSD es un lenguaje en sí mismo, con su propia sintaxis y [elementos](https://www.w3schools.com/xml/schema_elements_ref.asp). Una forma práctica para construir estos esquemas es a través de sistemas automatizados, por ejemplo https://www.liquid-technologies.com/online-xml-to-xsd-converter o en el mismo [Oxygen](https://www.oxygenxml.com/xml_editor/xml_schema_editor.html).


## XSL Transformer

Antes de poder ver el código XML correctamente transformado, es necesario ejecutar la trasformación. Hay varias herramientas para hacer este proceso, algunas más complejas que otras. En línea podemos utilizar el sitio https://www.freeformatter.com/xsl-transformer.html que nos genera un XML transformado que podemos guardar como Web.

Obviamente transformaciones más complejas demandan programación más específica, pero para un ejercicio inicial es una buena opción.
