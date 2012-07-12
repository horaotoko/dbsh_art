#include "testApp.h"

void testApp::setup(){
	ofSetFrameRate(60);
	ofEnableAlphaBlending();
	
	vidGrabber.setVerbose(true);
	//vidGrabber.initGrabber(320,240);
	vidGrabber.initGrabber(640,480);
	
    colorImg.allocate(640,480);
	grayImage.allocate(640,480);
	grayBg.allocate(640,480);
	grayDiff.allocate(640,480);
	//grayDiff.allocate(640,480);
	
	bLearnBakground = true;
	  threshold = 100;
	
}

void testApp::update(){
	ofBackground(100,100,100);
	
    bool bNewFrame = false;
	
	vidGrabber.grabFrame();
	bNewFrame = vidGrabber.isFrameNew();
	
	if (bNewFrame){
		colorImg.setFromPixels(vidGrabber.getPixels(), 640,480);
		
        grayImage = colorImg;
		if (bLearnBakground == true){
			grayBg = grayImage;
			bLearnBakground = false;
		}
		
		grayDiff.absDiff(grayBg, grayImage);
		grayDiff.threshold(threshold);
		
		contourFinder.findContours(grayDiff, 20, (640*480)/3, 10, true);
	}
}

void testApp::draw(){
	
	ofFill();
	ofSetHexColor(0x333333);
	ofRect(0,0,ofGetWidth(),ofGetHeight());
	
	ofSetHexColor(0xffffff);
	contourFinder.draw(0,0);
	
	
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
