#include <SPI.h>
#include <Ethernet.h>

// Enter a MAC address, IP address and Portnumber for your Server below.
// The IP address will be dependent on your local network:
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = {192,168,2,10};
int serverPort=8888;
int servoPin=3;
int velocity = 0;
int pos = 0;
char  ReplyBuffer[] = "acknowledged"; 

// Initialize the Ethernet server library
// with the IP address and port you want to use
EthernetServer server(serverPort);

void setup()
{
  // start the serial for debugging
  Serial.begin(115200);
  // start the Ethernet connection and the server:
  Ethernet.begin(mac, ip);
  server.begin();
  Serial.println("Server started");//debug
}

void loop()
{
  // listen for incoming clients
  EthernetClient client = server.available();
  if (client) {
    //Serial.println("Client Available");
    String commandStr ="";//Connamdstring where incoming commands are stored

    if (client.connected()) {//if a client is connected
      while(client.available()) {//and available
        //reading the inputs from the client
        char c = client.read();
        commandStr+=c;//and ands them to the commands String

        if (c == '\n') {//if a newline character is sent (commandline is fully recieved)
          //Serial.println("Command:"+commandStr);//output the command
          if(commandStr.indexOf("V:")==0){//if the command begins with "set:"
            String value=commandStr;//store the command into a new String
            value.replace("V:", " "); //replace the "set:" from the command string
            velocity = convertToInt(value);
            //Serial.print("velocity: ");
            //Serial.println(velocity);
            int minBrakeDist = velocity*100 - 100;
          }
          else if(commandStr.indexOf("P:")==0){//if the command begins with "set:"
            String value=commandStr;//store the command into a new String
            value.replace("P:", " "); //replace the "set:" from the command string
            pos = convertToInt(value);
            //Serial.print("          position: ");
            //Serial.println(pos);
            int minBrakeDist = pos*100 - 100;
          }
          commandStr="";//reset the commandline String
        }
      }
      client.print('A');
    }
    
    // Send client the acknoledgment
    
    //client.write(ReplyBuffer);
    // give the client time to receive the data
    delay(1);
    // close the connection:
    client.stop();
  }
  Serial.print("Velocity: ");
  Serial.print(velocity);
  Serial.print(" Position: ");
  Serial.println(pos); 
}

int convertToInt(String value){
  char buf[value.length()];
  value.toCharArray(buf,value.length());
  return atoi(buf);
}
