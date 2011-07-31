#pragma once

#include "ofxBox2d.h"
#include "lunar.h"
class bludBox2d {
public:
	ofxBox2d box2d;
	static const char className[];
	static Lunar<bludBox2d>::RegType methods[];
	bludBox2d(lua_State *L) {
		box2d.init();
		box2d.setGravity(0, 0);
		box2d.createBounds();
		box2d.setFPS(30.0);
	}
	int update(lua_State *L) { box2d.update(); return 0; }
	~bludBox2d() {}
};

class bludBox2dCircle {
public:
	ofxBox2dCircle circle;
	bool destroyed;
	static const char className[];
	static Lunar<bludBox2dCircle>::RegType methods[];
	bludBox2dCircle(lua_State *L) {
		// need to pull out the user data that was passed in on the first parameter
		bludBox2d *w = Lunar<bludBox2d>::check(L, 1);
		circle.setPhysics(luaL_checknumber(L, 2), luaL_checknumber(L, 3), luaL_checknumber(L, 4));
		circle.setup(w->box2d.getWorld(), luaL_checknumber(L, 5), luaL_checknumber(L, 6), luaL_checknumber(L, 7));
		destroyed = false;
	}
	int getX(lua_State *L) {
		if(destroyed){return 0;}
		lua_pushnumber(L, circle.getPosition().x); return 1;
	}
	int getY(lua_State *L) {
		if(destroyed){return 0;}
		lua_pushnumber(L, circle.getPosition().y); return 1;
	}
	int getRot(lua_State *L) {
		if(destroyed){return 0;}
		lua_pushnumber(L, circle.getRotation()); return 1;
	}
	int destroy(lua_State *L) {
		destroyed = true;
		circle.destroy(); return 1;
	}
	int addForce(lua_State *L) {
		if(destroyed){return 0;}
		circle.addForce(ofVec2f(luaL_checknumber(L, 1), luaL_checknumber(L, 2)), luaL_checknumber(L, 3));return 1;
	}
	~bludBox2dCircle() { cout << "freeing circle" << endl;circle.destroy(); cout << "destroying circle" << endl; }
};
