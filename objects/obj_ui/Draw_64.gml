/// @description Insert description here
// You can write your code in this editor
var scr = obj_guigui.scr;
var minutes = obj_guigui.minutes;
var tenseconds = obj_guigui.tenseconds;
var seconds = obj_guigui.seconds;
var corns = obj_guigui.corns;
var guardianlife = obj_guigui.guardianlife;
draw_set_color(c_yellow);
draw_set_font(fnt_ui);
draw_text(28,28,"SCORE:");
draw_text(28,28*2,"TIME:");
draw_text(28,28*3,"CORNS:");

draw_set_color(c_white);
draw_text(28*5,28,string(scr));
draw_text(28*4,28*2,string(minutes) + ":" + string(tenseconds) + string(seconds));
draw_text(28*5,28*3,string(corns));

if(obj_guigui.guardian){
	draw_set_color(c_green);
	draw_text(28,28*4,"GUARDIAN LIFE:");
	draw_set_color(c_white);
	draw_text(28*10,28*4,string(guardianlife));
}
