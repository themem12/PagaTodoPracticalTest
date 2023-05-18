# PagaTodoPracticalTest
### iOS Engineer Practical Test for PagaTodo


This project was made using Swift language, and UIKit library.
The project uses CoreData for data persistence.
The architecture used for the project is MVVM using Combine for binding View and ViewModel.

The project is a single view application where at launch for the first time it makes an API call to the URL "https://dev.obtenmas.com/catom/api/challenge/banks", and it retrieves a list of banks with the following info:

 - Name
 - Age
 - URL
 - Description

The data is shown in a list form and using one cell per bank, showing all the information and getting the icon of each bank from the provided URL.

When info is retrieved, the application saves it using CoreData so when the application runs again, it doesn't need to retrieve from a URL, it retrieves from local storage.

It can be seen from UI when the data is retrieved from API or locally, if it comes from API the application shows an activity indicator at the center of the screen while the data is loaded and the view is updated.


### Prueba práctica de iOS Engineer para PagaTodo

Éste proyecto fue realizado usando lenguaje Swift y la librería UIKit.
El proyecto usa CoreData para la persistencia de datos.
La arquitectura utilizada para el proyecto es MVVM utilizando la librería Combine para enlazar entre la vista y la VistaModelo.

El proyecto es una aplicación de una sola vista que al cargar por primera vez hace un llamado a API a la URL: "https://dev.obtenmas.com/catom/api/challenge/banks", que regresa un listado de bancos con la siguiente información:

 - Nombre
 - Tiempo
 - URL
 - Descripción

La información es mostrada en una lista usando una celda por cada banco, mostrando toda su información y mostrando el ícono del banco proporcionado por la URL.

Cuando regresa la información, es guardada de manera local utilizando CoreData para que las próximas veces que corra la aplicación no tenga que traerla de una URL y la pueda traer del almacenamiento local.

Se puede observar en la IU cuando la información es traída de una API o de manera local, ya que si viene de una API se muestra un indicador de actividad al centro de la pantalla mientras carga la información y actualiza la vista.

![BanksTableView](https://github.com/themem12/PagaTodoPracticalTest/assets/37200661/3715c167-a7e1-46dc-b204-910ee4e3be6f)
