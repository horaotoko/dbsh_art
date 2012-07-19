#include "testApp.h"

void testApp::setup(){
	//ofBackground(0, 0, 0);
	ofSetFrameRate(60);
	ofEnableAlphaBlending();
	
	vidGrabber.setVerbose(true);
	vidGrabber.initGrabber(320,240);
	
	colorImg.allocate(320,240);
	grayImage.allocate(320,240);
    //colorImg.allocate(1024,768);
	//grayImage.allocate(1024,768);
	
	grayBg.allocate(320,240);
	grayDiff.allocate(320,240);
	//grayBg.allocate(1024,768);
	//grayDiff.allocate(1024,768);
	
	bLearnBakground = true;
	  threshold = 100;
	
}

void testApp::update(){
	
	
    bool bNewFrame = false;
	
	vidGrabber.grabFrame();
	bNewFrame = vidGrabber.isFrameNew();
	
	if (bNewFrame){
		colorImg.setFromPixels(vidGrabber.getPixels(), 320,240);
		
        grayImage = colorImg;
		if (bLearnBakground == true){
			grayBg = grayImage;
			bLearnBakground = false;
		}
		
		grayDiff.absDiff(grayBg, grayImage);
		grayDiff.threshold(threshold);
		
		contourFinder.findContours(grayDiff, 20, (320,240), 10, true);
	}
}

void testApp::draw(){
	
	ofFill();
	ofSetColor(0, 31, 255, 200);
	for(int i = 0;i<(int)contourFinder.blobs.size(); i++){
		ofBeginShape();
		  for (int j=0; j<contourFinder.blobs[i].nPts; j++) {
			  ofVertex(contourFinder.blobs[i].pts[j].x * 4,contourFinder.blobs[i].pts[j].y * 4);
		  }
			  ofEndShape();
		  }
	
	ofSetColor(0xffffff);
	char reportStr[1024];
	sprintf(reportStr, "threshold %i (press: +/-)\nnum blobs found %i",
			threshold, contourFinder.nBlobs);
	ofDrawBitmapString(reportStr, 20,10);
	
	//ofSetHexColor(0x333333);
	//ofRect(0,0,ofGetWidth(),ofGetHeight());
	//ofSetHexColor(0xffffff);
	//contourFinder.draw(0,0);
	
	
}

void testApp::keyPressed(int key){
	switch (key){
		case ' ':
			bLearnBakground = true;
			break;
		case '+':
			threshold ++;
			if (threshold > 255) threshold = 255;
			break;
		case '-':
			threshold --;
			if (threshold < 0) threshold = 0;
			break;
	}
}
