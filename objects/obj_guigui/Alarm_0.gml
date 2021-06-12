/// @description Insert description here
// You can write your code in this editor
alarm[0] = 60;
seconds++;
if(seconds > 9){
	seconds = 0;
	tenseconds++;
}

if(tenseconds > 5){
	tenseconds = 0;
	minutes++;
}