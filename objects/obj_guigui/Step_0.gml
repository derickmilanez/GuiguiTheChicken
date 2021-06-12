/// @description Insert description here
// You can write your code in this editor

//walks and checks collision with solid objects
if(!disabled){
	if(keyboard_check(vk_right) && place_free(x+spd,y)){
		spd+=runspd;
		x+=spd;
		sprite_index = spr_guigui_walk;
		image_xscale = 1;
		image_speed += 0.1;
		dir = 1;
	}else if(keyboard_check(vk_left) && place_free(x-spd,y)){
		spd+=runspd;
		x-=spd;
		sprite_index = spr_guigui_walk;
		image_xscale = -1;
		image_speed += 0.1;
		dir = -1;
	}else{
		sprite_index = spr_guigui;
		image_speed = 1;
		spd = initspd
	}
}

if(spd>maxspd){
	spd=maxspd
}

//spins
if(keyboard_check(vk_down) && spd>6){
	if(audio_is_playing(snd_spin) == false) {
		audio_play_sound(snd_spin,1,false);
	}
	if(spd<=16 && spd>12){
		spinMaxFrames = 60*3;
		image_speed = 3;
	}else if(spd<=12 && spd>8){
		spinMaxFrames = 60*2;
		image_speed = 2;
	}else if(spd<=8 && spd>6){
		spinMaxFrames = 60;
		image_speed = 1;
	}
	spin = true;
	disabled = true;
}

if(spin){
	spinFrames++;
	sprite_index = spr_guigui_spin;
	if(place_free(x+spd,y) && dir == 1){
		x+=spd;
	}
	
	if(place_free(x-spd,y) && dir == -1){
		x-=spd;
	}
	
	if(spinFrames>=spinMaxFrames){
		spinFrames = 0;
		spin = false;
		disabled = false;
	}
}

//jumps
if(keyboard_check(ord("Z"))){
	if(audio_is_playing(snd_jump) == false) {
		audio_play_sound(snd_jump,1,false);
	}
	if(!place_free(x,y+1)){
		jump = true;
		spin = false;
		disabled = false;
	}
}

if(jump){
	if(jumpFrames<=jumpHeight){
		if(place_free(x,y-jmpspd)){
			jumpFrames+=jmpspd;
			y-=jmpspd;
			sprite_index = spr_guigui_jmp;
		}else{
			jump = false;
			jumpFrames = 0;
		}
	}else{
		jump = false;
		jumpFrames = 0;
	}
}


//free fall
if(!jump){
	if(place_free(x,y+spdfall)&& !onsloper && !onslopel){
		y+=spdfall;
		spdfall+=grv;
		sprite_index = spr_guigui_jmp;
		if(spdfall>maxspdfall){
			spdfall = maxspdfall;
		}
		//colision while jumping
		if(place_meeting(x,y,obj_robot)){
			jump = true;
			var obj = instance_place(x,y,obj_robot);
			scr+=100;
			instance_destroy(obj);
			audio_play_sound(snd_destroy,1,false);
		}else if(place_meeting(x,y,obj_guardian_box)){
			jump = true;
			if(guardiancount == 0){
			var obj = instance_place(x,y,obj_guardian_box);
			}
			scr+=100;
			instance_destroy(obj);
			instance_create_depth(x-64, y-64, -1, obj_guardian);
			audio_play_sound(snd_guardian,1,false);
			guardian = true;
			guardianlife += 10;
			guardiancount++;
		}
		
	}else{
		spdfall = initialspdfall;
		while(place_free(x,y+1)){
			y++;
		}
	}
}

//spin attack
if(place_meeting(x,y,obj_robot) && spin){
	var obj = instance_place(x,y,obj_robot);
	scr+=100;
	instance_destroy(obj);
	audio_play_sound(snd_destroy,1,false);

}else if(place_meeting(x,y,obj_guardian_box) && spin){
	var obj = instance_place(x,y,obj_guardian_box);
	scr+=100;
	instance_destroy(obj);
	if(guardiancount == 0){
		instance_create_depth(x-64, y-64, -1, obj_guardian);
	}
	audio_play_sound(snd_guardian,1,false);
	guardian = true;
	guardianlife += 10;
	guardiancount++;
}

//damaged
if(place_meeting(x,y,obj_robot)){
	damaged = true;
}else{
	damaged = false;
}

//damaged guardian
if(damaged && guardian){
	if(random(100) < 50){
		guardianlife--;
		damaged = false;
	}
}

//guardian life
if(guardianlife < 0){
	var obj = instance_place(x,y,obj_guardian);
	instance_destroy(obj);
	guardiancount = 0;
	guardian = false;
}

//corn damage
if(damaged && !guardian){
	if(random(100) < 50){
		corns--;
	}
}

//death
if(corns < 0){
	room_restart();
}

//collision corn
if(place_meeting(x,y,obj_corn)){
	audio_play_sound(snd_ring,1,false);
	var obj = instance_place(x,y,obj_corn);
	corns++;
	instance_destroy(obj);
}

//slope right
if(place_meeting(x+spd,y,obj_grass_slope_r)){
	while(place_meeting(x+spd,y,obj_grass_slope_r)){
		y-=spd;
		onsloper = true;
	}
}else{
	onsloper = false;
}

//slope left
if(place_meeting(x-spd,y,obj_grass_slope_l)){
	while(place_meeting(x-spd,y,obj_grass_slope_l)){
		y-=spd;
		onslopel = true;
	}
}else{
	onslopel = false;
}

//Camera
camera_set_view_pos(view_camera[0], x-view_wport[0]/2, y-view_hport[0]/2);
if(camera_get_view_x(view_camera[0]) < 0){
	camera_set_view_pos(view_camera[0], 0, y-view_hport[0]/2);
}