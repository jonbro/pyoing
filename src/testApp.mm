#include "testApp.h"
#include "bludPd.h"
#include "bludBox2d.h"
#include "SHWorldModel.h"

//--------------------------------------------------------------
void testApp::setup(){
	blud.setup();
	Lunar<bludPd>::Register(blud.luaVM);
	Lunar<bludBox2d>::Register(blud.luaVM);
	Lunar<bludBox2dCircle>::Register(blud.luaVM);
	cout << blud.executeFile("ld48m28/core.lua") << endl; // this returns an error code for the compiled code

	ofRegisterTouchEvents(this);

	int ticksPerBuffer = 4;	// 8 * 64 = buffer len of 1024
	
	// setup the app core
	pd = bludPdInstance::getInstance();
	if(!pd->init(2, 0, 22050, ticksPerBuffer)) {
		ofLog(OF_LOG_ERROR, "Could not init pd");
		OF_EXIT_APP(1);
	}
	pd->dspOn();
	Patch patch = pd->openPatch("ld48m28/pdAudio/tutorial_audio.pd");
//	cout << patch << endl;

	ofSoundStreamSetup(2,0,this, 22050, ofxPd::getBlockSize()*ticksPerBuffer, 4);
}

//--------------------------------------------------------------
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){
}
void testApp::audioRequested(float * output, int bufferSize, int nChannels){
	//core.audioRequested(output, bufferSize, nChannels);
	pd->audioOut(output, bufferSize, nChannels);
//	for (int i = 0; i < bufferSize; i++){
//		output[i*nChannels    ] = ofRandomf() * 0.5;
//		output[i*nChannels + 1] = ofRandomf() * 0.5;
//	}
}

//--------------------------------------------------------------
void testApp::exit(){
	
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
	
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
	
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
	
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){
	
}

//--------------------------------------------------------------
void testApp::lostFocus(){
	
}
	
//--------------------------------------------------------------
void testApp::gotFocus(){
	
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
	
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
	
}

