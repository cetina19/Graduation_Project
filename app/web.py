import threading
import socket
from flask import Flask

app = Flask(__name__)


class LoadBalancer:
    def __init__(self, host, port, server_addresses):
        self.host = host
        self.port = port
        self.server_addresses = server_addresses
        self.current_server = 0
        self.lock = threading.Lock()

    def get_next_server_address(self):
        with self.lock:
            address = self.server_addresses[self.current_server]
            self.current_server = (self.current_server + 1) % len(self.server_addresses)
            return address

    def handle_client(self, client_socket):
        server_address = self.get_next_server_address()
        server_socket = socket.create_connection(server_address)

        def forward(source, destination):
            try:
                while True:
                    data = source.recv(1024)
                    if not data:
                        break
                    destination.sendall(data)
            except ConnectionResetError:
                pass 
            except Exception as e:
                print(f"An error occurred: {e}")  
            finally:
                print("Connection Closed")
                source.close()
                destination.close()

        threading.Thread(target=forward, args=(client_socket, server_socket)).start()
        threading.Thread(target=forward, args=(server_socket, client_socket)).start()

    def start(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            s.bind((self.host, self.port))
            s.listen(5)

            while True:
                client_socket, addr = s.accept()
                client_handler = threading.Thread(
                    target=self.handle_client,
                    args=(client_socket,)
                )
                client_handler.start()

def main():
    lb_host = '0.0.0.0'
    lb_port = 8004

    servers = [('172.20.0.2', 5000),('172.20.0.2', 5000),('172.20.0.2', 5000),('172.20.0.2', 5001)]

    load_balancer = LoadBalancer(lb_host, lb_port, servers)
    load_balancer.start()

if __name__ == "__main__":
    main()