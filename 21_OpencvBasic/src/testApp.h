#pragma once
#include "ofMain.h"
#include "ofxOpenCv.h"

//#define _USE_LIVE_VIDEO

class testApp : public ofBaseApp{
public:
	void setup();
	void update();
	void draw();
	void keyPressed(int key);
	
	ofVideoGrabber vidGrabber;
		
	ofxCvColorImage colorImg;
	ofxCvGrayscaleImage grayImage;
	ofxCvGrayscaleImage grayBg;
	ofxCvGrayscaleImage grayDiff;
	ofxCvContourFinder contourFinder;
	
	int threshold;
	bool bLearnBakground;
};

