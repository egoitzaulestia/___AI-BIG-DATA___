# pages/2_Datasets.py

import streamlit as st
import pandas as pd

st.set_page_config(
    page_title="Datasets",
    page_icon="🏎️",
    layout="wide",
)

st.write("# Datasets Utilizados 📂")

st.markdown("A continuación, puedes explorar los distintos datasets utilizados en este proyecto.")

# Lista de datasets
datasets = {
    "Drivers": "data/drivers.csv",
    "Constructors": "data/constructors.csv",
    "Results": "data/results.csv",
    # Añade más datasets según sea necesario
}

# Selección de dataset
dataset_name = st.selectbox("Selecciona un dataset", list(datasets.keys()))
data = pd.read_csv(datasets[dataset_name])

st.write(f"## {dataset_name} Dataset")

# Muestra de datos
st.write("### Muestra de Datos:")
st.dataframe(data.head(21))

# Descripción estadística
st.write("### Descripción Estadística:")
st.write(data.describe())

# Información de columnas
st.write("### Información de Columnas:")
col_info = pd.DataFrame({
    "Columna": data.columns,
    "Tipo de Dato": data.dtypes,
    "Valores Nulos": data.isnull().sum()
})
st.dataframe(col_info)
