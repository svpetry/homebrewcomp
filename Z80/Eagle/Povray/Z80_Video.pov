//POVRay-Datei erstellt mit 3d41.ulp v1.05
//X:/Sven/Elektronik/Eagle/Z80/Z80_Video.brd
//01.08.2010 08:38:02

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 512;
#local cam_z = -229;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -10;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 60;
#local lgt1_pos_y = 91;
#local lgt1_pos_z = 53;
#local lgt1_intense = 0.928571;
#local lgt2_pos_x = -60;
#local lgt2_pos_y = 91;
#local lgt2_pos_z = 53;
#local lgt2_intense = 0.928571;
#local lgt3_pos_x = 60;
#local lgt3_pos_y = 91;
#local lgt3_pos_z = -36;
#local lgt3_intense = 0.928571;
#local lgt4_pos_x = -60;
#local lgt4_pos_y = 91;
#local lgt4_pos_z = -36;
#local lgt4_intense = 0.928571;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 160.000000;
#declare pcb_y_size = 100.000000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(590);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animationsdaten
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "Keine/zu wenig Animationsdaten vorhanden (mind. 3 Punkte) (Flugpfad)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "Keine/zu wenig Animationsdaten vorhanden (mind. 3 Punkte) (Blickpunktpfad)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//versetzt die Kamera, sodass <0,0,0> über dem Eagle-Nullpunkt ist
	//translate<-80.000000,0,-50.000000>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro Z80_VIDEO(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Platine
prism{-1.500000,0.000000,8
<0.000000,0.000000><160.000000,0.000000>
<160.000000,0.000000><160.000000,100.000000>
<160.000000,100.000000><0.000000,100.000000>
<0.000000,100.000000><0.000000,0.000000>
texture{col_brd}}
}//End union(Platine)
//Bohrungen(real)/Bauteile
cylinder{<27.740000,1,92.710000><27.740000,-5,92.710000>1.500000 texture{col_hls}}
cylinder{<2.740000,1,92.710000><2.740000,-5,92.710000>1.500000 texture{col_hls}}
//Bohrungen(real)/Platine
//Bohrungen(real)/Durchkontaktierungen
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Bauteile
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<3.810000,0.000000,71.120000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C1 100n C050-025X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<88.900000,0.000000,77.470000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C2 100n C050-025X075
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<88.900000,0.000000,60.960000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C3 100n C050-025X075
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<106.680000,0.000000,15.240000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C4 100n C050-025X075
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<136.525000,0.000000,6.350000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C5 100n C050-025X075
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<22.860000,0.000000,19.050000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C6 100n C050-025X075
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<41.910000,0.000000,64.770000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C7 100n C050-025X075
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<3.810000,0.000000,38.100000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C8 100n C050-025X075
#ifndef(pack_C9) #declare global_pack_C9=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<133.350000,0.000000,60.960000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C9 100n C050-025X075
#ifndef(pack_C10) #declare global_pack_C10=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<133.350000,0.000000,52.070000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C10 100n C050-025X075
#ifndef(pack_C11) #declare global_pack_C11=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<146.050000,0.000000,36.830000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C11 100n C050-025X075
#ifndef(pack_C12) #declare global_pack_C12=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<87.630000,0.000000,92.710000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C12 100n C050-025X075
#ifndef(pack_C13) #declare global_pack_C13=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<55.880000,0.000000,82.550000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C13 100n C050-025X075
#ifndef(pack_C14) #declare global_pack_C14=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<111.760000,0.000000,92.710000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C14 100n C050-025X075
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO35_102MM_H("BAT43",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<149.225000,0.000000,85.090000>}#end		//Diode DO35 10mm hor. D1 BAT43 DO35-10
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP14("74LS125N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<100.330000,0.000000,60.960000>translate<0,3.000000,0> }#end		//DIP14 IC1 74LS125N DIL14
#ifndef(pack_IC1) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<100.330000,0.000000,60.960000>}#end					//IC-Sockel 14Pin IC1 74LS125N
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP16("74HC590","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<147.320000,0.000000,60.960000>translate<0,3.000000,0> }#end		//DIP16 IC2 74HC590 DIL16
#ifndef(pack_IC2) object{SOCKET_DIP16()rotate<0,0.000000,0> rotate<0,0,0> translate<147.320000,0.000000,60.960000>}#end					//IC-Sockel 16Pin IC2 74HC590
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_DIS_DIP14("74LS125N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<67.310000,0.000000,81.280000>translate<0,3.000000,0> }#end		//DIP14 IC3 74LS125N DIL14
#ifndef(pack_IC3) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<67.310000,0.000000,81.280000>}#end					//IC-Sockel 14Pin IC3 74LS125N
#ifndef(pack_IC4) #declare global_pack_IC4=yes; object {IC_DIS_DIP16("74HC590","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<147.320000,0.000000,45.720000>translate<0,3.000000,0> }#end		//DIP16 IC4 74HC590 DIL16
#ifndef(pack_IC4) object{SOCKET_DIP16()rotate<0,0.000000,0> rotate<0,0,0> translate<147.320000,0.000000,45.720000>}#end					//IC-Sockel 16Pin IC4 74HC590
#ifndef(pack_IC5) #declare global_pack_IC5=yes; object {IC_DIS_DIP16("74LS42N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<101.600000,0.000000,77.470000>translate<0,3.000000,0> }#end		//DIP16 IC5 74LS42N DIL16
#ifndef(pack_IC5) object{SOCKET_DIP16()rotate<0,0.000000,0> rotate<0,0,0> translate<101.600000,0.000000,77.470000>}#end					//IC-Sockel 16Pin IC5 74LS42N
#ifndef(pack_IC6) #declare global_pack_IC6=yes; object {IC_DIS_DIP28("text ram","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,39.370000>translate<0,3.000000,0> }#end		//DIP28 300mil IC6 text ram DIL28-3
#ifndef(pack_IC6) object{SOCKET_DIP28()rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,39.370000>}#end					//IC-Sockel 28Pin IC6 text ram
#ifndef(pack_IC7) #declare global_pack_IC7=yes; object {IC_DIS_DIP16("74367N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<35.560000,0.000000,20.320000>translate<0,3.000000,0> }#end		//DIP16 IC7 74367N DIL16
#ifndef(pack_IC7) object{SOCKET_DIP16()rotate<0,0.000000,0> rotate<0,0,0> translate<35.560000,0.000000,20.320000>}#end					//IC-Sockel 16Pin IC7 74367N
#ifndef(pack_IC8) #declare global_pack_IC8=yes; object {IC_DIS_DIP16("74367N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<58.420000,0.000000,20.320000>translate<0,3.000000,0> }#end		//DIP16 IC8 74367N DIL16
#ifndef(pack_IC8) object{SOCKET_DIP16()rotate<0,0.000000,0> rotate<0,0,0> translate<58.420000,0.000000,20.320000>}#end					//IC-Sockel 16Pin IC8 74367N
#ifndef(pack_IC9) #declare global_pack_IC9=yes; object {IC_DIS_DIP40_W("PIC18F4455_40","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<107.950000,0.000000,26.670000>translate<0,3.000000,0> }#end		//DIP40 IC9 PIC18F4455_40 DIL40
#ifndef(pack_IC9) object{SOCKET_DIP40W()rotate<0,0.000000,0> rotate<0,0,0> translate<107.950000,0.000000,26.670000>}#end					//IC-Sockel 40Pin 600mil IC9 PIC18F4455_40
#ifndef(pack_IC10) #declare global_pack_IC10=yes; object {IC_DIS_DIP28("character ram","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,57.150000>translate<0,3.000000,0> }#end		//DIP28 300mil IC10 character ram DIL28-3
#ifndef(pack_IC10) object{SOCKET_DIP28()rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,57.150000>}#end					//IC-Sockel 28Pin IC10 character ram
#ifndef(pack_IC11) #declare global_pack_IC11=yes; object {IC_DIS_DIP14("74LS08N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<123.190000,0.000000,92.710000>translate<0,3.000000,0> }#end		//DIP14 IC11 74LS08N DIL14
#ifndef(pack_IC11) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<123.190000,0.000000,92.710000>}#end					//IC-Sockel 14Pin IC11 74LS08N
#ifndef(pack_IC12) #declare global_pack_IC12=yes; object {IC_DIS_DIP20("74HCT573N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<19.050000,0.000000,52.070000>translate<0,3.000000,0> }#end		//DIP20 IC12 74HCT573N DIL20
#ifndef(pack_IC12) object{SOCKET_DIP20()rotate<0,0.000000,0> rotate<0,0,0> translate<19.050000,0.000000,52.070000>}#end					//IC-Sockel 20Pin IC12 74HCT573N
#ifndef(pack_IC14) #declare global_pack_IC14=yes; object {IC_DIS_DIP20("74LS245N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<19.050000,0.000000,36.830000>translate<0,3.000000,0> }#end		//DIP20 IC14 74LS245N DIL20
#ifndef(pack_IC14) object{SOCKET_DIP20()rotate<0,0.000000,0> rotate<0,0,0> translate<19.050000,0.000000,36.830000>}#end					//IC-Sockel 20Pin IC14 74LS245N
#ifndef(pack_IC15) #declare global_pack_IC15=yes; object {IC_DIS_DIP14("74LS00N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<146.050000,0.000000,77.470000>translate<0,3.000000,0> }#end		//DIP14 IC15 74LS00N DIL14
#ifndef(pack_IC15) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<146.050000,0.000000,77.470000>}#end					//IC-Sockel 14Pin IC15 74LS00N
#ifndef(pack_IC16) #declare global_pack_IC16=yes; object {IC_DIS_DIP14("74F04N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<43.180000,0.000000,81.280000>translate<0,3.000000,0> }#end		//DIP14 IC16 74F04N DIL14
#ifndef(pack_IC16) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<43.180000,0.000000,81.280000>}#end					//IC-Sockel 14Pin IC16 74F04N
#ifndef(pack_IC17) #declare global_pack_IC17=yes; object {IC_DIS_DIP14("74LS86N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<100.330000,0.000000,92.710000>translate<0,3.000000,0> }#end		//DIP14 IC17 74LS86N DIL14
#ifndef(pack_IC17) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<100.330000,0.000000,92.710000>}#end					//IC-Sockel 14Pin IC17 74LS86N
#ifndef(pack_IC18) #declare global_pack_IC18=yes; object {IC_DIS_DIP20("74HCT573N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<19.050000,0.000000,67.310000>translate<0,3.000000,0> }#end		//DIP20 IC18 74HCT573N DIL20
#ifndef(pack_IC18) object{SOCKET_DIP20()rotate<0,0.000000,0> rotate<0,0,0> translate<19.050000,0.000000,67.310000>}#end					//IC-Sockel 20Pin IC18 74HCT573N
#ifndef(pack_IC19) #declare global_pack_IC19=yes; object {IC_DIS_DIP14("74AC74N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<148.590000,0.000000,27.940000>translate<0,3.000000,0> }#end		//DIP14 IC19 74AC74N DIL14
#ifndef(pack_IC19) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<148.590000,0.000000,27.940000>}#end					//IC-Sockel 14Pin IC19 74AC74N
#ifndef(pack_IC20) #declare global_pack_IC20=yes; object {IC_DIS_DIP14("7432N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<146.050000,0.000000,92.710000>translate<0,3.000000,0> }#end		//DIP14 IC20 7432N DIL14
#ifndef(pack_IC20) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<146.050000,0.000000,92.710000>}#end					//IC-Sockel 14Pin IC20 7432N
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<121.920000,0.000000,9.525000>}#end		//Diskrete 5MM LED LED1 power LED5MM
#ifndef(pack_QG2) #declare global_pack_QG2=yes; object {SPC_XTAL_OSZ_DIP14("50 MHz",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<147.955000,0.000000,11.430000>}#end		//Quarzoszillator im DIP14 QG2 50 MHz DIL14S
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<90.170000,0.000000,83.820000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R1 4K7 0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<93.980000,0.000000,86.360000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R2 4K7 0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<127.000000,0.000000,82.550000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R3 4K7 0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<22.860000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R4 500 0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<12.700000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R5 500 0207/10
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<17.780000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R6 500 0207/10
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<20.320000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R7 500 0207/10
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<15.240000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R8 500 0207/10
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<25.400000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R9 500 0207/10
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<5.080000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R10 500 0207/10
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<10.160000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R11 500 0207/10
#ifndef(pack_R12) #declare global_pack_R12=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<7.620000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R12 500 0207/10
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_DIS_0207_10MM(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<142.240000,0.000000,53.340000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R13 330 0207/10
#ifndef(pack_R14) #declare global_pack_R14=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<83.820000,0.000000,8.890000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R14 4K7 0207/10
#ifndef(pack_R15) #declare global_pack_R15=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<111.760000,0.000000,9.525000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R15 560 0207/10
#ifndef(pack_R16) #declare global_pack_R16=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<67.310000,0.000000,93.980000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R16 680 0207/10
#ifndef(pack_R18) #declare global_pack_R18=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<53.340000,0.000000,88.900000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R18 4K7 0207/10
#ifndef(pack_R19) #declare global_pack_R19=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<50.800000,0.000000,73.660000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R19 4K7 0207/10
#ifndef(pack_SL1) #declare global_pack_SL1=yes; object {PH_1X12()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<45.720000,0.000000,5.080000>}#end		//Stiftleiste 2,54mm Raster 12Pin 1Reihe (pinhead.lib) SL1 address bus 12P
#ifndef(pack_SL2) #declare global_pack_SL2=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<16.510000,0.000000,5.080000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL2 data bus 08P
#ifndef(pack_SL3) #declare global_pack_SL3=yes; object {PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<69.850000,0.000000,5.080000>}#end		//Stiftleiste 2,54mm Raster 4Pin 1Reihe (pinhead.lib) SL3 control bus 04P
#ifndef(pack_SL4) #declare global_pack_SL4=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<6.350000,0.000000,19.050000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL4 power 03P
}//End union
#end
#if(pcb_pads_smds=on)
//Lötaugen&SMD/Bauteile
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<3.810000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<3.810000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<88.900000,0,80.010000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<88.900000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<88.900000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<88.900000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<109.220000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<104.140000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<139.065000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<133.985000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<22.860000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<22.860000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<39.370000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<44.450000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<3.810000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<3.810000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<133.350000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<133.350000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<133.350000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<133.350000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<148.590000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<143.510000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<87.630000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<87.630000,0,95.250000> texture{col_thl}}
#ifndef(global_pack_C13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<55.880000,0,80.010000> texture{col_thl}}
#ifndef(global_pack_C13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<55.880000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_C14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<111.760000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_C14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<111.760000,0,95.250000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<154.305000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<144.145000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.250000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.330000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<102.870000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.410000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.410000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<102.870000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.330000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.250000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<156.210000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<156.210000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.770000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.310000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<69.850000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.390000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<74.930000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<74.930000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.390000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<69.850000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.310000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.770000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<156.210000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<156.210000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.250000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.330000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<102.870000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.410000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<110.490000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<110.490000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.410000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<102.870000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.330000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.250000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<26.670000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<29.210000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<31.750000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<34.290000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<36.830000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<39.370000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<41.910000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<44.450000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<44.450000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<41.910000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<39.370000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<36.830000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<34.290000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<31.750000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<29.210000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<26.670000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.530000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.070000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<54.610000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.150000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.770000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.310000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.310000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.770000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.150000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<54.610000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.070000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.530000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<83.820000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<86.360000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<88.900000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<91.440000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<93.980000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<96.520000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<99.060000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<101.600000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<104.140000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<106.680000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<109.220000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<111.760000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<114.300000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<116.840000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<119.380000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<121.920000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<124.460000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<127.000000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<129.540000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<132.080000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<132.080000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<129.540000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<127.000000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<124.460000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<121.920000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<119.380000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<116.840000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<114.300000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<111.760000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<109.220000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<106.680000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<104.140000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<101.600000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<99.060000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<96.520000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<93.980000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<91.440000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<88.900000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<86.360000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<83.820000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<115.570000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<118.110000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<120.650000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<123.190000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<125.730000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<128.270000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<130.810000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<130.810000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<128.270000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<125.730000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<123.190000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<120.650000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<118.110000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<115.570000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.250000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.330000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<102.870000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.410000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.410000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<102.870000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.330000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.250000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<156.210000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<156.210000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.670000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<120.650000,0,9.525000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<123.190000,0,9.525000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<151.765000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<151.765000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<144.145000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<144.145000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<95.250000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<85.090000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<99.060000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<88.900000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<121.920000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<132.080000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<22.860000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<22.860000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<12.700000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<12.700000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<17.780000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<17.780000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<20.320000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<20.320000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<15.240000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<15.240000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<10.160000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<10.160000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<7.620000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<7.620000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<147.320000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<137.160000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<78.740000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<88.900000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<116.840000,0,9.525000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<106.680000,0,9.525000> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<67.310000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<67.310000,0,99.060000> texture{col_thl}}
#ifndef(global_pack_R18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<48.260000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_R18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<58.420000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_R19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<45.720000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_R19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<55.880000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<31.750000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<34.290000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<36.830000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<39.370000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<41.910000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<44.450000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<46.990000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.530000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.070000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<54.610000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.150000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<73.660000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<10.911000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<13.197000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<15.483000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<17.769000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<20.055000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<9.768000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<12.054000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.340000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<16.626000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<18.912000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<10.911000,0,95.250000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<13.197000,0,95.250000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<15.483000,0,95.250000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<17.769000,0,95.250000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.611200,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<20.055000,0,95.250000> texture{col_thl}}
//Lötaugen/Durchkontaktierungen
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<7.620000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<26.670000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<7.620000,0,58.420000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<26.670000,0,58.420000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<34.925000,0,96.520000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<93.980000,0,14.605000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.655000,0,93.980000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<91.440000,0,14.605000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<53.340000,0,92.710000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<83.820000,0,92.710000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<57.150000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<43.180000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<80.010000,0,29.210000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<80.010000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<68.580000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<60.960000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<60.960000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<77.470000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<77.470000,0,30.480000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<74.930000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<74.930000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<73.660000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<73.660000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<71.120000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<71.120000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<57.150000,0,63.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<73.660000,0,63.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<73.660000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<73.660000,0,46.990000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<55.880000,0,48.260000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<62.230000,0,48.260000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<140.335000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<114.300000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<132.080000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<132.080000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<134.620000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<116.840000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<41.275000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<35.560000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<41.910000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<58.420000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<58.420000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<48.260000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<59.690000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<11.430000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<29.210000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<46.990000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<26.670000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<67.945000,0,10.795000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<45.720000,0,10.795000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<95.250000,0,46.990000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<95.250000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<115.570000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<102.870000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<113.030000,0,67.310000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<105.410000,0,67.310000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<101.600000,0,85.090000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<132.715000,0,85.090000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<99.060000,0,83.820000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<119.380000,0,83.820000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<133.350000,0,40.640000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<139.700000,0,39.370000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<69.850000,0,87.630000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<69.850000,0,91.440000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<67.310000,0,74.930000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<85.090000,0,74.930000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<80.010000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<59.690000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<130.810000,0,78.740000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<116.840000,0,78.740000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<135.890000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<152.400000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<17.780000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<34.925000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<58.420000,0,50.800000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<45.720000,0,50.800000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<20.320000,0,43.180000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,43.180000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<115.570000,0,45.720000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<68.580000,0,45.720000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<62.230000,0,45.720000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<27.940000,0,45.720000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<73.660000,0,66.040000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<58.420000,0,66.040000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<7.620000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<24.130000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<29.210000,0,28.575000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<54.610000,0,28.575000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<35.560000,0,40.640000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<35.560000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,58.420000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,85.090000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<135.890000,0,97.790000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<111.760000,0,97.790000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<135.890000,0,95.250000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<135.890000,0,81.280000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<133.350000,0,78.740000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<133.350000,0,66.040000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signale
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.810000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,40.640000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<3.810000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,55.880000>}
box{<0,0,-0.508000><15.240000,0.035000,0.508000> rotate<0,90.000000,0> translate<5.080000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.810000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,68.580000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<3.810000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,68.580000>}
box{<0,0,-0.508000><12.700000,0.035000,0.508000> rotate<0,90.000000,0> translate<5.080000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,71.120000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,90.000000,0> translate<5.080000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,76.200000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<5.080000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<5.080000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<6.350000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,24.130000>}
box{<0,0,-0.711200><2.839806,0.035000,0.711200> rotate<0,-63.430762,0> translate<6.350000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,33.020000>}
box{<0,0,-0.711200><8.890000,0.035000,0.711200> rotate<0,90.000000,0> translate<7.620000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,40.640000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.080000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,40.640000>}
box{<0,0,-0.508000><7.620000,0.035000,0.508000> rotate<0,90.000000,0> translate<7.620000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,55.880000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.080000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,71.120000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.080000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,81.280000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.080000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,86.879000>}
box{<0,0,-0.304800><0.519000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,86.879000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,45.720000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<8.890000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<7.620000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,57.785000>}
box{<0,0,-0.304800><1.419903,0.035000,0.304800> rotate<0,26.563298,0> translate<7.620000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,57.785000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<8.890000,-1.535000,57.785000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,90.000000,0> translate<8.890000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<6.350000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,8.890000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,12.700000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<7.620000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,33.020000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<8.890000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,40.640000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,46.990000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<8.890000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<8.890000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<8.890000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<8.890000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,76.200000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<7.620000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,86.879000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.911000,-1.535000,90.170000>}
box{<0,0,-0.304800><4.654177,0.035000,0.304800> rotate<0,-44.997030,0> translate<7.620000,-1.535000,86.879000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<10.160000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,35.560000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,44.450000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<10.160000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<10.160000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,59.055000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,7.620000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<10.160000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,33.020000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<11.430000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<11.430000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<11.430000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,59.055000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<11.430000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,72.390000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<10.160000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,76.200000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.197000,-1.535000,86.857000>}
box{<0,0,-0.304800><0.702864,0.035000,0.304800> rotate<0,-44.997030,0> translate<12.700000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.197000,-1.535000,86.857000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.197000,-1.535000,90.170000>}
box{<0,0,-0.304800><3.313000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.197000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<12.700000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,29.210000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.970000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,46.990000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.970000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<12.700000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<12.700000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,59.055000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.970000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.970000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,27.940000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,30.480000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.970000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,33.020000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<13.970000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.970000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<13.970000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,59.055000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.970000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,72.390000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<12.700000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,81.280000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.483000,-1.535000,90.170000>}
box{<0,0,-0.304800><0.243000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.240000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,27.940000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,90.000000,0> translate<16.510000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,45.720000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<16.510000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<15.240000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,59.055000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<16.510000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<16.510000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,10.160000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<16.510000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,26.670000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,30.480000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,33.020000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<16.510000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,44.450000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,46.990000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<16.510000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<16.510000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,59.055000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<16.510000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,76.200000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.483000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.658000,-1.535000,98.425000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.483000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,26.670000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,44.450000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<17.780000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<17.780000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,59.055000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.769000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.674000,-1.535000,97.155000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<17.769000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,10.160000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<17.780000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,26.670000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,31.750000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<16.510000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<19.050000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<19.050000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<19.050000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,59.055000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<19.050000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,76.200000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,86.360000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,36.867464,0> translate<15.240000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,44.450000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<21.590000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.320000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<20.320000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,59.055000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<21.590000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<21.590000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<19.050000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,29.210000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.320000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,30.480000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<19.050000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,31.750000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<17.780000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<21.590000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.590000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<21.590000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,59.055000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.590000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,81.280000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,0.000000,24.130000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,29.210000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<22.860000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,30.480000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<22.860000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.860000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,56.306216,0> translate<22.860000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,59.055000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<24.130000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,10.160000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<20.320000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<25.400000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.130000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<25.400000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<25.400000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,74.930000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.860000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,76.200000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<25.400000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.860000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<25.400000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,13.970000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<26.670000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<26.670000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<26.670000,-1.535000,24.130000>}
box{<0,0,-0.635000><4.579050,0.035000,0.635000> rotate<0,-33.687844,0> translate<22.860000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<24.130000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<26.670000,-1.535000,24.130000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<24.130000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,45.720000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.860000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,50.800000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,0.000000,58.420000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,0.000000,60.960000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,73.660000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<26.670000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<27.305000,-1.535000,28.575000>}
box{<0,0,-0.635000><4.490128,0.035000,0.635000> rotate<0,-81.864495,0> translate<26.670000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,19.050000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.940000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,33.020000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.130000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.940000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,44.450000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<25.400000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.940000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,52.070000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.210000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,22.225000>}
box{<0,0,-0.304800><4.065984,0.035000,0.304800> rotate<0,-51.336803,0> translate<26.670000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,22.225000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<29.210000,-1.535000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<29.210000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,0.000000,26.670000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<11.430000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<27.305000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<29.210000,-1.535000,28.575000>}
box{<0,0,-0.635000><1.905000,0.035000,0.635000> rotate<0,0.000000,0> translate<27.305000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,50.800000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.210000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,73.660000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.210000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.480000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,21.590000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<27.940000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.480000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,45.720000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.480000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<29.210000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.674000,-1.535000,97.155000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,97.155000>}
box{<0,0,-0.304800><11.441000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.674000,-1.535000,97.155000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<29.210000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,11.430000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,17.780000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,21.590000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.480000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<30.480000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<29.210000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<33.020000,-1.535000,30.480000>}
box{<0,0,-0.635000><4.259709,0.035000,0.635000> rotate<0,-26.563298,0> translate<29.210000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<33.020000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<33.020000,-1.535000,38.100000>}
box{<0,0,-0.635000><7.620000,0.035000,0.635000> rotate<0,90.000000,0> translate<33.020000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,43.180000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,46.990000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<27.940000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,52.070000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,80.010000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,85.090000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.658000,-1.535000,98.425000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,98.425000>}
box{<0,0,-0.304800><14.362000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.658000,-1.535000,98.425000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,97.155000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,94.615000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<31.115000,-1.535000,97.155000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,94.615000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.655000,-1.535000,94.615000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,16.510000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<34.290000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,26.035000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<34.290000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,0.000000,44.450000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,98.425000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,96.520000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<33.020000,-1.535000,98.425000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,19.050000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.750000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<33.020000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<35.560000,-1.535000,60.960000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,-44.997030,0> translate<33.020000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,60.960000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<33.020000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<35.560000,-1.535000,85.090000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<33.020000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<35.560000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<35.560000,-1.535000,86.360000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<35.560000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,0.000000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,95.885000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<34.925000,0.000000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,11.430000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.830000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,17.780000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.830000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.560000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.830000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,55.880000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<33.020000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,57.150000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.480000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,58.420000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.480000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,80.010000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<33.020000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<38.100000,-1.535000,43.180000>}
box{<0,0,-0.635000><7.184205,0.035000,0.635000> rotate<0,-44.997030,0> translate<33.020000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.100000,-1.535000,43.180000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<35.560000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<38.100000,-1.535000,60.960000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<35.560000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<38.100000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<38.100000,-1.535000,63.500000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<38.100000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<38.100000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<36.830000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,-1.535000,30.480000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<34.290000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,11.430000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<36.830000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,26.035000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,29.210000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.560000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,33.020000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<33.020000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,50.800000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<33.020000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<38.100000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<39.370000,-1.535000,64.770000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,67.310000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.480000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,49.530000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<34.925000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,12.700000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<39.370000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,19.050000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<36.830000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,71.120000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<30.480000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,8.890000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,27.940000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<39.370000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,5.080000>}
box{<0,0,-0.304800><3.862554,0.035000,0.304800> rotate<0,80.532363,0> translate<41.275000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,0.000000,11.430000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,17.780000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.910000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.640000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.910000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.640000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,33.020000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,74.930000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<30.480000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.910000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,52.070000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.910000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,67.310000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,76.200000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.910000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,5.080000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,-90.000000,0> translate<44.450000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,8.255000>}
box{<0,0,-0.304800><4.065984,0.035000,0.304800> rotate<0,51.336803,0> translate<41.910000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,25.400000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,26.670000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,27.940000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,29.210000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,30.480000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.735000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,49.530000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.005000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,58.420000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.640000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,74.930000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.640000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,80.010000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<35.560000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-1.535000,95.250000>}
box{<0,0,-0.635000><12.572359,0.035000,0.635000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.720000,-1.535000,3.175000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.720000,-1.535000,7.620000>}
box{<0,0,-0.203200><4.445000,0.035000,0.203200> rotate<0,90.000000,0> translate<45.720000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,10.795000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.720000,-1.535000,10.795000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.910000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,34.290000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.180000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,59.690000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.720000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.720000,-1.535000,77.470000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<45.720000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<46.990000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,0.000000,13.970000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.720000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,57.150000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,79.375000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<46.990000,-1.535000,79.375000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,34.290000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,53.340000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.990000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,72.390000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.180000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,77.470000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,7.620000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.530000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.990000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.530000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,24.130000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<49.530000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,34.290000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,36.830000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.530000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,30.480000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.720000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,31.750000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.720000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,33.020000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,34.290000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.800000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<50.800000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<48.260000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.800000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,7.620000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.070000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,15.240000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.990000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.070000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,22.860000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.530000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,24.130000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.070000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,27.940000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.530000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,30.480000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,36.830000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.070000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,39.370000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.530000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,46.990000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,-90.000000,0> translate<52.070000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,55.880000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<50.800000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,72.390000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.990000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,74.930000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.070000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,13.970000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<48.260000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,19.685000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,38.100000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,76.200000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,92.710000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,5.080000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<54.610000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,12.700000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.530000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<54.610000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,20.955000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<53.340000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<54.610000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,27.940000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,27.940000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<54.610000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,0.000000,28.575000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.610000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.610000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,30.480000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,34.290000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,48.260000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<53.340000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,57.150000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,12.700000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,15.240000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.880000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,25.400000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,0.000000,31.750000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.180000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.880000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,41.275000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<57.150000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,45.720000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,55.880000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.880000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,63.500000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.150000,-1.535000,73.660000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.150000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.150000,-1.535000,73.660000>}
box{<0,0,-0.203200><11.430000,0.035000,0.203200> rotate<0,-90.000000,0> translate<57.150000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<55.880000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<57.150000,-1.535000,85.090000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<55.880000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,37.465000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,8.129566,0> translate<53.340000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,11.430000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.150000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,13.970000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,19.685000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.420000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,36.830000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<57.785000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,46.990000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,49.530000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.420000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,50.800000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,64.770000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,66.040000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.420000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.420000,-1.535000,88.900000>}
box{<0,0,-0.635000><6.350000,0.035000,0.635000> rotate<0,-90.000000,0> translate<58.420000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.420000,-1.535000,95.250000>}
box{<0,0,-0.635000><13.970000,0.035000,0.635000> rotate<0,0.000000,0> translate<44.450000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,-1.535000,38.735000>}
box{<0,0,-0.304800><7.013804,0.035000,0.304800> rotate<0,5.194086,0> translate<52.070000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,5.080000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<59.690000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,0.000000,8.890000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,15.240000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<59.690000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<59.690000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,20.955000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<58.420000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.618172,0.035000,0.304800> rotate<0,14.035317,0> translate<57.150000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,41.910000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<59.690000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<58.420000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,52.070000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<58.420000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,58.420000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.150000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,63.500000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<58.420000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,63.500000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,77.470000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<57.150000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<59.690000,-1.535000,85.090000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<57.150000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<58.420000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<59.690000,-1.535000,85.090000>}
box{<0,0,-0.508000><4.016093,0.035000,0.508000> rotate<0,71.560328,0> translate<58.420000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<59.690000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.690000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<60.960000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,26.670000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,29.210000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.150000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<60.960000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,36.830000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<59.055000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,40.640000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<59.690000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,45.720000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<57.150000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,46.990000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<58.420000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,81.280000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,12.700000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.150000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,26.670000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,36.830000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<61.595000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,36.830000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,38.100000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<59.690000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,40.640000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,0.000000,45.720000>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,0.000000,48.260000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,77.470000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,82.550000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.960000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,2.540000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,20.320000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,27.940000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.230000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.230000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,54.610000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,57.150000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<62.230000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,80.010000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,82.550000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,90.170000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.230000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,17.780000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.770000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,21.590000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<63.500000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.770000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,38.100000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,55.880000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<63.500000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.770000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<63.500000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.770000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.770000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,31.750000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<63.500000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.040000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.040000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,36.830000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<64.770000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.040000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<64.770000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,46.990000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,80.010000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.770000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,82.550000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<63.500000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,27.940000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<66.040000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,38.100000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.310000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<66.040000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,77.470000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<67.310000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,85.090000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.310000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,0.000000,10.795000>}
box{<0,0,-0.304800><22.225000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,-1.535000,29.210000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,13.970000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,31.750000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.310000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.580000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.580000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,36.830000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<67.310000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,57.150000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,15.240000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<68.580000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.850000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,21.590000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<67.310000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,24.130000>}
box{<0,0,-0.304800><4.579050,0.035000,0.304800> rotate<0,56.306216,0> translate<67.310000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,48.260000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,58.420000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<69.850000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,77.470000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.850000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,87.630000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.850000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,0.000000,91.440000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.850000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,10.160000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,0.000000,16.510000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,-90.000000,0> translate<71.120000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,25.400000>}
box{<0,0,-0.304800><4.959509,0.035000,0.304800> rotate<0,50.191116,0> translate<67.945000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,66.040000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,-1.535000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,15.240000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.945000,-1.535000,10.795000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,41.910000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<72.390000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,70.485000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,-90.000000,0> translate<72.390000,-1.535000,70.485000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,77.470000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<72.390000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<72.390000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,80.010000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.120000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<72.390000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,88.900000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.310000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,67.945000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.120000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,34.290000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<73.660000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,46.990000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.660000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,49.530000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.660000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,63.500000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.150000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,66.040000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.420000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,90.170000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,67.945000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.025000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,13.970000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.120000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,19.050000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,0.000000,31.750000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.930000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,50.800000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<74.930000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<73.660000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,82.550000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.390000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,85.090000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.930000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<72.390000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.930000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,17.780000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,24.130000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<68.580000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,25.400000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<68.580000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,26.670000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<68.580000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,27.940000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<72.390000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<74.295000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,8.890000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<73.660000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,16.510000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.120000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,21.590000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<74.930000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,0.000000,30.480000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<77.470000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,55.880000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,57.150000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.580000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,58.420000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<74.930000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,81.280000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<77.470000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,86.360000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<73.660000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<77.470000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,59.690000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<78.740000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.200000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,70.485000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,67.310000>}
box{<0,0,-0.304800><7.099516,0.035000,0.304800> rotate<0,26.563298,0> translate<72.390000,-1.535000,70.485000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<78.740000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,87.630000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<74.930000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<76.200000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,0.000000,29.210000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<80.010000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,38.100000>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,44.997030,0> translate<69.850000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<80.010000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,0.000000,73.660000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,39.370000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<73.660000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<80.010000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,77.470000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<77.470000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-1.535000,86.360000>}
box{<0,0,-0.635000><8.890000,0.035000,0.635000> rotate<0,-90.000000,0> translate<81.280000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.420000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-1.535000,95.250000>}
box{<0,0,-0.635000><22.860000,0.035000,0.635000> rotate<0,0.000000,0> translate<58.420000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,40.640000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<73.660000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<78.740000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,15.240000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,22.860000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<77.470000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,34.290000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.660000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,41.910000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<74.930000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<83.820000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,0.000000,92.710000>}
box{<0,0,-0.304800><30.480000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,13.970000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<74.930000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,31.750000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<74.930000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,0.000000,74.930000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.310000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<85.090000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<85.090000,-1.535000,83.820000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,-90.000000,0> translate<85.090000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<85.090000,-1.535000,86.360000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,0.000000,0> translate<81.280000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<86.360000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,17.780000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<83.820000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<86.360000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,30.480000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<77.470000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<85.090000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<86.360000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,46.990000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<77.470000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,48.260000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<77.470000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,49.530000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<77.470000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,50.800000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<77.470000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,52.070000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<78.740000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,60.960000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<86.995000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,66.040000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,6.350000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<86.360000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<85.090000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<87.630000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,29.210000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.010000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<87.630000,-1.535000,95.250000>}
box{<0,0,-0.635000><6.350000,0.035000,0.635000> rotate<0,0.000000,0> translate<81.280000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<86.360000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,19.050000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<88.900000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,33.020000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<86.360000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<88.900000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<85.090000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,86.360000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,0.000000,0> translate<85.090000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,88.900000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<83.820000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<87.630000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,96.520000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<87.630000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,71.120000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<86.360000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,77.470000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,0.000000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,0.000000,14.605000>}
box{<0,0,-0.304800><98.180939,0.035000,0.304800> rotate<0,53.941822,0> translate<33.655000,0.000000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,19.050000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<91.440000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,33.020000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<87.630000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<91.440000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<91.440000,-1.535000,80.010000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<88.900000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<88.900000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,38.100000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.010000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<92.710000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<91.440000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<92.710000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,74.930000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<90.170000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<91.440000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,81.280000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<91.440000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,81.280000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,-90.000000,0> translate<92.710000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,82.550000>}
box{<0,0,-0.635000><5.388154,0.035000,0.635000> rotate<0,44.997030,0> translate<88.900000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,90.170000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<92.710000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,93.980000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,-90.000000,0> translate<92.710000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,96.520000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,0.000000,0> translate<88.900000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,95.885000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,0.000000,14.605000>}
box{<0,0,-0.304800><100.096627,0.035000,0.304800> rotate<0,54.289725,0> translate<35.560000,0.000000,95.885000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,19.050000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<93.980000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,34.290000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<93.980000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,36.830000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<92.710000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,39.370000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<92.710000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,62.230000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<93.980000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,67.310000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,78.740000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<82.550000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,91.440000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<92.710000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<93.980000,-1.535000,92.710000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,44.997030,0> translate<92.710000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,21.590000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,40.640000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<82.550000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,46.990000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,0.000000,54.610000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,73.660000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<95.250000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<93.980000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,96.520000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<96.520000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<95.250000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,34.290000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<96.520000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,36.830000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<93.980000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,41.910000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<83.820000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.980000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<96.520000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,71.120000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<90.170000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,86.360000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<91.440000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,93.980000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<95.250000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,57.150000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<97.790000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,60.960000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.995000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,64.770000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<96.520000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<97.790000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,87.630000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<96.520000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,97.790000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,34.290000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<99.060000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,36.830000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<95.250000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<97.790000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,99.060000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<97.790000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,46.990000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.330000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<97.790000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<100.330000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<100.330000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,67.310000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,69.850000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,73.660000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.330000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.330000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.330000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.330000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<101.600000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,22.860000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<83.820000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,34.290000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<101.600000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,36.830000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<96.520000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,59.690000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<100.330000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<101.600000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,93.980000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,20.320000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,31.115000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,-90.000000,0> translate<102.870000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,44.450000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<100.330000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,68.580000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,73.660000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,86.360000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,95.250000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<101.600000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,96.520000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<104.140000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<104.140000,-1.535000,34.290000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<104.140000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,54.610000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<104.140000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<101.600000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,67.310000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<104.140000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,78.740000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,85.090000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<104.140000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,91.440000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.980000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,29.210000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<102.870000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<88.900000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<105.410000,-1.535000,8.890000>}
box{<0,0,-0.508000><16.510000,0.035000,0.508000> rotate<0,0.000000,0> translate<88.900000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,20.955000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<105.410000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<104.140000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.410000,-1.535000,30.480000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,44.997030,0> translate<104.140000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,48.260000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,49.530000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,50.800000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,57.150000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<105.410000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,60.960000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<105.410000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<104.140000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<105.410000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<105.410000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,90.170000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<104.140000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.410000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.727500,-1.535000,9.207500>}
box{<0,0,-0.635000><0.449013,0.035000,0.635000> rotate<0,-44.997030,0> translate<105.410000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.727500,-1.535000,9.207500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<106.045000,-1.535000,9.525000>}
box{<0,0,-0.203200><0.449013,0.035000,0.203200> rotate<0,-44.997030,0> translate<105.727500,-1.535000,9.207500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<106.045000,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<106.680000,-1.535000,9.525000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<106.045000,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,75.565000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<106.680000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<105.410000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<107.950000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<107.950000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<93.980000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<107.950000,-1.535000,92.710000>}
box{<0,0,-0.635000><13.970000,0.035000,0.635000> rotate<0,0.000000,0> translate<93.980000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.727500,-1.535000,9.207500>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<109.220000,-1.535000,12.700000>}
box{<0,0,-0.635000><4.939141,0.035000,0.635000> rotate<0,-44.997030,0> translate<105.727500,-1.535000,9.207500> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<109.220000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<109.220000,-1.535000,15.240000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<109.220000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<109.220000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<109.220000,-1.535000,19.050000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,90.000000,0> translate<109.220000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<109.220000,-1.535000,79.375000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<109.220000,-1.535000,83.185000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<109.220000,-1.535000,83.185000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,54.610000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<107.950000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,68.580000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<110.490000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<107.950000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<110.490000,-1.535000,95.250000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,-44.997030,0> translate<107.950000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,53.340000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.980000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,80.010000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<110.490000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,80.010000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,90.000000,0> translate<111.760000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<110.490000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<111.760000,-1.535000,95.250000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,0.000000,0> translate<110.490000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<111.760000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<111.760000,-1.535000,97.790000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<111.760000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,33.020000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<113.030000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,40.640000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<105.410000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,52.070000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,0.000000,67.310000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,0.000000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,67.310000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<113.030000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<111.760000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<113.030000,-1.535000,96.520000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<111.760000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<114.300000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<113.030000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,34.290000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<114.300000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,40.640000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<105.410000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<114.300000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,39.370000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<115.570000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,40.640000>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,44.997030,0> translate<105.410000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,0.000000,45.720000>}
box{<0,0,-0.304800><46.990000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.580000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,0.000000,54.610000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<113.030000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<115.570000,-1.535000,96.520000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<113.030000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<116.840000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<115.570000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<116.840000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,63.430762,0> translate<115.570000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<116.840000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,77.470000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,90.000000,0> translate<118.110000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,19.050000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<119.380000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,24.130000>}
box{<0,0,-0.304800><43.180000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.200000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<119.380000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,35.560000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<115.570000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,0.000000,83.820000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,0.000000,0> translate<99.060000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<119.380000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,9.525000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,85.090000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,86.360000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,19.050000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<121.920000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,25.400000>}
box{<0,0,-0.304800><45.720000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.200000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<121.920000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,82.550000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<121.920000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<120.650000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,77.470000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<119.380000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,77.470000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.190000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,88.900000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.190000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,19.050000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<124.460000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,26.670000>}
box{<0,0,-0.304800><48.260000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.200000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,80.010000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<124.460000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<120.650000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<124.460000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<124.460000,-1.535000,90.805000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,90.000000,0> translate<124.460000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,6.350000>}
box{<0,0,-0.304800><38.100000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,27.940000>}
box{<0,0,-0.304800><49.530000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.200000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,91.440000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<125.730000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,29.210000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.775000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,19.050000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<127.000000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<125.730000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.410000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<127.000000,-1.535000,30.480000>}
box{<0,0,-0.635000><21.590000,0.035000,0.635000> rotate<0,0.000000,0> translate<105.410000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,34.290000>}
box{<0,0,-0.304800><16.164461,0.035000,0.304800> rotate<0,44.997030,0> translate<115.570000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,92.710000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<125.730000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,90.170000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<128.270000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,19.050000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,-90.000000,0> translate<129.540000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,26.035000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,44.997030,0> translate<126.365000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<129.540000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,35.560000>}
box{<0,0,-0.304800><23.348666,0.035000,0.304800> rotate<0,44.997030,0> translate<113.030000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,91.440000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<128.270000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,1.270000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<125.730000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<109.220000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,12.700000>}
box{<0,0,-0.635000><21.590000,0.035000,0.635000> rotate<0,0.000000,0> translate<109.220000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,16.510000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,90.000000,0> translate<130.810000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<130.810000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<127.000000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,26.670000>}
box{<0,0,-0.635000><5.388154,0.035000,0.635000> rotate<0,44.997030,0> translate<127.000000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,26.670000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<130.810000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,0.000000,78.740000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,78.740000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<123.190000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,85.090000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<130.810000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,30.480000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,35.560000>}
box{<0,0,-0.304800><26.940768,0.035000,0.304800> rotate<0,44.997030,0> translate<113.030000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,44.450000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,0.000000,76.200000>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,80.010000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<130.810000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,80.010000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<130.810000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,0.000000,85.090000>}
box{<0,0,-0.304800><31.115000,0.035000,0.304800> rotate<0,0.000000,0> translate<101.600000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<132.080000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,35.560000>}
box{<0,0,-0.304800><23.348666,0.035000,0.304800> rotate<0,44.997030,0> translate<116.840000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,35.560000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<133.350000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,45.720000>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,44.997030,0> translate<123.190000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,45.720000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<133.350000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,0.000000,66.040000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.350000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.350000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.350000,-1.535000,78.740000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,-90.000000,0> translate<133.350000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<132.080000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.350000,-1.535000,81.280000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,44.997030,0> translate<132.080000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<132.715000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,0.000000,16.510000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,30.480000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<134.620000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,36.830000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.350000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<134.620000,-1.535000,64.770000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,44.997030,0> translate<133.350000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,68.580000>}
box{<0,0,-0.304800><17.960512,0.035000,0.304800> rotate<0,44.997030,0> translate<121.920000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,69.850000>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,44.997030,0> translate<124.460000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<133.350000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,34.290000>}
box{<0,0,-0.304800><25.144717,0.035000,0.304800> rotate<0,44.997030,0> translate<118.110000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,40.005000>}
box{<0,0,-0.635000><9.525000,0.035000,0.635000> rotate<0,-90.000000,0> translate<135.890000,-1.535000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.350000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,49.530000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<133.350000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,49.530000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,-90.000000,0> translate<135.890000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,53.340000>}
box{<0,0,-0.635000><11.430000,0.035000,0.635000> rotate<0,-90.000000,0> translate<135.890000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.350000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,64.770000>}
box{<0,0,-0.635000><2.839806,0.035000,0.635000> rotate<0,-26.563298,0> translate<133.350000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<134.620000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<135.890000,-1.535000,64.770000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<134.620000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.350000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,81.280000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<133.350000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,81.280000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.890000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,97.790000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,0.000000,0> translate<111.760000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,71.120000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<136.525000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,33.020000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<134.620000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<134.620000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<137.160000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<135.890000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<137.160000,-1.535000,53.340000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<135.890000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,91.440000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<137.160000,-1.535000,96.520000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<135.890000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<137.160000,-1.535000,96.520000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,44.997030,0> translate<135.890000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,10.160000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,-90.000000,0> translate<138.430000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,12.700000>}
box{<0,0,-0.635000><7.620000,0.035000,0.635000> rotate<0,0.000000,0> translate<130.810000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,12.700000>}
box{<0,0,-0.635000><10.160000,0.035000,0.635000> rotate<0,-90.000000,0> translate<138.430000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,49.530000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<135.890000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,64.770000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<135.890000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,81.280000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<135.890000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<138.430000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,90.170000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<137.160000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<137.160000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,96.520000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,0.000000,0> translate<137.160000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<139.700000,-1.535000,24.130000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<138.430000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,0.000000,39.370000>}
box{<0,0,-0.304800><6.475755,0.035000,0.304800> rotate<0,11.309186,0> translate<133.350000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,39.370000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,63.430762,0> translate<138.430000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,45.720000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,-90.000000,0> translate<139.700000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,67.310000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<138.430000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,78.740000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<136.525000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<139.700000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,83.820000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<133.985000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,90.805000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.700000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,92.710000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,0.000000,15.240000>}
box{<0,0,-0.304800><26.035000,0.035000,0.304800> rotate<0,0.000000,0> translate<114.300000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,18.415000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<140.335000,-1.535000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,85.090000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,19.050000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<140.335000,-1.535000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<139.700000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,24.130000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,0.000000,0> translate<139.700000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,24.130000>}
box{<0,0,-0.635000><7.620000,0.035000,0.635000> rotate<0,-90.000000,0> translate<140.970000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,31.750000>}
box{<0,0,-0.635000><3.175000,0.035000,0.635000> rotate<0,-90.000000,0> translate<140.970000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,34.925000>}
box{<0,0,-0.635000><7.184205,0.035000,0.635000> rotate<0,44.997030,0> translate<135.890000,-1.535000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<140.970000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<139.700000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<138.430000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<140.970000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,87.630000>}
box{<0,0,-0.304800><2.618172,0.035000,0.304800> rotate<0,-75.958743,0> translate<140.335000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<140.970000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,93.980000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<139.700000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,96.520000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<140.970000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,76.200000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<140.970000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,90.805000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<142.240000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,26.670000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<143.510000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,27.940000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<143.510000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<143.510000,-1.535000,31.750000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<140.970000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<143.510000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<143.510000,-1.535000,36.830000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<143.510000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<143.510000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<143.510000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,64.770000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<143.510000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,69.850000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,71.120000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<136.525000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<143.510000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,85.725000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<143.510000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,93.980000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<143.510000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,96.520000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.970000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,97.790000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<143.510000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,3.810000>}
box{<0,0,-0.635000><6.350000,0.035000,0.635000> rotate<0,-90.000000,0> translate<144.145000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<139.065000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,6.350000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,0.000000,0> translate<139.065000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,6.350000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<144.145000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<138.430000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,10.160000>}
box{<0,0,-0.635000><5.715000,0.035000,0.635000> rotate<0,0.000000,0> translate<138.430000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.970000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,85.725000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,85.090000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<143.510000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,51.435000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<144.780000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<143.510000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,53.340000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.780000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<143.510000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,86.360000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.780000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,92.710000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<143.510000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,20.955000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<144.145000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<146.050000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.050000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<146.050000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.050000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.050000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,46.990000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<146.050000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<146.050000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<148.590000,-1.535000,14.605000>}
box{<0,0,-0.635000><6.286179,0.035000,0.635000> rotate<0,-44.997030,0> translate<144.145000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<148.590000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<148.590000,-1.535000,24.130000>}
box{<0,0,-0.508000><9.525000,0.035000,0.508000> rotate<0,90.000000,0> translate<148.590000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<148.590000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,76.200000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,81.280000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<148.590000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.780000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,96.520000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<149.860000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,26.670000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<143.510000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<149.860000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,62.230000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,62.230000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<149.860000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,69.850000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<143.510000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,76.200000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<149.860000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,24.130000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<151.130000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,27.940000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<143.510000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,31.750000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.130000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,46.990000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.130000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<149.860000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.130000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,63.500000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<149.860000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.130000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<151.130000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<148.590000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,96.520000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<148.590000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<151.130000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,26.670000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<152.400000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,0.000000,34.290000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,62.230000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<152.400000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<151.130000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,74.930000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<152.400000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,80.010000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<148.590000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<152.400000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,99.060000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,99.060000>}
box{<0,0,-0.304800><53.340000,0.035000,0.304800> rotate<0,0.000000,0> translate<99.060000,-1.535000,99.060000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,21.590000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,25.400000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,52.070000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<152.400000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,63.500000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<152.400000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,80.010000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<149.860000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,96.520000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<153.670000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,99.060000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,97.790000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<152.400000,-1.535000,99.060000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<153.670000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<148.590000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,67.310000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,90.000000,0> translate<154.940000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<151.130000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<154.940000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<152.400000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<154.940000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<156.210000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<152.400000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.305000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<154.305000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,85.090000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<156.210000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<157.480000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<154.940000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<158.750000,-1.535000,1.270000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<130.810000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<157.480000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<158.750000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<157.480000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<158.750000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<158.750000,-1.535000,44.450000>}
box{<0,0,-0.304800><43.180000,0.035000,0.304800> rotate<0,90.000000,0> translate<158.750000,-1.535000,44.450000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygone
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,100.330000>}
box{<0,0,-0.203200><99.060000,0.035000,0.203200> rotate<0,90.000000,0> translate<0.000000,-1.535000,100.330000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,0.000000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<0.000000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.000000,-1.535000,100.330000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<160.020000,-1.535000,100.330000>}
box{<0,0,-0.203200><160.020000,0.035000,0.203200> rotate<0,0.000000,0> translate<0.000000,-1.535000,100.330000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<160.020000,-1.535000,0.000000>}
box{<0,0,-0.203200><158.750000,0.035000,0.203200> rotate<0,0.000000,0> translate<1.270000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<160.020000,-1.535000,100.330000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<160.020000,-1.535000,0.000000>}
box{<0,0,-0.203200><100.330000,0.035000,0.203200> rotate<0,-90.000000,0> translate<160.020000,-1.535000,0.000000> }
texture{col_pol}
}
#end
union{
cylinder{<3.810000,0.038000,68.580000><3.810000,-1.538000,68.580000>0.406400}
cylinder{<3.810000,0.038000,73.660000><3.810000,-1.538000,73.660000>0.406400}
cylinder{<88.900000,0.038000,80.010000><88.900000,-1.538000,80.010000>0.406400}
cylinder{<88.900000,0.038000,74.930000><88.900000,-1.538000,74.930000>0.406400}
cylinder{<88.900000,0.038000,63.500000><88.900000,-1.538000,63.500000>0.406400}
cylinder{<88.900000,0.038000,58.420000><88.900000,-1.538000,58.420000>0.406400}
cylinder{<109.220000,0.038000,15.240000><109.220000,-1.538000,15.240000>0.406400}
cylinder{<104.140000,0.038000,15.240000><104.140000,-1.538000,15.240000>0.406400}
cylinder{<139.065000,0.038000,6.350000><139.065000,-1.538000,6.350000>0.406400}
cylinder{<133.985000,0.038000,6.350000><133.985000,-1.538000,6.350000>0.406400}
cylinder{<22.860000,0.038000,21.590000><22.860000,-1.538000,21.590000>0.406400}
cylinder{<22.860000,0.038000,16.510000><22.860000,-1.538000,16.510000>0.406400}
cylinder{<39.370000,0.038000,64.770000><39.370000,-1.538000,64.770000>0.406400}
cylinder{<44.450000,0.038000,64.770000><44.450000,-1.538000,64.770000>0.406400}
cylinder{<3.810000,0.038000,40.640000><3.810000,-1.538000,40.640000>0.406400}
cylinder{<3.810000,0.038000,35.560000><3.810000,-1.538000,35.560000>0.406400}
cylinder{<133.350000,0.038000,58.420000><133.350000,-1.538000,58.420000>0.406400}
cylinder{<133.350000,0.038000,63.500000><133.350000,-1.538000,63.500000>0.406400}
cylinder{<133.350000,0.038000,54.610000><133.350000,-1.538000,54.610000>0.406400}
cylinder{<133.350000,0.038000,49.530000><133.350000,-1.538000,49.530000>0.406400}
cylinder{<148.590000,0.038000,36.830000><148.590000,-1.538000,36.830000>0.406400}
cylinder{<143.510000,0.038000,36.830000><143.510000,-1.538000,36.830000>0.406400}
cylinder{<87.630000,0.038000,90.170000><87.630000,-1.538000,90.170000>0.406400}
cylinder{<87.630000,0.038000,95.250000><87.630000,-1.538000,95.250000>0.406400}
cylinder{<55.880000,0.038000,80.010000><55.880000,-1.538000,80.010000>0.406400}
cylinder{<55.880000,0.038000,85.090000><55.880000,-1.538000,85.090000>0.406400}
cylinder{<111.760000,0.038000,90.170000><111.760000,-1.538000,90.170000>0.406400}
cylinder{<111.760000,0.038000,95.250000><111.760000,-1.538000,95.250000>0.406400}
cylinder{<154.305000,0.038000,85.090000><154.305000,-1.538000,85.090000>0.406400}
cylinder{<144.145000,0.038000,85.090000><144.145000,-1.538000,85.090000>0.406400}
cylinder{<92.710000,0.038000,57.150000><92.710000,-1.538000,57.150000>0.406400}
cylinder{<95.250000,0.038000,57.150000><95.250000,-1.538000,57.150000>0.406400}
cylinder{<97.790000,0.038000,57.150000><97.790000,-1.538000,57.150000>0.406400}
cylinder{<100.330000,0.038000,57.150000><100.330000,-1.538000,57.150000>0.406400}
cylinder{<102.870000,0.038000,57.150000><102.870000,-1.538000,57.150000>0.406400}
cylinder{<105.410000,0.038000,57.150000><105.410000,-1.538000,57.150000>0.406400}
cylinder{<107.950000,0.038000,57.150000><107.950000,-1.538000,57.150000>0.406400}
cylinder{<107.950000,0.038000,64.770000><107.950000,-1.538000,64.770000>0.406400}
cylinder{<105.410000,0.038000,64.770000><105.410000,-1.538000,64.770000>0.406400}
cylinder{<102.870000,0.038000,64.770000><102.870000,-1.538000,64.770000>0.406400}
cylinder{<100.330000,0.038000,64.770000><100.330000,-1.538000,64.770000>0.406400}
cylinder{<97.790000,0.038000,64.770000><97.790000,-1.538000,64.770000>0.406400}
cylinder{<95.250000,0.038000,64.770000><95.250000,-1.538000,64.770000>0.406400}
cylinder{<92.710000,0.038000,64.770000><92.710000,-1.538000,64.770000>0.406400}
cylinder{<138.430000,0.038000,57.150000><138.430000,-1.538000,57.150000>0.406400}
cylinder{<140.970000,0.038000,57.150000><140.970000,-1.538000,57.150000>0.406400}
cylinder{<143.510000,0.038000,57.150000><143.510000,-1.538000,57.150000>0.406400}
cylinder{<146.050000,0.038000,57.150000><146.050000,-1.538000,57.150000>0.406400}
cylinder{<148.590000,0.038000,57.150000><148.590000,-1.538000,57.150000>0.406400}
cylinder{<151.130000,0.038000,57.150000><151.130000,-1.538000,57.150000>0.406400}
cylinder{<153.670000,0.038000,57.150000><153.670000,-1.538000,57.150000>0.406400}
cylinder{<156.210000,0.038000,57.150000><156.210000,-1.538000,57.150000>0.406400}
cylinder{<156.210000,0.038000,64.770000><156.210000,-1.538000,64.770000>0.406400}
cylinder{<153.670000,0.038000,64.770000><153.670000,-1.538000,64.770000>0.406400}
cylinder{<151.130000,0.038000,64.770000><151.130000,-1.538000,64.770000>0.406400}
cylinder{<148.590000,0.038000,64.770000><148.590000,-1.538000,64.770000>0.406400}
cylinder{<146.050000,0.038000,64.770000><146.050000,-1.538000,64.770000>0.406400}
cylinder{<143.510000,0.038000,64.770000><143.510000,-1.538000,64.770000>0.406400}
cylinder{<140.970000,0.038000,64.770000><140.970000,-1.538000,64.770000>0.406400}
cylinder{<138.430000,0.038000,64.770000><138.430000,-1.538000,64.770000>0.406400}
cylinder{<59.690000,0.038000,77.470000><59.690000,-1.538000,77.470000>0.406400}
cylinder{<62.230000,0.038000,77.470000><62.230000,-1.538000,77.470000>0.406400}
cylinder{<64.770000,0.038000,77.470000><64.770000,-1.538000,77.470000>0.406400}
cylinder{<67.310000,0.038000,77.470000><67.310000,-1.538000,77.470000>0.406400}
cylinder{<69.850000,0.038000,77.470000><69.850000,-1.538000,77.470000>0.406400}
cylinder{<72.390000,0.038000,77.470000><72.390000,-1.538000,77.470000>0.406400}
cylinder{<74.930000,0.038000,77.470000><74.930000,-1.538000,77.470000>0.406400}
cylinder{<74.930000,0.038000,85.090000><74.930000,-1.538000,85.090000>0.406400}
cylinder{<72.390000,0.038000,85.090000><72.390000,-1.538000,85.090000>0.406400}
cylinder{<69.850000,0.038000,85.090000><69.850000,-1.538000,85.090000>0.406400}
cylinder{<67.310000,0.038000,85.090000><67.310000,-1.538000,85.090000>0.406400}
cylinder{<64.770000,0.038000,85.090000><64.770000,-1.538000,85.090000>0.406400}
cylinder{<62.230000,0.038000,85.090000><62.230000,-1.538000,85.090000>0.406400}
cylinder{<59.690000,0.038000,85.090000><59.690000,-1.538000,85.090000>0.406400}
cylinder{<138.430000,0.038000,41.910000><138.430000,-1.538000,41.910000>0.406400}
cylinder{<140.970000,0.038000,41.910000><140.970000,-1.538000,41.910000>0.406400}
cylinder{<143.510000,0.038000,41.910000><143.510000,-1.538000,41.910000>0.406400}
cylinder{<146.050000,0.038000,41.910000><146.050000,-1.538000,41.910000>0.406400}
cylinder{<148.590000,0.038000,41.910000><148.590000,-1.538000,41.910000>0.406400}
cylinder{<151.130000,0.038000,41.910000><151.130000,-1.538000,41.910000>0.406400}
cylinder{<153.670000,0.038000,41.910000><153.670000,-1.538000,41.910000>0.406400}
cylinder{<156.210000,0.038000,41.910000><156.210000,-1.538000,41.910000>0.406400}
cylinder{<156.210000,0.038000,49.530000><156.210000,-1.538000,49.530000>0.406400}
cylinder{<153.670000,0.038000,49.530000><153.670000,-1.538000,49.530000>0.406400}
cylinder{<151.130000,0.038000,49.530000><151.130000,-1.538000,49.530000>0.406400}
cylinder{<148.590000,0.038000,49.530000><148.590000,-1.538000,49.530000>0.406400}
cylinder{<146.050000,0.038000,49.530000><146.050000,-1.538000,49.530000>0.406400}
cylinder{<143.510000,0.038000,49.530000><143.510000,-1.538000,49.530000>0.406400}
cylinder{<140.970000,0.038000,49.530000><140.970000,-1.538000,49.530000>0.406400}
cylinder{<138.430000,0.038000,49.530000><138.430000,-1.538000,49.530000>0.406400}
cylinder{<92.710000,0.038000,73.660000><92.710000,-1.538000,73.660000>0.406400}
cylinder{<95.250000,0.038000,73.660000><95.250000,-1.538000,73.660000>0.406400}
cylinder{<97.790000,0.038000,73.660000><97.790000,-1.538000,73.660000>0.406400}
cylinder{<100.330000,0.038000,73.660000><100.330000,-1.538000,73.660000>0.406400}
cylinder{<102.870000,0.038000,73.660000><102.870000,-1.538000,73.660000>0.406400}
cylinder{<105.410000,0.038000,73.660000><105.410000,-1.538000,73.660000>0.406400}
cylinder{<107.950000,0.038000,73.660000><107.950000,-1.538000,73.660000>0.406400}
cylinder{<110.490000,0.038000,73.660000><110.490000,-1.538000,73.660000>0.406400}
cylinder{<110.490000,0.038000,81.280000><110.490000,-1.538000,81.280000>0.406400}
cylinder{<107.950000,0.038000,81.280000><107.950000,-1.538000,81.280000>0.406400}
cylinder{<105.410000,0.038000,81.280000><105.410000,-1.538000,81.280000>0.406400}
cylinder{<102.870000,0.038000,81.280000><102.870000,-1.538000,81.280000>0.406400}
cylinder{<100.330000,0.038000,81.280000><100.330000,-1.538000,81.280000>0.406400}
cylinder{<97.790000,0.038000,81.280000><97.790000,-1.538000,81.280000>0.406400}
cylinder{<95.250000,0.038000,81.280000><95.250000,-1.538000,81.280000>0.406400}
cylinder{<92.710000,0.038000,81.280000><92.710000,-1.538000,81.280000>0.406400}
cylinder{<38.100000,0.038000,35.560000><38.100000,-1.538000,35.560000>0.406400}
cylinder{<40.640000,0.038000,35.560000><40.640000,-1.538000,35.560000>0.406400}
cylinder{<43.180000,0.038000,35.560000><43.180000,-1.538000,35.560000>0.406400}
cylinder{<45.720000,0.038000,35.560000><45.720000,-1.538000,35.560000>0.406400}
cylinder{<48.260000,0.038000,35.560000><48.260000,-1.538000,35.560000>0.406400}
cylinder{<50.800000,0.038000,35.560000><50.800000,-1.538000,35.560000>0.406400}
cylinder{<53.340000,0.038000,35.560000><53.340000,-1.538000,35.560000>0.406400}
cylinder{<55.880000,0.038000,35.560000><55.880000,-1.538000,35.560000>0.406400}
cylinder{<58.420000,0.038000,35.560000><58.420000,-1.538000,35.560000>0.406400}
cylinder{<60.960000,0.038000,35.560000><60.960000,-1.538000,35.560000>0.406400}
cylinder{<63.500000,0.038000,35.560000><63.500000,-1.538000,35.560000>0.406400}
cylinder{<66.040000,0.038000,35.560000><66.040000,-1.538000,35.560000>0.406400}
cylinder{<68.580000,0.038000,35.560000><68.580000,-1.538000,35.560000>0.406400}
cylinder{<71.120000,0.038000,35.560000><71.120000,-1.538000,35.560000>0.406400}
cylinder{<71.120000,0.038000,43.180000><71.120000,-1.538000,43.180000>0.406400}
cylinder{<68.580000,0.038000,43.180000><68.580000,-1.538000,43.180000>0.406400}
cylinder{<66.040000,0.038000,43.180000><66.040000,-1.538000,43.180000>0.406400}
cylinder{<63.500000,0.038000,43.180000><63.500000,-1.538000,43.180000>0.406400}
cylinder{<60.960000,0.038000,43.180000><60.960000,-1.538000,43.180000>0.406400}
cylinder{<58.420000,0.038000,43.180000><58.420000,-1.538000,43.180000>0.406400}
cylinder{<55.880000,0.038000,43.180000><55.880000,-1.538000,43.180000>0.406400}
cylinder{<53.340000,0.038000,43.180000><53.340000,-1.538000,43.180000>0.406400}
cylinder{<50.800000,0.038000,43.180000><50.800000,-1.538000,43.180000>0.406400}
cylinder{<48.260000,0.038000,43.180000><48.260000,-1.538000,43.180000>0.406400}
cylinder{<45.720000,0.038000,43.180000><45.720000,-1.538000,43.180000>0.406400}
cylinder{<43.180000,0.038000,43.180000><43.180000,-1.538000,43.180000>0.406400}
cylinder{<40.640000,0.038000,43.180000><40.640000,-1.538000,43.180000>0.406400}
cylinder{<38.100000,0.038000,43.180000><38.100000,-1.538000,43.180000>0.406400}
cylinder{<26.670000,0.038000,16.510000><26.670000,-1.538000,16.510000>0.406400}
cylinder{<29.210000,0.038000,16.510000><29.210000,-1.538000,16.510000>0.406400}
cylinder{<31.750000,0.038000,16.510000><31.750000,-1.538000,16.510000>0.406400}
cylinder{<34.290000,0.038000,16.510000><34.290000,-1.538000,16.510000>0.406400}
cylinder{<36.830000,0.038000,16.510000><36.830000,-1.538000,16.510000>0.406400}
cylinder{<39.370000,0.038000,16.510000><39.370000,-1.538000,16.510000>0.406400}
cylinder{<41.910000,0.038000,16.510000><41.910000,-1.538000,16.510000>0.406400}
cylinder{<44.450000,0.038000,16.510000><44.450000,-1.538000,16.510000>0.406400}
cylinder{<44.450000,0.038000,24.130000><44.450000,-1.538000,24.130000>0.406400}
cylinder{<41.910000,0.038000,24.130000><41.910000,-1.538000,24.130000>0.406400}
cylinder{<39.370000,0.038000,24.130000><39.370000,-1.538000,24.130000>0.406400}
cylinder{<36.830000,0.038000,24.130000><36.830000,-1.538000,24.130000>0.406400}
cylinder{<34.290000,0.038000,24.130000><34.290000,-1.538000,24.130000>0.406400}
cylinder{<31.750000,0.038000,24.130000><31.750000,-1.538000,24.130000>0.406400}
cylinder{<29.210000,0.038000,24.130000><29.210000,-1.538000,24.130000>0.406400}
cylinder{<26.670000,0.038000,24.130000><26.670000,-1.538000,24.130000>0.406400}
cylinder{<49.530000,0.038000,16.510000><49.530000,-1.538000,16.510000>0.406400}
cylinder{<52.070000,0.038000,16.510000><52.070000,-1.538000,16.510000>0.406400}
cylinder{<54.610000,0.038000,16.510000><54.610000,-1.538000,16.510000>0.406400}
cylinder{<57.150000,0.038000,16.510000><57.150000,-1.538000,16.510000>0.406400}
cylinder{<59.690000,0.038000,16.510000><59.690000,-1.538000,16.510000>0.406400}
cylinder{<62.230000,0.038000,16.510000><62.230000,-1.538000,16.510000>0.406400}
cylinder{<64.770000,0.038000,16.510000><64.770000,-1.538000,16.510000>0.406400}
cylinder{<67.310000,0.038000,16.510000><67.310000,-1.538000,16.510000>0.406400}
cylinder{<67.310000,0.038000,24.130000><67.310000,-1.538000,24.130000>0.406400}
cylinder{<64.770000,0.038000,24.130000><64.770000,-1.538000,24.130000>0.406400}
cylinder{<62.230000,0.038000,24.130000><62.230000,-1.538000,24.130000>0.406400}
cylinder{<59.690000,0.038000,24.130000><59.690000,-1.538000,24.130000>0.406400}
cylinder{<57.150000,0.038000,24.130000><57.150000,-1.538000,24.130000>0.406400}
cylinder{<54.610000,0.038000,24.130000><54.610000,-1.538000,24.130000>0.406400}
cylinder{<52.070000,0.038000,24.130000><52.070000,-1.538000,24.130000>0.406400}
cylinder{<49.530000,0.038000,24.130000><49.530000,-1.538000,24.130000>0.406400}
cylinder{<83.820000,0.038000,19.050000><83.820000,-1.538000,19.050000>0.406400}
cylinder{<86.360000,0.038000,19.050000><86.360000,-1.538000,19.050000>0.406400}
cylinder{<88.900000,0.038000,19.050000><88.900000,-1.538000,19.050000>0.406400}
cylinder{<91.440000,0.038000,19.050000><91.440000,-1.538000,19.050000>0.406400}
cylinder{<93.980000,0.038000,19.050000><93.980000,-1.538000,19.050000>0.406400}
cylinder{<96.520000,0.038000,19.050000><96.520000,-1.538000,19.050000>0.406400}
cylinder{<99.060000,0.038000,19.050000><99.060000,-1.538000,19.050000>0.406400}
cylinder{<101.600000,0.038000,19.050000><101.600000,-1.538000,19.050000>0.406400}
cylinder{<104.140000,0.038000,19.050000><104.140000,-1.538000,19.050000>0.406400}
cylinder{<106.680000,0.038000,19.050000><106.680000,-1.538000,19.050000>0.406400}
cylinder{<109.220000,0.038000,19.050000><109.220000,-1.538000,19.050000>0.406400}
cylinder{<111.760000,0.038000,19.050000><111.760000,-1.538000,19.050000>0.406400}
cylinder{<114.300000,0.038000,19.050000><114.300000,-1.538000,19.050000>0.406400}
cylinder{<116.840000,0.038000,19.050000><116.840000,-1.538000,19.050000>0.406400}
cylinder{<119.380000,0.038000,19.050000><119.380000,-1.538000,19.050000>0.406400}
cylinder{<121.920000,0.038000,19.050000><121.920000,-1.538000,19.050000>0.406400}
cylinder{<124.460000,0.038000,19.050000><124.460000,-1.538000,19.050000>0.406400}
cylinder{<127.000000,0.038000,19.050000><127.000000,-1.538000,19.050000>0.406400}
cylinder{<129.540000,0.038000,19.050000><129.540000,-1.538000,19.050000>0.406400}
cylinder{<132.080000,0.038000,19.050000><132.080000,-1.538000,19.050000>0.406400}
cylinder{<132.080000,0.038000,34.290000><132.080000,-1.538000,34.290000>0.406400}
cylinder{<129.540000,0.038000,34.290000><129.540000,-1.538000,34.290000>0.406400}
cylinder{<127.000000,0.038000,34.290000><127.000000,-1.538000,34.290000>0.406400}
cylinder{<124.460000,0.038000,34.290000><124.460000,-1.538000,34.290000>0.406400}
cylinder{<121.920000,0.038000,34.290000><121.920000,-1.538000,34.290000>0.406400}
cylinder{<119.380000,0.038000,34.290000><119.380000,-1.538000,34.290000>0.406400}
cylinder{<116.840000,0.038000,34.290000><116.840000,-1.538000,34.290000>0.406400}
cylinder{<114.300000,0.038000,34.290000><114.300000,-1.538000,34.290000>0.406400}
cylinder{<111.760000,0.038000,34.290000><111.760000,-1.538000,34.290000>0.406400}
cylinder{<109.220000,0.038000,34.290000><109.220000,-1.538000,34.290000>0.406400}
cylinder{<106.680000,0.038000,34.290000><106.680000,-1.538000,34.290000>0.406400}
cylinder{<104.140000,0.038000,34.290000><104.140000,-1.538000,34.290000>0.406400}
cylinder{<101.600000,0.038000,34.290000><101.600000,-1.538000,34.290000>0.406400}
cylinder{<99.060000,0.038000,34.290000><99.060000,-1.538000,34.290000>0.406400}
cylinder{<96.520000,0.038000,34.290000><96.520000,-1.538000,34.290000>0.406400}
cylinder{<93.980000,0.038000,34.290000><93.980000,-1.538000,34.290000>0.406400}
cylinder{<91.440000,0.038000,34.290000><91.440000,-1.538000,34.290000>0.406400}
cylinder{<88.900000,0.038000,34.290000><88.900000,-1.538000,34.290000>0.406400}
cylinder{<86.360000,0.038000,34.290000><86.360000,-1.538000,34.290000>0.406400}
cylinder{<83.820000,0.038000,34.290000><83.820000,-1.538000,34.290000>0.406400}
cylinder{<38.100000,0.038000,53.340000><38.100000,-1.538000,53.340000>0.406400}
cylinder{<40.640000,0.038000,53.340000><40.640000,-1.538000,53.340000>0.406400}
cylinder{<43.180000,0.038000,53.340000><43.180000,-1.538000,53.340000>0.406400}
cylinder{<45.720000,0.038000,53.340000><45.720000,-1.538000,53.340000>0.406400}
cylinder{<48.260000,0.038000,53.340000><48.260000,-1.538000,53.340000>0.406400}
cylinder{<50.800000,0.038000,53.340000><50.800000,-1.538000,53.340000>0.406400}
cylinder{<53.340000,0.038000,53.340000><53.340000,-1.538000,53.340000>0.406400}
cylinder{<55.880000,0.038000,53.340000><55.880000,-1.538000,53.340000>0.406400}
cylinder{<58.420000,0.038000,53.340000><58.420000,-1.538000,53.340000>0.406400}
cylinder{<60.960000,0.038000,53.340000><60.960000,-1.538000,53.340000>0.406400}
cylinder{<63.500000,0.038000,53.340000><63.500000,-1.538000,53.340000>0.406400}
cylinder{<66.040000,0.038000,53.340000><66.040000,-1.538000,53.340000>0.406400}
cylinder{<68.580000,0.038000,53.340000><68.580000,-1.538000,53.340000>0.406400}
cylinder{<71.120000,0.038000,53.340000><71.120000,-1.538000,53.340000>0.406400}
cylinder{<71.120000,0.038000,60.960000><71.120000,-1.538000,60.960000>0.406400}
cylinder{<68.580000,0.038000,60.960000><68.580000,-1.538000,60.960000>0.406400}
cylinder{<66.040000,0.038000,60.960000><66.040000,-1.538000,60.960000>0.406400}
cylinder{<63.500000,0.038000,60.960000><63.500000,-1.538000,60.960000>0.406400}
cylinder{<60.960000,0.038000,60.960000><60.960000,-1.538000,60.960000>0.406400}
cylinder{<58.420000,0.038000,60.960000><58.420000,-1.538000,60.960000>0.406400}
cylinder{<55.880000,0.038000,60.960000><55.880000,-1.538000,60.960000>0.406400}
cylinder{<53.340000,0.038000,60.960000><53.340000,-1.538000,60.960000>0.406400}
cylinder{<50.800000,0.038000,60.960000><50.800000,-1.538000,60.960000>0.406400}
cylinder{<48.260000,0.038000,60.960000><48.260000,-1.538000,60.960000>0.406400}
cylinder{<45.720000,0.038000,60.960000><45.720000,-1.538000,60.960000>0.406400}
cylinder{<43.180000,0.038000,60.960000><43.180000,-1.538000,60.960000>0.406400}
cylinder{<40.640000,0.038000,60.960000><40.640000,-1.538000,60.960000>0.406400}
cylinder{<38.100000,0.038000,60.960000><38.100000,-1.538000,60.960000>0.406400}
cylinder{<115.570000,0.038000,88.900000><115.570000,-1.538000,88.900000>0.406400}
cylinder{<118.110000,0.038000,88.900000><118.110000,-1.538000,88.900000>0.406400}
cylinder{<120.650000,0.038000,88.900000><120.650000,-1.538000,88.900000>0.406400}
cylinder{<123.190000,0.038000,88.900000><123.190000,-1.538000,88.900000>0.406400}
cylinder{<125.730000,0.038000,88.900000><125.730000,-1.538000,88.900000>0.406400}
cylinder{<128.270000,0.038000,88.900000><128.270000,-1.538000,88.900000>0.406400}
cylinder{<130.810000,0.038000,88.900000><130.810000,-1.538000,88.900000>0.406400}
cylinder{<130.810000,0.038000,96.520000><130.810000,-1.538000,96.520000>0.406400}
cylinder{<128.270000,0.038000,96.520000><128.270000,-1.538000,96.520000>0.406400}
cylinder{<125.730000,0.038000,96.520000><125.730000,-1.538000,96.520000>0.406400}
cylinder{<123.190000,0.038000,96.520000><123.190000,-1.538000,96.520000>0.406400}
cylinder{<120.650000,0.038000,96.520000><120.650000,-1.538000,96.520000>0.406400}
cylinder{<118.110000,0.038000,96.520000><118.110000,-1.538000,96.520000>0.406400}
cylinder{<115.570000,0.038000,96.520000><115.570000,-1.538000,96.520000>0.406400}
cylinder{<7.620000,0.038000,48.260000><7.620000,-1.538000,48.260000>0.406400}
cylinder{<10.160000,0.038000,48.260000><10.160000,-1.538000,48.260000>0.406400}
cylinder{<12.700000,0.038000,48.260000><12.700000,-1.538000,48.260000>0.406400}
cylinder{<15.240000,0.038000,48.260000><15.240000,-1.538000,48.260000>0.406400}
cylinder{<17.780000,0.038000,48.260000><17.780000,-1.538000,48.260000>0.406400}
cylinder{<20.320000,0.038000,48.260000><20.320000,-1.538000,48.260000>0.406400}
cylinder{<22.860000,0.038000,48.260000><22.860000,-1.538000,48.260000>0.406400}
cylinder{<25.400000,0.038000,48.260000><25.400000,-1.538000,48.260000>0.406400}
cylinder{<27.940000,0.038000,48.260000><27.940000,-1.538000,48.260000>0.406400}
cylinder{<30.480000,0.038000,48.260000><30.480000,-1.538000,48.260000>0.406400}
cylinder{<30.480000,0.038000,55.880000><30.480000,-1.538000,55.880000>0.406400}
cylinder{<27.940000,0.038000,55.880000><27.940000,-1.538000,55.880000>0.406400}
cylinder{<25.400000,0.038000,55.880000><25.400000,-1.538000,55.880000>0.406400}
cylinder{<22.860000,0.038000,55.880000><22.860000,-1.538000,55.880000>0.406400}
cylinder{<20.320000,0.038000,55.880000><20.320000,-1.538000,55.880000>0.406400}
cylinder{<17.780000,0.038000,55.880000><17.780000,-1.538000,55.880000>0.406400}
cylinder{<15.240000,0.038000,55.880000><15.240000,-1.538000,55.880000>0.406400}
cylinder{<12.700000,0.038000,55.880000><12.700000,-1.538000,55.880000>0.406400}
cylinder{<10.160000,0.038000,55.880000><10.160000,-1.538000,55.880000>0.406400}
cylinder{<7.620000,0.038000,55.880000><7.620000,-1.538000,55.880000>0.406400}
cylinder{<7.620000,0.038000,33.020000><7.620000,-1.538000,33.020000>0.406400}
cylinder{<10.160000,0.038000,33.020000><10.160000,-1.538000,33.020000>0.406400}
cylinder{<12.700000,0.038000,33.020000><12.700000,-1.538000,33.020000>0.406400}
cylinder{<15.240000,0.038000,33.020000><15.240000,-1.538000,33.020000>0.406400}
cylinder{<17.780000,0.038000,33.020000><17.780000,-1.538000,33.020000>0.406400}
cylinder{<20.320000,0.038000,33.020000><20.320000,-1.538000,33.020000>0.406400}
cylinder{<22.860000,0.038000,33.020000><22.860000,-1.538000,33.020000>0.406400}
cylinder{<25.400000,0.038000,33.020000><25.400000,-1.538000,33.020000>0.406400}
cylinder{<27.940000,0.038000,33.020000><27.940000,-1.538000,33.020000>0.406400}
cylinder{<30.480000,0.038000,33.020000><30.480000,-1.538000,33.020000>0.406400}
cylinder{<30.480000,0.038000,40.640000><30.480000,-1.538000,40.640000>0.406400}
cylinder{<27.940000,0.038000,40.640000><27.940000,-1.538000,40.640000>0.406400}
cylinder{<25.400000,0.038000,40.640000><25.400000,-1.538000,40.640000>0.406400}
cylinder{<22.860000,0.038000,40.640000><22.860000,-1.538000,40.640000>0.406400}
cylinder{<20.320000,0.038000,40.640000><20.320000,-1.538000,40.640000>0.406400}
cylinder{<17.780000,0.038000,40.640000><17.780000,-1.538000,40.640000>0.406400}
cylinder{<15.240000,0.038000,40.640000><15.240000,-1.538000,40.640000>0.406400}
cylinder{<12.700000,0.038000,40.640000><12.700000,-1.538000,40.640000>0.406400}
cylinder{<10.160000,0.038000,40.640000><10.160000,-1.538000,40.640000>0.406400}
cylinder{<7.620000,0.038000,40.640000><7.620000,-1.538000,40.640000>0.406400}
cylinder{<138.430000,0.038000,73.660000><138.430000,-1.538000,73.660000>0.406400}
cylinder{<140.970000,0.038000,73.660000><140.970000,-1.538000,73.660000>0.406400}
cylinder{<143.510000,0.038000,73.660000><143.510000,-1.538000,73.660000>0.406400}
cylinder{<146.050000,0.038000,73.660000><146.050000,-1.538000,73.660000>0.406400}
cylinder{<148.590000,0.038000,73.660000><148.590000,-1.538000,73.660000>0.406400}
cylinder{<151.130000,0.038000,73.660000><151.130000,-1.538000,73.660000>0.406400}
cylinder{<153.670000,0.038000,73.660000><153.670000,-1.538000,73.660000>0.406400}
cylinder{<153.670000,0.038000,81.280000><153.670000,-1.538000,81.280000>0.406400}
cylinder{<151.130000,0.038000,81.280000><151.130000,-1.538000,81.280000>0.406400}
cylinder{<148.590000,0.038000,81.280000><148.590000,-1.538000,81.280000>0.406400}
cylinder{<146.050000,0.038000,81.280000><146.050000,-1.538000,81.280000>0.406400}
cylinder{<143.510000,0.038000,81.280000><143.510000,-1.538000,81.280000>0.406400}
cylinder{<140.970000,0.038000,81.280000><140.970000,-1.538000,81.280000>0.406400}
cylinder{<138.430000,0.038000,81.280000><138.430000,-1.538000,81.280000>0.406400}
cylinder{<35.560000,0.038000,77.470000><35.560000,-1.538000,77.470000>0.406400}
cylinder{<38.100000,0.038000,77.470000><38.100000,-1.538000,77.470000>0.406400}
cylinder{<40.640000,0.038000,77.470000><40.640000,-1.538000,77.470000>0.406400}
cylinder{<43.180000,0.038000,77.470000><43.180000,-1.538000,77.470000>0.406400}
cylinder{<45.720000,0.038000,77.470000><45.720000,-1.538000,77.470000>0.406400}
cylinder{<48.260000,0.038000,77.470000><48.260000,-1.538000,77.470000>0.406400}
cylinder{<50.800000,0.038000,77.470000><50.800000,-1.538000,77.470000>0.406400}
cylinder{<50.800000,0.038000,85.090000><50.800000,-1.538000,85.090000>0.406400}
cylinder{<48.260000,0.038000,85.090000><48.260000,-1.538000,85.090000>0.406400}
cylinder{<45.720000,0.038000,85.090000><45.720000,-1.538000,85.090000>0.406400}
cylinder{<43.180000,0.038000,85.090000><43.180000,-1.538000,85.090000>0.406400}
cylinder{<40.640000,0.038000,85.090000><40.640000,-1.538000,85.090000>0.406400}
cylinder{<38.100000,0.038000,85.090000><38.100000,-1.538000,85.090000>0.406400}
cylinder{<35.560000,0.038000,85.090000><35.560000,-1.538000,85.090000>0.406400}
cylinder{<92.710000,0.038000,88.900000><92.710000,-1.538000,88.900000>0.406400}
cylinder{<95.250000,0.038000,88.900000><95.250000,-1.538000,88.900000>0.406400}
cylinder{<97.790000,0.038000,88.900000><97.790000,-1.538000,88.900000>0.406400}
cylinder{<100.330000,0.038000,88.900000><100.330000,-1.538000,88.900000>0.406400}
cylinder{<102.870000,0.038000,88.900000><102.870000,-1.538000,88.900000>0.406400}
cylinder{<105.410000,0.038000,88.900000><105.410000,-1.538000,88.900000>0.406400}
cylinder{<107.950000,0.038000,88.900000><107.950000,-1.538000,88.900000>0.406400}
cylinder{<107.950000,0.038000,96.520000><107.950000,-1.538000,96.520000>0.406400}
cylinder{<105.410000,0.038000,96.520000><105.410000,-1.538000,96.520000>0.406400}
cylinder{<102.870000,0.038000,96.520000><102.870000,-1.538000,96.520000>0.406400}
cylinder{<100.330000,0.038000,96.520000><100.330000,-1.538000,96.520000>0.406400}
cylinder{<97.790000,0.038000,96.520000><97.790000,-1.538000,96.520000>0.406400}
cylinder{<95.250000,0.038000,96.520000><95.250000,-1.538000,96.520000>0.406400}
cylinder{<92.710000,0.038000,96.520000><92.710000,-1.538000,96.520000>0.406400}
cylinder{<7.620000,0.038000,63.500000><7.620000,-1.538000,63.500000>0.406400}
cylinder{<10.160000,0.038000,63.500000><10.160000,-1.538000,63.500000>0.406400}
cylinder{<12.700000,0.038000,63.500000><12.700000,-1.538000,63.500000>0.406400}
cylinder{<15.240000,0.038000,63.500000><15.240000,-1.538000,63.500000>0.406400}
cylinder{<17.780000,0.038000,63.500000><17.780000,-1.538000,63.500000>0.406400}
cylinder{<20.320000,0.038000,63.500000><20.320000,-1.538000,63.500000>0.406400}
cylinder{<22.860000,0.038000,63.500000><22.860000,-1.538000,63.500000>0.406400}
cylinder{<25.400000,0.038000,63.500000><25.400000,-1.538000,63.500000>0.406400}
cylinder{<27.940000,0.038000,63.500000><27.940000,-1.538000,63.500000>0.406400}
cylinder{<30.480000,0.038000,63.500000><30.480000,-1.538000,63.500000>0.406400}
cylinder{<30.480000,0.038000,71.120000><30.480000,-1.538000,71.120000>0.406400}
cylinder{<27.940000,0.038000,71.120000><27.940000,-1.538000,71.120000>0.406400}
cylinder{<25.400000,0.038000,71.120000><25.400000,-1.538000,71.120000>0.406400}
cylinder{<22.860000,0.038000,71.120000><22.860000,-1.538000,71.120000>0.406400}
cylinder{<20.320000,0.038000,71.120000><20.320000,-1.538000,71.120000>0.406400}
cylinder{<17.780000,0.038000,71.120000><17.780000,-1.538000,71.120000>0.406400}
cylinder{<15.240000,0.038000,71.120000><15.240000,-1.538000,71.120000>0.406400}
cylinder{<12.700000,0.038000,71.120000><12.700000,-1.538000,71.120000>0.406400}
cylinder{<10.160000,0.038000,71.120000><10.160000,-1.538000,71.120000>0.406400}
cylinder{<7.620000,0.038000,71.120000><7.620000,-1.538000,71.120000>0.406400}
cylinder{<140.970000,0.038000,24.130000><140.970000,-1.538000,24.130000>0.406400}
cylinder{<143.510000,0.038000,24.130000><143.510000,-1.538000,24.130000>0.406400}
cylinder{<146.050000,0.038000,24.130000><146.050000,-1.538000,24.130000>0.406400}
cylinder{<148.590000,0.038000,24.130000><148.590000,-1.538000,24.130000>0.406400}
cylinder{<151.130000,0.038000,24.130000><151.130000,-1.538000,24.130000>0.406400}
cylinder{<153.670000,0.038000,24.130000><153.670000,-1.538000,24.130000>0.406400}
cylinder{<156.210000,0.038000,24.130000><156.210000,-1.538000,24.130000>0.406400}
cylinder{<156.210000,0.038000,31.750000><156.210000,-1.538000,31.750000>0.406400}
cylinder{<153.670000,0.038000,31.750000><153.670000,-1.538000,31.750000>0.406400}
cylinder{<151.130000,0.038000,31.750000><151.130000,-1.538000,31.750000>0.406400}
cylinder{<148.590000,0.038000,31.750000><148.590000,-1.538000,31.750000>0.406400}
cylinder{<146.050000,0.038000,31.750000><146.050000,-1.538000,31.750000>0.406400}
cylinder{<143.510000,0.038000,31.750000><143.510000,-1.538000,31.750000>0.406400}
cylinder{<140.970000,0.038000,31.750000><140.970000,-1.538000,31.750000>0.406400}
cylinder{<138.430000,0.038000,88.900000><138.430000,-1.538000,88.900000>0.406400}
cylinder{<140.970000,0.038000,88.900000><140.970000,-1.538000,88.900000>0.406400}
cylinder{<143.510000,0.038000,88.900000><143.510000,-1.538000,88.900000>0.406400}
cylinder{<146.050000,0.038000,88.900000><146.050000,-1.538000,88.900000>0.406400}
cylinder{<148.590000,0.038000,88.900000><148.590000,-1.538000,88.900000>0.406400}
cylinder{<151.130000,0.038000,88.900000><151.130000,-1.538000,88.900000>0.406400}
cylinder{<153.670000,0.038000,88.900000><153.670000,-1.538000,88.900000>0.406400}
cylinder{<153.670000,0.038000,96.520000><153.670000,-1.538000,96.520000>0.406400}
cylinder{<151.130000,0.038000,96.520000><151.130000,-1.538000,96.520000>0.406400}
cylinder{<148.590000,0.038000,96.520000><148.590000,-1.538000,96.520000>0.406400}
cylinder{<146.050000,0.038000,96.520000><146.050000,-1.538000,96.520000>0.406400}
cylinder{<143.510000,0.038000,96.520000><143.510000,-1.538000,96.520000>0.406400}
cylinder{<140.970000,0.038000,96.520000><140.970000,-1.538000,96.520000>0.406400}
cylinder{<138.430000,0.038000,96.520000><138.430000,-1.538000,96.520000>0.406400}
cylinder{<120.650000,0.038000,9.525000><120.650000,-1.538000,9.525000>0.406400}
cylinder{<123.190000,0.038000,9.525000><123.190000,-1.538000,9.525000>0.406400}
cylinder{<151.765000,0.038000,3.810000><151.765000,-1.538000,3.810000>0.406400}
cylinder{<151.765000,0.038000,19.050000><151.765000,-1.538000,19.050000>0.406400}
cylinder{<144.145000,0.038000,19.050000><144.145000,-1.538000,19.050000>0.406400}
cylinder{<144.145000,0.038000,3.810000><144.145000,-1.538000,3.810000>0.406400}
cylinder{<95.250000,0.038000,83.820000><95.250000,-1.538000,83.820000>0.406400}
cylinder{<85.090000,0.038000,83.820000><85.090000,-1.538000,83.820000>0.406400}
cylinder{<99.060000,0.038000,86.360000><99.060000,-1.538000,86.360000>0.406400}
cylinder{<88.900000,0.038000,86.360000><88.900000,-1.538000,86.360000>0.406400}
cylinder{<121.920000,0.038000,82.550000><121.920000,-1.538000,82.550000>0.406400}
cylinder{<132.080000,0.038000,82.550000><132.080000,-1.538000,82.550000>0.406400}
cylinder{<22.860000,0.038000,76.200000><22.860000,-1.538000,76.200000>0.406400}
cylinder{<22.860000,0.038000,86.360000><22.860000,-1.538000,86.360000>0.406400}
cylinder{<12.700000,0.038000,76.200000><12.700000,-1.538000,76.200000>0.406400}
cylinder{<12.700000,0.038000,86.360000><12.700000,-1.538000,86.360000>0.406400}
cylinder{<17.780000,0.038000,76.200000><17.780000,-1.538000,76.200000>0.406400}
cylinder{<17.780000,0.038000,86.360000><17.780000,-1.538000,86.360000>0.406400}
cylinder{<20.320000,0.038000,76.200000><20.320000,-1.538000,76.200000>0.406400}
cylinder{<20.320000,0.038000,86.360000><20.320000,-1.538000,86.360000>0.406400}
cylinder{<15.240000,0.038000,76.200000><15.240000,-1.538000,76.200000>0.406400}
cylinder{<15.240000,0.038000,86.360000><15.240000,-1.538000,86.360000>0.406400}
cylinder{<25.400000,0.038000,76.200000><25.400000,-1.538000,76.200000>0.406400}
cylinder{<25.400000,0.038000,86.360000><25.400000,-1.538000,86.360000>0.406400}
cylinder{<5.080000,0.038000,76.200000><5.080000,-1.538000,76.200000>0.406400}
cylinder{<5.080000,0.038000,86.360000><5.080000,-1.538000,86.360000>0.406400}
cylinder{<10.160000,0.038000,76.200000><10.160000,-1.538000,76.200000>0.406400}
cylinder{<10.160000,0.038000,86.360000><10.160000,-1.538000,86.360000>0.406400}
cylinder{<7.620000,0.038000,76.200000><7.620000,-1.538000,76.200000>0.406400}
cylinder{<7.620000,0.038000,86.360000><7.620000,-1.538000,86.360000>0.406400}
cylinder{<147.320000,0.038000,53.340000><147.320000,-1.538000,53.340000>0.406400}
cylinder{<137.160000,0.038000,53.340000><137.160000,-1.538000,53.340000>0.406400}
cylinder{<78.740000,0.038000,8.890000><78.740000,-1.538000,8.890000>0.406400}
cylinder{<88.900000,0.038000,8.890000><88.900000,-1.538000,8.890000>0.406400}
cylinder{<116.840000,0.038000,9.525000><116.840000,-1.538000,9.525000>0.406400}
cylinder{<106.680000,0.038000,9.525000><106.680000,-1.538000,9.525000>0.406400}
cylinder{<67.310000,0.038000,88.900000><67.310000,-1.538000,88.900000>0.406400}
cylinder{<67.310000,0.038000,99.060000><67.310000,-1.538000,99.060000>0.406400}
cylinder{<48.260000,0.038000,88.900000><48.260000,-1.538000,88.900000>0.406400}
cylinder{<58.420000,0.038000,88.900000><58.420000,-1.538000,88.900000>0.406400}
cylinder{<45.720000,0.038000,73.660000><45.720000,-1.538000,73.660000>0.406400}
cylinder{<55.880000,0.038000,73.660000><55.880000,-1.538000,73.660000>0.406400}
cylinder{<31.750000,0.038000,5.080000><31.750000,-1.538000,5.080000>0.457200}
cylinder{<34.290000,0.038000,5.080000><34.290000,-1.538000,5.080000>0.457200}
cylinder{<36.830000,0.038000,5.080000><36.830000,-1.538000,5.080000>0.457200}
cylinder{<39.370000,0.038000,5.080000><39.370000,-1.538000,5.080000>0.457200}
cylinder{<41.910000,0.038000,5.080000><41.910000,-1.538000,5.080000>0.457200}
cylinder{<44.450000,0.038000,5.080000><44.450000,-1.538000,5.080000>0.457200}
cylinder{<46.990000,0.038000,5.080000><46.990000,-1.538000,5.080000>0.457200}
cylinder{<49.530000,0.038000,5.080000><49.530000,-1.538000,5.080000>0.457200}
cylinder{<52.070000,0.038000,5.080000><52.070000,-1.538000,5.080000>0.457200}
cylinder{<54.610000,0.038000,5.080000><54.610000,-1.538000,5.080000>0.457200}
cylinder{<57.150000,0.038000,5.080000><57.150000,-1.538000,5.080000>0.457200}
cylinder{<59.690000,0.038000,5.080000><59.690000,-1.538000,5.080000>0.457200}
cylinder{<7.620000,0.038000,5.080000><7.620000,-1.538000,5.080000>0.457200}
cylinder{<10.160000,0.038000,5.080000><10.160000,-1.538000,5.080000>0.457200}
cylinder{<12.700000,0.038000,5.080000><12.700000,-1.538000,5.080000>0.457200}
cylinder{<15.240000,0.038000,5.080000><15.240000,-1.538000,5.080000>0.457200}
cylinder{<17.780000,0.038000,5.080000><17.780000,-1.538000,5.080000>0.457200}
cylinder{<20.320000,0.038000,5.080000><20.320000,-1.538000,5.080000>0.457200}
cylinder{<22.860000,0.038000,5.080000><22.860000,-1.538000,5.080000>0.457200}
cylinder{<25.400000,0.038000,5.080000><25.400000,-1.538000,5.080000>0.457200}
cylinder{<66.040000,0.038000,5.080000><66.040000,-1.538000,5.080000>0.457200}
cylinder{<68.580000,0.038000,5.080000><68.580000,-1.538000,5.080000>0.457200}
cylinder{<71.120000,0.038000,5.080000><71.120000,-1.538000,5.080000>0.457200}
cylinder{<73.660000,0.038000,5.080000><73.660000,-1.538000,5.080000>0.457200}
cylinder{<6.350000,0.038000,16.510000><6.350000,-1.538000,16.510000>0.457200}
cylinder{<6.350000,0.038000,19.050000><6.350000,-1.538000,19.050000>0.457200}
cylinder{<6.350000,0.038000,21.590000><6.350000,-1.538000,21.590000>0.457200}
cylinder{<10.911000,0.038000,90.170000><10.911000,-1.538000,90.170000>0.450000}
cylinder{<13.197000,0.038000,90.170000><13.197000,-1.538000,90.170000>0.450000}
cylinder{<15.483000,0.038000,90.170000><15.483000,-1.538000,90.170000>0.450000}
cylinder{<17.769000,0.038000,90.170000><17.769000,-1.538000,90.170000>0.450000}
cylinder{<20.055000,0.038000,90.170000><20.055000,-1.538000,90.170000>0.450000}
cylinder{<9.768000,0.038000,92.710000><9.768000,-1.538000,92.710000>0.450000}
cylinder{<12.054000,0.038000,92.710000><12.054000,-1.538000,92.710000>0.450000}
cylinder{<14.340000,0.038000,92.710000><14.340000,-1.538000,92.710000>0.450000}
cylinder{<16.626000,0.038000,92.710000><16.626000,-1.538000,92.710000>0.450000}
cylinder{<18.912000,0.038000,92.710000><18.912000,-1.538000,92.710000>0.450000}
cylinder{<10.911000,0.038000,95.250000><10.911000,-1.538000,95.250000>0.450000}
cylinder{<13.197000,0.038000,95.250000><13.197000,-1.538000,95.250000>0.450000}
cylinder{<15.483000,0.038000,95.250000><15.483000,-1.538000,95.250000>0.450000}
cylinder{<17.769000,0.038000,95.250000><17.769000,-1.538000,95.250000>0.450000}
cylinder{<20.055000,0.038000,95.250000><20.055000,-1.538000,95.250000>0.450000}
//Bohrungen(schnell)/Durchkontaktierungen
cylinder{<7.620000,0.038000,60.960000><7.620000,-1.538000,60.960000>0.300000 }
cylinder{<26.670000,0.038000,60.960000><26.670000,-1.538000,60.960000>0.300000 }
cylinder{<7.620000,0.038000,58.420000><7.620000,-1.538000,58.420000>0.300000 }
cylinder{<26.670000,0.038000,58.420000><26.670000,-1.538000,58.420000>0.300000 }
cylinder{<34.925000,0.038000,96.520000><34.925000,-1.538000,96.520000>0.300000 }
cylinder{<93.980000,0.038000,14.605000><93.980000,-1.538000,14.605000>0.300000 }
cylinder{<33.655000,0.038000,93.980000><33.655000,-1.538000,93.980000>0.300000 }
cylinder{<91.440000,0.038000,14.605000><91.440000,-1.538000,14.605000>0.300000 }
cylinder{<53.340000,0.038000,92.710000><53.340000,-1.538000,92.710000>0.300000 }
cylinder{<83.820000,0.038000,92.710000><83.820000,-1.538000,92.710000>0.300000 }
cylinder{<57.150000,0.038000,31.750000><57.150000,-1.538000,31.750000>0.300000 }
cylinder{<43.180000,0.038000,31.750000><43.180000,-1.538000,31.750000>0.300000 }
cylinder{<80.010000,0.038000,29.210000><80.010000,-1.538000,29.210000>0.300000 }
cylinder{<80.010000,0.038000,21.590000><80.010000,-1.538000,21.590000>0.300000 }
cylinder{<68.580000,0.038000,13.970000><68.580000,-1.538000,13.970000>0.300000 }
cylinder{<60.960000,0.038000,13.970000><60.960000,-1.538000,13.970000>0.300000 }
cylinder{<60.960000,0.038000,26.670000><60.960000,-1.538000,26.670000>0.300000 }
cylinder{<33.020000,0.038000,26.670000><33.020000,-1.538000,26.670000>0.300000 }
cylinder{<77.470000,0.038000,21.590000><77.470000,-1.538000,21.590000>0.300000 }
cylinder{<77.470000,0.038000,30.480000><77.470000,-1.538000,30.480000>0.300000 }
cylinder{<74.930000,0.038000,31.750000><74.930000,-1.538000,31.750000>0.300000 }
cylinder{<74.930000,0.038000,21.590000><74.930000,-1.538000,21.590000>0.300000 }
cylinder{<73.660000,0.038000,34.290000><73.660000,-1.538000,34.290000>0.300000 }
cylinder{<73.660000,0.038000,24.130000><73.660000,-1.538000,24.130000>0.300000 }
cylinder{<71.120000,0.038000,25.400000><71.120000,-1.538000,25.400000>0.300000 }
cylinder{<71.120000,0.038000,16.510000><71.120000,-1.538000,16.510000>0.300000 }
cylinder{<57.150000,0.038000,63.500000><57.150000,-1.538000,63.500000>0.300000 }
cylinder{<73.660000,0.038000,63.500000><73.660000,-1.538000,63.500000>0.300000 }
cylinder{<73.660000,0.038000,60.960000><73.660000,-1.538000,60.960000>0.300000 }
cylinder{<73.660000,0.038000,46.990000><73.660000,-1.538000,46.990000>0.300000 }
cylinder{<55.880000,0.038000,48.260000><55.880000,-1.538000,48.260000>0.300000 }
cylinder{<62.230000,0.038000,48.260000><62.230000,-1.538000,48.260000>0.300000 }
cylinder{<140.335000,0.038000,15.240000><140.335000,-1.538000,15.240000>0.300000 }
cylinder{<114.300000,0.038000,15.240000><114.300000,-1.538000,15.240000>0.300000 }
cylinder{<132.080000,0.038000,76.200000><132.080000,-1.538000,76.200000>0.300000 }
cylinder{<132.080000,0.038000,44.450000><132.080000,-1.538000,44.450000>0.300000 }
cylinder{<134.620000,0.038000,16.510000><134.620000,-1.538000,16.510000>0.300000 }
cylinder{<116.840000,0.038000,16.510000><116.840000,-1.538000,16.510000>0.300000 }
cylinder{<41.275000,0.038000,8.890000><41.275000,-1.538000,8.890000>0.300000 }
cylinder{<35.560000,0.038000,8.890000><35.560000,-1.538000,8.890000>0.300000 }
cylinder{<41.910000,0.038000,11.430000><41.910000,-1.538000,11.430000>0.300000 }
cylinder{<33.020000,0.038000,11.430000><33.020000,-1.538000,11.430000>0.300000 }
cylinder{<58.420000,0.038000,13.970000><58.420000,-1.538000,13.970000>0.300000 }
cylinder{<58.420000,0.038000,11.430000><58.420000,-1.538000,11.430000>0.300000 }
cylinder{<48.260000,0.038000,8.890000><48.260000,-1.538000,8.890000>0.300000 }
cylinder{<59.690000,0.038000,8.890000><59.690000,-1.538000,8.890000>0.300000 }
cylinder{<11.430000,0.038000,26.670000><11.430000,-1.538000,26.670000>0.300000 }
cylinder{<29.210000,0.038000,26.670000><29.210000,-1.538000,26.670000>0.300000 }
cylinder{<46.990000,0.038000,13.970000><46.990000,-1.538000,13.970000>0.300000 }
cylinder{<26.670000,0.038000,13.970000><26.670000,-1.538000,13.970000>0.300000 }
cylinder{<67.945000,0.038000,10.795000><67.945000,-1.538000,10.795000>0.300000 }
cylinder{<45.720000,0.038000,10.795000><45.720000,-1.538000,10.795000>0.300000 }
cylinder{<95.250000,0.038000,46.990000><95.250000,-1.538000,46.990000>0.300000 }
cylinder{<95.250000,0.038000,54.610000><95.250000,-1.538000,54.610000>0.300000 }
cylinder{<115.570000,0.038000,54.610000><115.570000,-1.538000,54.610000>0.300000 }
cylinder{<102.870000,0.038000,54.610000><102.870000,-1.538000,54.610000>0.300000 }
cylinder{<113.030000,0.038000,67.310000><113.030000,-1.538000,67.310000>0.300000 }
cylinder{<105.410000,0.038000,67.310000><105.410000,-1.538000,67.310000>0.300000 }
cylinder{<101.600000,0.038000,85.090000><101.600000,-1.538000,85.090000>0.300000 }
cylinder{<132.715000,0.038000,85.090000><132.715000,-1.538000,85.090000>0.300000 }
cylinder{<99.060000,0.038000,83.820000><99.060000,-1.538000,83.820000>0.300000 }
cylinder{<119.380000,0.038000,83.820000><119.380000,-1.538000,83.820000>0.300000 }
cylinder{<133.350000,0.038000,40.640000><133.350000,-1.538000,40.640000>0.300000 }
cylinder{<139.700000,0.038000,39.370000><139.700000,-1.538000,39.370000>0.300000 }
cylinder{<69.850000,0.038000,87.630000><69.850000,-1.538000,87.630000>0.300000 }
cylinder{<69.850000,0.038000,91.440000><69.850000,-1.538000,91.440000>0.300000 }
cylinder{<67.310000,0.038000,74.930000><67.310000,-1.538000,74.930000>0.300000 }
cylinder{<85.090000,0.038000,74.930000><85.090000,-1.538000,74.930000>0.300000 }
cylinder{<80.010000,0.038000,73.660000><80.010000,-1.538000,73.660000>0.300000 }
cylinder{<59.690000,0.038000,73.660000><59.690000,-1.538000,73.660000>0.300000 }
cylinder{<130.810000,0.038000,78.740000><130.810000,-1.538000,78.740000>0.300000 }
cylinder{<116.840000,0.038000,78.740000><116.840000,-1.538000,78.740000>0.300000 }
cylinder{<135.890000,0.038000,34.290000><135.890000,-1.538000,34.290000>0.300000 }
cylinder{<152.400000,0.038000,34.290000><152.400000,-1.538000,34.290000>0.300000 }
cylinder{<17.780000,0.038000,44.450000><17.780000,-1.538000,44.450000>0.300000 }
cylinder{<34.925000,0.038000,44.450000><34.925000,-1.538000,44.450000>0.300000 }
cylinder{<58.420000,0.038000,50.800000><58.420000,-1.538000,50.800000>0.300000 }
cylinder{<45.720000,0.038000,50.800000><45.720000,-1.538000,50.800000>0.300000 }
cylinder{<20.320000,0.038000,43.180000><20.320000,-1.538000,43.180000>0.300000 }
cylinder{<33.020000,0.038000,43.180000><33.020000,-1.538000,43.180000>0.300000 }
cylinder{<115.570000,0.038000,45.720000><115.570000,-1.538000,45.720000>0.300000 }
cylinder{<68.580000,0.038000,45.720000><68.580000,-1.538000,45.720000>0.300000 }
cylinder{<62.230000,0.038000,45.720000><62.230000,-1.538000,45.720000>0.300000 }
cylinder{<27.940000,0.038000,45.720000><27.940000,-1.538000,45.720000>0.300000 }
cylinder{<73.660000,0.038000,66.040000><73.660000,-1.538000,66.040000>0.300000 }
cylinder{<58.420000,0.038000,66.040000><58.420000,-1.538000,66.040000>0.300000 }
cylinder{<7.620000,0.038000,24.130000><7.620000,-1.538000,24.130000>0.300000 }
cylinder{<24.130000,0.038000,24.130000><24.130000,-1.538000,24.130000>0.300000 }
cylinder{<29.210000,0.038000,28.575000><29.210000,-1.538000,28.575000>0.300000 }
cylinder{<54.610000,0.038000,28.575000><54.610000,-1.538000,28.575000>0.300000 }
cylinder{<35.560000,0.038000,40.640000><35.560000,-1.538000,40.640000>0.300000 }
cylinder{<35.560000,0.038000,60.960000><35.560000,-1.538000,60.960000>0.300000 }
cylinder{<33.020000,0.038000,58.420000><33.020000,-1.538000,58.420000>0.300000 }
cylinder{<33.020000,0.038000,85.090000><33.020000,-1.538000,85.090000>0.300000 }
cylinder{<135.890000,0.038000,97.790000><135.890000,-1.538000,97.790000>0.300000 }
cylinder{<111.760000,0.038000,97.790000><111.760000,-1.538000,97.790000>0.300000 }
cylinder{<135.890000,0.038000,95.250000><135.890000,-1.538000,95.250000>0.300000 }
cylinder{<135.890000,0.038000,81.280000><135.890000,-1.538000,81.280000>0.300000 }
cylinder{<133.350000,0.038000,78.740000><133.350000,-1.538000,78.740000>0.300000 }
cylinder{<133.350000,0.038000,66.040000><133.350000,-1.538000,66.040000>0.300000 }
//Bohrungen(schnell)/Platine
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Bestückungsdruck
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.175000,0.000000,70.815200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,70.815200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.175000,0.000000,70.815200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,70.815200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.445000,0.000000,70.815200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.810000,0.000000,70.815200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,70.815200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,69.596000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.175000,0.000000,71.450200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,71.450200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.175000,0.000000,71.450200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,71.450200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.445000,0.000000,71.450200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.810000,0.000000,71.450200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,71.450200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,72.644000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.826000,0.000000,67.437000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,67.691000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,74.549000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.826000,0.000000,74.803000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,74.803000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,74.803000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,67.691000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<2.540000,0.000000,67.691000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<2.794000,0.000000,74.549000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<4.826000,0.000000,74.549000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<4.826000,0.000000,67.691000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<2.794000,0.000000,67.691000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<89.535000,0.000000,77.774800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,77.774800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.900000,0.000000,77.774800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,77.774800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.265000,0.000000,77.774800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.265000,0.000000,77.774800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,77.774800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,78.994000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<88.900000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<89.535000,0.000000,77.139800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,77.139800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.900000,0.000000,77.139800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,77.139800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.265000,0.000000,77.139800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.265000,0.000000,77.139800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,77.139800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,75.946000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<88.900000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,81.153000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,81.153000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.884000,0.000000,81.153000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,80.899000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,74.041000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.630000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,73.787000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,73.787000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.884000,0.000000,73.787000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.170000,0.000000,74.041000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.170000,0.000000,80.899000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<90.170000,0.000000,80.899000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<89.916000,0.000000,74.041000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<87.884000,0.000000,74.041000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<87.884000,0.000000,80.899000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<89.916000,0.000000,80.899000>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<89.535000,0.000000,61.264800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,61.264800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.900000,0.000000,61.264800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,61.264800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.265000,0.000000,61.264800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.265000,0.000000,61.264800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,61.264800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,62.484000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<88.900000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<89.535000,0.000000,60.629800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,60.629800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.900000,0.000000,60.629800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.900000,0.000000,60.629800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.265000,0.000000,60.629800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<88.265000,0.000000,60.629800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,60.629800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,59.436000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<88.900000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,64.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,64.643000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.884000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,64.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,57.531000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.630000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,57.277000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.884000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.170000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.170000,0.000000,64.389000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<90.170000,0.000000,64.389000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<89.916000,0.000000,57.531000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<87.884000,0.000000,57.531000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<87.884000,0.000000,64.389000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<89.916000,0.000000,64.389000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.984800,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.984800,0.000000,15.240000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<106.984800,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.984800,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.984800,0.000000,15.875000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<106.984800,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.984800,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.204000,0.000000,15.240000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<106.984800,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.349800,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.349800,0.000000,15.240000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<106.349800,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.349800,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<106.349800,0.000000,15.875000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<106.349800,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.349800,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.156000,0.000000,15.240000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<105.156000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,16.256000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.363000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.109000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<103.251000,0.000000,16.510000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<103.251000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.997000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.997000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<102.997000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<103.251000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.109000,0.000000,13.970000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<103.251000,0.000000,13.970000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<103.251000,0.000000,14.224000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<103.251000,0.000000,16.256000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<110.109000,0.000000,16.256000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<110.109000,0.000000,14.224000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.829800,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.829800,0.000000,6.350000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<136.829800,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.829800,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.829800,0.000000,6.985000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<136.829800,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.829800,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.049000,0.000000,6.350000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<136.829800,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.194800,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.194800,0.000000,6.350000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<136.194800,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.194800,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.194800,0.000000,6.985000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<136.194800,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.194800,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.001000,0.000000,6.350000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<135.001000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.208000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.208000,0.000000,7.366000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.208000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.096000,0.000000,7.620000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.096000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.842000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.842000,0.000000,5.334000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<132.842000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.096000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,5.080000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.096000,0.000000,5.080000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<133.096000,0.000000,5.334000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<133.096000,0.000000,7.366000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<139.954000,0.000000,7.366000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<139.954000,0.000000,5.334000>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<23.495000,0.000000,19.354800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.860000,0.000000,19.354800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<22.860000,0.000000,19.354800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.860000,0.000000,19.354800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.225000,0.000000,19.354800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<22.225000,0.000000,19.354800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,19.354800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,20.574000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<22.860000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<23.495000,0.000000,18.719800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.860000,0.000000,18.719800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<22.860000,0.000000,18.719800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.860000,0.000000,18.719800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.225000,0.000000,18.719800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<22.225000,0.000000,18.719800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,18.719800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,17.526000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.860000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,22.733000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,22.733000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,15.621000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.590000,0.000000,15.621000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,15.367000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,15.621000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,22.479000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.130000,0.000000,22.479000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<23.876000,0.000000,15.621000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<21.844000,0.000000,15.621000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<21.844000,0.000000,22.479000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<23.876000,0.000000,22.479000>}
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<41.605200,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<41.605200,0.000000,64.770000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<41.605200,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<41.605200,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<41.605200,0.000000,64.135000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<41.605200,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.605200,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,64.770000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<40.386000,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.240200,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.240200,0.000000,64.770000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<42.240200,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.240200,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.240200,0.000000,64.135000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<42.240200,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.240200,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,64.770000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<42.240200,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,63.754000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.227000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,63.500000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.481000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.593000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.593000,0.000000,65.786000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.593000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,66.040000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.481000,0.000000,66.040000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<45.339000,0.000000,65.786000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<45.339000,0.000000,63.754000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.481000,0.000000,63.754000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.481000,0.000000,65.786000>}
//C8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.445000,0.000000,38.404800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,38.404800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.810000,0.000000,38.404800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,38.404800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.175000,0.000000,38.404800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.175000,0.000000,38.404800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,38.404800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,39.624000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.445000,0.000000,37.769800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,37.769800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.810000,0.000000,37.769800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.810000,0.000000,37.769800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<3.175000,0.000000,37.769800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<3.175000,0.000000,37.769800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,37.769800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,36.576000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.826000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,41.783000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,34.671000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<2.540000,0.000000,34.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,34.417000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.826000,0.000000,34.417000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,34.417000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,34.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,41.529000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,41.529000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<4.826000,0.000000,34.671000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<2.794000,0.000000,34.671000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<2.794000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<4.826000,0.000000,41.529000>}
//C9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<132.715000,0.000000,60.655200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,60.655200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<132.715000,0.000000,60.655200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,60.655200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.985000,0.000000,60.655200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<133.350000,0.000000,60.655200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,60.655200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,59.436000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<133.350000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<132.715000,0.000000,61.290200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,61.290200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<132.715000,0.000000,61.290200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,61.290200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.985000,0.000000,61.290200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<133.350000,0.000000,61.290200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,61.290200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,62.484000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<133.350000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.334000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.366000,0.000000,57.277000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<132.334000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,64.389000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,64.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.366000,0.000000,64.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.334000,0.000000,64.643000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<132.334000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,64.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,57.531000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<132.080000,0.000000,57.531000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<132.334000,0.000000,64.389000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<134.366000,0.000000,64.389000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<134.366000,0.000000,57.531000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<132.334000,0.000000,57.531000>}
//C10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.985000,0.000000,52.374800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,52.374800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<133.350000,0.000000,52.374800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,52.374800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<132.715000,0.000000,52.374800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<132.715000,0.000000,52.374800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,52.374800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,53.594000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<133.350000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.985000,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,51.739800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<133.350000,0.000000,51.739800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<133.350000,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<132.715000,0.000000,51.739800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<132.715000,0.000000,51.739800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,50.546000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<133.350000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.366000,0.000000,55.753000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.334000,0.000000,55.753000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<132.334000,0.000000,55.753000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,55.499000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,48.641000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<132.080000,0.000000,48.641000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.334000,0.000000,48.387000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.366000,0.000000,48.387000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<132.334000,0.000000,48.387000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,48.641000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,55.499000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,55.499000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<134.366000,0.000000,48.641000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<132.334000,0.000000,48.641000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<132.334000,0.000000,55.499000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<134.366000,0.000000,55.499000>}
//C11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,36.830000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<146.354800,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,37.465000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<146.354800,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.354800,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,36.830000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<146.354800,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,36.830000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<145.719800,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,37.465000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<145.719800,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.719800,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,36.830000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<144.526000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,37.846000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.733000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,38.100000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,35.814000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,35.560000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,35.560000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<142.621000,0.000000,35.814000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<142.621000,0.000000,37.846000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<149.479000,0.000000,37.846000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<149.479000,0.000000,35.814000>}
//C12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<86.995000,0.000000,92.405200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<87.630000,0.000000,92.405200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<86.995000,0.000000,92.405200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<87.630000,0.000000,92.405200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.265000,0.000000,92.405200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<87.630000,0.000000,92.405200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,92.405200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,91.186000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.630000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<86.995000,0.000000,93.040200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<87.630000,0.000000,93.040200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<86.995000,0.000000,93.040200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<87.630000,0.000000,93.040200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<88.265000,0.000000,93.040200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<87.630000,0.000000,93.040200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,93.040200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,94.234000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<87.630000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.614000,0.000000,89.027000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.646000,0.000000,89.027000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.614000,0.000000,89.027000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,96.139000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<88.900000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.646000,0.000000,96.393000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.614000,0.000000,96.393000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.614000,0.000000,96.393000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,89.281000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<86.360000,0.000000,89.281000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<86.614000,0.000000,96.139000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<88.646000,0.000000,96.139000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<88.646000,0.000000,89.281000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<86.614000,0.000000,89.281000>}
//C13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<55.245000,0.000000,82.245200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<55.880000,0.000000,82.245200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<55.245000,0.000000,82.245200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<55.880000,0.000000,82.245200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<56.515000,0.000000,82.245200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<55.880000,0.000000,82.245200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,82.245200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,81.026000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.880000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<55.245000,0.000000,82.880200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<55.880000,0.000000,82.880200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<55.245000,0.000000,82.880200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<55.880000,0.000000,82.880200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<56.515000,0.000000,82.880200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<55.880000,0.000000,82.880200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,82.880200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,84.074000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<55.880000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.864000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,78.867000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.864000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,85.979000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.150000,0.000000,85.979000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,86.233000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.864000,0.000000,86.233000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.864000,0.000000,86.233000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,85.979000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,79.121000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.610000,0.000000,79.121000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<54.864000,0.000000,85.979000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<56.896000,0.000000,85.979000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<56.896000,0.000000,79.121000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<54.864000,0.000000,79.121000>}
//C14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<111.125000,0.000000,92.405200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<111.760000,0.000000,92.405200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<111.125000,0.000000,92.405200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<111.760000,0.000000,92.405200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<112.395000,0.000000,92.405200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<111.760000,0.000000,92.405200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,92.405200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,91.186000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<111.760000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<111.125000,0.000000,93.040200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<111.760000,0.000000,93.040200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<111.125000,0.000000,93.040200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<111.760000,0.000000,93.040200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<112.395000,0.000000,93.040200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<111.760000,0.000000,93.040200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,93.040200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,94.234000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<111.760000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.744000,0.000000,89.027000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<112.776000,0.000000,89.027000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.744000,0.000000,89.027000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.030000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.030000,0.000000,96.139000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<113.030000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<112.776000,0.000000,96.393000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.744000,0.000000,96.393000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.744000,0.000000,96.393000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,89.281000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,89.281000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<110.744000,0.000000,96.139000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<112.776000,0.000000,96.139000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<112.776000,0.000000,89.281000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<110.744000,0.000000,89.281000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<154.305000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<153.416000,0.000000,85.090000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<153.416000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<144.145000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<145.034000,0.000000,85.090000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<144.145000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.590000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,85.090000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.590000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.241000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.241000,0.000000,84.455000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.241000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.241000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,85.090000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<149.225000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,85.090000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.225000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.241000,0.000000,85.725000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<149.225000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,85.090000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.225000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,84.455000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.225000,0.000000,84.455000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<151.257000,0.000000,85.852000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<147.193000,0.000000,85.852000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<147.193000,0.000000,84.328000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<151.257000,0.000000,84.328000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.511000,0.000000,84.328000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.511000,0.000000,85.852000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<151.511000,0.000000,85.852000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,85.852000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,84.328000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.939000,0.000000,84.328000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.193000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,86.106000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.193000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.193000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,84.074000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.193000,0.000000,84.074000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-0.000000,0> translate<147.574000,0.000000,85.090000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-0.000000,0> translate<152.463500,0.000000,85.090000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-0.000000,0> translate<145.986500,0.000000,85.090000>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,63.881000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.440000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,58.039000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.440000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,58.039000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.220000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,61.976000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<91.440000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,59.944000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<91.440000,0.000000,59.944000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<91.440000,0.000000,60.960000>}
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,63.881000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,58.039000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,58.039000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<157.480000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,61.976000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<137.160000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,59.944000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<137.160000,0.000000,59.944000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<137.160000,0.000000,60.960000>}
//IC3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,84.201000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,78.359000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,78.359000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,78.359000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.200000,0.000000,78.359000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,82.296000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.420000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,80.264000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.420000,0.000000,80.264000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<58.420000,0.000000,81.280000>}
//IC4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,48.641000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,48.641000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,48.641000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,42.799000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,48.641000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,42.799000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<157.480000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,48.641000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,46.736000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<137.160000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,44.704000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<137.160000,0.000000,44.704000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<137.160000,0.000000,45.720000>}
//IC5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,80.391000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.440000,0.000000,80.391000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,74.549000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.440000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,74.549000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<111.760000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,78.486000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<91.440000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,76.454000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<91.440000,0.000000,76.454000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<91.440000,0.000000,77.470000>}
//IC6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,42.291000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.830000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,36.449000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.830000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,36.449000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.390000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,40.386000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.830000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,38.354000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.830000,0.000000,38.354000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<36.830000,0.000000,39.370000>}
//IC7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,23.241000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,17.399000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,17.399000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,17.399000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,17.399000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.720000,0.000000,17.399000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,21.336000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.400000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,17.399000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,19.304000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,19.304000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<25.400000,0.000000,20.320000>}
//IC8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,23.241000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,17.399000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,17.399000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,17.399000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,17.399000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.580000,0.000000,17.399000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,21.336000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,17.399000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,19.304000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.260000,0.000000,19.304000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<48.260000,0.000000,20.320000>}
//IC9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,20.447000>}
box{<0,0,-0.076200><4.953000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.550000,0.000000,20.447000> }
object{ARC(1.270000,0.152400,270.000000,450.000000,0.036000) translate<82.550000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,32.893000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,90.000000,0> translate<133.350000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,27.940000>}
box{<0,0,-0.076200><4.953000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.550000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,32.893000>}
box{<0,0,-0.076200><50.800000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,20.447000>}
box{<0,0,-0.076200><50.800000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,20.447000> }
//IC10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,60.071000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.830000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,54.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,54.229000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.830000,0.000000,54.229000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,54.229000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.390000,0.000000,54.229000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,58.166000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.830000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,54.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,56.134000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.830000,0.000000,56.134000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<36.830000,0.000000,57.150000>}
//IC11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,95.631000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.300000,0.000000,95.631000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,89.789000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.300000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.080000,0.000000,89.789000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<132.080000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,93.726000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<114.300000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,91.694000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<114.300000,0.000000,91.694000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<114.300000,0.000000,92.710000>}
//IC12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,54.991000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,54.991000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,54.991000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,49.149000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,49.149000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,49.149000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,54.991000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,49.149000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.750000,0.000000,49.149000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,54.991000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,53.086000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,49.149000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,51.054000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,51.054000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<6.350000,0.000000,52.070000>}
//IC14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,39.751000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,33.909000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,33.909000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,33.909000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,33.909000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.750000,0.000000,33.909000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,37.846000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,33.909000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,35.814000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,35.814000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<6.350000,0.000000,36.830000>}
//IC15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,80.391000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,80.391000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,74.549000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,74.549000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.940000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,78.486000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<137.160000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,76.454000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<137.160000,0.000000,76.454000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<137.160000,0.000000,77.470000>}
//IC16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,84.201000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,78.359000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,78.359000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,78.359000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.070000,0.000000,78.359000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,82.296000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,80.264000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.290000,0.000000,80.264000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<34.290000,0.000000,81.280000>}
//IC17 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,95.631000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.440000,0.000000,95.631000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,89.789000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.440000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,89.789000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.220000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,93.726000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<91.440000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,91.694000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<91.440000,0.000000,91.694000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<91.440000,0.000000,92.710000>}
//IC18 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,70.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,70.231000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,70.231000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,64.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,64.389000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,64.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,70.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,64.389000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.750000,0.000000,64.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,70.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,68.326000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,64.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,66.294000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,66.294000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<6.350000,0.000000,67.310000>}
//IC19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,30.861000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.700000,0.000000,30.861000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,25.019000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.700000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.480000,0.000000,25.019000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<157.480000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,28.956000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.700000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,26.924000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.700000,0.000000,26.924000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<139.700000,0.000000,27.940000>}
//IC20 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,95.631000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,95.631000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,89.789000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.160000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,89.789000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.940000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,95.631000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,93.726000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<137.160000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,91.694000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<137.160000,0.000000,91.694000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<137.160000,0.000000,92.710000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.460000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.460000,0.000000,11.430000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<124.460000,0.000000,11.430000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<121.920000,0.000000,9.525000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<121.920000,0.000000,9.525000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<121.920000,0.000000,9.525000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<121.920000,0.000000,9.525000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<121.920000,0.000000,9.525000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<121.920000,0.000000,9.525000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<121.920000,0.000000,9.525000>}
difference{
cylinder{<121.920000,0,9.525000><121.920000,0.036000,9.525000>2.616200 translate<0,0.000000,0>}
cylinder{<121.920000,-0.1,9.525000><121.920000,0.135000,9.525000>2.463800 translate<0,0.000000,0>}}
//QG2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<154.305000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<154.305000,0.000000,20.320000>}
box{<0,0,-0.127000><19.050000,0.036000,0.127000> rotate<0,90.000000,0> translate<154.305000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<153.035000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<142.875000,0.000000,21.590000>}
box{<0,0,-0.127000><10.160000,0.036000,0.127000> rotate<0,0.000000,0> translate<142.875000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<141.605000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<141.605000,0.000000,2.540000>}
box{<0,0,-0.127000><17.780000,0.036000,0.127000> rotate<0,-90.000000,0> translate<141.605000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<154.305000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<142.875000,0.000000,1.270000>}
box{<0,0,-0.127000><11.430000,0.036000,0.127000> rotate<0,0.000000,0> translate<142.875000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,20.320000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.035000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,20.955000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.875000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,2.540000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.240000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.035000,0.000000,1.905000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.875000,0.000000,1.905000> }
object{ARC(1.270000,0.254000,0.000000,90.000000,0.036000) translate<153.035000,0.000000,20.320000>}
object{ARC(0.635000,0.152400,0.000000,90.000000,0.036000) translate<153.035000,0.000000,20.320000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<142.875000,0.000000,20.320000>}
object{ARC(1.270000,0.254000,90.000000,180.000000,0.036000) translate<142.875000,0.000000,20.320000>}
object{ARC(0.635000,0.152400,180.000000,270.000000,0.036000) translate<142.875000,0.000000,2.540000>}
object{ARC(1.270000,0.254000,180.000000,270.000000,0.036000) translate<142.875000,0.000000,2.540000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<153.035000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.875000,0.000000,11.099800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.415000,0.000000,11.099800>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,0.000000,0> translate<142.875000,0.000000,11.099800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.415000,0.000000,11.099800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.415000,0.000000,11.734800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<145.415000,0.000000,11.734800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.415000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.875000,0.000000,11.734800>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,0.000000,0> translate<142.875000,0.000000,11.734800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.875000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.875000,0.000000,11.099800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<142.875000,0.000000,11.099800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.875000,0.000000,12.369800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<144.145000,0.000000,12.369800>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<142.875000,0.000000,12.369800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.875000,0.000000,10.490200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<144.145000,0.000000,10.490200>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<142.875000,0.000000,10.490200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,12.369800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,13.970000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,90.000000,0> translate<144.145000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<144.145000,0.000000,12.369800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.415000,0.000000,12.369800>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<144.145000,0.000000,12.369800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,10.490200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,8.890000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,-90.000000,0> translate<144.145000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<144.145000,0.000000,10.490200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.415000,0.000000,10.490200>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<144.145000,0.000000,10.490200> }
difference{
cylinder{<152.654000,0,2.921000><152.654000,0.036000,2.921000>0.787400 translate<0,0.000000,0>}
cylinder{<152.654000,-0.1,2.921000><152.654000,0.135000,2.921000>0.482600 translate<0,0.000000,0>}}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<85.090000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<86.106000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<85.090000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<95.250000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<94.234000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<94.234000,0.000000,83.820000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<93.091000,0.000000,82.931000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<93.091000,0.000000,84.709000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<87.249000,0.000000,84.709000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<87.249000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.345000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.345000,0.000000,82.931000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<93.345000,0.000000,82.931000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.091000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<92.583000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.091000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<92.583000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<87.630000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,82.804000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.757000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<87.630000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,84.836000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.757000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.249000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.249000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.249000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.249000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,82.931000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<86.995000,0.000000,82.931000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<86.563200,0.000000,83.820000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<93.776800,0.000000,83.820000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<88.900000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<89.916000,0.000000,86.360000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<88.900000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<99.060000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<98.044000,0.000000,86.360000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<98.044000,0.000000,86.360000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<96.901000,0.000000,85.471000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<96.901000,0.000000,87.249000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<91.059000,0.000000,87.249000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<91.059000,0.000000,85.471000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.155000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.155000,0.000000,85.471000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.155000,0.000000,85.471000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.901000,0.000000,85.217000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,85.217000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,85.217000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.393000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,85.217000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<96.393000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.901000,0.000000,87.503000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,87.503000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,87.503000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.393000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,87.503000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<96.393000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.567000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,85.217000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<91.440000,0.000000,85.217000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.567000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.393000,0.000000,85.344000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.567000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.567000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,87.503000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<91.440000,0.000000,87.503000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.567000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.393000,0.000000,87.376000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.567000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.059000,0.000000,85.217000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,85.217000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.059000,0.000000,85.217000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.059000,0.000000,87.503000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.440000,0.000000,87.503000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<91.059000,0.000000,87.503000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.805000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.805000,0.000000,85.471000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<90.805000,0.000000,85.471000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<90.373200,0.000000,86.360000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<97.586800,0.000000,86.360000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<132.080000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<131.064000,0.000000,82.550000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<131.064000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<121.920000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<122.936000,0.000000,82.550000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<121.920000,0.000000,82.550000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<124.079000,0.000000,83.439000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<124.079000,0.000000,81.661000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<129.921000,0.000000,81.661000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<129.921000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.825000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.825000,0.000000,83.439000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<123.825000,0.000000,83.439000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.079000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.460000,0.000000,83.693000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.079000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.460000,0.000000,83.693000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<124.460000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.079000,0.000000,81.407000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.460000,0.000000,81.407000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.079000,0.000000,81.407000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.460000,0.000000,81.407000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<124.460000,0.000000,81.407000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.413000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,83.693000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<129.413000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.413000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,83.566000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.587000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.413000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,81.407000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<129.413000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.413000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,81.534000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.587000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.921000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,83.693000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<129.540000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.921000,0.000000,81.407000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,81.407000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<129.540000,0.000000,81.407000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.175000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.175000,0.000000,83.439000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.175000,0.000000,83.439000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<130.606800,0.000000,82.550000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<123.393200,0.000000,82.550000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.860000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.860000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<22.860000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.860000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.860000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<22.860000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<21.971000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<23.749000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<23.749000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<21.971000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.971000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.971000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.717000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<21.717000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.003000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<23.876000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<21.717000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.844000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<23.876000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.876000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.717000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.003000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.971000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.971000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<22.860000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<22.860000,0.000000,77.673200>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<12.700000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<12.700000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<11.811000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<13.589000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<13.589000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<11.811000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.589000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.811000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.811000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.557000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.557000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.843000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<13.716000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<11.557000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.684000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<13.716000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.716000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.557000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.843000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.589000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.811000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.811000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<12.700000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<12.700000,0.000000,77.673200>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<16.891000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<18.669000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<18.669000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<16.891000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.669000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.891000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.637000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.637000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.637000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.637000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<16.637000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.923000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<18.796000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.637000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<16.637000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<18.796000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.796000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.637000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.637000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.637000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.923000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.669000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.891000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,77.673200>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<20.320000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<20.320000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<20.320000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<20.320000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<20.320000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<20.320000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<19.431000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<21.209000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<21.209000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<19.431000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.209000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.431000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.431000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.177000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.177000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.463000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<21.336000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<19.177000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.304000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<21.336000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.336000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.177000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.463000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.209000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.431000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.431000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<20.320000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<20.320000,0.000000,77.673200>}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.240000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.240000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<15.240000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.240000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.240000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<15.240000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<14.351000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<16.129000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<16.129000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<14.351000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.351000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.351000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.097000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.097000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.383000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<16.256000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<14.097000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<16.256000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.256000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.097000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.383000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.351000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.351000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<15.240000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<15.240000,0.000000,77.673200>}
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<25.400000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<24.511000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<26.289000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<26.289000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<24.511000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.257000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.257000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.543000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<26.416000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.257000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.384000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<26.416000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.257000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.543000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,77.673200>}
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<5.080000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<5.080000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<4.191000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<5.969000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<5.969000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<4.191000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.191000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.937000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.937000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.223000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<6.096000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<3.937000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.064000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.096000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.096000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.937000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.223000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.191000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<5.080000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<5.080000,0.000000,77.673200>}
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<10.160000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<10.160000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<9.271000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<11.049000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<11.049000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<9.271000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.017000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.017000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.303000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<11.176000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<9.017000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.176000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.176000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.017000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.303000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<10.160000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<10.160000,0.000000,77.673200>}
//R12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<7.620000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<7.620000,0.000000,85.344000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<7.620000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<7.620000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<7.620000,0.000000,77.216000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<7.620000,0.000000,77.216000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<6.731000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<8.509000,0.000000,78.359000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<8.509000,0.000000,84.201000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<6.731000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,78.105000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.731000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.477000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.477000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,78.740000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.763000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,78.740000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<8.636000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<6.477000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.636000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,78.867000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.477000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.763000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,84.455000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.731000,0.000000,84.455000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<7.620000,0.000000,84.886800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<7.620000,0.000000,77.673200>}
//R13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<137.160000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<138.176000,0.000000,53.340000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<137.160000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<147.320000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<146.304000,0.000000,53.340000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<146.304000,0.000000,53.340000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<145.161000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<145.161000,0.000000,54.229000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<139.319000,0.000000,54.229000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<139.319000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,54.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,52.451000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.415000,0.000000,52.451000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,52.197000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,52.197000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,52.197000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,52.197000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<144.653000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,54.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,54.483000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,54.483000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<144.653000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,52.197000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<139.700000,0.000000,52.197000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,52.324000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.827000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,54.483000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<139.700000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,54.356000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.827000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.319000,0.000000,52.197000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,52.197000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.319000,0.000000,52.197000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.319000,0.000000,54.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,54.483000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.319000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,54.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,52.451000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.065000,0.000000,52.451000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<138.633200,0.000000,53.340000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<145.846800,0.000000,53.340000>}
//R14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<88.900000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<87.884000,0.000000,8.890000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<87.884000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<78.740000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<79.756000,0.000000,8.890000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<78.740000,0.000000,8.890000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<80.899000,0.000000,9.779000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<80.899000,0.000000,8.001000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<86.741000,0.000000,8.001000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<86.741000,0.000000,9.779000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,9.779000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.645000,0.000000,9.779000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,10.033000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,10.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,10.033000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<81.280000,0.000000,10.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,7.747000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,7.747000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<81.280000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.033000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<86.233000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,9.906000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,7.747000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<86.233000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,7.874000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.033000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,10.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,7.747000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,9.779000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.995000,0.000000,9.779000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<87.426800,0.000000,8.890000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<80.213200,0.000000,8.890000>}
//R15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<106.680000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<107.696000,0.000000,9.525000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<106.680000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<116.840000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<115.824000,0.000000,9.525000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<115.824000,0.000000,9.525000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<114.681000,0.000000,8.636000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<114.681000,0.000000,10.414000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<108.839000,0.000000,10.414000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<108.839000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.935000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.935000,0.000000,8.636000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<114.935000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.681000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.300000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.173000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,8.382000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<114.173000,0.000000,8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.681000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,10.668000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.300000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.173000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.300000,0.000000,10.668000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<114.173000,0.000000,10.541000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,8.382000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<109.220000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.173000,0.000000,8.509000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<109.347000,0.000000,8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,10.668000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<109.220000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.173000,0.000000,10.541000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<109.347000,0.000000,10.541000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.839000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,8.382000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<108.839000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.839000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.220000,0.000000,10.668000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<108.839000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.585000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.585000,0.000000,8.636000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<108.585000,0.000000,8.636000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<108.153200,0.000000,9.525000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<115.366800,0.000000,9.525000>}
//R16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<67.310000,0.000000,99.060000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<67.310000,0.000000,98.044000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<67.310000,0.000000,98.044000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<67.310000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<67.310000,0.000000,89.916000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<67.310000,0.000000,89.916000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<66.421000,0.000000,91.059000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<68.199000,0.000000,91.059000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<68.199000,0.000000,96.901000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<66.421000,0.000000,96.901000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,90.805000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.421000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.167000,0.000000,91.059000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.167000,0.000000,91.440000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.167000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.167000,0.000000,91.440000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<66.167000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,91.059000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,91.440000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.453000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,91.440000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<68.326000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,96.393000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.167000,0.000000,96.520000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<66.167000,0.000000,96.520000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,96.393000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,91.567000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.294000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,96.393000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,96.520000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<68.326000,0.000000,96.393000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,96.393000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,91.567000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.326000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.167000,0.000000,96.901000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.167000,0.000000,96.520000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.167000,0.000000,96.520000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,96.901000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,96.520000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.453000,0.000000,96.520000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,97.155000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,97.155000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.421000,0.000000,97.155000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<67.310000,0.000000,97.586800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<67.310000,0.000000,90.373200>}
//R18 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<58.420000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<57.404000,0.000000,88.900000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<57.404000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<48.260000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.276000,0.000000,88.900000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<48.260000,0.000000,88.900000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<50.419000,0.000000,89.789000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<50.419000,0.000000,88.011000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<56.261000,0.000000,88.011000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<56.261000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,88.011000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,89.789000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,90.043000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.800000,0.000000,90.043000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.419000,0.000000,90.043000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.800000,0.000000,90.043000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<50.800000,0.000000,90.043000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,87.757000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.800000,0.000000,87.757000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.419000,0.000000,87.757000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.800000,0.000000,87.757000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.800000,0.000000,87.757000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,90.043000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<55.753000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,89.916000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.927000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,87.757000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<55.753000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,87.884000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.927000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.261000,0.000000,90.043000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,90.043000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.880000,0.000000,90.043000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.261000,0.000000,87.757000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,87.757000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.880000,0.000000,87.757000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,88.011000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,89.789000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.515000,0.000000,89.789000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<56.946800,0.000000,88.900000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<49.733200,0.000000,88.900000>}
//R19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<55.880000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.864000,0.000000,73.660000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<54.864000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.720000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<46.736000,0.000000,73.660000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<45.720000,0.000000,73.660000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<47.879000,0.000000,74.549000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<47.879000,0.000000,72.771000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<53.721000,0.000000,72.771000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<53.721000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,72.771000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,74.549000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.625000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,74.803000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,74.803000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.879000,0.000000,74.803000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,74.803000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<48.260000,0.000000,74.803000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,72.517000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,72.517000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.879000,0.000000,72.517000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,72.517000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.260000,0.000000,72.517000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.340000,0.000000,74.803000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.213000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,74.676000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.387000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.340000,0.000000,72.517000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.213000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,72.644000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.387000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,74.803000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.340000,0.000000,74.803000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.340000,0.000000,74.803000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,72.517000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.340000,0.000000,72.517000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.340000,0.000000,72.517000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,72.771000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,74.549000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.975000,0.000000,74.549000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<54.406800,0.000000,73.660000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<47.193200,0.000000,73.660000>}
//SL1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.639000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,6.731000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<32.639000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,6.477000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<32.766000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,6.731000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.020000,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.401000,0.000000,6.858000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.274000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.766000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.734000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.274000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,6.858000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.734000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.734000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,2.794000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.734000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,3.302000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.734000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.385000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.385000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.655000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.655000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.274000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.734000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,3.302000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.734000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.496000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.734000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.496000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.496000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.496000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.004000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.496000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.496000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.036000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.544000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.274000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.766000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.306000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.814000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.846000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.465000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.195000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.925000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.925000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.195000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.195000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.306000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.465000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.465000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.576000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.576000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.576000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.084000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.084000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.576000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.576000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.814000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.576000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.306000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.306000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.544000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.036000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.274000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.004000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.639000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.734000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.401000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.401000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.306000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.274000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.766000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.306000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.814000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.655000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.274000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.306000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.306000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.386000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.354000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.386000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.894000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.354000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.005000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.735000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.005000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.275000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.275000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.005000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.386000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.894000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.354000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.735000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.354000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.116000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.624000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.116000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.656000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.164000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.164000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.164000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.894000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.386000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,6.731000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.420000,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,6.858000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.674000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.166000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.674000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.674000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.801000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.706000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,2.794000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.706000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,3.302000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.325000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.706000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.325000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.055000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.785000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.785000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.055000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.055000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.785000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.166000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.674000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.325000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.325000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,3.302000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.706000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.436000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.944000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.944000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.436000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.674000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.674000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.166000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.166000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.039000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,6.731000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<58.039000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,6.477000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<58.166000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.164000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.656000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.894000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.386000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.624000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.354000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.894000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.386000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.166000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.674000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.005000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.785000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.166000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.386000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.846000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.354000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.846000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.465000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.846000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.846000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.846000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,7.493000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.846000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,7.493000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.354000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.926000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.894000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.434000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.545000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.545000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.815000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.815000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.196000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.926000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.164000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.164000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.894000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.434000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.926000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.466000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.466000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.974000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.085000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.085000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.355000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.355000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.466000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.974000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.736000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.244000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.974000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.466000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.736000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.974000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.466000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.974000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.466000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.466000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.006000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.974000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.006000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.514000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.625000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.355000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.625000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.895000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.895000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.006000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.514000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.276000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.276000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.276000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.784000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.784000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.784000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.514000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.006000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.784000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.276000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.276000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.276000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.514000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.006000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.244000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.974000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.514000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.006000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.006000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.546000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.514000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.546000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<51.054000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.895000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.435000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.435000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.546000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.054000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.816000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.816000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.816000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.324000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.324000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.324000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.054000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.546000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.324000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.816000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.816000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.816000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.054000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.546000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.784000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.784000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.514000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<51.054000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.546000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.546000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.086000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.054000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.086000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.594000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.705000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.435000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.705000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.975000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.975000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.705000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.086000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.594000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.356000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.356000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.356000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.864000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.864000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.864000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.594000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.086000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.864000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.356000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.356000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.356000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.594000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.086000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.324000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.324000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.054000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.594000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.086000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.705000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.086000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.626000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.594000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.626000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.134000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.245000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.245000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.515000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.515000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.245000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.626000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.134000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.896000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.404000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.404000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.404000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.134000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.626000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.404000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.896000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.134000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.626000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.864000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.864000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.594000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.134000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.626000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.245000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.626000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.404000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.404000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.039000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.134000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.515000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.166000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.134000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.134000,0.000000,2.794000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<31.750000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<34.290000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<36.830000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<39.370000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<41.910000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<46.990000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<44.450000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<59.690000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<49.530000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<52.070000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<54.610000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<57.150000,0.000000,5.080000>}
//SL2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,6.731000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<8.509000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,6.477000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<8.636000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,6.731000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.890000,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,6.858000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.144000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.636000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,6.858000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,2.794000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,3.302000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.255000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.985000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.985000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.255000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.525000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.525000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.636000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.985000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,3.302000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.366000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.366000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.906000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.414000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.636000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.684000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.716000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.335000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.795000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.795000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.335000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.446000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.954000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.954000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.446000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.684000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.176000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.906000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.636000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.176000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.684000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.525000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.176000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.256000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.875000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.605000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.875000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.145000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.145000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.605000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.986000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.494000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.986000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.526000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.034000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.256000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,6.731000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.130000,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,6.858000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.384000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.876000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.384000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.384000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.416000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,2.794000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,3.302000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.035000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.495000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.495000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.765000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.765000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.876000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.384000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.035000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,3.302000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.146000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.146000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.384000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.384000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.876000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.876000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,6.731000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<23.749000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,6.477000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<23.876000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.494000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.256000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.876000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.384000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.876000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.716000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,7.493000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.716000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,7.493000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.796000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.304000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.415000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.145000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.415000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.685000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.685000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.066000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.574000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.304000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.796000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.066000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.034000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.304000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.796000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.336000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.844000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.685000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.225000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.225000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.606000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.114000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.844000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.336000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.606000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.574000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,6.858000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.844000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.336000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.114000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.225000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,2.794000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<7.620000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<10.160000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<12.700000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<15.240000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<17.780000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<22.860000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<20.320000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<25.400000,0.000000,5.080000>}
//SL3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,6.731000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<66.929000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,6.477000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<67.056000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,6.731000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.310000,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.691000,0.000000,6.858000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.564000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.024000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.564000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,6.858000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.024000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.024000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,2.794000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.024000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,3.302000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.024000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.675000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.405000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.405000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.675000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.675000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.564000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.024000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.405000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,3.302000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.024000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.786000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.024000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.786000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.786000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.786000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.786000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.786000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.326000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.834000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.834000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.834000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.564000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.056000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.596000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.104000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.104000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.755000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.485000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.215000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.215000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.485000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.485000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.215000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.596000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.104000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.755000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.866000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.866000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.866000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.374000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.374000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.374000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.374000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.374000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.374000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.866000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.866000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.104000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.866000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.104000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.596000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.596000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.834000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.834000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.834000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.326000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.326000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.564000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.024000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.691000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.691000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,6.858000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.596000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.564000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.596000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.104000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.945000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.675000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.564000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.215000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.596000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,3.556000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.676000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,2.794000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.676000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,2.921000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.136000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.136000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,2.794000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.644000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,2.794000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.644000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,3.302000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.295000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.295000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.295000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.295000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.025000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.025000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.755000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,3.556000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.136000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,3.556000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.644000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,3.810000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.025000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.644000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,6.477000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<72.136000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,3.556000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.136000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,6.731000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<72.009000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,6.858000>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.390000,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.771000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,3.302000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.755000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,3.556000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.676000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.136000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.136000,0.000000,7.493000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.136000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.406000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.644000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,7.620000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.644000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.406000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.406000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.406000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.406000,0.000000,7.747000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.406000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,7.747000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.914000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,7.620000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.914000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,6.858000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.676000,0.000000,6.858000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.104000,0.000000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,6.858000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.104000,0.000000,6.858000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<66.040000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<68.580000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<71.120000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<73.660000,0.000000,5.080000>}
//SL4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,17.399000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,17.526000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.572000,0.000000,17.399000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,17.780000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.699000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,18.034000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<4.699000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,18.161000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<4.572000,0.000000,18.161000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.509000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,15.494000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,17.526000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.509000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.509000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,15.494000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,15.494000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.572000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.128000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,15.875000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.128000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,17.526000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,18.415000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,15.494000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.874000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,15.494000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,16.256000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.683000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.683000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.683000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.683000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.683000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,20.574000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<4.699000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,20.701000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<4.572000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,20.066000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.509000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.509000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,20.574000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,22.606000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.572000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,22.606000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,22.606000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.128000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.225000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.128000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,22.606000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.572000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.066000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.955000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,22.606000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.606000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.683000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,22.606000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.683000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,21.336000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.683000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,21.336000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,20.066000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.937000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.810000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,20.066000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.572000,0.000000,19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,20.320000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.699000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,20.066000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.683000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,18.796000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.937000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,16.764000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,17.399000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,15.494000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.572000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,19.939000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.572000,0.000000,19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,18.034000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.699000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,17.526000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.699000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.066000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.699000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.699000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,20.574000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.699000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.128000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,20.066000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.636000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.128000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.509000,0.000000,20.066000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<6.350000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<6.350000,0.000000,19.050000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<6.350000,0.000000,21.590000>}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,88.265000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.381000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,88.773000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.207000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,88.265000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<24.765000,0.000000,88.773000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.226000,0.000000,88.265000>}
box{<0,0,-0.076200><4.953000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.273000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.226000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,88.773000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.226000,0.000000,88.265000> }
difference{
cylinder{<2.740000,0,92.710000><2.740000,0.036000,92.710000>1.727200 translate<0,0.000000,0>}
cylinder{<2.740000,-0.1,92.710000><2.740000,0.135000,92.710000>1.574800 translate<0,0.000000,0>}}
difference{
cylinder{<27.740000,0,92.710000><27.740000,0.036000,92.710000>1.727200 translate<0,0.000000,0>}
cylinder{<27.740000,-0.1,92.710000><27.740000,0.135000,92.710000>1.574800 translate<0,0.000000,0>}}
box{<-0.200000,0,-1.550000><0.200000,0.036000,1.550000> rotate<0,-180.000000,0> translate<20.055000,0.000000,92.760000>}
box{<-0.200000,0,-1.550000><0.200000,0.036000,1.550000> rotate<0,-180.000000,0> translate<17.769000,0.000000,92.760000>}
box{<-0.200000,0,-1.550000><0.200000,0.036000,1.550000> rotate<0,-180.000000,0> translate<15.483000,0.000000,92.760000>}
box{<-0.200000,0,-1.550000><0.200000,0.036000,1.550000> rotate<0,-180.000000,0> translate<13.197000,0.000000,92.760000>}
box{<-0.200000,0,-1.550000><0.200000,0.036000,1.550000> rotate<0,-180.000000,0> translate<10.911000,0.000000,92.760000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  Z80_VIDEO(-80.000000,0,-50.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//X1	vga	HDF15H
