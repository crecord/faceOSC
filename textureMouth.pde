import codeanticode.syphon.*;
import oscP5.*;
OscP5 oscP5;


SyphonClient client;
int found;
float[] rawPoints = new float[131];
PImage img;
PImage[] create = new PImage[3];
float cWidth; 
float cHeight; 
boolean unique; 
PImage currentImg;
int currentImgIndex;


public void setup() {
  unique = true; 
  create[0] = loadImage("img1.png");
  create[1] = loadImage("img2.png");
  create[2] = loadImage("img3.png");
  currentImgIndex=0;
  currentImg = create[0]; 
  cWidth = create[0].width;
  cHeight = create[0].height; 
  size(640, 480, P3D);
  frameRate(30);
  // Create syhpon client to receive frames 
  // from running server with given name:
  oscP5 = new OscP5(this, 8338); 
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "rawRecieved", "/raw");
  client = new SyphonClient(this, "FaceOSC");
  background(0);
}

public void draw() {  
  if (client.available()) {
    // The first time getImage() is called with 
    // a null argument, it will initialize the PImage
    // object with the correct size.
    img = client.getImage(img); // load the pixels array with the updated image info (slow)
    //img = client.getImage(img, false); // does not load the pixels array (faster)
    background(img);
    //background(255,0,0,0);
         if(found > 0) {
    float lastNum = 0; 
    int Idx = 0; 
    /*
    for (int i=100; i< 131; i++){
     float currentNum = rawPoints[i];
      if( i == 0 || i%2==0 ){
        lastNum = currentNum;
        Idx = i;
     }
     else {
       ellipse(lastNum, currentNum, 2, 2);
       String id = str ( Idx); 
       String cur = str ( i); 
       String cords = "x: " + id + ", y: " + cur +""; 
       text (cords, lastNum, currentNum);
     }
    }
   */
  //ellipse (rawPoints[92],rawPoints[93], 2,2); 
 // ellipse (rawPoints[94],rawPoints[95], 2,2); 
 /*
 fill(255,0,0);
  ellipse (rawPoints[96],rawPoints[97], 2,2);
  //ellipse (rawPoints[98],rawPoints[99], 2,2);  
  //ellipse (rawPoints[100],rawPoints[101], 2,2);  
  //ellipse (rawPoints[102],rawPoints[103], 2,2);  
 // fill(0,0,255);
 // ellipse (rawPoints[104],rawPoints[105], 2,2); 
 //fill(0,0,255);  
  //ellipse (rawPoints[106],rawPoints[107], 2,2);
// fill(0,255,0);  
  ellipse (rawPoints[108],rawPoints[109], 2,2);  
  //ellipse (rawPoints[110],rawPoints[111], 2,2);  
  //ellipse (rawPoints[112],rawPoints[113], 2,2);  
  //ellipse (rawPoints[114],rawPoints[115], 2,2);  
  //ellipse (rawPoints[116],rawPoints[117], 2,2);  
  //ellipse (rawPoints[118],rawPoints[119], 2,2); 
 // fill(0,0,255); 
  ellipse (rawPoints[120],rawPoints[121], 2,2);  
  ellipse (rawPoints[122],rawPoints[123], 2,2);  
  ellipse (rawPoints[124],rawPoints[125], 2,2);  
  ellipse (rawPoints[126],rawPoints[127], 2,2);  
  ellipse (rawPoints[128],rawPoints[129], 2,2); 
*/
 /*
 String cords = "1"; 
 text (cords, rawPoints[96],rawPoints[97]);
      cords = "2"; 
 text (cords, rawPoints[122],rawPoints[123]);
      cords = "3"; 
 text (cords, rawPoints[124],rawPoints[125]);
      cords = "4"; 
 text (cords, rawPoints[120],rawPoints[121]);
       cords = "5"; 
 text (cords, rawPoints[128],rawPoints[129]);
       cords = "6"; 
 text (cords, rawPoints[126],rawPoints[127]);
        cords = "7"; 
 text (cords, rawPoints[108],rawPoints[109]);
 println ("the image is width " + cWidth);
 */
 
 beginShape();
 noStroke();
texture(currentImg); 
//1
vertex(rawPoints[96],rawPoints[97], 0, cHeight/2 );
//4
vertex(rawPoints[120],rawPoints[121], cWidth/4 , 0);
//2
vertex(rawPoints[122],rawPoints[123], cWidth/2, 0);
//3
vertex(rawPoints[124],rawPoints[125], cWidth/4 * 3, 0);
//7
vertex(rawPoints[108],rawPoints[109], cWidth , cHeight/2); 
//6
vertex(rawPoints[126],rawPoints[127],cWidth/4 * 3, cHeight);
//5
vertex(rawPoints[128],rawPoints[129],cWidth/2, cHeight);
//1
//vertex(rawPoints[96],rawPoints[97],0, cHeight/2 );

endShape(CLOSE); 

if ((dist(rawPoints[122],rawPoints[123],rawPoints[128],rawPoints[129]) < 5) && (unique == true) ){
   println ("!!!!!");
   if (  currentImgIndex < create.length-1){
       currentImgIndex ++;
   }
   else {
     currentImgIndex = 0;
   }
  currentImg = create[currentImgIndex]; 
  cWidth = currentImg.width;
  cHeight = currentImg.height;    
  unique = false;
}
else if (dist(rawPoints[122],rawPoints[123],rawPoints[128],rawPoints[129]) > 5 ) {
  unique = true; 
}

 // ellipse (rawPoints[130],rawPoints[131], 2,2);  
 
   
   }
    else{
    println ("not found");
    }

    
 
 }
}

void keyPressed() {
  if (key == ' ') {
    client.stop();  
  } else if (key == 'd') {
    println(client.description());
  }
}

public void found(int i) {
  //println("found: " + i);
  found = i;
}


public void switchImg() {
  //println("found: " + i);
}


public void rawRecieved(float[] f) {
 // println("mouth: " + f[0]);
  //pointx =  f[0];
  //pointy =  f[1];
  for (int i=0; i < f.length; i++){
    rawPoints[i] = f[i];
  }
  //nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if(m.isPlugged() == false) {
    //println("UNPLUGGED: " + m);
  }
}


