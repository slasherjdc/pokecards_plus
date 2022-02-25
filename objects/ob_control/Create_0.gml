randomize(); //random seed
game_name="Pocket Palette";
game_version="v0.0.0.11";
window_set_caption(game_name + " (" + string(game_version) + ")");
//————————————————————————————————————————————————————————————————————————————————————————————————————
depth=-1000;
//
view_set_visible(view_camera[0],true);
view_set_xport(view_camera[0],0);
view_set_yport(view_camera[0],0);
view_set_wport(view_camera[0],512);
view_set_hport(view_camera[0],288);
camera_set_view_pos(view_camera[0],x,y);
camera_set_view_size(view_camera[0],512,288);
camera_set_view_target(view_camera[0],ob_control);
camera_set_view_border(view_camera[0],99999,99999);
camera_set_view_speed(view_camera[0],-1,-1);
cam_x=camera_get_view_x(view_camera[0]);
cam_y=camera_get_view_y(view_camera[0]);
cam_w=camera_get_view_width(view_camera[0]);
cam_h=camera_get_view_height(view_camera[0]);
surface_resize(application_surface,cam_w,cam_h);
//
var screen_w=display_get_width(), screen_h=display_get_height();
var i=0, biggest_screen_size_found=false;
do {
	i+=1;
	if 512*i>=screen_w or 288*i>=screen_h {
		biggest_screen_size_found=true;
	}
} until (biggest_screen_size_found=true);
window_set_size(512*(i-1),288*(i-1));
//
display_reset(0,true);
window_set_fullscreen(false);
//————————————————————————————————————————————————————————————————————————————————————————————————————
global.sound_level=10;
global.music_level=10;
//————————————————————————————————————————————————————————————————————————————————————————————————————
var button_create;
button_create=instance_create_layer(cam_w-54,150,"instances",ob_button_31x24);
button_create.button_id=0;
button_create=instance_create_layer(cam_w-91,197,"instances",ob_button_16x16);
button_create.button_id=1;
//————————————————————————————————————————————————————————————————————————————————————————————————————
var i=0;
repeat (11) {
	if i<=4 { //0-4 enemy side
		card_space_id[i]=instance_create_layer(100+64*(i),44,"instances",ob_card_space);
		card_space_id[i].trash=false;
	}
	else if i<=9 { //5-9 player side
		card_space_id[i]=instance_create_layer(100+64*(i-5),134,"instances",ob_card_space);
		card_space_id[i].trash=false;
	}
	else { //10 trash
		card_space_id[i]=instance_create_layer(10,44,"instances",ob_card_space);
		card_space_id[i].trash=true;
	}
	i+=1;
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
card_maindeck_total=50;
var i=0;
repeat (card_maindeck_total) {
	card_cat_creation=0;
	card_maindeck[i]=instance_create_layer(cam_w-67,181,"instances",ob_card);
	card_maindeck[i].num_in_maindeck=i;
	i+=1;
}
//
card_berrydeck_total=50;
var i=0;
repeat (card_berrydeck_total) {
	card_cat_creation=1;
	card_berrydeck[i]=instance_create_layer(10,181,"instances",ob_card);
	card_berrydeck[i].num_in_berrydeck=i;
	i+=1;
}
//
card_hand_total=0;
card_hand_max=12;
var i=0;
repeat (card_hand_max) {
	card_hand[i]=-1;
	i+=1;
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
mouse_cursor=0;
cursor_hide=false;
tooltip_text="";
helpmsg_dismissed=false;
player_turn=true;
card_draw_points=2;
card_drawcost_main=2;
card_drawcost_berry=1;
card_focus=-1; //id
card_hold=-1; //id
card_focus_hand=-1;
button_sorthand=false;
button_nextturn=false;
//————————————————————————————————————————————————————————————————————————————————————————————————————
event_active=false;
reset_objects=false;
screen_transition=false;
//
fade_black=0;
textbox_active=false;
text_string="";
text_show="";
text_charnum=1;
text_timer=0;
text_timermax=1;
text_next=false;