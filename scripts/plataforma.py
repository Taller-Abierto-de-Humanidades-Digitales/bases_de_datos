# !/usr/bin/env python3
# -*- coding: utf-8 -*-

from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.common.exceptions import WebDriverException
import chromedriver_autoinstaller


def navegador():
    """Crea una ruta ejecutable para chromedriver"""
    try:
        return webdriver.Chrome()
    except SessionNotCreatedException:
        print("Actualizando Chromedriver")
        chromedriver_autoinstaller.install()
        return webdriver.Chrome()
    except WebDriverException:
        print("Comprobando la instalación de Chromedriver")
        chromedriver_autoinstaller.install()
        return webdriver.Chrome()