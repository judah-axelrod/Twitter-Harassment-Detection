# Auditing Twitter Harassment Detection Models for Racial Bias
## Walkthrough of Included Files
I include several files in this folder. The first two are the main text of the report and the accompanying code. The remaining files deal with cleaning and pre-processing or are helper functions called within the notebooks.

### Data
- The [Golbeck et al. (2017)](https://dl.acm.org/doi/10.1145/3091478.3091509) harassment corpus cannot be made publicly available due to privacy concerns. Please contact the authors for access (subject to a terms of use agreement).
- The [Blodgett et al. (2016)](https://www.aclweb.org/anthology/D16-1120/) TwitterAAE corpus is publicly available and can be downloaded [from here](https://www.aclweb.org/anthology/D16-1120/).

### Project-Twitter-Harassment-Detection.pdf
- Full report of analysis

### Twitter Harassment Detection.ipynb
- Main notebook for analysis including all code related to:
  - Visualization of word embeddings
  - Model construction, training, and validation
  - Model evaluation and assessment of racial bias

### Data Build.ipynb
- Main data cleaning and pre-processing program
  - Golbeck corpus cleaning and pre-processing steps
  - Feature Generation for language models

### Fuzzy Matching.ipynb
- Used to compute string similarities to remove near-duplicate tweets that have differing labels
- Output from this notebook used in Data Build notebook

### Blodgett TwitterAAE Data Build.R
- Simple cleaning, de-duplicating, and subsetting steps applied to Blodgett corpus
- Output from this script used in main notebook

### Attention.py
- Attention module code from [Chakrabarty et al. (2019)](https://github.com/tuhinjubcse/ALW3-ACL2019) with minor adaptations
- Imported in main notebook for construction of Self-Attention neural language models

### preprocessingTwitter.py
- Additional pre-processing steps original found from [Kaggle user amackrane](https://www.kaggle.com/amackcrane/python-version-of-glove-twitter-preprocess-script)
- Several of my own tweaks and edits to tailor more closely to the Golbeck corpus
- Function imported in Data Build notebook
