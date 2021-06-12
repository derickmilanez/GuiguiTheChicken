/// @description Insert description here
// You can write your code in this editor

//free fall
if(place_free(x,y+spdfall)){
	y+=spdfall;
	spdfall+=grv;
	if(spdfall>maxspdfall){
		spdfall = maxspdfall;
	}
}else{
	spdfall = initialspdfall;
	while(place_free(x,y+1)){
		y++;
	}
}


//movement
if(dir == 1){
	image_xscale = -1;
	if(place_free(x+spd,y) && !place_free(x+64,y+spd)){
		x+=spd;
	}else{
		dir = -1;
	}
}

if(dir == -1){
	image_xscale = 1;
	if(place_free(x-spd,y) && !place_free(x-64,y+spd)){
		x-=spd;
	}else{
		dir = 1;
	}
}