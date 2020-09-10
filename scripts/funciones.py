#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import requests
import time
import re

from bs4 import BeautifulSoup
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import StaleElementReferenceException

from plataforma import navegador
from reconex import requests_retry_session


'''
Elaboración de la sopa :D
'''


def bsopa(url):
    try:
        s = requests.Session()
        r = requests_retry_session(session=s).get(url)
    except ConnectionError as e:
        print(e)

    contenido = r.content
    return BeautifulSoup(contenido, 'html.parser')


'''
Función para recuperar los enlaces de los elementos desplegados en la búsqueda.
Regresa un listado de urls en la forma '/ParesBusquedas20/catalogo/description/xxxxx'
'''


def obtener_urls(sopa):
    hrefs = []

    caja = sopa.select('table.displayTable tbody')
    for box in caja:
        titul = box.select('p.titulo a')
        for columns in titul:
            get_href = columns['href']
            # La siguiente condición evita los resultados duplicados
            if get_href.endswith('?nm'):
                pass
            else:
                hrefs.append(get_href)

    return hrefs


'''
Función para encontrar un elemento usando un selector css y el método .select() de bs4
Retorna el texto de los elementos seleccionados.
'''


def obtener_elemento(sopa, selector):

    elemento = sopa.select(selector)
    for e in elemento:
        etexto = e.get_text()

    return etexto


def obtener_href_desc(sopa, selector, dominio):

    enlace = sopa.select(selector)
    for e in enlace:
        get_href = e["href"]
        enlace_completo = dominio + get_href

    return enlace_completo


def obtener_elemento_fecha(sopa, selector):

    fecha_completa = sopa.select(selector)
    for e in fecha_completa:
        etexto = e.get_text()
        fecha = etexto.split(',')[0]

    return fecha 

def obtener_elemento_lugardoc(sopa, selector):
    
    fecha_completa = sopa.select(selector)
    for e in fecha_completa:
        etexto = e.get_text()
        try:
            lugar = etexto.split(',')[1]
        except IndexError:
            lugar = ""

    return lugar 


'''
Función para navegar por el menú de páginas desde Chromedriver.
'''


def metapages(soup):
    num_pages = soup.select("span", {"class": "azul"})
    lines = [span.get_text() for span in num_pages]
    if lines[4] == "Aviso Legal":
        num_pags = 1
    else:
        num_pag = lines[9]
        num_pag1 = ''.join(num_pag).replace('.', '')
        num_pag2 = int(num_pag1) / 25
        num_pags = round(num_pag2) + 1

    return num_pags


def navegador_pantallas(url):

    urls = []

    browser = navegador()
    browser.get(url)

    sopa = BeautifulSoup(browser.page_source, 'html.parser')

    num_pags = metapages(sopa)
    rango = num_pags - 2
    pag_rest = num_pags + 2

    if num_pags == 1:
        try:
            urls.extend(obtener_urls(sopa))
        except NoSuchElementException as e:
            print(e)
        except StaleElementReferenceException:
            try:
                ruti = browser.find_element_by_xpath(
                    '//*[@id="resultados"]/div[2]/a[{}]'.format(num_pags))
                ruti.click()
                time.sleep(1)
                urls.extend(obtener_urls(sopa))
            except StaleElementReferenceException as e:
                print(
                    "no se pudo acceder al elemento por {}. El resultado puede tener errores".format(e))
                pass

    elif num_pags in range(1, 6):
        urls.extend(obtener_urls(sopa))
        try:
            ruti = browser.find_element_by_xpath(
                '//*[@id="resultados"]/div[2]/a[{}]'.format(num_pags))
            ruti.click()
            time.sleep(1)
            sopa = BeautifulSoup(browser.page_source, 'html.parser')
            urls.extend(obtener_urls(sopa))
        except NoSuchElementException:
            pass
        except StaleElementReferenceException:
            try:
                ruti = browser.find_element_by_xpath(
                    '//*[@id="resultados"]/div[2]/a[{}]'.format(num_pags))
                ruti.click()
                time.sleep(1)
                sopa = BeautifulSoup(browser.page_source, 'html.parser')
                urls.extend(obtener_urls(sopa))
            except StaleElementReferenceException as e:
                print(
                    "no se pudo acceder al elemento por {}. El resultado puede tener errores".format(e))
                pass

        for i in range(rango):
            try:
                i = browser.find_element_by_xpath(
                    '//*[@id="resultados"]/div[2]/a[{}]'.format(pag_rest))
                i.click()
                time.sleep(5)
                sopa = BeautifulSoup(browser.page_source, 'html.parser')
                urls.extend(obtener_urls(sopa))
            except NoSuchElementException:
                pass
            except StaleElementReferenceException:
                try:
                    ruti = browser.find_element_by_xpath(
                        '//*[@id="resultados"]/div[2]/a[{}]'.format(num_pags))
                    ruti.click()
                    time.sleep(1)
                    sopa = BeautifulSoup(browser.page_source, 'html.parser')
                    urls.extend(obtener_urls(sopa))
                except StaleElementReferenceException as e:
                    print(
                        "no se pudo acceder al elemento por {}. El resultado puede tener errores".format(e))
                    pass

    elif num_pags > 5:
        urls.extend(obtener_urls(sopa))
        time.sleep(1)
        try:
            ruti = browser.find_element_by_xpath(
                '//*[@id="resultados"]/div[2]/a[5]')
            ruti.click()
            time.sleep(3)
            sopa = BeautifulSoup(browser.page_source, 'html.parser')
            urls.extend(obtener_urls(sopa))
        except NoSuchElementException:
            pass
        except StaleElementReferenceException:
            try:
                ruti = browser.find_element_by_xpath(
                    '//*[@id="resultados"]/div[2]/a[{}]'.format(num_pags))
                ruti.click()
                time.sleep(1)
                sopa = BeautifulSoup(browser.page_source, 'html.parser')
                urls.extend(obtener_urls(sopa))
            except StaleElementReferenceException as e:
                print(
                    "no se pudo acceder al elemento por {}. El resultado puede tener errores".format(e))
                pass

        time.sleep(3)
        for i in range(rango):
            try:
                i = browser.find_element_by_xpath(
                    '//*[@id="resultados"]/div[2]/a[7]')
                i.click()
                time.sleep(5)
                sopa = BeautifulSoup(browser.page_source, 'html.parser')
                urls.extend(obtener_urls(sopa))
            except NoSuchElementException:
                pass
            except StaleElementReferenceException:
                try:
                    ruti = browser.find_element_by_xpath(
                        '//*[@id="resultados"]/div[2]/a[{}]'.format(num_pags))
                    ruti.click()
                    time.sleep(1)
                    sopa = BeautifulSoup(browser.page_source, 'html.parser')
                    urls.extend(obtener_urls(sopa))
                except StaleElementReferenceException as e:
                    print(
                        "no se pudo acceder al elemento por {}. El resultado puede tener errores".format(e))
                    pass

    else:
        print("ERROR")
        time.sleep(3)

    browser.quit()

    return urls


'''
Función para eliminar retornos de carro, nuevas líneas y tabulaciones en cada lista.
'''


def limpiadatos(lista):

    lista_limpia = []

    expresion_regular = re.compile(r'[\n\r\t]')

    for elem in lista:
        reemplazo = expresion_regular.sub('', elem)
        lista_limpia.append(reemplazo)

    return lista_limpia
