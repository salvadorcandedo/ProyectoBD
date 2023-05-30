#!c:/Python/python.exe

from pwn import *
import requests, signal, time, pdb, sys, string
def def_handler(sig, frame):
    print("\n\n SALIENDO...")
    sys.exit(1)
## Ctrl C
signal.signal(signal.SIGINT, def_handler)

if __name__ =='__main__':

    time.sleep(10)