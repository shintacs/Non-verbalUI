class SoundAnim{
  PImage[] soundImg;
  int x, y, w, h;
  int imgNum;
  
  SoundAnim(int _x, int _y){
    x = _x;
    y = _y;
    imgNum = 2;
    soundImg = new PImage[4];
    soundImg[0] = loadImage("sound0.png");
    soundImg[1] = loadImage("sound1.png");
    soundImg[2] = loadImage("sound2.png");
    soundImg[3] = loadImage("sound3.png");
  }
  
  void update(float volume){
    if(volume == 0){
      imgNum = 0;
    }else if(volume < 30){
      imgNum = 1;
    }else if(volume < 80){
      imgNum = 2;
    }else if(volume <= 100){
      imgNum = 3;
    }
    image(soundImg[imgNum], x, y, soundImg[imgNum].width*3/5, 32); 
  }
}
