import ciid2015.exquisitdatacorpse.*;
import oscP5.*;
import netP5.*;
import ddf.minim.*;

//Project as part of Introduction to programming 
NetworkClient mClient;
Minim minim;
AudioPlayer song;
//PFont font;
String [] fontlist = PFont.list();
float mBackgroundColor;
int i, j;
int grid = 71;
int size = 69;
int Margin = (grid-size)/2;
char a; 
PFont[] mFonts;

void setup() {  
  size(displayWidth, displayHeight);
  minim = new Minim(this);
  song = minim.loadFile("noise.mp3");
  frameRate(25);
  mFonts = new PFont[197];
  for (int k=0; k<mFonts.length; k++) {
    mFonts[k] = createFont(fontlist[k], 30);
  }
  mClient = new NetworkClient(this, "edc.local", "sudhanshu");

  a = ' ';
  //textAlign(CENTER, CENTER);
}

boolean sketchFullScreen() {
  return true;
}

void draw() {  
  background(0);
  //if (a == ' ') {
  if (mousePressed && (mouseX>1205) && (mouseX< 1280) &&(mouseY < 780) && (mouseY > 700)) {
    song.rewind();
    song.play();
    drawRandomCharacters();
  } else {
    song.pause();
    drawCharacters();
  }
  drawButton();

  //  if (mousePressed) {
  //    if ((mouseX>1205) && (mouseX< 1280) &&(mouseY < 780) && (mouseY > 700)) {
  //      drawRandomCharacters();
  //    } else  { //if (mouseX!=1205 && mouseY!=720) {
  //      drawMainScreen();
  //    }
  //  } else {
  //    drawCharacters();
  //  }
}

void drawRandomCharacters() {
  background(255);
  fill(255, 0, 0);
  for (int i=0; i<7; i++)
  {
    for (int k=0; k<10; k++)
    {

      float x = random(width);
      float y = random(height);
      //          font = createFont(mFonts[k], 30);
      PFont font = mFonts[k];
      textFont(font, 30);
      text(a, x, y);
    }
  }
}
void drawButton() {
  stroke(200);
  fill(255, 35, 13);
  rect(1205, 710, 70, 70);
}

void drawCharacters() {

  fill(0);
  for (int i=0; i<displayWidth; i+=grid)
  {
    for (int j=0; j<displayHeight; j+=grid)
    {
      stroke(30);
      rect(i+Margin, j+Margin, size, size);
    }
  }
  fonts(a);
}

void mousePressed() {
  mClient.send("sudi", key);
}

void mouseMoved() {
}

void keyPressed() {
  a=key;
  background(0);
}


void fonts(char a) {
  fill(0);
  stroke(30);
  int x = 0, y = 0, k = 0;
  for (int i=0; i<displayWidth; i+=grid) {
    for (int j=0; j<displayHeight; j+=grid) {
      rect(i+Margin, j+Margin, size, size);
    }
  }

  fill(255);
  for (k=0; k<mFonts.length; k++) {
    PFont font = mFonts[k];
    if (k%18 == 0) {
      y=y+71;
      x=0;
    } 
    // textAlign(LEFT);
    textFont(font, 60);
    text(a, x, y);
    x = x+71;
  }
}

void receive(String name, String tag, float x) {
 
    
  if (name.equals("midsummer")){
    println("### received: " + name + " - " + tag + " - " + x);
    a =  (char) x;
  }
}

