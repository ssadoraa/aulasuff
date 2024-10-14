import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import nltk
nltk.download('stopwords')
nltk.download('punkt')

# sadness (0), joy (1), love (2), anger (3), fear (4), and surprise (5).

# Carregar dados do arquivo CSV
dados = pd.read_csv('text.csv')

# Separar textos e classes
textos = dados['text'].values
classes = dados['label'].values

# Remover stopwords
stop_words = set(stopwords.words('english'))

textos_processados = []
for texto in textos:
    words = word_tokenize(texto)
    words = [word for word in words if word.lower() not in stop_words]
    textos_processados.append(' '.join(words))

# Vetorização dos textos
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(textos_processados)

# Divisão dos dados em conjunto de treinamento e teste
# 80% para treino e 20% para teste
X_train, X_test, y_train, y_test = train_test_split(X, classes, test_size=0.2, random_state=42)

# Treinamento do classificador Naive Bayes Multinomial
naive_bayes = MultinomialNB()
naive_bayes.fit(X_train, y_train)

# Previsões
y_pred = naive_bayes.predict(X_test)

# Avaliação do modelo
accuracy = accuracy_score(y_test, y_pred)

# Nova frase de exemplo
nova_frase = ["i am feeling so scared right now"]

# Remover stopwords da nova frase
nova_frase_processada = ' '.join([word for word in word_tokenize(nova_frase[0]) if word.lower() not in stop_words])

# Vetorização da nova frase
nova_frase_vetorizada = vectorizer.transform([nova_frase_processada])

# Previsão da classe utilizando o modelo treinado
previsao = naive_bayes.predict(nova_frase_vetorizada)

# Impressão da resposta
print("Nova frase:", nova_frase[0])
print("Classe prevista:", previsao[0])
print("Acurácia do modelo: {:.2f}%".format(accuracy * 100))
