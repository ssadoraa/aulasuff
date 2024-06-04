import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# Carregar dados do arquivo CSV
dados = pd.read_csv('text.csv')

# Separar textos e classes
textos = dados['text'].values
classes = dados['label'].values

# Vetorização dos textos
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(textos)

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
nova_frase = ["i am feeling so stressed right now"]

# Vetorização da nova frase
nova_frase_vetorizada = vectorizer.transform(nova_frase)

# Previsão da classe utilizando o modelo treinado
previsao = naive_bayes.predict(nova_frase_vetorizada)

# Impressão da resposta
print("Nova frase:", nova_frase[0])
print("Classe prevista:", previsao[0])
print("Acurácia do modelo: {:.2f}%".format(accuracy * 100))