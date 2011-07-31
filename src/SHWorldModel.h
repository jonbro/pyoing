// and now we come to the point in the development were I actually need to do some development... Oh woe is me

#pragma once
#import "bludSpriteSheet.h"

// manages all of the different types of terrain in the world
// handles how much each bit of terrain has been harvested
/*
class SHTerrainBlockModel{
public:
	// all of the properties
	int type, amountHarvested;
	bludSprite *sprite;
	bool hasPlant;
};
*/

// contains a 2d array of terrain blocks
// handles drawing them to the screen super fast
class SHWorldModel{
public:
	static const char className[];
	static Lunar<SHWorldModel>::RegType methods[];

	int x_size, y_size;
	bludSpriteSheet *sheet;
	float hgridSize;
	float vgridSize;
	SHWorldModel(lua_State *L){
		sheet = Lunar<bludSpriteSheet>::check(L, 1);
		x_size = 200;
		y_size = 200;
		clearModel(L);
		const int screenWidth = ofGetWidth();
		if (screenWidth > 320) {
			hgridSize = 100;
			vgridSize = 100;
		}else {
			hgridSize = 50;
			vgridSize = 50;
		}		
	}
	
	bludSprite *terrain[200][200]; // just going to hard code this for now, don't want to figure out the multidimensional stuff
	bludSprite *plant; // again, going to hard code this in so that 
	bool hasSprite[200][200]; // just going to hard code this for now, don't want to figure out the multidimensional stuff
	bool isFogged[200][200]; // if the terrain is foggy then display it with a different tile
	
	int clearModel(lua_State *L){
		// wipe the has sprite defs
		// also set all the terrain tiles as fogged
		for (int i=0; i<x_size; i++) {
			for (int j=0; j<y_size; j++) {
				hasSprite[i][j] = false;
				isFogged[i][j] = true;
			}
		}
		return 1;
	}
	
	void draw(float camX, float camY);
	int draw(lua_State *L);
	
	int addSpriteAt(lua_State *L);
	void addSpriteAt(bludSprite* sprite, int x, int y);
	
	int setFog(lua_State *L);
	void setFog(int x, int y, bool fog); // sets the terrain as fogged	
	
	~SHWorldModel(){
	}
};