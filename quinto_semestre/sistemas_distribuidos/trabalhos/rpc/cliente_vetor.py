import rpyc
import sys
import time

if len(sys.argv) < 3:
    exit("Usage: {} SERVER N".format(sys.argv[0]))

server = sys.argv[1]
n = int(sys.argv[2])

# Conectar ao servidor
conn = rpyc.connect(server, 18861)

# Criar o vetor de 0 a n-1
vector = list(range(n))

# Medir tempo de execução no cliente
start = time.time()  # iniciar a medição do tempo
result = conn.root.sum_vector(vector)
end = time.time()  # terminar a medição do tempo

# Imprimir o resultado da soma e o tempo de execução no cliente
# print("A soma dos elementos do vetor é:", result)
print("Tempo de execução no cliente:", end - start)  # imprimir tempo no cliente
