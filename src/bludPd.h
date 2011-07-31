// a wrapper around ofxPd

#pragma once
#import "ofxPd.h"
#import "bludPdInstance.h"

class bludPd : public ofxPdListener {
public:
	static const char className[];
	static Lunar<bludPd>::RegType methods[];
	bludPd(lua_State *L) {
		// load the pd instance that we are dealing with
		pd = bludPdInstance::getInstance();
		pd->addListener(*this);
	}
	int sendBang(lua_State *L){
		pd->sendBang(luaL_checkstring(L, 1));
		return 1;
	}
	int startList(lua_State *L){
		pd->startList(luaL_checkstring(L, 1));
		return 1;
	}
	int finish(lua_State *L){
		pd->finish();
		return 1;
	}
	int addFloat(lua_State *L){
		pd->addFloat(luaL_checknumber(L,1));
		return 1;
	}
	int addSymbol(lua_State *L){
		pd->addSymbol(luaL_checkstring(L,1));
		return 1;
	}
	void printReceived(const std::string& message) {
		cout << "pd: " << message << endl;
	}	
	~bludPd() {}
private:
	ofxPd *pd;
};

const char bludPd::className[] = "bludPd";

Lunar<bludPd>::RegType bludPd::methods[] = {
	method(bludPd, sendBang),
	method(bludPd, startList),
	method(bludPd, finish),
	method(bludPd, addFloat),
	method(bludPd, addSymbol),
	{0,0}
};