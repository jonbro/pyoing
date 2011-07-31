#pragma once
#import "ofxPd.h"

class bludPdInstance {
public:
	static ofxPd* getInstance();
private:
	static ofxPd *instance;
};
