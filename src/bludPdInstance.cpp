/*
 *  bludPdInstance.cpp
 *  spaceHero
 *
 *  Created by jonbroFERrealz on 6/29/11.
 *  Copyright 2011 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "bludPdInstance.h"

ofxPd* bludPdInstance::instance = NULL; 

ofxPd* bludPdInstance::getInstance(){
	if (!instance)   // Only allow one instance of class to be generated.
		instance = new ofxPd();
	return instance;	
}