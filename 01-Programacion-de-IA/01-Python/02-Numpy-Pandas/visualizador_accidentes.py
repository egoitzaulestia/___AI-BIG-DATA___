import pandas as pd
import folium
import matplotlib.pyplot as plt
import tkinter as tk
from tkinter import messagebox, ttk
from io import BytesIO
import base64
from PIL import Image, ImageTk
import webbrowser
from folium.plugins import HeatMap

# Cargar el CSV con pandas
df_accidentes_eus = pd.read_csv("datos/accidentes_2022.csv")  # Asegúrate de poner la ruta correcta del CSV

# Clase Accidente
class Accidente:
    def __init__(self, incidenceId, province, cause, cityTown, startDate, incidenceLevel, road, pkStart, pkEnd, direction, latitude, longitude):
        self.incidenceId = incidenceId
        self.province = province
        self.cause = cause
        self.cityTown = cityTown
        self.startDate = startDate
        self.incidenceLevel = incidenceLevel
        self.road = road
        self.pkStart = pkStart
        self.pkEnd = pkEnd
        self.direction = direction
        self.latitude = latitude
        self.longitude = longitude

    def __str__(self):
        return f"Accidente {self.incidenceId}: {self.cause} en {self.cityTown}, {self.province}, el {self.startDate}.\n" \
               f"Nivel de incidencia: {self.incidenceLevel}, Carretera: {self.road}, PK: {self.pkStart}-{self.pkEnd}, Dirección: {self.direction}, " \
               f"Latitud: {self.latitude}, Longitud: {self.longitude}"

    # Método para visualizar el accidente en un mapa con Folium
    def mostrar_en_mapa(self):
        # Crear un mapa centrado en la ubicación del accidente
        mapa = folium.Map(location=[self.latitude, self.longitude], zoom_start=13)

        # Añadir un marcador en la ubicación del accidente
        folium.Marker(
            [self.latitude, self.longitude],
            popup=f"Accidente {self.incidenceId}: {self.cause} en {self.cityTown}",
            tooltip=self.cause
        ).add_to(mapa)

        return mapa

# Diccionario para almacenar los accidentes por `incidenceId`
accidentes_dict = {}

# Iterar sobre el DataFrame para crear instancias de Accidente
for _, row in df_accidentes_eus.iterrows():
    accidente = Accidente(
        incidenceId=row['incidenceId'],
        province=row['province'],
        cause=row['cause'],
        cityTown=row['cityTown'],
        startDate=row['startDate'],
        incidenceLevel=row['incidenceLevel'],
        road=row['road'],
        pkStart=row['pkStart'],
        pkEnd=row['pkEnd'],
        direction=row['direction'],
        latitude=row['latitude'],
        longitude=row['longitude']
    )
    accidentes_dict[row['incidenceId']] = accidente

# Crear la interfaz gráfica con Tkinter
class AccidentesApp:
    def __init__(self, master):
        self.master = master
        master.title("Visualizador de Accidentes")

        # Etiqueta de entrada
        self.label = tk.Label(master, text="Introduce el ID del accidente:")
        self.label.pack()

        # Campo de entrada para el ID
        self.entry = tk.Entry(master)
        self.entry.pack()

        # Botón para mostrar el accidente
        self.show_button = tk.Button(master, text="Mostrar accidente", command=self.mostrar_accidente)
        self.show_button.pack()

        # Etiqueta para mostrar los detalles del accidente
        self.result_label = tk.Label(master, text="")
        self.result_label.pack()

        # Canvas para mostrar el mapa
        self.canvas = tk.Canvas(master, width=400, height=400)
        self.canvas.pack()

        # Botón para mostrar el mapa de calor
        self.heatmap_button = tk.Button(master, text="Mostrar mapa de calor", command=self.mostrar_mapa_calor)
        self.heatmap_button.pack()

        # Menú desplegable para las provincias
        self.provincias = ['GIPUZKOA', 'BIZKAIA', 'ARABA']
        self.provincia_seleccionada = tk.StringVar(master)
        self.provincia_seleccionada.set(self.provincias[0])  # Selección inicial
        self.menu_provincia = tk.OptionMenu(master, self.provincia_seleccionada, *self.provincias)
        self.menu_provincia.pack()

        # Menú desplegable para elegir entre gráfico de barras o tarta
        self.graficos = ['Barras', 'Tarta']
        self.grafico_seleccionado = tk.StringVar(master)
        self.grafico_seleccionado.set(self.graficos[0])  # Selección inicial
        self.menu_grafico = tk.OptionMenu(master, self.grafico_seleccionado, *self.graficos)
        self.menu_grafico.pack()

        # Botón para mostrar gráfico de accidentes
        self.show_graph_button = tk.Button(master, text="Mostrar gráfico", command=self.mostrar_grafico)
        self.show_graph_button.pack()

    def mostrar_accidente(self):
        try:
            # Obtener el ID ingresado por el usuario
            incidence_id = int(self.entry.get())

            # Buscar el accidente en el diccionario
            accidente_seleccionado = accidentes_dict.get(incidence_id)

            if accidente_seleccionado:
                # Mostrar los detalles del accidente
                self.result_label.config(text=str(accidente_seleccionado))

                # Mostrar el mapa en la interfaz
                mapa = accidente_seleccionado.mostrar_en_mapa()
                mapa.save('mapa_accidente.html')
                webbrowser.open('mapa_accidente.html')  # Abre el mapa en el navegador
            else:
                messagebox.showerror("Error", f"No se encontró un accidente con ID {incidence_id}.")
        except ValueError:
            messagebox.showerror("Error", "Por favor, introduce un ID válido (un número entero).")

    def mostrar_mapa_calor(self):
        # Crear el mapa de calor con todos los accidentes
        mapa_calor = folium.Map(location=[43.0, -2.5], zoom_start=8)
        heat_data = [[row['latitude'], row['longitude']] for index, row in df_accidentes_eus.iterrows()]
        HeatMap(heat_data).add_to(mapa_calor)
        
        # Guardar el mapa de calor en un archivo HTML
        mapa_calor.save('mapa_calor.html')
        
        # Abrir el archivo HTML en el navegador
        webbrowser.open('mapa_calor.html')

    def mostrar_grafico(self):
        # Filtrar accidentes por provincia seleccionada
        provincia = self.provincia_seleccionada.get()
        df_provincia = df_accidentes_eus[df_accidentes_eus['province'] == provincia]

        # Elegir el gráfico según la selección
        tipo_grafico = self.grafico_seleccionado.get()

        if tipo_grafico == 'Barras':
            # Gráfico de barras del número de accidentes por ciudad
            df_provincia['cityTown'].value_counts().plot(kind='bar', color='lightblue')
            plt.title(f'Número de accidentes en {provincia} por ciudad')
            plt.xlabel('Ciudad')
            plt.ylabel('Número de accidentes')
            plt.xticks(rotation=45, ha='right')
            plt.tight_layout()
            plt.show()

        elif tipo_grafico == 'Tarta':
            # Gráfico de tarta del porcentaje de accidentes por ciudad
            df_provincia['cityTown'].value_counts().plot(kind='pie', autopct='%1.1f%%')
            plt.title(f'Porcentaje de accidentes en {provincia} por ciudad')
            plt.ylabel('')
            plt.show()

# Crear la ventana principal
root = tk.Tk()
app = AccidentesApp(root)
root.mainloop()
