# -*- coding: utf-8 -*-
"""
Created on Sun Jan 17 17:45:19 2021

@author: borja
"""

import mechanicalsoup

browser = mechanicalsoup.Browser()

login_url = "http://olympus.realpython.org/login"
login_page = browser.get(login_url)
login_html = login_page.soup

form = login_html.form
# user y password
form.select("input")[0]["value"] = "zeus"
form.select("input")[1]["value"] = "ThunderDude"

# Envio
profiles_page = browser.submit(form, login_page.url)

print(profiles_page.soup.title)