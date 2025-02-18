# -*- coding: utf-8 -*-
"""
Created on Tue Jan 12 18:22:33 2021

@author: borja
"""

# EJERCICIO 1
from urllib.request import urlopen

url = "http://olympus.realpython.org/profiles/dionysus"
html_page = urlopen(url)
html_text = html_page.read().decode("utf-8")
print(html_text)

for string in ["Name: ","Hometown: ","Favorite animal: ","Favorite Color:"]:
    string_start_idx = html_text.find(string)
    text_start_idx = string_start_idx + len(string)

    next_html_tag_offset = html_text[text_start_idx:].find("<")
    text_end_idx = text_start_idx + next_html_tag_offset

    raw_text = html_text[text_start_idx : text_end_idx]
    clean_text = raw_text.strip(" \r\n\t")
    print(string, clean_text)