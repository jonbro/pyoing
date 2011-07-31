#include "bludBox2d.h"

const char bludBox2dCircle::className[] = "bludBox2dCircle";

Lunar<bludBox2dCircle>::RegType bludBox2dCircle::methods[] = {
	method(bludBox2dCircle, getX),
	method(bludBox2dCircle, getY),
	method(bludBox2dCircle, getRot),
	method(bludBox2dCircle, addForce),
	method(bludBox2dCircle, destroy),
	{0,0}
};

const char bludBox2d::className[] = "bludBox2d";

Lunar<bludBox2d>::RegType bludBox2d::methods[] = {
	method(bludBox2d, update),
	{0,0}
};
