import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent; 
import processing.serial.*;

int xx = 10, yy = 10;
Robot robby;

Serial myPort;  // The serial port
char c = 'a';//start verdi for å stille mus
boolean ringer = false;//bruker for å vite hvilken situasjon det er nå og det er du som ringer andre     
boolean receivedCall = false;//bruker for å vite det er andre som ringer deg      


//Start program      
void setup()
{
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[11], 9600);
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
}

void draw()
{
//Prosessingen starter å stille mus for å klikke sykpe vindu
  if(c == 'a'){
   robby.mouseMove(25, 150); 
   delay(1000);
   robby.mousePress(InputEvent.BUTTON1_MASK);
   delay(50);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
   robby.mousePress(InputEvent.BUTTON1_MASK);
   delay(50);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
   c = 0;
  }
  // Might need to confine to sketch's window…
 //Hvis det finnes noen verdi som blir skrives paa terminaren, skal verdiene leses og legge inn variabelen c
  while (myPort.available() > 0) { 
     char inByte = (char)myPort.read(); 
     c = inByte;
  }    
     //println(c);
//Ved å skille de forskjellige verdiene i c, kan musen gjøre forskjellige handlinger
  if(c == '2'){//ringer 1.person i nummer listen
   robby.mouseMove(25, 150);//beveger mus
   robby.mousePress(InputEvent.BUTTON1_MASK);//trykker på
   robby.mouseRelease(InputEvent.BUTTON1_MASK);//slippe av
   delay(50);
  // for å double sikre at knappen trykkes
   robby.mousePress(InputEvent.BUTTON1_MASK);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
//klikke ring på 1.person
   robby.mouseMove(325, 240); 
   robby.mousePress(InputEvent.BUTTON1_MASK);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
   delay(50);
   robby.mousePress(InputEvent.BUTTON1_MASK);
   delay(50);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
   ringer = true;
   c = 0;//for å starte en ny handling
  }else if(c == '3'){ //ringer 2.person i nummer listen
   robby.mouseMove(25, 150); 
   robby.mousePress(InputEvent.BUTTON1_MASK);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
   delay(50);
   robby.mousePress(InputEvent.BUTTON1_MASK);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
//klikke ring på 2.person
   robby.mouseMove(325, 190); 
   robby.mousePress(InputEvent.BUTTON1_MASK);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
   delay(50);
   robby.mousePress(InputEvent.BUTTON1_MASK);
   delay(50);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
   ringer = true;
   c = 0;
  }else if(c=='x'&&ringer&&!receivedCall){ // stops current call
   ringer = false;
   robby.mouseMove(830, 875); 
   robby.mousePress(InputEvent.BUTTON1_MASK);
   robby.mouseRelease(InputEvent.BUTTON1_MASK);
    c = 0;
  }else if (c == 'b'){ //answer call
     robby.mouseMove(800, 460); 
     robby.mousePress(InputEvent.BUTTON1_MASK);
     robby.mouseRelease(InputEvent.BUTTON1_MASK);
     c = 0;
     ringer = true;
     receivedCall = true;
  }else if(c == 'c' && !ringer){ //decline incoming call
     robby.mouseMove(650, 460); 
     robby.mousePress(InputEvent.BUTTON1_MASK);
     robby.mouseRelease(InputEvent.BUTTON1_MASK);
     c = 0;
  }else if(c == 'c' && ringer && receivedCall){ //decline current call
     robby.mouseMove(830, 875); 
     robby.mousePress(InputEvent.BUTTON1_MASK);
     robby.mouseRelease(InputEvent.BUTTON1_MASK);
     c = 0;
     receivedCall = false;
  }
  
  
}