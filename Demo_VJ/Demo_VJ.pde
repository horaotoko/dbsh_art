import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
AudioPlayer song1;


//import fullscreen.*;
//FullScreen fs;


import japplemenubar.*;
import TUIO.*;
TuioProcessing tuioClient;

float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;


int counter;
int[] j = new int[11];
//import processing.video.*;

//String[] cams = Capture.list();
//println(cams);


void setup()
{
  
    //fs = new FullScreen(this);
    //fs.enter();

  size(1024,768);
    
  minim = new Minim(this);
  song = minim.loadFile("Nautilas- 80kidz.mp3");
  song1 = minim.loadFile("Little One.mp3");
  
  
  
  size(1280,800);
  background(255);
  colorMode(HSB);
  noCursor();
   frameRate(20);   
  rectMode(CENTER);
  textAlign(CENTER);
  smooth();
  
  scale_factor = height/table_size;
   
  tuioClient  = new TuioProcessing(this);
  
  counter = 0;
}

void draw()
{
  background(255);
  
  float obj_size = object_size*scale_factor;
  float obj_point = obj_size;
  
  float cur_size = cursor_size*scale_factor; 
  
   
  Vector tuioObjectList = tuioClient.getTuioObjects();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);
     stroke(0);
    
     pushMatrix();
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());      
     
     float ad = tobj.getAngleDegrees();
    

//ここからオブジェクトの編集   
 
          
 switch (tobj.getSymbolID()){
     
      
   case 0:    // images
               
       popMatrix();
      float d2 = random(width)/2-20;
   
  float d1 = width/2 - (d2+40);  
  smooth();  
  noFill(); 
  strokeWeight(random(20,40)); 
  stroke (random(255), random(255), random(255));
  ellipse (width-(width/4), height/2, d1+ad, d1+ad);
  ellipse (width/4, height/2, d2+ad, d2+ad);
      
      
       pushMatrix();
   break;


    case 1:    //animation1
       
       popMatrix();
        noStroke();
         fill(random(200),255,255);
         ellipse(random(width),random(height),ad,ad);
         ellipse(random(width),random(height),ad,ad);
         noFill();
   
        //frameRate(20);  //フレームレートを戻す
      
        pushMatrix();
  
   break;


    case 2: //animation2  
             
       popMatrix();
     
      for(j[0] = 0; j[0] < ad/6; j[0]++){
   
         float cl1 = random(0,50);
         float cl2 = random(0,50);
         fill(cl1,cl2,cl2,20);
     
         float xx = random(width);
         float yy = random(height);
       strokeWeight(5);
       rect(xx,yy,10+ad/2,10+ad/2);      
   }     
  
   pushMatrix();
  
   break;
  
  
   case 3:    // object changer
                
       popMatrix();
    
    background(255);
  fill(random(300),200,200);
  noStroke();
    rect(0,random(height),width*2,20+ad);
    rect(random(width),0,20+ad,height*2);
    rect(width,random(height),width*2,20+ad);
    rect(random(width),height,20+ad,height*2);
     
       pushMatrix();
   
   break;     

  
  case 4:    // line

   popMatrix(); 
   noStroke();
   int triDistance = 20+int(ad);
 
 for (int x = 10; x<width; x=x+triDistance)
 {
   for (int y = 10; y<= height; y=y+triDistance) {
     fill(random(256), random(256), random(256));
     ellipse(x, y, 10, 10);
     }
 } 



   pushMatrix();
   break;

   case 5:   // rect
     
   popMatrix();
   strokeWeight(2);
   stroke(random(255));
   for( j[1] = 0 ; j[1]< ad/6; j[1]++){
     noFill();
     rect(width/2,height/2,random(width)+obj_size,random(height)+obj_size);
    }   
   
   pushMatrix();
   break;

  case 6:   // watch
     
   popMatrix();
                     
int anzahl = 10;
int value= 0;
float winkel = 0;
  
  strokeWeight(5); 
  background(255);
   
 if (winkel > TWO_PI) {
    winkel = 0;
  } 
   
  for ( j[2]=0; j[2] < 7; j[2] = j[2] + 1) {
     
   //rotate (winkel);
  
      stroke(4);
       
    fill (random(255),random(300),300);
    
    ellipse (width/2, height/2, 180 - j[2] * 40*random(5), 180 - j[2] * 40*random(5));
   
  winkel = winkel + 0.004;  
  }
   
   pushMatrix();
   break;
  
    case 7:   // lines
     
   popMatrix();
   
  stroke(0,100);
  strokeWeight(random(0,20));
 
  for( j[3] = 0 ; j[3]< ad/3; j[3]++){
     
    line(width/2, height/2, random(0,width),random(0, height) ); 
     }   
      
 strokeWeight(1);
 noStroke();  
   
   pushMatrix();
   break;
   
    case 8:   // lines
     
   popMatrix();
 background(255);  
 strokeWeight(5); 
   beginShape(TRIANGLE_STRIP);

fill(random(255),random(255),random(255),random(5,100));

vertex(random(0,width),random(0,height));
vertex(random(0,width),random(0,height));
vertex(random(0,width),random(0,height));
vertex(random(0,width),random(0,height));
vertex(random(0,width),random(0,height));
vertex(random(0,width),random(0,height));
vertex(random(0,width),random(0,height));
vertex(random(0,width),random(0,height));

endShape();
//fill(random(255),random(255),random(255),random(5,100));
      
   pushMatrix();
   break;

   case 9:   // lines
     
   popMatrix();
   noStroke();
  
   fill(random(255));
  
  
    rect(random(width),0,ad,height*2);
    rect(random(width),height,ad,height*2);
   
   noFill();
   noStroke();
   
   pushMatrix();
   break;
   
    
     case 10:    // object for interaction tester 
       //popMatrix();
    
       if(ad < 180){
       
       song.play();
       }else{
       song.pause();
       song.rewind();
       }
       //pushMatrix();
   break;  
    
    case 16:   // sounds 
    
    popMatrix();
     if(ad < 180){
       
       song1.play();
       }else{
       song1.pause();
       song1.rewind();
       }
  
    pushMatrix();  
    break;
    
    
    
}           
     popMatrix();
 
 //copy( 0,0,width/2,height,width/2,0,width,height);
  

}
       
   
   Vector tuioCursorList = tuioClient.getTuioCursors();
   for (int i=0;i<tuioCursorList.size();i++) {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      Vector pointList = tcur.getPath();
      
      if (pointList.size()>0) {
        stroke(0,0,255);
        TuioPoint start_point = (TuioPoint)pointList.firstElement();;
        for (int j=0;j<pointList.size();j++) {
           TuioPoint end_point = (TuioPoint)pointList.elementAt(j);
           line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
           start_point = end_point;
        }
        
        stroke(192,192,192);
        fill(192,192,192);
        ellipse( tcur.getScreenX(width), tcur.getScreenY(height),cur_size,cur_size);
        fill(200,0,0);
        text(""+ tcur.getCursorID(),  tcur.getScreenX(width)-5,  tcur.getScreenY(height)+5);
      }
   }
   
}
void stop()
{
  song.close();
  minim.stop();
  super.stop();
}

// these callback methods are called whenever a TUIO event occurs

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}
