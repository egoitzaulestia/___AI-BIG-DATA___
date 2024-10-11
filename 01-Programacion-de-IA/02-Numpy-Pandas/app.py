import pandas as pd
import folium
import streamlit as st
from streamlit_folium import folium_static
from folium.plugins import HeatMap
from geopy.distance import geodesic
import matplotlib.pyplot as plt

# Cargar el CSV
df_accidentes_eus = pd.read_csv("datos/accidentes_2022.csv")

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
        # Crear un mapa centrado en la ubicación del accidente con tamaño ajustado
        mapa = folium.Map(location=[self.latitude, self.longitude], zoom_start=13, width=800, height=500)

        # Añadir un marcador en la ubicación del accidente
        folium.Marker(
            [self.latitude, self.longitude],
            popup=f"Accidente {self.incidenceId}: {self.cause} en {self.cityTown}",
            tooltip=self.cause
        ).add_to(mapa)

        return mapa

# Diccionario para almacenar los accidentes
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

# Función para calcular la distancia entre dos puntos geográficos
def calcular_distancia(lat1, lon1, lat2, lon2):
    return geodesic((lat1, lon1), (lat2, lon2)).kilometers

# Sidebar para la navegación entre secciones
st.sidebar.title("Navegación")
seccion = st.sidebar.selectbox("Selecciona una sección", ["Intro", "Mapa de Accidentes", "Gráficos"])

# Sección 1: Intro
if seccion == "Intro":
    st.title("Introducción al Proyecto de Accidentes de Tráfico")
    st.markdown("""
    Este proyecto se basa en la visualización y análisis de datos de accidentes de tráfico.
    Utilizamos mapas interactivos para mostrar la ubicación de los accidentes y gráficos estadísticos para entender
    mejor los patrones que pueden estar ocurriendo.
    
    **Características del proyecto:**
    - Mapa interactivo con visualización de accidentes.
    - Posibilidad de encontrar los accidentes más cercanos a uno seleccionado.
    - Gráficos de barras y gráficos de tarta que muestran los accidentes por provincia y ciudad.
    """)

# Sección 2: Mapa de Accidentes
elif seccion == "Mapa de Accidentes":
    st.title("Mapa de Accidentes")

    # Input para seleccionar un ID de accidente
    incidence_id = st.number_input("Introduce el ID del accidente", min_value=0, step=1)

    # Input para el número de accidentes más cercanos que se quieren mostrar
    num_accidentes_cercanos = st.number_input("Número de accidentes cercanos a mostrar", min_value=1, max_value=10, value=3, step=1)

    # Botón para visualizar el accidente
    if st.button("Mostrar accidente"):
        accidente_seleccionado = accidentes_dict.get(incidence_id)

        if accidente_seleccionado:
            # Mostrar los detalles del accidente
            st.write(accidente_seleccionado)
            
            # Mostrar el mapa interactivo
            mapa = accidente_seleccionado.mostrar_en_mapa()
            folium_static(mapa)
            
            # Calcular las distancias a los demás accidentes y mostrar los más cercanos
            df_accidentes_eus['distance'] = df_accidentes_eus.apply(
                lambda row: calcular_distancia(accidente_seleccionado.latitude, accidente_seleccionado.longitude, row['latitude'], row['longitude']), axis=1
            )

            # Obtener los accidentes más cercanos
            accidentes_cercanos = df_accidentes_eus.sort_values(by='distance').head(num_accidentes_cercanos)

            st.write(f"Los {num_accidentes_cercanos} accidentes más cercanos al seleccionado son:")
            st.dataframe(accidentes_cercanos[['incidenceId', 'cityTown', 'province', 'distance']])

            # Mostrar los accidentes más cercanos en el mapa
            mapa_cercanos = folium.Map(location=[accidente_seleccionado.latitude, accidente_seleccionado.longitude], zoom_start=12, width=800, height=500)
            folium.Marker([accidente_seleccionado.latitude, accidente_seleccionado.longitude],
                          popup=f"Accidente {accidente_seleccionado.incidenceId} (seleccionado)",
                          icon=folium.Icon(color='red')).add_to(mapa_cercanos)

            for _, row in accidentes_cercanos.iterrows():
                folium.Marker([row['latitude'], row['longitude']],
                              popup=f"Accidente {row['incidenceId']} en {row['cityTown']}",
                              icon=folium.Icon(color='blue')).add_to(mapa_cercanos)

            folium_static(mapa_cercanos)

        else:
            st.error(f"No se encontró un accidente con ID {incidence_id}.")

    # Botón para mostrar el mapa de calor
    if st.button("Mostrar mapa de calor"):
        # Crear el mapa de calor con todos los accidentes
        mapa_calor = folium.Map(location=[43.0, -2.5], zoom_start=8, width=800, height=500)
        heat_data = [[row['latitude'], row['longitude']] for index, row in df_accidentes_eus.iterrows()]
        HeatMap(heat_data).add_to(mapa_calor)
        folium_static(mapa_calor)

# Sección 3: Gráficos
elif seccion == "Gráficos":
    st.title("Gráficos de Accidentes")

    # Menú desplegable para las provincias
    provincias = ['GIPUZKOA', 'BIZKAIA', 'ARABA']
    provincia_seleccionada = st.selectbox("Selecciona una provincia", provincias)

    # Menú desplegable para elegir entre gráfico de barras o tarta
    tipo_grafico = st.selectbox("Selecciona el tipo de gráfico", ['Barras', 'Tarta'])

    # Botón para mostrar gráfico de accidentes
    if st.button("Mostrar gráfico"):
        # Filtrar accidentes por provincia seleccionada
        df_provincia = df_accidentes_eus[df_accidentes_eus['province'] == provincia_seleccionada]

        if tipo_grafico == 'Barras':
            # Gráfico de barras del número de accidentes por ciudad
            df_provincia['cityTown'].value_counts().plot(kind='bar', color='lightblue')
            plt.title(f'Número de accidentes en {provincia_seleccionada} por ciudad')
            plt.xlabel('Ciudad')
            plt.ylabel('Número de accidentes')
            plt.xticks(rotation=45, ha='right')
            plt.tight_layout()
            st.pyplot()

        elif tipo_grafico == 'Tarta':
            # Gráfico de tarta del porcentaje de accidentes por ciudad
            df_provincia['cityTown'].value_counts().plot(kind='pie', autopct='%1.1f%%')
            plt.title(f'Porcentaje de accidentes en {provincia_seleccionada} por ciudad')
            plt.ylabel('')
            st.pyplot()
