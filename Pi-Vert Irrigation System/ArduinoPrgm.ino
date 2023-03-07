const int ledPin1 = 13; //LED pompe
const int ledPin2 = 12; //LED brumisation
const int relayPin = 3;
int Moisture_signal =A0;
String command;
void setup() {
  pinMode(ledPin1,OUTPUT);
  pinMode(ledPin2,OUTPUT);
  pinMode(relayPin,OUTPUT);
  Serial.begin(9600);}
 
void loop(){
  float Moisture = analogRead(Moisture_signal);
  Serial.println(Moisture);
  if ( Serial.available()){
    command = Serial.readStringUntil('\n');
    command.trim();
    if(command.equals("pompeOn")){
      digitalWrite(ledPin1,HIGH);
      digitalWrite(relayPin,HIGH);
      }
    if(command.equals("pompeOff")){
      digitalWrite(ledPin1,LOW);
      digitalWrite(relayPin,LOW);
      }
    if(command.equals("brumOn")){
      digitalWrite(ledPin2,HIGH);
      }
    if(command.equals("brumOff")){
      digitalWrite(ledPin2,LOW);
      }
    }
  delay(1000);
    }