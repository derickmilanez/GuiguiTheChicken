/// @description Insert description here
// You can write your code in this editor
spd = obj_guigui.spd;
if(obj_guigui.dir == 1){
	image_xscale = 1;
	offsetx = obj_guigui.x-64;
	offsety = obj_guigui.y-64;
}else if(obj_guigui.dir == -1){
	image_xscale = -1;
	offsetx = obj_guigui.x+64;
	offsety = obj_guigui.y-64;
}
mp_potential_step(offsetx, offsety, spd*1.2, false);