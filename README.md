# CoWEs - Corpus de la Wikipedia en Español

Este proyecto tiene los scripts necesarios para poder generar un corpus para *Procesamiento de Lenguage Natural* (PLN) en español a partir del último dump de la Wikipedia. Además, incluye el último corpus generado para empezar a trastear. Esto último es interesante ya que en generar el corpus se tarda... un rato.

Está inspirado y toma los scripts del siguiente artículo:

https://towardsdatascience.com/pre-processing-a-wikipedia-dump-for-nlp-model-training-a-write-up-3b9176fdf67

La extracción del texto la realiza la fantástica herramienta creada por [
Giuseppe Attardi](https://github.com/attardi) conocida como [WikiExtractor](https://github.com/attardi/wikiextractor).

## Requisitos

* **Python 3.5** - No vale otra versión.
* [**WikiExtractor**](https://github.com/attardi/wikiextractor) - Este es el culpable de que no valga otra versión de Python.
* (Opcional) [**PyEnv**](https://github.com/pyenv/pyenv) + [**PyEnv-Virtualenv**](https://github.com/pyenv/pyenv-virtualenv) o [**Conda**](https://docs.conda.io/en/latest/) - Permite gestionar diferentes versiones y entornos virtuales de python.

## Configuración
### Configuración del entorno virtual

Antes de comenzar se recomienda configurar un entorno virtual con la versión requerida de Python. Esto se puede hacer con PyEnv o Conda. El siguiente ejemplo muestra como hacerlo con PyEnv.

**Nota**: Para instalar [**PyEnv**](https://github.com/pyenv/pyenv) y [**PyEnv-Virtualenv**](https://github.com/pyenv/pyenv-virtualenv) remitimos a las instrucciones de los respectivos proyectos. En esta documentación se presuponen instalados y configurados.

```bash
$ pyenv install 3.5.7
$ pyenv virtualenv 3.5.7 cowes
$ pyenv local cowes
(cowes)$
```

### Instalación de dependencias

```bash
(cowes)$ pip install -r requirements.txt
```

## Volcado de la Wikipedia en Español

La ejecución del siguiente script descarga el último volcado disponible de la Wikipedia con el nombre "eswiki-latest-pages-articles.xml.bz2".

```bash
(cowes)$ ./download_wiki_dump.sh es
```

## Extracción y limpieza del volcado

En este paso se extrae el texto y se limpia del lenguaje de marcado de Wikipedia, de etiquetas html o xml. Genera
un archivo de textos de todos los artículos.

```bash
(cowes)$ ./extract_and_clean_wiki_dump.sh eswiki-latest-pages-articles.xml.bz2
```

El archivo generado toma el nombre de "eswiki-latest-pages-articles.txt" que es el corpus final.

## Descargar Corpus

El [corpus está subido en kaggle](https://www.kaggle.com/jmorenobl/corpus-de-la-wikipedia-en-espaol) y se puede previsualizar desde dicha plataforma:

* [Descargar CoWEs](https://www.kaggle.com/jmorenobl/corpus-de-la-wikipedia-en-espaol/download)

Lo siguiente es usarlo, por ejemplo, para crear un [Tokenizador de HuggingFace](https://huggingface.co/docs/tokenizers/python/latest/quicktour.html).

## (Opcional) Últimos retoques

Es posible que el corpus en *bruto* no sea suficiente para empezar a trabajar con él, por ejemplo, para entrenar un word embedding con FastText. Si es tu caso, las acciones que se ejecutan en este paso son las siguientes:

* Se eliminan líneas en blanco.
* A cada línea se le asigna una única oración. Es decir, se dividen los párrafos en varias oraciones.
* Se normalizan los caracteres unicode usando "NFKC".

El comando se ejecuta de la siguiente manera:

```bash
(cowes)$ ./preprocess_wiki_dump.py eswiki-latest-pages-articles.txt
```

Un ejemplo del resultado de la ejecución del comando es la transformación del siguiente texto:

>Andorra, oficialmente Principado de Andorra, es un micro-Estado soberano del suroeste de Europa, ubicado entre España y Francia, en el límite de la península ibérica. Se constituye en Estado independiente, de derecho, democrático y social, cuya forma de gobierno es el coprincipado parlamentario. Su territorio está organizado en siete parroquias, con una población total de 76 177 habitantes. Su capital es Andorra la Vieja.

en este:

>Andorra, oficialmente Principado de Andorra, es un micro-Estado soberano del suroeste de Europa, ubicado entre España y Francia, en el límite de la península ibérica.<br/>
>Se constituye en Estado independiente, de derecho, democrático y social, cuya forma de gobierno es el coprincipado parlamentario.<br/>
>Su territorio está organizado en siete parroquias, con una población total de 76 177 habitantes.<br/>
>Su capital es Andorra la Vieja.