//Trying to use iTunes for the first time
import processing.video.*;
import controlP5.*;
Movie myMovie;

ControlP5 slider;
ControlP5 slider2;
ControlP5 slider3;
SoundAnim sound;

int brightValue = 200;
float soundValue = 50;
boolean playMode = true;
boolean changeLang = false;
int playNum = 2;
float angle = 0;
int sliding = 280; 
int langMode; //0: English, 1: Japanese, 2: Global

PFont japaneseFont;
String title;

PImage[] img;
PImage[] jpnImg;

void setup(){
  size(320, 568);
  
  langMode = 0;
  
  //images for global UI
  img = new PImage[11];
  img[0] = loadImage("brightness.png");
  img[1] = loadImage("language2.png");
  img[2] = loadImage("play.png");
  img[3] = loadImage("playback.png");
  img[4] = loadImage("skip.png");
  img[5] = loadImage("stop.png");
  img[6] = loadImage("america.png");
  img[7] = loadImage("japan.png");
  img[8] = loadImage("global.png");
  
  //images for Japanese UI
  jpnImg = new PImage[8];
  jpnImg[0] = loadImage("brightnessjp.png");
  jpnImg[1] = loadImage("skipjp.png");
  jpnImg[2] = loadImage("playjp.png");
  jpnImg[3] = loadImage("playbackjp.png");
  jpnImg[4] = loadImage("volumejp.png");
  jpnImg[5] = loadImage("stopjp.png");
  jpnImg[6] = loadImage("merryjp.png");
  jpnImg[7] = loadImage("namejp.png");
  
  //initialize classes
  slider = new ControlP5(this);
  slider2 = new ControlP5(this);
  slider3 = new ControlP5(this);
  sound = new SoundAnim(16, 480);
  
  //load a Font
  japaneseFont = loadFont("HiraKakuProN-W3-48.vlw");
  textFont(japaneseFont, 24);
  
  //the title of the movie
  title = "Merry-go-round";
  
  //setting for a slider
  int sliderColor = color(230, 0, 0);
    slider.addSlider("brightValue", 127, 255, 200.0, 60, 73, 200, 5)
      .setLabel("")
      .setColorForeground(sliderColor);
    
    slider.getController("brightValue")
      .getValueLabel();
    
    //slider for sounds
    slider2.addSlider("soundValue", 0, 100, 50, 60, 493, 200, 5)
      .setLabel("")
      .setColorForeground(sliderColor);
    
    slider2.getController("soundValue")
      .getValueLabel();
      
  //initialize the movie class
  myMovie = new Movie(this, "merry.mp4");
  myMovie.play();
  myMovie.pause();
}

void draw(){
  background(brightValue); //set the brightness
  myMovie.volume(soundValue/100); //set the volume
  
  if(langMode == 0){ //English
    textSize(12);
    text("brightness", 0, 70);
    textSize(22);
    if(playNum == 2){
      text("play", 140, 400);
    }else{
      text("pause", 136, 400);
    }
    text("back", 50, 400);
    text("skip", 220, 400);
    textSize(14);
    text("volume", 5, 500);
    textSize(22);
    text(title, 20, 340);
    textSize(16);
    text("17T2018A Shintaro Ito", 130, 555);
  }else if(langMode == 1){//Japanese
    image(jpnImg[0], 5, 66, 50, 16); //brightness
    image(jpnImg[playNum], 136, 378, 50, 24); //play or stop
    image(jpnImg[1], 206, 378, 68, 24); //skip
    image(jpnImg[3], 46, 378, 75, 24); //playback
    image(jpnImg[4], 16, 486, 33, 16); //sound
    image(jpnImg[6], 10, 310, 150, 26);
    image(jpnImg[7], 130, 545, 180, 16);
    
  }else{//Global
    image(img[0], 10, 60, 32, 32); //brightness
    image(img[playNum], 136, 378, 48, 48); //play or stop
    image(img[3], 46, 378, 48, 48); //playback
    image(img[4], 226, 378, 48, 48); //skip
    image(jpnImg[6], 10, 310, 150, 26);
    sound.update(soundValue);
    image(jpnImg[7], 130, 545, 180, 16);
  }
  
  image(myMovie, 0, 120, 320, 180);
  
  textSize(12);
  fill(0, 0, 0);
  text(nf(hour(), 2)+":"+nf(minute(),2), 10, 10, 40, 20);
  
  if(changeLang){
    selectLang();
  }else{
    image(img[1], 280, 10, 32, 32);
    changeLang = false;
    angle = 0;
    sliding = 280;
  }
}

void movieEvent(Movie m){
  m.read();
}

void mousePressed(){
  float movieTime = myMovie.time();
  
  //when a user clicks flags or the earth
  if(changeLang){
    if((mouseX > 140 && mouseX < 140 + 43) && (mouseY > 10 && mouseY < 10 + 32)){//french
      langMode = 0;
    }else if((mouseX > 190 && mouseX < 190 + 43) && (mouseY > 10 && mouseY < 10 + 32)){//japanese
      langMode = 1;
    }else if((mouseX > 240 && mouseX < 240 + 32) && (mouseY > 10 && mouseY < 10 + 32)){//global
      langMode = 2;
    }
    changeLang = false;
  }
  
  if((mouseX > 136 && mouseX < 136 + 48) &&(mouseY > 378 && mouseY < 378 + 48)){
    //clicks for playing
    if(playMode){
      playNum = 5;
      playMode = false;
      myMovie.play();
    }else{
      playNum = 2;
      playMode = true;
      myMovie.pause();
    }
  }else if((mouseX > 46 && mouseX < 46 + 48) && (mouseY > 378 && mouseY < 378 + 48)){
    //clicks for playing back
    float playback = movieTime - 10;
    if(playback > 0){
      myMovie.jump(movieTime - 10);
    }else{
      myMovie.jump(0);
    }
  }else if((mouseX > 226 && mouseX < 226 + 48) && (mouseY > 378 && mouseY < 378 + 48)){
    //clicks for skipping
    float skip = movieTime + 10;
    if(skip < myMovie.duration()){
      myMovie.jump(movieTime + 10);
    }else{
      myMovie.jump(myMovie.duration()-0.01);
    }
  }else if((mouseX > 280 && mouseX < 280 + 32) && (mouseY > 10 && mouseY < 10 + 32)){
    //clicks for the global mark
    changeLang = true;
  }else{
    ;
  }
}

void selectLang(){
  //motion of the global mark
  imageMode(CENTER);
  
  pushMatrix();
  translate(295, 26);
  if(angle < radians(180)){
    angle += 0.2;
  }else{
    angle = radians(180);
  }
  rotate(angle);
  image(img[1], 0, 0, 32, 32);
  popMatrix();
  
  imageMode(CORNER);
  if(sliding > 140){//motion of the flags
    sliding -= 10;
  }else if(sliding < 140){
    sliding = 140;
  }
  image(img[6], sliding, 10, 43, 32); //usa flag
  image(img[7], sliding + 50, 10, 43, 32); //japanese flag
  image(img[8], sliding + 100, 10, 32, 32); //global mark
}
