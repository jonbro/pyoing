#include "SHWorldModel.h"

const char SHWorldModel::className[] = "SHWorldModel";

Lunar<SHWorldModel>::RegType SHWorldModel::methods[] = {
	method(SHWorldModel, addSpriteAt),
	method(SHWorldModel, clearModel),
	method(SHWorldModel, setFog),
	method(SHWorldModel, draw),
	{0,0}
};


int SHWorldModel::draw(lua_State *L){
	draw(luaL_checknumber(L, 1), luaL_checknumber(L, 2));
	return 1;
}
void SHWorldModel::draw(float camX, float camY){
	// hardcode in the number of vertical and hori steps for now
	const int xSteps = 10;
	const int ySteps = 17;

	
	// calculate the starting position on the grid
	float xOffset, xOffRem;
	float yOffset, yOffRem;
	
	camX /= hgridSize;
	camY /= vgridSize;
	
	xOffRem = modf(camX, &xOffset);
	yOffRem = modf(camY, &yOffset);
	int x, y, xpos, ypos;
	xpos = -xOffRem*hgridSize;
	for (int i=0; i<xSteps; i++) {
		ypos = -yOffRem*vgridSize;
		for (int j=0; j<ySteps; j++) {
			x = i+xOffset;
			y = j+yOffset;
			if (
				x > 0 && x < x_size &&
				y > 0 && y < y_size &&
				hasSprite[x][y]
			) {
				// not sure why that -24 is in there now... might need to get rid of it
				// only render if the terrain is not fogged
				if(isFogged[x][y]){
					sheet->spriteRenderer->addTile(&terrain[x][y]->ani, xpos, ypos, -1, F_NONE, 255, 255, 255,50);
				}else {
					sheet->spriteRenderer->addTile(&terrain[x][y]->ani, xpos, ypos);					
				}
			}
			ypos += vgridSize;
		}
		xpos += hgridSize;
	}
}
void SHWorldModel::addSpriteAt(bludSprite* sprite, int x, int y){
	terrain[x][y] = sprite;
	hasSprite[x][y] = true;
}
int SHWorldModel::addSpriteAt(lua_State *L){
	// just calls the above function	int addCenteredTile(lua_State *L)  {
	// need to pull out the user data that was passed in on the first parameter
	bludSprite *s = Lunar<bludSprite>::check(L, 1);
	addSpriteAt(s, luaL_checknumber(L, 2), luaL_checknumber(L, 3));
	return 1;
}

int SHWorldModel::setFog(lua_State *L)
{
	setFog(luaL_checknumber(L, 1), luaL_checknumber(L, 2), lua_toboolean(L,3));
	return 1;
}
void SHWorldModel::setFog(int x, int y, bool fog)
{
	isFogged[x][y] = fog;
}