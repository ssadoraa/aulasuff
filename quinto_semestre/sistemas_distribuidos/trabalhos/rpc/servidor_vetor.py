import rpyc
import time

class MyService(rpyc.Service):
    def on_connect(self, conn):
        pass

    def on_disconnect(self, conn):
        pass

    def exposed_sum_vector(self, vector):
        start = time.time()  # iniciar a medição do tempo
        result = sum(vector)
        end = time.time()  # terminar a medição do tempo
        print("Tempo de execução no servidor:", end - start)
        return result

if __name__ == "__main__":
    from rpyc.utils.server import ThreadedServer
    t = ThreadedServer(MyService, port=18861)
    t.start()
