# Proyecto de Clasificación de Artículos Científicos con Deep Learning en el Dataset Cora

Este proyecto he explorado y evaluado distintos enfoques de deep learning para la clasificación de artículos científicos utilizando el conjunto de datos Cora. He implementado tanto modelos tradicionales (MLP) como modelos basados en Redes Neuronales de Grafos (GNN, Graph Neural Networks), incluyendo variantes como GCN (Graph Convolutional Networks), GAT (Graph Attention Networks) y GraphSAGE (Graph Sample and Aggregation), para determinar la ventaja de incorporar la estructura de citaciones en la tarea de clasificación.

---

## 1. El Dataset Cora

El conjunto de datos Cora consiste en artículos sobre Aprendizaje Automático (Machine Learning). Los artículos están clasificados en una de las siguientes siete categorías:

- Case_Based  
- Genetic_Algorithms  
- Neural_Networks  
- Probabilistic_Methods  
- Reinforcement_Learning  
- Rule_Learning  
- Theory

El corpus está formado por 2708 artículos, en el cual cada artículo cita o es citado por al menos otro artículo, conformando un total de 5429 enlaces de citación. 

El dataset Cora ya venia con una limpieza de datos realizada, tras ahabérsele aplicado técnicas de stemming y eliminación de stopwords, donde se obtuvieron un vocabulario de 1433 palabras únicas, descartando aquellas con frecuencia inferior a 10.

El directorio del dataset contiene dos archivos principales:

- **cora.content:**  
  Cada línea de este archivo representa un artículo e incluye:  
  - Un identificador único (cadena) del artículo.  
  - Un vector binario de 1433 valores que indica la presencia (1) o ausencia (0) de cada palabra del vocabulario en el artículo.  
  - La etiqueta de clase que clasifica el artículo en una de las siete categorías.

- **cora.cites:**  
  Cada línea de este archivo describe una relación de citación entre dos artículos. El formato es:  
  - El primer identificador corresponde al artículo que está siendo citado.  
  - El segundo identificador corresponde al artículo que realiza la citación.  
  La dirección del enlace es de derecha a izquierda (por ejemplo, "paper1 paper2" implica que *paper2* cita a *paper1*).

---

## 2. Metodología del Proyecto

En este trabajo he seguido una metodología estructurada que comprende los siguientes pasos:

- **Carga y Preprocesamiento:**  

  He extraído la información de los archivos `cora.content` (para las características y etiquetas) y `cora.cites` (para la estructura del grafo de citaciones). En algunos experimentos, he extendido las features originales agregando métricas del grafo (grado de entrada, grado de salida y coeficiente de agrupamiento) para enriquecer la representación de los artículos.

- **Análisis Exploratorio y Visualización:**  
  He realizado diversas visualizaciones para comprender la distribución de los datos, tanto a nivel del contenido textual de los artículos como en la red de citaciones. Esto ha incluído la visualización de matrices de confusión, reportes de clasificación y gráficos comparativos de precisión obtenida mediante validación cruzada.

- **Generación de Modelos:**  
  He implementado dos líneas de modelos:
  - **Modelo Baseline (MLP):** Un clasificador de red neuronal convencional que utiliza únicamente las características extendidas de cada artículo (sin considerar explícitamente las relaciones del grafo).
  - **Modelos de Redes Neuronales de Grafos (GNN):** He explorado distintas arquitecturas, incluyendo:
    - **GCN (Graph Convolutional Network):** Modelo principal que aplica operaciones de convolución adaptadas a la estructura del grafo.
    - **GAT (Graph Attention Network):** Modelo que incorpora mecanismos de atención para ponderar la influencia de los vecinos.
    - **GraphSAGE:** Modelo que utiliza técnicas de muestreo y agregación para generar representaciones de los nodos.

- **Evaluación de Modelos:**  
  He utilizado validación cruzada (5-fold) para evaluar de manera robusta el desempeño de cada modelo. He comparado las precisiones promedio y he analizado las matrices de confusión y los reportes de clasificación para determinar el rendimiento en el conjunto de test.

- **Consideraciones sobre Implementación:**  
  Durante el desarrollo, también intenté implementar GNN en TensorFlow mediante bibliotecas como Spektral y DGL, pero surgieron problemas de compatibilidad. Por ello, he utilizado PyTorch Geometric para los modelos GNN y un MLP secuencial en TensorFlow como línea base para establecer una comparación.

---

## 3. Redes Neuronales de Grafos (GNN) y su Selección

Las Redes Neuronales de Grafos (GNN) son modelos de deep learning diseñados para trabajar con datos estructurados en forma de grafos. A diferencia de los modelos tradicionales, las GNN integran la información de los nodos junto con la de sus conexiones, lo que permite capturar relaciones complejas y patrones globales en conjuntos de datos interconectados. Esta característica resulta especialmente útil para el dataset Cora, donde la estructura de citaciones es clave para comprender las relaciones entre los artículos.

He optado por utilizar variantes de GNN como:
- **GCN:** Por su sencillez y efectividad al aplicar convoluciones sobre el grafo.
- **GAT:** Debido a su capacidad para ponderar las conexiones relevantes mediante mecanismos de atención.
- **GraphSAGE:** Por su estrategia de muestreo y agregación, que resulta útil en grafos con variabilidad en el número de vecinos.

Estas arquitecturas han sido comparadas mediante validación cruzada para evaluar su desempeño y se ha determinado cuál de ellas ofrece la mejor precisión en el conjunto de test.

---

## 4. Resumen de los Datos y la Experiencia

El proyecto se ha desarrollado sobre un dataset que combina información textual y relacional:
- **2708 artículos científicos** con descripciones basadas en un vector binario de 1433 dimensiones (vocabulario de 1433 palabras).
- **5429 relaciones de citación**, que forman un grafo dirigido y proporcionan contexto relacional adicional.

Esta integración de datos permite aprovechar tanto la información interna de cada artículo como las relaciones entre ellos, lo que es fundamental para entender y clasificar adecuadamente los documentos científicos en el ámbito del Aprendizaje Automático.
