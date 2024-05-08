## Eduard Martínez
## update: 16-04-2023

## llamar la librería pacman: contiene la función p_load()
rm(list=ls())
require(pacman)
p_load(tidyverse, # contiene las librerías ggplot, dplyr...
       rvest) # web-scraping

## Acceder al robots.txt de wikipedia
browseURL("https://en.wikipedia.org/robots.txt")

## Mi primer HTML
my_html <- 
'<!DOCTYPE html> 
<html>
<meta charset="utf-8">
<head>
<title> Título de la página: Eduard Martínez </title>
</head>
<body>
<h1> <font color="#162B57"> Eduard Martinez </font></h1>
<h2> Subtitle <u>subrayado-1</u>. </h2>
<p> Este es un párrafo muy pequeño que se encuentra dentro de la etiqueta <b>p</b> de <i>html</i> </p>
<a href="https://es.wikipedia.org/wiki/Copa_Mundial_de_F%C3%BAtbol"> link a wikipedia </a>
</body>
</html>'

## export and read html
write.table(x=my_html , file='my_page.html' , quote=F , col.names=F , row.names=F)
browseURL("my_page.html") ## leer con el navegador de su equipo

## view rvest
vignette("rvest")

## 2.1 Aplicación en R:
my_url = "https://es.wikipedia.org/wiki/Copa_Mundial_de_F%C3%BAtbol"
browseURL(my_url) ## Ir a la página

## leer el html de la página
html <- read_html(my_url)

## ver la clase del objeto
class(html)

## ver el objeto
html

## 2.2 Extraer elementos de un HTML

## Obtener los elementos h2 de la página
html_elements(x = html , "h2")

## Ver los textos
html_elements(x = html , "h1") %>% html_text2()

## 2.3 Xpath
html_element(x = html , 
             xpath = "/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/p[75]") %>% 
html_text()

## Extraer tablas
tablas <- html %>% html_table()

## subconjunto de tabla
html_sub <- html %>% html_element(xpath = "/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/table[11]")
html_sub %>% html_table()

## 
html_sub %>% html_elements("a") %>% length()

links <- html_sub %>% html_elements("a")
urls <- links %>% html_attr("href")

## ir a la pagina de Rossi
browseURL(paste0("https://es.wikipedia.org/",str_subset(urls,"Flag_of_Qatar.svg")))


download.file("https://upload.wikimedia.org/wikipedia/commons/6/65/Flag_of_Qatar.svg" , destfile = "bandera.jpeg")

pset <- "https://eduard-martinez.github.io/pset-4.html"
browseURL(pset)

urls <- read_html(pset) %>% html_elements("a") %>% html_attr("href") %>% str_subset("propiedad")

browseURL(urls[50])


urls[50] %>% read_html() %>% html_table()




