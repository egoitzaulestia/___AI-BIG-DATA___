
Análisis Avanzado de Textos Científicos: Aplicación de NLP y Redes Neuronales en arXiv

——————————————————————————

1. Introducción y Metodología del Proyecto

En este proyecto he trabajado con el dataset de artículos científicos de arXiv, el cual originalmente pesa 4.52GB. Debido a la enorme cantidad de papers, he reducido la muestra para facilitar el procesamiento y análisis en mi entorno de hardware. Además, he realizado "web scraping" para extraer información sobre la taxonomía de las categorías de arXiv, permitiéndome mapear las etiquetas originales a clusters o categorías de mayor nivel.

El flujo de trabajo seguido ha sido el siguiente:

- Carga y Preprocesamiento: Reducción del dataset original, limpieza y normalización del texto de los abstracts, y extracción de metadatos relevantes.

- Enriquecimiento de Datos: Webscraping para obtener la taxonomía de las categorías de arXiv, con el fin de mapear los artículos a clusters de categorías (por ejemplo, Physics, Computer Science, Mathematics, etc.).

- Análisis Exploratorio y Visualización: Exploración de la distribución de los datos, visualización de la frecuencia de palabras, tendencias temporales y distribución de artículos por categoría.

- Generación de Modelos: Implementación de un modelo de clasificación basado en una red neuronal de TensorFlow, que actúa como línea base para asignar artículos a sus clusters correspondientes. Además, se ha entrenado un modelo Word2Vec para generar embeddings que capturan relaciones semánticas en los abstracts.

- Evaluación de Modelos: Comparación de métricas de desempeño (precisión, recall, F1-score) del clasificador, y análisis de la calidad de los embeddings generados, lo que sienta las bases para la integración de modelos más complejos en el futuro.

Este enfoque me permite evaluar cómo las técnicas de NLP y deep learning pueden manejar grandes volúmenes de datos científicos, y sienta las bases para investigaciones futuras en la clasificación y representación semántica de artículos académicos.

——————————————————————————

2. Datos Disponibles en el Dataset arXiv y Enriquecimiento con Taxonomía

El dataset arXiv proporciona información detallada de miles de artículos científicos, incluyendo títulos, autores, abstracts, categorías y fechas de publicación. Gracias al proceso de webscraping, se ha enriquecido el dataset con una taxonomía que permite mapear las abreviaturas de las categorías a clusters de alto nivel (por ejemplo, Physics, Computer Science, Mathematics, Quantitative Biology, entre otros). Este enriquecimiento es fundamental para analizar la distribución de los artículos y evaluar el desempeño del modelo de clasificación.

- Dataset arXiv de Kaggle: https://www.kaggle.com/datasets/Cornell-University/arxiv/data?select=arxiv-metadata-oai-snapshot.json

- Categorías taxonómicas de arXiv (web scraping): https://arxiv.org/category_taxonomy?utm_source=chatgpt.com

——————————————————————————

3. Técnicas de Procesamiento de Lenguaje Natural (NLP) Aplicadas en el Proyecto

El proyecto se centra en la aplicación de avanzadas técnicas de NLP para la limpieza, tokenización y representación de textos. Se han eliminado stopwords, normalizado el texto y generado embeddings con Word2Vec para extraer características semánticas de los abstracts. Esto facilita la extracción de información relevante y la posterior clasificación de los artículos en función de su contenido.

——————————————————————————

4. Modelo de Clasificación y Generación de Embeddings

Como línea base, he desarrollado un modelo de clasificación en TensorFlow que utiliza las representaciones obtenidas a partir de los abstracts procesados. El modelo se entrena para asignar cada artículo a uno de los clusters definidos a partir de la taxonomía de arXiv. Paralelamente, el entrenamiento de Word2Vec ha permitido generar embeddings de los abstracts, que ayudan a visualizar y comprender las relaciones semánticas entre los términos presentes en los artículos.

——————————————————————————

🌏 ✨ 🚀
Egoitz Aulestia, 2025