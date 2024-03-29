import socket
import sys
import time

sendData = 0

while 1:
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Connect the socket to the port where the server is listening
    server_address = ('192.168.2.10', 8888)
    print >>sys.stderr, 'connecting to %s port %s' % server_address
    sock.connect(server_address)

    try:
    
        # Send data
        sendData = sendData + 1
        message = 'V:' + str(sendData) + "\n"
        print >>sys.stderr, 'sending "%s"' % message
        sock.sendall(message)

        # Look for the response
        amount_received = 0
        amount_expected = 1
        #amount_expected = len(message)
    
        while amount_received < amount_expected:
            data = sock.recv(12)
            amount_received += len(data)
            print >>sys.stderr, 'received "%s"' % data

    finally:
        print >>sys.stderr, 'closing socket'
        sock.close()

    time.sleep(0.05)