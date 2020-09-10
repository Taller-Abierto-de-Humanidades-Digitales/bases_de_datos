#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import csv
from time import strftime
from funciones import navegador_pantallas
from funciones import obtener_elemento
from funciones import obtener_href_desc
from funciones import obtener_elemento_fecha
from funciones import obtener_elemento_lugardoc
from funciones import bsopa
from funciones import limpiadatos

local = os.getcwd()
vtiempo = strftime("%d-%m-%Y_%H-%M-%S")


base_url = "http://pares.mcu.es"

'''
Modifique estas variables para cambiar la ruta de búsqueda y el nombre del archivo.
'''

url_busqueda = "http://pares.mcu.es/ParesBusquedas20/catalogo/find?nm=&fraseExacta=Diario+de+navegaci%C3%B3n&archivo=10&digitalizado=S"
nombre_archivo_csv = "diario_de_navegacion"

'''
Selectores de contenido
'''

titulo = "#wrapper_ficha > div > div:nth-child(2) > p"
signatura = "#wrapper_ficha > div > div:nth-child(3) > p"
fecha_creacion = "#wrapper_ficha > div > div:nth-child(4) > p"
alcanceycontenido = "#fichaIsad > div:nth-child(3) > div > p"
archivo = "#nombre_archivo > a:nth-child(1)"
enlace_imgs = "#enlace_imagenes > a"

'''
Listas para crear el csv
'''
ident = []
texto_titulo = []
texto_signatura = []
texto_fecha_creacion = []
texto_lugar_documento = []
texto_alcanceycontenido = []
texto_archivo = []
enlace_documento = []

'''
Loop para llenar los listados
'''
resultado = navegador_pantallas(url_busqueda)

for i in range(len(resultado)):
    ident.append(str(i))


for h in resultado:
    full_url = base_url + h
    sopa = bsopa(full_url)
    print("obteniendo resultados de " + full_url)
    texto_titulo.append(obtener_elemento(sopa, titulo))
    texto_signatura.append(obtener_elemento(sopa, signatura))
    texto_fecha_creacion.append(obtener_elemento_fecha(sopa, fecha_creacion))
    texto_lugar_documento.append(
        obtener_elemento_lugardoc(sopa, fecha_creacion))
    texto_alcanceycontenido.append(obtener_elemento(sopa, alcanceycontenido))
    texto_archivo.append(obtener_elemento(sopa, archivo))
    try:
        enlace_documento.append(obtener_href_desc(sopa, enlace_imgs, base_url))
    except UnboundLocalError:
        enlace_documento.append("")


'''
Limpiar datos
'''

texto_fecha_creacion = limpiadatos(texto_fecha_creacion)
texto_lugar_documento = limpiadatos(texto_lugar_documento)
texto_signatura = limpiadatos(texto_signatura)
texto_archivo = limpiadatos(texto_archivo)

'''
Crear el archivo csv: se eliminarán los archivos que contengan el mismo nombre.
'''

nombre_csv = '{}/data/{}{}.csv'.format(local, nombre_archivo_csv, vtiempo)

if os.path.exists(nombre_csv):
    os.remove(nombre_csv)

with open(nombre_csv, "w", newline="") as csv_file:
    fieldnames = ['id', 'titulo', 'fecha', 'lugar_creacion_documento', 'signatura',
                  'archivo', 'alcance_y_contenido', 'url']
    writer_h = csv.DictWriter(csv_file, fieldnames=fieldnames)
    writer_h.writeheader()
    writer = csv.writer(csv_file)
    print("creando archivo csv")
    writer.writerows(zip(ident, texto_titulo, texto_fecha_creacion, texto_lugar_documento, texto_signatura,
                         texto_archivo, texto_alcanceycontenido, enlace_documento))
