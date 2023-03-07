#Les biblioteque utilisées
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import pyrebase

import board
import adafruit_dht

import serial

import threading
import time
from time import sleep
from datetime import datetime,timedelta


#>>>>>>>>>>>>>>>>>>>>>>>>>>Configuration de firebase

#>>>>>>>Firestore Databse
cred = credentials.Certificate("/home/pi/Desktop/Firestore/serviceAccountKey.json")
firebase_admin.initialize_app(cred)
db = firestore.client()
callback_done = threading.Event()

#>>>>>>>Realtime Databse
config = {
  "apiKey": "AIzaSyAINcyp_SqvlsOc0fMa8ciTYyllMO0wfFo",
  "authDomain": "system-d-arrosage.firebaseapp.com",
  "databaseURL": "https://system-d-arrosage-default-rtdb.firebaseio.com",
  "projectId": "system-d-arrosage",
  "storageBucket": "system-d-arrosage.appspot.com",
  "messagingSenderId": "852160365626",
  "appId": "1:852160365626:web:876caf0cb2b8a9a2d16103"
};
firebase = pyrebase.initialize_app(config)
storage = firebase.storage()
database = firebase.database()

#>>>>>>>>>>>>>>>>>>>>>>>>>>Configuration de DHT22 
dhtDevice = adafruit_dht.DHT22(board.D4, use_pulseio=False)

#>>>>>>>>>>>>>>>>>>>>>>>>>>Fonctions<<<<<<<<<<<<<<<<<<<<<<<<<<

#>>>>>>>>>>>>>>>>>>>>>>>>>>Initialisation System
#Initialisation Système
def Initialisation():
    #Les variables du system
    global mode
    mode = "manuel"
    global arroser
    arroser = False
    global brumisation
    brumisation = False 
    global Notif
    Notif = False
    #Les variables de la plante
    global Max_Moisture
    Max_Moisture =600
    global Min_Moisture
    Min_Moisture =450
    global Max_humidity
    Max_humidity= 79
    global Min_humidity
    Min_humidity= 80
    global min_Temp
    min_Temp=15
    global max_Temp
    max_Temp=35
    
    global Humidity_actuelle
    global Moisture_actuelle
    global Temperature_actuelle
    Humidity_actuelle = 40
    Moisture_actuelle = 600
    Temperature_actuelle = 20
    
    global date_verif
    date_verif= datetime.today()   
    global date_brum
    date_brum = datetime.today()
    global freq_brum
    freq_brum = 5
    
    reading = db.collection('Informations').document('Plante 1').get()
    doc_dict = reading.to_dict()
    moisture = doc_dict['moisture']
    humidity = doc_dict['humidity']
    #Initialiser la temperature maximale et minimale
    max_Temp = doc_dict['max_Temp']
    min_Temp = doc_dict['min_Temp']
    #Initialiser l'humidity de sol maximale et minimale
    if(moisture == "low"):
        Max_Moisture = 1000
        Min_Moisture = 601
    else:
        if(moisture == "normal"):
            Max_Moisture = 600 
            Min_Moisture = 450
        else:
            Max_Moisture = 449
            Min_Moisture = 0
            #Min_Moisture = 50
    #Initialiser l'humidity de l'air maximale et minimale      
    if(humidity == "low"):
        Max_Humidity = 59
        Min_Humidity = 0
        #Min_Moisture = 10
    else:
        if(humidity == "normal"):
            Max_Humidity = 79
            Min_Humidity = 60
        else:
            Max_Humidity = 100
            Min_Humidity = 80
            #Min_Moisture = 50
        
    #Initialiser les diffirents variables du system
    db.collection('Informations').document('System').update(
        {'mode' : 'manuel',
         'arroser' : False,
         'brumisation': True,
         'notification': True,
            })
    
    ser.write(b"pompeOff\n")

#>>>>>>>>>>>>>>>>>>>>>>>>>>Detecter les changements des variables
#Les variables de la plante
def on_snapshot_plante(snapshots, changes, read_time):
    for doc in snapshots:
         global Max_Moisture
         global Min_Moisture
         global Max_humidity
         global Min_humidity
         global min_Temp
         global max_Temp
         docDict= doc.to_dict()
         humidity = docDict['humidity']
         max_Temp = docDict['max_Temp']
         min_Temp = docDict['min_Temp']
         moisture = docDict['moisture']
         if (moisture == 'normal'):
             Max_Moisture =600 
             Min_Moisture=450
         else :
             if (moisture =='low'):
                 Max_Moisture = 1000
                 Min_Moisture=601
             else :
                 if (moisture == 'high'):
                     Max_Moisture = 449
                     Min_Moisture=0
         if (humidity== 'normal'):
             Max_humidity = 100
             Min_humidity=90
         else:
             if (humidity =='low'):
                Max_humidity = 59
                Min_humidity=0
             else: 
                 if (humidity == 'high'):
                     Max_humidity = 100
                     Min_humidity=80        
    callback_done.set()    

#Les variables du system
def on_snapshot_system(snapshots, changes, read_time):
    for doc in snapshots:
        docDict= doc.to_dict()
        md = docDict['mode']  
        arr = docDict['arroser']
        Ntf=docDict['notification']
        brm = docDict['brumisation']
        global mode
        global arroser
        global Notif
        global brumisation
        mode = md
        arroser=arr
        Notif = Ntf
        brumisation = brm 
    callback_done.set()
    
#>>>>>>>>>>>>>>>>>>>>>>>>>>Recuperer les valeurs des capteurs
def get_temperature(temp):
    try :
        temperature_c = dhtDevice.temperature
        time.sleep(2)
        database.child("Data")
        database.update({'Temperature': temperature_c})
        temp = temperature_c
    except RuntimeError as error:
         # Errors happen fairly often, DHT's are hard to read, just keep going
        print(error.args[0])
    except Exception as error:
        dhtDevice.exit()
        raise error
    finally :
        return temp

def get_humidity(hum):
    i=0
    while(i<4):
        try :
            humidity = dhtDevice.humidity
            time.sleep(2)
            database.child("Data")
            database.update(
             {'Humidity': humidity})
            hum= humidity
            i=6
        except RuntimeError as error:
            #Errors happen fairly often, DHT's are hard to read, just keep going
            #print(error.args[0])
            i=i+1
        except Exception as error:
            dhtDevice.exit()
            i=i+1
            raise error
        finally :
            return hum 

def get_moisture(mstr,ser):
    try :
        while ser.in_waiting >0:
           line = ser.readline().decode('utf-8').rstrip()
           mstr =float(line) 
        database.child("Data")
        database.update(
         {'Moisture': mstr})
    except Exception as err:
        print("Error :")
    print(mstr)
    return mstr

#>>>>>>>>>>>>>>>>>>>>>>>>>>Envoyer les donnees a Firebase
#>>>>>>>>>>>>>Envoyer les valeurs des capteurs a BDD a temps reel
def send_to_firebase():
    global Humidity_actuelle
    global Moisture_actuelle
    global Temperature_actuelle    
    Humidity_actuelle= get_humidity(Humidity_actuelle)
    time.sleep(0.2)
    Moisture_actuelle = get_moisture(Moisture_actuelle,ser)
    time.sleep(0.2)
    Temperature_actuelle = get_temperature(Temperature_actuelle)
    time.sleep(0.2)
    D=datetime.now()
    D_str=D.strftime("%H:%M:%S")
    database.child("Data")
    database.update({'Time': D_str})
#>>>>>>>>>>>>>Envoyer les notifications a Firestore database
def write_notification(notification):
    db.collection('Informations').document('Sortie').update(
        {'notification' :notification,
         'NewNotif' :True})
#>>>>>>>>>>>>>Envoyer l'etat de la plante
def write_Etat(etat,prct):
    db.collection('Informations').document('Sortie').update(
        {'Etat_Plante' :etat,
         'Etat_prct' : prct})
def Etat_Plante():
    global Humidity_actuelle
    global Moisture_actuelle
    global Temperature_actuelle
    Humidity_actuelle = get_humidity(Humidity_actuelle)
    Moisture_actuelle = get_moisture(Moisture_actuelle,ser)
    Temperature_actuelle = get_temperature(Temperature_actuelle)
    print("etat temp",Temperature_actuelle)
    print("etat temp min",min_Temp)
    if(Humidity_actuelle>Min_humidity and Humidity_actuelle<Max_humidity):
        if(Moisture_actuelle>Min_Moisture and Moisture_actuelle<Max_Moisture):
            if(Temperature_actuelle>min_Temp and Temperature_actuelle<max_Temp):
                write_Etat("votre plante est en bonne santé",0.95)
            else :
                write_Etat("La température n'est pas convenable pour votre plante !!",0.60)
                write_notification("Alert La température n'est pas convenable pour votre plante !!")
        else :
           write_Etat("L'humidité de sol n'est pas convenable pour votre plante !!",0.30)        
    else :
        write_Etat("L'humidité de l'air n'est pas convenable pour votre plante !!",0.80)
#>>>>>>>>>>>>>>Envoyer les dates
def Send_date_arrosage(date_arrosage):
    db.collection('Informations').document('Sortie').update(
        {'prochain_arrosage' :date_arrosage })
    
def Send_date_brum(date_brum):
    db.collection('Informations').document('Sortie').update(
        {'prochaine_brumisation' :date_brum })
    
def Send_der_arrosage(date_arrosage):
    db.collection('Informations').document('Sortie').update(
        {'dernier_arrosage' :date_arrosage })
    
def Send_der_brum(date_brum):
    db.collection('Informations').document('Sortie').update(
        {'derniere_brumisation' :date_brum })

#>>>>>>>>>>>>>>>>>>>>>>>>>>Desactiver l'arrosage
def turn_off():
    db.collection('Informations').document('System').update(
        {'arroser':False})

#>>>>>>>>>>>>>>>>>>>>>>>>>>Gestion du temps
def add_time(date,a):
    hours = timedelta(minutes = a)
    return(date+hours)


#>>>>>>>>>>>>>>>>>>>>>>>>>> Main <<<<<<<<<<<<<<<<<<<<<<<<<<

#>>>>Definir la porte du capteur d'humidité de sol
try :
    ser = serial.Serial('/dev/ttyACM1', 9600, timeout=1)
    ser.flush()
except Exception as error :
    ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
    ser.flush()

#>>>>Initialisation
Initialisation()

#>>>>Appel de la fonction Snapshot pour les deux documents
doc_ref = db.collection(u'Informations').document(u'Plante 1')
doc_watch = doc_ref.on_snapshot(on_snapshot_plante)

doc2 = db.collection(u'Informations').document(u'System')
doc2_watch = doc2.on_snapshot(on_snapshot_system)

while True:
    while mode == 'automatique':
        date_act = datetime.today()
        if (date_act >= date_verif):
            Moisture_actuelle = get_moisture(Moisture_actuelle,ser)
            if Moisture_actuelle > Max_Moisture :
                if Notif == True :
                    write_notification("l'arrosage va commencer")
                hum_sol_init = Moisture_actuelle
                send_to_firebase()
#>>>>>>>>>>>>>>>>>>>Arrosage1
                ser.write(b"pompeOn\n")
                while Moisture_actuelle > (hum_sol_init + (Max_Moisture+Min_Moisture)/2) / 2:
                    Moisture_actuelle =get_moisture(Moisture_actuelle,ser)
                    print('arroser1')
                    #send_to_firebase()
                    if ((mode == "manuel") and (arroser == True)):
                        write_notification("Veuillez attendre jusqu'a la fin d'arrosage")
                        turn_off()
                    time.sleep(2)
                ser.write(b"pompeOff\n")
                
                if(mode=="manuel"):
                    break
                
#>>>>>>>>>>>>>>>>>>>>>>>>Attendre 10 min
                print('waiting')
                time.sleep(2)
                send_to_firebase()
                
#>>>>>>>>>>>>>>>>>>>>>>>Arrosage2
                ser.write(b"pompeOn\n")
                Moisture_actuelle =get_moisture(Moisture_actuelle,ser)
                while Moisture_actuelle> (Max_Moisture+Min_Moisture)/2:
                    Moisture_actuelle =get_moisture(Moisture_actuelle,ser)
                    print('arroser2')
                    #send_to_firebase()
                    if ((mode == "manuel") and (arroser == True)):
                        write_notification("Veuillez attendre jusqu'a la fin d'arrosage")
                        turn_off()
                    time.sleep(2)
                ser.write(b"pompeOff\n")
                send_to_firebase()
                
                if (Notif == True ):
                    write_notification("l'arrosage est términé")
#>>>>>>>>>>>>>>>>>>>>>>>>>>Fin de l'arrosage
                    
                    
#>>>>>>>>>>>>>>>>>>>>>>>>>>Mise a jour des dates                  
                date_act= datetime.today()
                Send_der_arrosage(date_act)
                date_verif=add_time(date_act,3)
                Send_date_arrosage(date_verif)
    
            else:  #>>>>>>>>>>>>>>>>>>> pas d'arrosage
                date_act= datetime.today()
                date_verif=add_time(date_act,1)
                Send_date_arrosage(date_verif)
        send_to_firebase()      
        if(mode=="manuel"):
            break
        print('etat')
        Etat_Plante()
        if(mode=="manuel"):
            break
        #print("______")
        #print(Min_Moisture);
        if(brumisation==True):
            #print("inn")
            date_brum_act = datetime.today()
            if(date_brum_act >= date_brum):
                #Humidity_actuelle=get_humidity(Humidity_actuelle)
                #print (Humidity_actuelle)
                #print(Min_humidity)
                if(Humidity_actuelle< Min_humidity):
                    print("doing brumisation");
                    ser.write(b"brumOn\n")
                    send_to_firebase()
                    if (Notif == True ):
                        write_notification("brumisation commencée")
                    time.sleep(2)
                    ser.write(b"brumOff\n")
                    if (Notif == True ):
                        write_notification("brumisation terminée")
                    Send_der_brum(date_brum_act)
                    date_brum = add_time(date_brum_act,freq_brum)
                    print("send date")
                    Send_date_brum(date_brum)

#>>>>>>>>>>>>mode manuel
                    
    while  mode =="manuel":
        print('----')
        #Etat_Plante()
        if arroser == True :
            if Notif == True :
                write_notification("l'arrosage va commencer ")            
            #GPIO.output(LED,high)
            ser.write(b"pompeOn\n")
            i=0
            send_to_firebase()
            while (i<=4 ):                    
                #send_to_firebase()
                print("hi")
                time.sleep(0.5)
                if mode == "automatique" :
                    if Notif == True :
                        write_notification("veuillez attendre jusqu'à la fin de l'arrosage")
                i=i+1
            ser.write(b"pompeOff\n")
            turn_off()
            if Notif == True :
                write_notification("l'arrosage est términé")
            send_to_firebase()
        else:
            print('-----')
            send_to_firebase()
            i=0
            while(i<1):
                if(arroser==True)or(mode=='automatique'):
                    break
                time.sleep(0.5)
                i=i+1
                #print(i)
