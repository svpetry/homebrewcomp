//POVRay-Datei erstellt mit 3d41.ulp v1.05
//X:/Sven/Elektronik/Eagle/Z80/Z80_Memory.brd
//01.08.2010 08:35:27

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
#declare global_seed=seed(434);
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


#macro Z80_MEMORY(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
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
//Bohrungen(real)/Platine
//Bohrungen(real)/Durchkontaktierungen
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Bauteile
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_WIMA_5_030_072_075("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<42.545000,0.000000,77.470000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C1  C050-030X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_WIMA_5_030_072_075("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<146.050000,0.000000,35.560000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C2  C050-030X075
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_WIMA_5_030_072_075("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<91.440000,0.000000,78.740000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C3  C050-030X075
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_WIMA_5_030_072_075("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<146.050000,0.000000,73.660000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C4  C050-030X075
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_WIMA_5_030_072_075("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<118.110000,0.000000,27.940000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C5  C050-030X075
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_WIMA_5_030_072_075("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<64.770000,0.000000,31.750000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C6  C050-030X075
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_DIS_CERAMIC_50MM_44MM("33n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,93.345000>}#end		//ceramic disc capacitator C7 33n C050-024X044
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_DIS_CERAMIC_50MM_44MM("33n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,89.535000>}#end		//ceramic disc capacitator C8 33n C050-024X044
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP16("74LS42N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<123.190000,0.000000,64.770000>translate<0,3.000000,0> }#end		//DIP16 IC1 74LS42N DIL16
#ifndef(pack_IC1) object{SOCKET_DIP16()rotate<0,-90.000000,0> rotate<0,0,0> translate<123.190000,0.000000,64.770000>}#end					//IC-Sockel 16Pin IC1 74LS42N
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP14("74LS04N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<146.050000,0.000000,88.900000>translate<0,3.000000,0> }#end		//DIP14 IC2 74LS04N DIL14
#ifndef(pack_IC2) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<146.050000,0.000000,88.900000>}#end					//IC-Sockel 14Pin IC2 74LS04N
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_DIS_DIP14("7400N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<146.050000,0.000000,24.130000>translate<0,3.000000,0> }#end		//DIP14 IC3 7400N DIL14
#ifndef(pack_IC3) object{SOCKET_DIP14()rotate<0,-270.000000,0> rotate<0,0,0> translate<146.050000,0.000000,24.130000>}#end					//IC-Sockel 14Pin IC3 7400N
#ifndef(pack_IC4) #declare global_pack_IC4=yes; object {IC_DIS_DIP14("74LS74","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<56.515000,0.000000,88.900000>translate<0,3.000000,0> }#end		//DIP14 IC4 74LS74 DIL14
#ifndef(pack_IC4) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<56.515000,0.000000,88.900000>}#end					//IC-Sockel 14Pin IC4 74LS74
#ifndef(pack_IC8) #declare global_pack_IC8=yes; object {IC_DIS_DIP28("SRAM0","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<52.070000,0.000000,57.150000>translate<0,3.000000,0> }#end		//DIP28 300mil IC8 SRAM0 DIL28-3
#ifndef(pack_IC8) object{SOCKET_DIP28()rotate<0,-270.000000,0> rotate<0,0,0> translate<52.070000,0.000000,57.150000>}#end					//IC-Sockel 28Pin IC8 SRAM0
#ifndef(pack_IC9) #declare global_pack_IC9=yes; object {IC_DIS_DIP28("SRAM1","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<68.580000,0.000000,57.150000>translate<0,3.000000,0> }#end		//DIP28 300mil IC9 SRAM1 DIL28-3
#ifndef(pack_IC9) object{SOCKET_DIP28()rotate<0,-270.000000,0> rotate<0,0,0> translate<68.580000,0.000000,57.150000>}#end					//IC-Sockel 28Pin IC9 SRAM1
#ifndef(pack_IC10) #declare global_pack_IC10=yes; object {IC_DIS_DIP20("74LS373N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<91.440000,0.000000,19.050000>translate<0,3.000000,0> }#end		//DIP20 IC10 74LS373N DIL20
#ifndef(pack_IC10) object{SOCKET_DIP20()rotate<0,-270.000000,0> rotate<0,0,0> translate<91.440000,0.000000,19.050000>}#end					//IC-Sockel 20Pin IC10 74LS373N
#ifndef(pack_IC14) #declare global_pack_IC14=yes; object {IC_DIS_DIP16("74HC42","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<123.190000,0.000000,87.630000>translate<0,3.000000,0> }#end		//DIP16 IC14 74HC42 DIL16
#ifndef(pack_IC14) object{SOCKET_DIP16()rotate<0,-90.000000,0> rotate<0,0,0> translate<123.190000,0.000000,87.630000>}#end					//IC-Sockel 16Pin IC14 74HC42
#ifndef(pack_IC15) #declare global_pack_IC15=yes; object {IC_DIS_DIP20("74LS373N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<52.070000,0.000000,19.050000>translate<0,3.000000,0> }#end		//DIP20 IC15 74LS373N DIL20
#ifndef(pack_IC15) object{SOCKET_DIP20()rotate<0,-270.000000,0> rotate<0,0,0> translate<52.070000,0.000000,19.050000>}#end					//IC-Sockel 20Pin IC15 74LS373N
#ifndef(pack_IC20) #declare global_pack_IC20=yes; object {IC_DIS_DIP28("SRAM2","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<85.090000,0.000000,57.150000>translate<0,3.000000,0> }#end		//DIP28 300mil IC20 SRAM2 DIL28-3
#ifndef(pack_IC20) object{SOCKET_DIP28()rotate<0,-270.000000,0> rotate<0,0,0> translate<85.090000,0.000000,57.150000>}#end					//IC-Sockel 28Pin IC20 SRAM2
#ifndef(pack_IC21) #declare global_pack_IC21=yes; object {IC_DIS_DIP28("SRAM3","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<101.600000,0.000000,57.150000>translate<0,3.000000,0> }#end		//DIP28 300mil IC21 SRAM3 DIL28-3
#ifndef(pack_IC21) object{SOCKET_DIP28()rotate<0,-270.000000,0> rotate<0,0,0> translate<101.600000,0.000000,57.150000>}#end					//IC-Sockel 28Pin IC21 SRAM3
#ifndef(pack_IC23) #declare global_pack_IC23=yes; object {IC_DIS_DIP20("74LS373N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<146.050000,0.000000,52.070000>translate<0,3.000000,0> }#end		//DIP20 IC23 74LS373N DIL20
#ifndef(pack_IC23) object{SOCKET_DIP20()rotate<0,-270.000000,0> rotate<0,0,0> translate<146.050000,0.000000,52.070000>}#end					//IC-Sockel 20Pin IC23 74LS373N
#ifndef(pack_IC34) #declare global_pack_IC34=yes; object {IC_DIS_DIP14("74F32N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<107.950000,0.000000,88.900000>translate<0,3.000000,0> }#end		//DIP14 IC34 74F32N DIL14
#ifndef(pack_IC34) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<107.950000,0.000000,88.900000>}#end					//IC-Sockel 14Pin IC34 74F32N
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Yellow,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<36.195000,0.000000,85.090000>}#end		//Diskrete 5MM LED LED2 port3 LED5MM
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {DIODE_DIS_LED_5MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<124.460000,0.000000,30.480000>}#end		//Diskrete 5MM LED LED3 power LED5MM
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<71.120000,0.000000,81.915000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R1 22K 0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<41.275000,0.000000,92.710000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R2 470 0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<137.795000,0.000000,69.215000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R3 1K5 0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<125.730000,0.000000,17.780000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R5 470 0207/10
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_025MMV(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<92.075000,0.000000,86.995000>}#end		//Diskreter Widerstand 0,25W stehend 100mil R7 22K 0207/2V
#ifndef(pack_SL1) #declare global_pack_SL1=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<12.700000,0.000000,21.590000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL1 data bus 08P
#ifndef(pack_SL2) #declare global_pack_SL2=yes; object {PH_1X16()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<12.700000,0.000000,57.150000>}#end		//Stiftleiste 2,54mm Raster 16Pin 1Reihe (pinhead.lib) SL2 address bus 16P
#ifndef(pack_SL3) #declare global_pack_SL3=yes; object {PH_1X6()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<133.350000,0.000000,67.310000>}#end		//Stiftleiste 2,54mm Raster 6Pin 1Reihe (pinhead.lib) SL3  06P
#ifndef(pack_SL4) #declare global_pack_SL4=yes; object {PH_1X7()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<12.700000,0.000000,90.170000>}#end		//Stiftleiste 2,54mm Raster 7Pin 1Reihe (pinhead.lib) SL4 mem control bus 07P
#ifndef(pack_SL5) #declare global_pack_SL5=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<4.445000,0.000000,85.090000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL5 power 03P
#ifndef(pack_SL6) #declare global_pack_SL6=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<107.950000,0.000000,19.050000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL6 PORT1 08P
#ifndef(pack_SL7) #declare global_pack_SL7=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<68.580000,0.000000,19.050000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL7 PORT2 08P
#ifndef(pack_SL8) #declare global_pack_SL8=yes; object {PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<97.155000,0.000000,88.900000>}#end		//Stiftleiste 2,54mm Raster 4Pin 1Reihe (pinhead.lib) SL8  04P
#ifndef(pack_SL9) #declare global_pack_SL9=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<144.145000,0.000000,69.215000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL9 memory ext 03P
}//End union
#end
#if(pcb_pads_smds=on)
//Lötaugen&SMD/Bauteile
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<45.085000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<40.005000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<148.590000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<143.510000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<88.900000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<93.980000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<148.590000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<143.510000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<118.110000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<118.110000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<62.230000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<67.310000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<72.390000,0,93.345000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<67.310000,0,93.345000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<72.390000,0,89.535000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<67.310000,0,89.535000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<88.900000,0,85.725000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<88.900000,0,88.265000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<149.860000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<149.860000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<149.860000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<149.860000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<149.860000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<149.860000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<149.860000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<60.325000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<60.325000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<60.325000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<60.325000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<60.325000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<60.325000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<60.325000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<52.705000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<52.705000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<52.705000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<52.705000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<52.705000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<52.705000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<52.705000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<84.455000,0,84.455000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<84.455000,0,86.995000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<84.455000,0,89.535000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<84.455000,0,92.075000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<76.835000,0,92.075000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<76.835000,0,89.535000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<76.835000,0,86.995000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<76.835000,0,84.455000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<64.770000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<72.390000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<87.630000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<95.250000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.000000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<119.380000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<48.260000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_IC15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<55.880000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<81.280000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.790000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<105.410000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<142.240000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<149.860000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<111.760000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<111.760000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<111.760000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<111.760000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<111.760000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<111.760000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<111.760000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<104.140000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<104.140000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<104.140000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<104.140000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<104.140000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<104.140000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC34) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<104.140000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<36.195000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<36.195000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<123.190000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<125.730000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<66.040000,0,81.915000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<76.200000,0,81.915000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<46.355000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<36.195000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<137.795000,0,64.135000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<137.795000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<125.730000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<125.730000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<92.075000,0,88.265000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<92.075000,0,85.725000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<133.350000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<133.350000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<133.350000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<133.350000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<133.350000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<133.350000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,87.630000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,95.250000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<12.700000,0,97.790000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<4.445000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<4.445000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<4.445000,0,87.630000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<107.950000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<68.580000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_SL8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.155000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_SL8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.155000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_SL8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.155000,0,87.630000> texture{col_thl}}
#ifndef(global_pack_SL8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<97.155000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_SL9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<146.685000,0,69.215000> texture{col_thl}}
#ifndef(global_pack_SL9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<144.145000,0,69.215000> texture{col_thl}}
#ifndef(global_pack_SL9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<141.605000,0,69.215000> texture{col_thl}}
//Lötaugen/Durchkontaktierungen
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<75.565000,0,53.340000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<75.565000,0,36.195000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<91.440000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<91.440000,0,53.340000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<107.950000,0,53.340000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<107.950000,0,33.655000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<19.685000,0,88.900000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<139.700000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<139.700000,0,29.210000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<137.160000,0,53.340000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<137.160000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<138.430000,0,51.435000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<138.430000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<85.090000,0,80.010000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<48.260000,0,80.010000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<31.750000,0,87.630000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<31.750000,0,59.690000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<26.670000,0,72.390000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<26.670000,0,87.630000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<27.305000,0,92.075000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<32.385000,0,94.615000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<116.840000,0,97.790000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<38.735000,0,97.790000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<116.840000,0,49.530000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<116.840000,0,81.280000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<107.950000,0,67.310000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<107.950000,0,78.105000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<45.085000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<45.085000,0,38.100000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<115.570000,0,38.100000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<115.570000,0,77.470000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<133.350000,0,53.340000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<133.350000,0,48.260000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<39.370000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<20.320000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<72.390000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<72.390000,0,34.925000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<20.320000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<20.320000,0,80.645000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<39.370000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<25.400000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<39.370000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<30.480000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<57.785000,0,5.715000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<45.085000,0,5.715000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<135.890000,0,46.355000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<135.890000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<78.105000,0,40.640000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<78.105000,0,12.700000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<118.110000,0,43.180000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<118.110000,0,39.370000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<109.220000,0,45.720000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<109.220000,0,40.640000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<35.560000,0,27.940000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<22.860000,0,27.940000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<83.820000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<83.820000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<59.690000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<59.690000,0,2.540000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<97.790000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<97.790000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<59.055000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<59.055000,0,50.800000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<95.250000,0,33.655000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<95.250000,0,40.005000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<120.015000,0,2.540000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<120.015000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<52.705000,0,78.105000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<80.010000,0,78.105000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<142.240000,0,78.105000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<156.845000,0,78.105000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<20.955000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<20.955000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<80.010000,0,1.270000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<80.010000,0,7.620000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<114.300000,0,71.120000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<114.300000,0,86.360000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<101.600000,0,13.335000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<101.600000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<102.870000,0,26.035000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<102.870000,0,9.525000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<63.500000,0,12.700000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<63.500000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<62.230000,0,29.210000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<62.230000,0,10.160000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<111.125000,0,53.340000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<111.125000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<148.590000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<119.380000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<152.400000,0,63.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<152.400000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<114.300000,0,30.480000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<114.300000,0,53.340000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<73.660000,0,7.620000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.512800,0.700000,1,16,2,0) translate<73.660000,0,2.540000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signale
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,27.940000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<5.080000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,71.120000>}
box{<0,0,-0.304800><23.495000,0.035000,0.304800> rotate<0,90.000000,0> translate<5.080000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,26.670000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<6.350000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,67.310000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<6.350000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,24.130000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,66.040000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<4.445000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<7.620000,-1.535000,87.630000>}
box{<0,0,-0.635000><3.175000,0.035000,0.635000> rotate<0,0.000000,0> translate<4.445000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<7.620000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<7.620000,-1.535000,87.630000>}
box{<0,0,-0.635000><9.525000,0.035000,0.635000> rotate<0,90.000000,0> translate<7.620000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,22.860000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<8.890000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,60.960000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<8.890000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,21.590000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,39.370000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,44.450000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<6.350000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,58.420000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,72.390000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,76.200000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<5.080000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,90.170000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,41.910000>}
box{<0,0,-0.304800><8.082231,0.035000,0.304800> rotate<0,44.997030,0> translate<5.080000,-1.535000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,12.700000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<6.350000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,15.240000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,22.860000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<8.890000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,27.940000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.080000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,30.480000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<8.890000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,66.040000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,76.200000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,90.170000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<15.240000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,67.310000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<6.350000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<7.620000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<15.875000,-1.535000,78.105000>}
box{<0,0,-0.635000><8.255000,0.035000,0.635000> rotate<0,0.000000,0> translate<7.620000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,12.065000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<17.780000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,16.510000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<8.890000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,27.940000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,36.830000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,55.880000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,68.580000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,80.645000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<15.875000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<18.415000,-1.535000,75.565000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,44.997030,0> translate<15.875000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,-1.535000,87.630000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,13.335000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<19.050000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,17.780000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,54.610000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,67.310000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,79.375000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<17.780000,-1.535000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<18.415000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.350000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,26.670000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<6.350000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,34.290000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,53.340000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,66.040000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,0.000000,80.645000>}
box{<0,0,-0.304800><46.355000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,0.000000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.955000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.955000,0.000000,15.240000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.955000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,52.070000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<8.890000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,64.770000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<21.590000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,25.400000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,27.940000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,34.290000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,50.800000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,63.500000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,71.120000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,49.530000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,62.230000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<24.130000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<22.860000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,72.390000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,82.550000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,85.090000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.765000,-1.535000,80.645000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,-1.535000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,24.130000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,33.020000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<25.400000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,48.260000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,60.960000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<25.400000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<24.130000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,79.375000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,79.375000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.050000,-1.535000,79.375000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,92.710000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,45.720000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,58.420000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,0.000000,72.390000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,-90.000000,0> translate<26.670000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,87.630000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.130000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,79.375000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<25.400000,-1.535000,79.375000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,92.075000>}
box{<0,0,-0.304800><1.419903,0.035000,0.304800> rotate<0,26.563298,0> translate<26.035000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,20.320000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,22.860000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,31.750000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.940000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,44.450000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,57.150000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.940000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<27.940000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,43.180000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,55.880000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.210000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.765000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,85.090000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.765000,-1.535000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,87.630000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.130000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,10.795000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.080000,-1.535000,10.795000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,21.590000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,20.955000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<29.845000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,30.480000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.480000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,41.910000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.795000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,54.610000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.480000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,12.065000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,95.250000>}
box{<0,0,-0.304800><18.415000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,40.640000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,53.340000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,87.630000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,0.000000,87.630000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,95.250000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.115000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.385000,-1.535000,13.335000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.050000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.385000,-1.535000,94.615000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<31.750000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,29.210000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,39.370000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,52.070000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,38.100000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,50.800000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<34.290000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.560000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,27.940000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<22.860000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,36.830000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,49.530000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.195000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,92.710000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.195000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<35.560000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,35.560000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,48.260000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.830000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,2.540000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<29.845000,-1.535000,10.795000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,13.970000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<38.100000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,19.050000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,34.290000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<22.860000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,46.990000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<38.100000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,-1.535000,97.790000>}
box{<0,0,-0.304800><26.035000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,3.810000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<31.115000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,12.700000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<38.100000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,15.240000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,-90.000000,0> translate<39.370000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,0.000000,20.955000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<30.480000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,0.000000,24.130000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,0.000000,26.670000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,33.020000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,45.720000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.385000,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,5.715000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<32.385000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,25.400000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<39.370000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,31.750000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,44.450000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,30.480000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<30.480000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,43.180000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.910000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,22.860000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,29.210000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,41.910000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,24.130000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,27.940000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,35.560000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,5.715000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.005000,-1.535000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,38.100000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.085000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,54.610000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,0.000000,0> translate<30.480000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<18.415000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<45.085000,-1.535000,75.565000>}
box{<0,0,-0.635000><26.670000,0.035000,0.635000> rotate<0,0.000000,0> translate<18.415000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<45.085000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<45.085000,-1.535000,77.470000>}
box{<0,0,-0.635000><1.905000,0.035000,0.635000> rotate<0,90.000000,0> translate<45.085000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.720000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<43.180000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<44.450000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,25.400000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,34.925000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,36.830000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,35.560000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.720000,-1.535000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,96.520000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<46.355000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,81.280000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,12.700000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,15.240000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,25.400000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,43.180000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,45.720000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,48.260000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,50.800000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.290000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,53.340000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.750000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,55.880000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,58.420000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,60.960000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,63.500000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<22.860000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,66.040000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,68.580000>}
box{<0,0,-0.304800><30.480000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,71.120000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,73.660000>}
box{<0,0,-0.304800><35.560000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,80.010000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<46.990000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,82.550000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.195000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,85.090000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,95.250000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.895000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<48.895000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<48.895000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,92.710000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.165000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,10.160000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.800000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,27.940000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,41.910000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.180000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,44.450000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,46.990000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,49.530000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,52.070000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,57.150000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,59.690000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.750000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,62.230000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.130000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,64.770000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,67.310000>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.050000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,69.850000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.130000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,72.390000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,17.780000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,15.240000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<50.800000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,24.130000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<50.800000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,29.210000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<50.800000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<51.435000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<51.435000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.165000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.705000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.165000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,88.900000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.165000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,96.520000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.355000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,3.810000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,12.700000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,54.610000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,72.390000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<50.800000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.705000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,91.440000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.705000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,12.700000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,15.240000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,73.660000>}
box{<0,0,-0.635000><1.905000,0.035000,0.635000> rotate<0,-90.000000,0> translate<55.880000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<45.085000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,75.565000>}
box{<0,0,-0.635000><10.795000,0.035000,0.635000> rotate<0,0.000000,0> translate<45.085000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,76.200000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,90.000000,0> translate<55.880000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<52.705000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,81.280000>}
box{<0,0,-0.635000><3.175000,0.035000,0.635000> rotate<0,0.000000,0> translate<52.705000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,81.280000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<55.880000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.515000,-1.535000,87.630000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.895000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<55.880000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<57.150000,-1.535000,31.750000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<55.880000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,0.000000,5.715000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.085000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<55.245000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.515000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<56.515000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<55.245000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,10.160000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.705000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,0.000000,25.400000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,-90.000000,0> translate<59.055000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,2.540000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<58.420000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,15.240000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<58.420000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,22.860000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,0.000000,22.860000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,40.640000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,41.910000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,44.450000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,46.990000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,48.260000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,49.530000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,52.070000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,54.610000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,55.880000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,57.150000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,58.420000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,59.690000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,62.230000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,64.770000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,66.040000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,69.850000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,72.390000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<60.325000,-1.535000,81.280000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,0.000000,0> translate<55.880000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.785000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.785000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,-1.535000,88.900000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.785000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,25.400000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.055000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,11.430000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.230000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,13.970000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,25.400000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,29.210000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,0.000000,29.210000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<57.150000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<62.230000,-1.535000,31.750000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,0.000000,0> translate<57.150000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,52.070000>}
box{<0,0,-0.304800><3.419580,0.035000,0.304800> rotate<0,-21.799971,0> translate<59.055000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,72.390000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<59.690000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,92.710000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.165000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.325000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,88.900000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.325000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,88.900000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.865000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,95.250000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.895000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-1.535000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,5.715000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.785000,-1.535000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,0.000000,12.700000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<63.500000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,19.050000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.705000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,-1.535000,3.810000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,-1.535000,6.350000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<63.500000,-1.535000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,17.780000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,22.860000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.770000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,2.540000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,5.080000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.135000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<62.230000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<65.405000,-1.535000,29.845000>}
box{<0,0,-0.508000><3.702654,0.035000,0.508000> rotate<0,30.961713,0> translate<62.230000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,97.790000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.865000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,86.360000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,96.520000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.230000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.675000,-1.535000,3.810000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<65.405000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.675000,-1.535000,86.995000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<66.040000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,41.910000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,44.450000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,46.990000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,49.530000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,52.070000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,57.150000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,62.230000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,64.770000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,69.850000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,72.390000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,10.160000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,12.700000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,15.240000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,22.860000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,25.400000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,27.940000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,54.610000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,72.390000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<67.310000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,11.430000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.580000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,17.780000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,24.130000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<65.405000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<71.755000,-1.535000,29.845000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,0.000000,0> translate<65.405000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,-1.535000,35.560000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.355000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,8.890000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.580000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,20.320000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<72.390000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,25.400000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,-90.000000,0> translate<72.390000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<71.755000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<72.390000,-1.535000,29.210000>}
box{<0,0,-0.508000><0.898026,0.035000,0.508000> rotate<0,44.997030,0> translate<71.755000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,34.925000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<71.755000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<72.390000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<72.390000,-1.535000,73.660000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,-90.000000,0> translate<72.390000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<72.390000,-1.535000,76.200000>}
box{<0,0,-0.635000><16.510000,0.035000,0.635000> rotate<0,0.000000,0> translate<55.880000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,36.830000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,91.440000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.325000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,2.540000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.660000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,7.620000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,90.805000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<73.025000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,6.350000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.135000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,15.240000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<75.565000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,33.020000>}
box{<0,0,-0.304800><4.579050,0.035000,0.304800> rotate<0,56.306216,0> translate<73.025000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,53.340000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,0.000000,53.340000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<75.565000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,93.345000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,93.345000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,36.830000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<75.565000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,41.910000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,44.450000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,46.990000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,48.260000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,49.530000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,52.070000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,54.610000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,55.880000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,57.150000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,58.420000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,59.690000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,62.230000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,64.770000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,66.040000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,69.850000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,72.390000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<72.390000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.835000,-1.535000,76.200000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,0.000000,0> translate<72.390000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.200000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.835000,-1.535000,81.915000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,0.000000,0> translate<76.200000,-1.535000,81.915000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.835000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.835000,-1.535000,81.915000>}
box{<0,0,-0.635000><5.715000,0.035000,0.635000> rotate<0,90.000000,0> translate<76.835000,-1.535000,81.915000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.835000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.835000,-1.535000,84.455000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<76.835000,-1.535000,84.455000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.675000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,86.995000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.675000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,89.535000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,89.535000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,92.075000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<75.565000,-1.535000,93.345000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,0.000000,12.700000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,-90.000000,0> translate<78.105000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,40.640000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,86.995000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,72.390000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<76.200000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.375000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<78.105000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.375000,-1.535000,85.725000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<78.105000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.375000,-1.535000,89.535000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,89.535000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,0.000000,7.620000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<80.010000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,0.000000,78.105000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.705000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,90.805000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,90.805000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.660000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,90.805000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,92.075000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<80.010000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.375000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,86.995000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<79.375000,-1.535000,89.535000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<83.820000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,0.000000,20.320000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,-90.000000,0> translate<83.820000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,33.020000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.375000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,41.910000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<79.375000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,44.450000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,46.990000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,49.530000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,52.070000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,57.150000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,62.230000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,64.770000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,69.850000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,72.390000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.455000,-1.535000,86.995000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.915000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,92.075000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.455000,-1.535000,92.075000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,92.075000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<83.820000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<72.390000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<85.090000,-1.535000,29.210000>}
box{<0,0,-0.635000><12.700000,0.035000,0.635000> rotate<0,0.000000,0> translate<72.390000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,0.000000,80.010000>}
box{<0,0,-0.304800><36.830000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,54.610000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,72.390000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<83.820000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.455000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,86.995000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<84.455000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.455000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,89.535000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<84.455000,-1.535000,89.535000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,81.915000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<85.090000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,12.700000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.105000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,15.240000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,22.860000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,25.400000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,88.265000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<86.360000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,73.660000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,-90.000000,0> translate<88.900000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<76.835000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,76.200000>}
box{<0,0,-0.635000><12.065000,0.035000,0.635000> rotate<0,0.000000,0> translate<76.835000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,78.740000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<88.900000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.375000,-1.535000,85.725000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,85.725000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<79.375000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,88.265000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,88.265000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,88.265000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,92.710000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<86.360000,-1.535000,89.535000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,10.160000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<90.170000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,20.320000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,26.670000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,29.210000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,25.400000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<90.170000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,27.940000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,0.000000,53.340000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<91.440000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,85.725000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,85.725000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,88.265000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,88.265000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,88.265000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,5.080000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,0.000000,0> translate<65.405000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,12.700000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<92.710000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,15.240000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<90.170000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<90.170000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<90.170000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<91.440000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<90.170000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<92.710000,-1.535000,30.480000>}
box{<0,0,-0.508000><2.839806,0.035000,0.508000> rotate<0,-26.563298,0> translate<90.170000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<91.440000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,40.640000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,41.910000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,44.450000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,46.990000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,48.260000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,49.530000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,52.070000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,54.610000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,55.880000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,57.150000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,58.420000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,59.690000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,62.230000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,64.770000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,66.040000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,67.310000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,69.850000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,72.390000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,12.700000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,15.240000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<91.440000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<92.710000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<95.250000,-1.535000,30.480000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<92.710000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,0.000000,40.005000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,64.770000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,72.390000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,-26.563298,0> translate<92.710000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.675000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,3.810000>}
box{<0,0,-0.304800><29.845000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.675000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.155000,-1.535000,92.710000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<89.535000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,5.080000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<96.520000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.170000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,13.970000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<90.170000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,0.000000,22.860000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,2.540000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.660000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,7.620000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,10.160000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,15.240000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<98.425000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,17.780000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,20.320000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,6.350000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<99.060000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<97.790000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,41.910000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,44.450000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,46.990000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,49.530000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,52.070000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,57.150000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,62.230000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,64.770000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,69.850000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,72.390000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,96.520000>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<99.695000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,81.915000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.995000,-1.535000,81.915000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,85.090000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.965000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,5.080000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<99.060000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,7.620000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<99.060000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,0.000000,13.335000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,-90.000000,0> translate<101.600000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,19.050000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,95.250000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<100.330000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,12.700000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<101.600000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,26.670000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,26.035000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<102.235000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,0.000000,26.035000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,49.530000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,54.610000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<100.330000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,10.160000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<102.870000,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.965000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,22.860000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<104.140000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<88.900000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<104.140000,-1.535000,76.200000>}
box{<0,0,-0.635000><15.240000,0.035000,0.635000> rotate<0,0.000000,0> translate<88.900000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<104.140000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<104.140000,-1.535000,81.280000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<104.140000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,25.400000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<99.695000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.410000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.410000,-1.535000,73.660000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,-90.000000,0> translate<105.410000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<104.140000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.410000,-1.535000,76.200000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,0.000000,0> translate<104.140000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,39.370000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<105.410000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,97.790000>}
box{<0,0,-0.304800><41.275000,0.035000,0.304800> rotate<0,0.000000,0> translate<65.405000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,95.250000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<101.600000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,10.160000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<103.505000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,12.700000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.235000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,15.240000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<99.695000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,22.860000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.775000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,27.940000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,0.000000,53.340000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,90.000000,0> translate<107.950000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,0.000000,78.105000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,90.000000,0> translate<107.950000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,83.820000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<107.950000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,34.290000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<107.950000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,0.000000,40.640000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<109.220000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,86.360000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<109.220000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,95.250000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<106.680000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.855000,-1.535000,92.710000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<107.315000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,44.450000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.125000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.125000,0.000000,53.340000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,-90.000000,0> translate<111.125000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<105.410000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<111.125000,-1.535000,73.660000>}
box{<0,0,-0.635000><5.715000,0.035000,0.635000> rotate<0,0.000000,0> translate<105.410000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,11.430000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,17.780000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.950000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,17.780000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<111.760000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.950000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,43.180000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<110.490000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.950000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,7.620000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<101.600000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<111.760000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,19.050000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<113.030000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<111.760000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<95.250000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<114.300000,-1.535000,30.480000>}
box{<0,0,-0.635000><19.050000,0.035000,0.635000> rotate<0,0.000000,0> translate<95.250000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,0.000000,30.480000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,-90.000000,0> translate<114.300000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<111.125000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<114.300000,-1.535000,53.340000>}
box{<0,0,-0.635000><3.175000,0.035000,0.635000> rotate<0,0.000000,0> translate<111.125000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<114.300000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<111.125000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<114.300000,-1.535000,73.660000>}
box{<0,0,-0.635000><3.175000,0.035000,0.635000> rotate<0,0.000000,0> translate<111.125000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<111.760000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,81.280000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<114.300000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,85.090000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.965000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<111.760000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,0.000000,86.360000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,90.000000,0> translate<114.300000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,38.100000>}
box{<0,0,-0.304800><70.485000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.085000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,54.610000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,57.150000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,59.690000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,62.230000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,66.040000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<114.300000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,0.000000,77.470000>}
box{<0,0,-0.304800><39.370000,0.035000,0.304800> rotate<0,90.000000,0> translate<115.570000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,87.630000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.220000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,87.630000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<115.570000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,49.530000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<114.300000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<116.840000,-1.535000,53.340000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<114.300000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<115.570000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<115.570000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,63.500000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<115.570000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,0.000000,74.930000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,90.000000,0> translate<116.840000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<114.300000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<116.840000,-1.535000,76.200000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,-44.997030,0> translate<114.300000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,0.000000,81.280000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<116.840000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<116.840000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,0.000000,97.790000>}
box{<0,0,-0.304800><78.105000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.735000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<114.300000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<118.110000,-1.535000,30.480000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,0.000000,0> translate<114.300000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,39.370000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<106.680000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,0.000000,43.180000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<118.110000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,57.150000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<115.570000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,96.520000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<116.840000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<116.840000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<119.380000,-1.535000,55.880000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,-44.997030,0> translate<116.840000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,66.040000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<115.570000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<116.840000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<119.380000,-1.535000,76.200000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<116.840000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<119.380000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<119.380000,-1.535000,78.740000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<119.380000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,96.520000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,0.000000,8.890000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<120.015000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,52.070000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,57.150000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,82.550000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,90.000000,0> translate<121.920000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,30.480000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<121.920000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<119.380000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,83.820000>}
box{<0,0,-0.304800><30.480000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.190000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,88.900000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<119.380000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,88.900000>}
box{<0,0,-0.304800><33.020000,0.035000,0.304800> rotate<0,90.000000,0> translate<124.460000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,30.480000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<125.730000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<124.460000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,50.800000>}
box{<0,0,-0.304800><22.225000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,48.260000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,95.250000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.220000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.445000,-1.535000,55.880000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,46.990000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<129.540000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<129.540000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,66.040000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<129.540000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<129.540000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<129.540000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,73.660000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<129.540000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,96.520000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<130.810000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,20.320000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.350000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,34.290000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,0.000000,0> translate<108.585000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,45.720000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<111.760000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<132.080000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,0.000000,53.340000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<133.350000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,53.975000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<133.350000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,63.500000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,66.040000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,21.590000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,-90.000000,0> translate<134.620000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,35.560000>}
box{<0,0,-0.304800><41.910000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.445000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,59.055000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<131.445000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,52.705000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<130.810000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,53.975000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<135.255000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,57.785000>}
box{<0,0,-0.304800><10.337051,0.035000,0.304800> rotate<0,-42.507642,0> translate<127.635000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,17.780000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<133.350000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,27.940000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.890000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,36.830000>}
box{<0,0,-0.304800><59.690000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.200000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,41.910000>}
box{<0,0,-0.304800><33.020000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,46.355000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<135.890000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,56.515000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<133.350000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,78.740000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,81.280000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,83.820000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,86.360000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,88.900000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,49.530000>}
box{<0,0,-0.304800><4.959509,0.035000,0.304800> rotate<0,-50.191116,0> translate<133.350000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,55.245000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.255000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,59.055000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,59.055000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<134.620000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<135.890000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,43.180000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,44.450000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.030000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,0.000000,53.340000>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,90.000000,0> translate<137.160000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,57.785000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,57.785000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.255000,-1.535000,57.785000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,90.170000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.890000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.890000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,56.515000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,59.055000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,60.325000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<136.525000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,64.135000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<137.795000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,74.295000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<137.795000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,40.640000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.220000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,0.000000,51.435000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,90.000000,0> translate<138.430000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,55.245000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,55.245000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<136.525000,-1.535000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.890000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.855000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,92.710000>}
box{<0,0,-0.304800><28.575000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.855000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,50.800000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<138.430000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,57.785000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<137.160000,-1.535000,57.785000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<138.430000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<138.430000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<137.160000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,46.990000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<137.160000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<137.795000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,0.000000,60.960000>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.700000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,70.485000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.700000,-1.535000,70.485000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.890000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,85.090000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.890000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,87.630000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.890000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,91.440000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<138.430000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,55.245000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,57.150000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<138.430000,-1.535000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,33.020000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<140.970000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,38.100000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<115.570000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,70.485000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,71.755000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<139.700000,-1.535000,70.485000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,65.405000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<139.700000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,69.215000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<141.605000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,19.050000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,26.670000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,29.210000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<140.970000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,48.260000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.795000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.065000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,53.340000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,58.420000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<138.430000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,91.440000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,96.520000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.080000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,66.675000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<141.605000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,71.755000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.970000,-1.535000,71.755000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,41.910000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.065000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,69.215000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.145000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,71.120000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<143.510000,-1.535000,71.755000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,22.860000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,24.130000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.780000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,31.750000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,46.990000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,49.530000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<136.525000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,55.880000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<144.780000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,65.405000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<141.605000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,65.405000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<144.780000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,90.170000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,93.980000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,93.980000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<144.780000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<144.145000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,17.780000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,57.150000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.335000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,59.690000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<144.780000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,62.230000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<146.050000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,66.675000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.875000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,82.550000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,85.090000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,87.630000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,49.530000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,-53.126596,0> translate<144.780000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,69.215000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.685000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<146.050000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<144.780000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<144.780000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,46.990000>}
box{<0,0,-0.304800><5.990578,0.035000,0.304800> rotate<0,-57.990789,0> translate<144.145000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<147.320000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,55.880000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<146.050000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<146.050000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,67.945000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<146.685000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,67.945000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<147.320000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,76.200000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.795000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<142.240000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<147.320000,-1.535000,76.200000>}
box{<0,0,-0.406400><7.184205,0.035000,0.406400> rotate<0,44.997030,0> translate<142.240000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<146.050000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,86.360000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<146.050000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<146.050000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,90.170000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<147.320000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,62.230000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<147.320000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<148.590000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<148.590000,-1.535000,73.660000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<148.590000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,0.000000,76.200000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<119.380000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<147.320000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<148.590000,-1.535000,76.200000>}
box{<0,0,-0.406400><1.270000,0.035000,0.406400> rotate<0,0.000000,0> translate<147.320000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,91.440000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<147.320000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<149.860000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<149.860000,-1.535000,31.750000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,-90.000000,0> translate<149.860000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<148.590000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<149.860000,-1.535000,35.560000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,0.000000,0> translate<148.590000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,58.420000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<145.415000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,81.280000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,91.440000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<148.590000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<149.860000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<150.495000,-1.535000,63.500000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,0.000000,0> translate<149.860000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<150.495000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<150.495000,-1.535000,63.500000>}
box{<0,0,-0.635000><8.255000,0.035000,0.635000> rotate<0,-90.000000,0> translate<150.495000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<148.590000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<150.495000,-1.535000,71.755000>}
box{<0,0,-0.635000><2.694077,0.035000,0.635000> rotate<0,44.997030,0> translate<148.590000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,62.230000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.955000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<152.400000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,22.860000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<149.860000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<152.400000,-1.535000,35.560000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<149.860000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,0.000000,35.560000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,-90.000000,0> translate<152.400000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<152.400000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,49.530000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.685000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,53.975000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<151.765000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,59.690000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<152.400000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<149.860000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<152.400000,-1.535000,63.500000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,0.000000,0> translate<149.860000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,83.820000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,90.000000,0> translate<152.400000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,93.980000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,52.705000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<151.765000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,60.325000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<151.765000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,60.325000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<151.130000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,86.360000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,40.640000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<152.400000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,63.500000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,90.000000,0> translate<154.940000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,91.440000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<152.400000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,91.440000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,90.000000,0> translate<154.940000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,6.350000>}
box{<0,0,-0.304800><55.880000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,64.135000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<153.670000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,-1.535000,64.135000>}
box{<0,0,-0.304800><57.785000,0.035000,0.304800> rotate<0,90.000000,0> translate<156.210000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.845000,0.000000,78.105000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<157.480000,-1.535000,5.080000>}
box{<0,0,-0.304800><55.880000,0.035000,0.304800> rotate<0,0.000000,0> translate<101.600000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<157.480000,-1.535000,64.770000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<154.940000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<157.480000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<157.480000,-1.535000,64.770000>}
box{<0,0,-0.304800><59.690000,0.035000,0.304800> rotate<0,90.000000,0> translate<157.480000,-1.535000,64.770000> }
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
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.020000,-1.535000,0.000000>}
box{<0,0,-0.152400><160.020000,0.035000,0.152400> rotate<0,0.000000,0> translate<0.000000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,100.330000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,0.000000>}
box{<0,0,-0.152400><100.330000,0.035000,0.152400> rotate<0,-90.000000,0> translate<0.000000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,100.330000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.020000,-1.535000,100.330000>}
box{<0,0,-0.152400><160.020000,0.035000,0.152400> rotate<0,0.000000,0> translate<0.000000,-1.535000,100.330000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.020000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.020000,-1.535000,100.330000>}
box{<0,0,-0.152400><100.330000,0.035000,0.152400> rotate<0,90.000000,0> translate<160.020000,-1.535000,100.330000> }
texture{col_pol}
}
#end
union{
cylinder{<45.085000,0.038000,77.470000><45.085000,-1.538000,77.470000>0.406400}
cylinder{<40.005000,0.038000,77.470000><40.005000,-1.538000,77.470000>0.406400}
cylinder{<148.590000,0.038000,35.560000><148.590000,-1.538000,35.560000>0.406400}
cylinder{<143.510000,0.038000,35.560000><143.510000,-1.538000,35.560000>0.406400}
cylinder{<88.900000,0.038000,78.740000><88.900000,-1.538000,78.740000>0.406400}
cylinder{<93.980000,0.038000,78.740000><93.980000,-1.538000,78.740000>0.406400}
cylinder{<148.590000,0.038000,73.660000><148.590000,-1.538000,73.660000>0.406400}
cylinder{<143.510000,0.038000,73.660000><143.510000,-1.538000,73.660000>0.406400}
cylinder{<118.110000,0.038000,30.480000><118.110000,-1.538000,30.480000>0.406400}
cylinder{<118.110000,0.038000,25.400000><118.110000,-1.538000,25.400000>0.406400}
cylinder{<62.230000,0.038000,31.750000><62.230000,-1.538000,31.750000>0.406400}
cylinder{<67.310000,0.038000,31.750000><67.310000,-1.538000,31.750000>0.406400}
cylinder{<72.390000,0.038000,93.345000><72.390000,-1.538000,93.345000>0.406400}
cylinder{<67.310000,0.038000,93.345000><67.310000,-1.538000,93.345000>0.406400}
cylinder{<72.390000,0.038000,89.535000><72.390000,-1.538000,89.535000>0.406400}
cylinder{<67.310000,0.038000,89.535000><67.310000,-1.538000,89.535000>0.406400}
cylinder{<88.900000,0.038000,85.725000><88.900000,-1.538000,85.725000>0.406400}
cylinder{<88.900000,0.038000,88.265000><88.900000,-1.538000,88.265000>0.406400}
cylinder{<127.000000,0.038000,55.880000><127.000000,-1.538000,55.880000>0.406400}
cylinder{<127.000000,0.038000,58.420000><127.000000,-1.538000,58.420000>0.406400}
cylinder{<127.000000,0.038000,60.960000><127.000000,-1.538000,60.960000>0.406400}
cylinder{<127.000000,0.038000,63.500000><127.000000,-1.538000,63.500000>0.406400}
cylinder{<127.000000,0.038000,66.040000><127.000000,-1.538000,66.040000>0.406400}
cylinder{<127.000000,0.038000,68.580000><127.000000,-1.538000,68.580000>0.406400}
cylinder{<127.000000,0.038000,71.120000><127.000000,-1.538000,71.120000>0.406400}
cylinder{<127.000000,0.038000,73.660000><127.000000,-1.538000,73.660000>0.406400}
cylinder{<119.380000,0.038000,73.660000><119.380000,-1.538000,73.660000>0.406400}
cylinder{<119.380000,0.038000,71.120000><119.380000,-1.538000,71.120000>0.406400}
cylinder{<119.380000,0.038000,68.580000><119.380000,-1.538000,68.580000>0.406400}
cylinder{<119.380000,0.038000,66.040000><119.380000,-1.538000,66.040000>0.406400}
cylinder{<119.380000,0.038000,63.500000><119.380000,-1.538000,63.500000>0.406400}
cylinder{<119.380000,0.038000,60.960000><119.380000,-1.538000,60.960000>0.406400}
cylinder{<119.380000,0.038000,58.420000><119.380000,-1.538000,58.420000>0.406400}
cylinder{<119.380000,0.038000,55.880000><119.380000,-1.538000,55.880000>0.406400}
cylinder{<149.860000,0.038000,81.280000><149.860000,-1.538000,81.280000>0.406400}
cylinder{<149.860000,0.038000,83.820000><149.860000,-1.538000,83.820000>0.406400}
cylinder{<149.860000,0.038000,86.360000><149.860000,-1.538000,86.360000>0.406400}
cylinder{<149.860000,0.038000,88.900000><149.860000,-1.538000,88.900000>0.406400}
cylinder{<149.860000,0.038000,91.440000><149.860000,-1.538000,91.440000>0.406400}
cylinder{<149.860000,0.038000,93.980000><149.860000,-1.538000,93.980000>0.406400}
cylinder{<149.860000,0.038000,96.520000><149.860000,-1.538000,96.520000>0.406400}
cylinder{<142.240000,0.038000,96.520000><142.240000,-1.538000,96.520000>0.406400}
cylinder{<142.240000,0.038000,93.980000><142.240000,-1.538000,93.980000>0.406400}
cylinder{<142.240000,0.038000,91.440000><142.240000,-1.538000,91.440000>0.406400}
cylinder{<142.240000,0.038000,88.900000><142.240000,-1.538000,88.900000>0.406400}
cylinder{<142.240000,0.038000,86.360000><142.240000,-1.538000,86.360000>0.406400}
cylinder{<142.240000,0.038000,83.820000><142.240000,-1.538000,83.820000>0.406400}
cylinder{<142.240000,0.038000,81.280000><142.240000,-1.538000,81.280000>0.406400}
cylinder{<142.240000,0.038000,31.750000><142.240000,-1.538000,31.750000>0.406400}
cylinder{<142.240000,0.038000,29.210000><142.240000,-1.538000,29.210000>0.406400}
cylinder{<142.240000,0.038000,26.670000><142.240000,-1.538000,26.670000>0.406400}
cylinder{<142.240000,0.038000,24.130000><142.240000,-1.538000,24.130000>0.406400}
cylinder{<142.240000,0.038000,21.590000><142.240000,-1.538000,21.590000>0.406400}
cylinder{<142.240000,0.038000,19.050000><142.240000,-1.538000,19.050000>0.406400}
cylinder{<142.240000,0.038000,16.510000><142.240000,-1.538000,16.510000>0.406400}
cylinder{<149.860000,0.038000,16.510000><149.860000,-1.538000,16.510000>0.406400}
cylinder{<149.860000,0.038000,19.050000><149.860000,-1.538000,19.050000>0.406400}
cylinder{<149.860000,0.038000,21.590000><149.860000,-1.538000,21.590000>0.406400}
cylinder{<149.860000,0.038000,24.130000><149.860000,-1.538000,24.130000>0.406400}
cylinder{<149.860000,0.038000,26.670000><149.860000,-1.538000,26.670000>0.406400}
cylinder{<149.860000,0.038000,29.210000><149.860000,-1.538000,29.210000>0.406400}
cylinder{<149.860000,0.038000,31.750000><149.860000,-1.538000,31.750000>0.406400}
cylinder{<60.325000,0.038000,81.280000><60.325000,-1.538000,81.280000>0.406400}
cylinder{<60.325000,0.038000,83.820000><60.325000,-1.538000,83.820000>0.406400}
cylinder{<60.325000,0.038000,86.360000><60.325000,-1.538000,86.360000>0.406400}
cylinder{<60.325000,0.038000,88.900000><60.325000,-1.538000,88.900000>0.406400}
cylinder{<60.325000,0.038000,91.440000><60.325000,-1.538000,91.440000>0.406400}
cylinder{<60.325000,0.038000,93.980000><60.325000,-1.538000,93.980000>0.406400}
cylinder{<60.325000,0.038000,96.520000><60.325000,-1.538000,96.520000>0.406400}
cylinder{<52.705000,0.038000,96.520000><52.705000,-1.538000,96.520000>0.406400}
cylinder{<52.705000,0.038000,93.980000><52.705000,-1.538000,93.980000>0.406400}
cylinder{<52.705000,0.038000,91.440000><52.705000,-1.538000,91.440000>0.406400}
cylinder{<52.705000,0.038000,88.900000><52.705000,-1.538000,88.900000>0.406400}
cylinder{<52.705000,0.038000,86.360000><52.705000,-1.538000,86.360000>0.406400}
cylinder{<52.705000,0.038000,83.820000><52.705000,-1.538000,83.820000>0.406400}
cylinder{<52.705000,0.038000,81.280000><52.705000,-1.538000,81.280000>0.406400}
cylinder{<84.455000,0.038000,84.455000><84.455000,-1.538000,84.455000>0.406400}
cylinder{<84.455000,0.038000,86.995000><84.455000,-1.538000,86.995000>0.406400}
cylinder{<84.455000,0.038000,89.535000><84.455000,-1.538000,89.535000>0.406400}
cylinder{<84.455000,0.038000,92.075000><84.455000,-1.538000,92.075000>0.406400}
cylinder{<76.835000,0.038000,92.075000><76.835000,-1.538000,92.075000>0.406400}
cylinder{<76.835000,0.038000,89.535000><76.835000,-1.538000,89.535000>0.406400}
cylinder{<76.835000,0.038000,86.995000><76.835000,-1.538000,86.995000>0.406400}
cylinder{<76.835000,0.038000,84.455000><76.835000,-1.538000,84.455000>0.406400}
cylinder{<48.260000,0.038000,73.660000><48.260000,-1.538000,73.660000>0.406400}
cylinder{<48.260000,0.038000,71.120000><48.260000,-1.538000,71.120000>0.406400}
cylinder{<48.260000,0.038000,68.580000><48.260000,-1.538000,68.580000>0.406400}
cylinder{<48.260000,0.038000,66.040000><48.260000,-1.538000,66.040000>0.406400}
cylinder{<48.260000,0.038000,63.500000><48.260000,-1.538000,63.500000>0.406400}
cylinder{<48.260000,0.038000,60.960000><48.260000,-1.538000,60.960000>0.406400}
cylinder{<48.260000,0.038000,58.420000><48.260000,-1.538000,58.420000>0.406400}
cylinder{<48.260000,0.038000,55.880000><48.260000,-1.538000,55.880000>0.406400}
cylinder{<48.260000,0.038000,53.340000><48.260000,-1.538000,53.340000>0.406400}
cylinder{<48.260000,0.038000,50.800000><48.260000,-1.538000,50.800000>0.406400}
cylinder{<48.260000,0.038000,48.260000><48.260000,-1.538000,48.260000>0.406400}
cylinder{<48.260000,0.038000,45.720000><48.260000,-1.538000,45.720000>0.406400}
cylinder{<48.260000,0.038000,43.180000><48.260000,-1.538000,43.180000>0.406400}
cylinder{<48.260000,0.038000,40.640000><48.260000,-1.538000,40.640000>0.406400}
cylinder{<55.880000,0.038000,40.640000><55.880000,-1.538000,40.640000>0.406400}
cylinder{<55.880000,0.038000,43.180000><55.880000,-1.538000,43.180000>0.406400}
cylinder{<55.880000,0.038000,45.720000><55.880000,-1.538000,45.720000>0.406400}
cylinder{<55.880000,0.038000,48.260000><55.880000,-1.538000,48.260000>0.406400}
cylinder{<55.880000,0.038000,50.800000><55.880000,-1.538000,50.800000>0.406400}
cylinder{<55.880000,0.038000,53.340000><55.880000,-1.538000,53.340000>0.406400}
cylinder{<55.880000,0.038000,55.880000><55.880000,-1.538000,55.880000>0.406400}
cylinder{<55.880000,0.038000,58.420000><55.880000,-1.538000,58.420000>0.406400}
cylinder{<55.880000,0.038000,60.960000><55.880000,-1.538000,60.960000>0.406400}
cylinder{<55.880000,0.038000,63.500000><55.880000,-1.538000,63.500000>0.406400}
cylinder{<55.880000,0.038000,66.040000><55.880000,-1.538000,66.040000>0.406400}
cylinder{<55.880000,0.038000,68.580000><55.880000,-1.538000,68.580000>0.406400}
cylinder{<55.880000,0.038000,71.120000><55.880000,-1.538000,71.120000>0.406400}
cylinder{<55.880000,0.038000,73.660000><55.880000,-1.538000,73.660000>0.406400}
cylinder{<64.770000,0.038000,73.660000><64.770000,-1.538000,73.660000>0.406400}
cylinder{<64.770000,0.038000,71.120000><64.770000,-1.538000,71.120000>0.406400}
cylinder{<64.770000,0.038000,68.580000><64.770000,-1.538000,68.580000>0.406400}
cylinder{<64.770000,0.038000,66.040000><64.770000,-1.538000,66.040000>0.406400}
cylinder{<64.770000,0.038000,63.500000><64.770000,-1.538000,63.500000>0.406400}
cylinder{<64.770000,0.038000,60.960000><64.770000,-1.538000,60.960000>0.406400}
cylinder{<64.770000,0.038000,58.420000><64.770000,-1.538000,58.420000>0.406400}
cylinder{<64.770000,0.038000,55.880000><64.770000,-1.538000,55.880000>0.406400}
cylinder{<64.770000,0.038000,53.340000><64.770000,-1.538000,53.340000>0.406400}
cylinder{<64.770000,0.038000,50.800000><64.770000,-1.538000,50.800000>0.406400}
cylinder{<64.770000,0.038000,48.260000><64.770000,-1.538000,48.260000>0.406400}
cylinder{<64.770000,0.038000,45.720000><64.770000,-1.538000,45.720000>0.406400}
cylinder{<64.770000,0.038000,43.180000><64.770000,-1.538000,43.180000>0.406400}
cylinder{<64.770000,0.038000,40.640000><64.770000,-1.538000,40.640000>0.406400}
cylinder{<72.390000,0.038000,40.640000><72.390000,-1.538000,40.640000>0.406400}
cylinder{<72.390000,0.038000,43.180000><72.390000,-1.538000,43.180000>0.406400}
cylinder{<72.390000,0.038000,45.720000><72.390000,-1.538000,45.720000>0.406400}
cylinder{<72.390000,0.038000,48.260000><72.390000,-1.538000,48.260000>0.406400}
cylinder{<72.390000,0.038000,50.800000><72.390000,-1.538000,50.800000>0.406400}
cylinder{<72.390000,0.038000,53.340000><72.390000,-1.538000,53.340000>0.406400}
cylinder{<72.390000,0.038000,55.880000><72.390000,-1.538000,55.880000>0.406400}
cylinder{<72.390000,0.038000,58.420000><72.390000,-1.538000,58.420000>0.406400}
cylinder{<72.390000,0.038000,60.960000><72.390000,-1.538000,60.960000>0.406400}
cylinder{<72.390000,0.038000,63.500000><72.390000,-1.538000,63.500000>0.406400}
cylinder{<72.390000,0.038000,66.040000><72.390000,-1.538000,66.040000>0.406400}
cylinder{<72.390000,0.038000,68.580000><72.390000,-1.538000,68.580000>0.406400}
cylinder{<72.390000,0.038000,71.120000><72.390000,-1.538000,71.120000>0.406400}
cylinder{<72.390000,0.038000,73.660000><72.390000,-1.538000,73.660000>0.406400}
cylinder{<87.630000,0.038000,30.480000><87.630000,-1.538000,30.480000>0.406400}
cylinder{<87.630000,0.038000,27.940000><87.630000,-1.538000,27.940000>0.406400}
cylinder{<87.630000,0.038000,25.400000><87.630000,-1.538000,25.400000>0.406400}
cylinder{<87.630000,0.038000,22.860000><87.630000,-1.538000,22.860000>0.406400}
cylinder{<87.630000,0.038000,20.320000><87.630000,-1.538000,20.320000>0.406400}
cylinder{<87.630000,0.038000,17.780000><87.630000,-1.538000,17.780000>0.406400}
cylinder{<87.630000,0.038000,15.240000><87.630000,-1.538000,15.240000>0.406400}
cylinder{<87.630000,0.038000,12.700000><87.630000,-1.538000,12.700000>0.406400}
cylinder{<87.630000,0.038000,10.160000><87.630000,-1.538000,10.160000>0.406400}
cylinder{<87.630000,0.038000,7.620000><87.630000,-1.538000,7.620000>0.406400}
cylinder{<95.250000,0.038000,7.620000><95.250000,-1.538000,7.620000>0.406400}
cylinder{<95.250000,0.038000,10.160000><95.250000,-1.538000,10.160000>0.406400}
cylinder{<95.250000,0.038000,12.700000><95.250000,-1.538000,12.700000>0.406400}
cylinder{<95.250000,0.038000,15.240000><95.250000,-1.538000,15.240000>0.406400}
cylinder{<95.250000,0.038000,17.780000><95.250000,-1.538000,17.780000>0.406400}
cylinder{<95.250000,0.038000,20.320000><95.250000,-1.538000,20.320000>0.406400}
cylinder{<95.250000,0.038000,22.860000><95.250000,-1.538000,22.860000>0.406400}
cylinder{<95.250000,0.038000,25.400000><95.250000,-1.538000,25.400000>0.406400}
cylinder{<95.250000,0.038000,27.940000><95.250000,-1.538000,27.940000>0.406400}
cylinder{<95.250000,0.038000,30.480000><95.250000,-1.538000,30.480000>0.406400}
cylinder{<127.000000,0.038000,78.740000><127.000000,-1.538000,78.740000>0.406400}
cylinder{<127.000000,0.038000,81.280000><127.000000,-1.538000,81.280000>0.406400}
cylinder{<127.000000,0.038000,83.820000><127.000000,-1.538000,83.820000>0.406400}
cylinder{<127.000000,0.038000,86.360000><127.000000,-1.538000,86.360000>0.406400}
cylinder{<127.000000,0.038000,88.900000><127.000000,-1.538000,88.900000>0.406400}
cylinder{<127.000000,0.038000,91.440000><127.000000,-1.538000,91.440000>0.406400}
cylinder{<127.000000,0.038000,93.980000><127.000000,-1.538000,93.980000>0.406400}
cylinder{<127.000000,0.038000,96.520000><127.000000,-1.538000,96.520000>0.406400}
cylinder{<119.380000,0.038000,96.520000><119.380000,-1.538000,96.520000>0.406400}
cylinder{<119.380000,0.038000,93.980000><119.380000,-1.538000,93.980000>0.406400}
cylinder{<119.380000,0.038000,91.440000><119.380000,-1.538000,91.440000>0.406400}
cylinder{<119.380000,0.038000,88.900000><119.380000,-1.538000,88.900000>0.406400}
cylinder{<119.380000,0.038000,86.360000><119.380000,-1.538000,86.360000>0.406400}
cylinder{<119.380000,0.038000,83.820000><119.380000,-1.538000,83.820000>0.406400}
cylinder{<119.380000,0.038000,81.280000><119.380000,-1.538000,81.280000>0.406400}
cylinder{<119.380000,0.038000,78.740000><119.380000,-1.538000,78.740000>0.406400}
cylinder{<48.260000,0.038000,30.480000><48.260000,-1.538000,30.480000>0.406400}
cylinder{<48.260000,0.038000,27.940000><48.260000,-1.538000,27.940000>0.406400}
cylinder{<48.260000,0.038000,25.400000><48.260000,-1.538000,25.400000>0.406400}
cylinder{<48.260000,0.038000,22.860000><48.260000,-1.538000,22.860000>0.406400}
cylinder{<48.260000,0.038000,20.320000><48.260000,-1.538000,20.320000>0.406400}
cylinder{<48.260000,0.038000,17.780000><48.260000,-1.538000,17.780000>0.406400}
cylinder{<48.260000,0.038000,15.240000><48.260000,-1.538000,15.240000>0.406400}
cylinder{<48.260000,0.038000,12.700000><48.260000,-1.538000,12.700000>0.406400}
cylinder{<48.260000,0.038000,10.160000><48.260000,-1.538000,10.160000>0.406400}
cylinder{<48.260000,0.038000,7.620000><48.260000,-1.538000,7.620000>0.406400}
cylinder{<55.880000,0.038000,7.620000><55.880000,-1.538000,7.620000>0.406400}
cylinder{<55.880000,0.038000,10.160000><55.880000,-1.538000,10.160000>0.406400}
cylinder{<55.880000,0.038000,12.700000><55.880000,-1.538000,12.700000>0.406400}
cylinder{<55.880000,0.038000,15.240000><55.880000,-1.538000,15.240000>0.406400}
cylinder{<55.880000,0.038000,17.780000><55.880000,-1.538000,17.780000>0.406400}
cylinder{<55.880000,0.038000,20.320000><55.880000,-1.538000,20.320000>0.406400}
cylinder{<55.880000,0.038000,22.860000><55.880000,-1.538000,22.860000>0.406400}
cylinder{<55.880000,0.038000,25.400000><55.880000,-1.538000,25.400000>0.406400}
cylinder{<55.880000,0.038000,27.940000><55.880000,-1.538000,27.940000>0.406400}
cylinder{<55.880000,0.038000,30.480000><55.880000,-1.538000,30.480000>0.406400}
cylinder{<81.280000,0.038000,73.660000><81.280000,-1.538000,73.660000>0.406400}
cylinder{<81.280000,0.038000,71.120000><81.280000,-1.538000,71.120000>0.406400}
cylinder{<81.280000,0.038000,68.580000><81.280000,-1.538000,68.580000>0.406400}
cylinder{<81.280000,0.038000,66.040000><81.280000,-1.538000,66.040000>0.406400}
cylinder{<81.280000,0.038000,63.500000><81.280000,-1.538000,63.500000>0.406400}
cylinder{<81.280000,0.038000,60.960000><81.280000,-1.538000,60.960000>0.406400}
cylinder{<81.280000,0.038000,58.420000><81.280000,-1.538000,58.420000>0.406400}
cylinder{<81.280000,0.038000,55.880000><81.280000,-1.538000,55.880000>0.406400}
cylinder{<81.280000,0.038000,53.340000><81.280000,-1.538000,53.340000>0.406400}
cylinder{<81.280000,0.038000,50.800000><81.280000,-1.538000,50.800000>0.406400}
cylinder{<81.280000,0.038000,48.260000><81.280000,-1.538000,48.260000>0.406400}
cylinder{<81.280000,0.038000,45.720000><81.280000,-1.538000,45.720000>0.406400}
cylinder{<81.280000,0.038000,43.180000><81.280000,-1.538000,43.180000>0.406400}
cylinder{<81.280000,0.038000,40.640000><81.280000,-1.538000,40.640000>0.406400}
cylinder{<88.900000,0.038000,40.640000><88.900000,-1.538000,40.640000>0.406400}
cylinder{<88.900000,0.038000,43.180000><88.900000,-1.538000,43.180000>0.406400}
cylinder{<88.900000,0.038000,45.720000><88.900000,-1.538000,45.720000>0.406400}
cylinder{<88.900000,0.038000,48.260000><88.900000,-1.538000,48.260000>0.406400}
cylinder{<88.900000,0.038000,50.800000><88.900000,-1.538000,50.800000>0.406400}
cylinder{<88.900000,0.038000,53.340000><88.900000,-1.538000,53.340000>0.406400}
cylinder{<88.900000,0.038000,55.880000><88.900000,-1.538000,55.880000>0.406400}
cylinder{<88.900000,0.038000,58.420000><88.900000,-1.538000,58.420000>0.406400}
cylinder{<88.900000,0.038000,60.960000><88.900000,-1.538000,60.960000>0.406400}
cylinder{<88.900000,0.038000,63.500000><88.900000,-1.538000,63.500000>0.406400}
cylinder{<88.900000,0.038000,66.040000><88.900000,-1.538000,66.040000>0.406400}
cylinder{<88.900000,0.038000,68.580000><88.900000,-1.538000,68.580000>0.406400}
cylinder{<88.900000,0.038000,71.120000><88.900000,-1.538000,71.120000>0.406400}
cylinder{<88.900000,0.038000,73.660000><88.900000,-1.538000,73.660000>0.406400}
cylinder{<97.790000,0.038000,73.660000><97.790000,-1.538000,73.660000>0.406400}
cylinder{<97.790000,0.038000,71.120000><97.790000,-1.538000,71.120000>0.406400}
cylinder{<97.790000,0.038000,68.580000><97.790000,-1.538000,68.580000>0.406400}
cylinder{<97.790000,0.038000,66.040000><97.790000,-1.538000,66.040000>0.406400}
cylinder{<97.790000,0.038000,63.500000><97.790000,-1.538000,63.500000>0.406400}
cylinder{<97.790000,0.038000,60.960000><97.790000,-1.538000,60.960000>0.406400}
cylinder{<97.790000,0.038000,58.420000><97.790000,-1.538000,58.420000>0.406400}
cylinder{<97.790000,0.038000,55.880000><97.790000,-1.538000,55.880000>0.406400}
cylinder{<97.790000,0.038000,53.340000><97.790000,-1.538000,53.340000>0.406400}
cylinder{<97.790000,0.038000,50.800000><97.790000,-1.538000,50.800000>0.406400}
cylinder{<97.790000,0.038000,48.260000><97.790000,-1.538000,48.260000>0.406400}
cylinder{<97.790000,0.038000,45.720000><97.790000,-1.538000,45.720000>0.406400}
cylinder{<97.790000,0.038000,43.180000><97.790000,-1.538000,43.180000>0.406400}
cylinder{<97.790000,0.038000,40.640000><97.790000,-1.538000,40.640000>0.406400}
cylinder{<105.410000,0.038000,40.640000><105.410000,-1.538000,40.640000>0.406400}
cylinder{<105.410000,0.038000,43.180000><105.410000,-1.538000,43.180000>0.406400}
cylinder{<105.410000,0.038000,45.720000><105.410000,-1.538000,45.720000>0.406400}
cylinder{<105.410000,0.038000,48.260000><105.410000,-1.538000,48.260000>0.406400}
cylinder{<105.410000,0.038000,50.800000><105.410000,-1.538000,50.800000>0.406400}
cylinder{<105.410000,0.038000,53.340000><105.410000,-1.538000,53.340000>0.406400}
cylinder{<105.410000,0.038000,55.880000><105.410000,-1.538000,55.880000>0.406400}
cylinder{<105.410000,0.038000,58.420000><105.410000,-1.538000,58.420000>0.406400}
cylinder{<105.410000,0.038000,60.960000><105.410000,-1.538000,60.960000>0.406400}
cylinder{<105.410000,0.038000,63.500000><105.410000,-1.538000,63.500000>0.406400}
cylinder{<105.410000,0.038000,66.040000><105.410000,-1.538000,66.040000>0.406400}
cylinder{<105.410000,0.038000,68.580000><105.410000,-1.538000,68.580000>0.406400}
cylinder{<105.410000,0.038000,71.120000><105.410000,-1.538000,71.120000>0.406400}
cylinder{<105.410000,0.038000,73.660000><105.410000,-1.538000,73.660000>0.406400}
cylinder{<142.240000,0.038000,63.500000><142.240000,-1.538000,63.500000>0.406400}
cylinder{<142.240000,0.038000,60.960000><142.240000,-1.538000,60.960000>0.406400}
cylinder{<142.240000,0.038000,58.420000><142.240000,-1.538000,58.420000>0.406400}
cylinder{<142.240000,0.038000,55.880000><142.240000,-1.538000,55.880000>0.406400}
cylinder{<142.240000,0.038000,53.340000><142.240000,-1.538000,53.340000>0.406400}
cylinder{<142.240000,0.038000,50.800000><142.240000,-1.538000,50.800000>0.406400}
cylinder{<142.240000,0.038000,48.260000><142.240000,-1.538000,48.260000>0.406400}
cylinder{<142.240000,0.038000,45.720000><142.240000,-1.538000,45.720000>0.406400}
cylinder{<142.240000,0.038000,43.180000><142.240000,-1.538000,43.180000>0.406400}
cylinder{<142.240000,0.038000,40.640000><142.240000,-1.538000,40.640000>0.406400}
cylinder{<149.860000,0.038000,40.640000><149.860000,-1.538000,40.640000>0.406400}
cylinder{<149.860000,0.038000,43.180000><149.860000,-1.538000,43.180000>0.406400}
cylinder{<149.860000,0.038000,45.720000><149.860000,-1.538000,45.720000>0.406400}
cylinder{<149.860000,0.038000,48.260000><149.860000,-1.538000,48.260000>0.406400}
cylinder{<149.860000,0.038000,50.800000><149.860000,-1.538000,50.800000>0.406400}
cylinder{<149.860000,0.038000,53.340000><149.860000,-1.538000,53.340000>0.406400}
cylinder{<149.860000,0.038000,55.880000><149.860000,-1.538000,55.880000>0.406400}
cylinder{<149.860000,0.038000,58.420000><149.860000,-1.538000,58.420000>0.406400}
cylinder{<149.860000,0.038000,60.960000><149.860000,-1.538000,60.960000>0.406400}
cylinder{<149.860000,0.038000,63.500000><149.860000,-1.538000,63.500000>0.406400}
cylinder{<111.760000,0.038000,81.280000><111.760000,-1.538000,81.280000>0.406400}
cylinder{<111.760000,0.038000,83.820000><111.760000,-1.538000,83.820000>0.406400}
cylinder{<111.760000,0.038000,86.360000><111.760000,-1.538000,86.360000>0.406400}
cylinder{<111.760000,0.038000,88.900000><111.760000,-1.538000,88.900000>0.406400}
cylinder{<111.760000,0.038000,91.440000><111.760000,-1.538000,91.440000>0.406400}
cylinder{<111.760000,0.038000,93.980000><111.760000,-1.538000,93.980000>0.406400}
cylinder{<111.760000,0.038000,96.520000><111.760000,-1.538000,96.520000>0.406400}
cylinder{<104.140000,0.038000,96.520000><104.140000,-1.538000,96.520000>0.406400}
cylinder{<104.140000,0.038000,93.980000><104.140000,-1.538000,93.980000>0.406400}
cylinder{<104.140000,0.038000,91.440000><104.140000,-1.538000,91.440000>0.406400}
cylinder{<104.140000,0.038000,88.900000><104.140000,-1.538000,88.900000>0.406400}
cylinder{<104.140000,0.038000,86.360000><104.140000,-1.538000,86.360000>0.406400}
cylinder{<104.140000,0.038000,83.820000><104.140000,-1.538000,83.820000>0.406400}
cylinder{<104.140000,0.038000,81.280000><104.140000,-1.538000,81.280000>0.406400}
cylinder{<36.195000,0.038000,83.820000><36.195000,-1.538000,83.820000>0.406400}
cylinder{<36.195000,0.038000,86.360000><36.195000,-1.538000,86.360000>0.406400}
cylinder{<123.190000,0.038000,30.480000><123.190000,-1.538000,30.480000>0.406400}
cylinder{<125.730000,0.038000,30.480000><125.730000,-1.538000,30.480000>0.406400}
cylinder{<66.040000,0.038000,81.915000><66.040000,-1.538000,81.915000>0.406400}
cylinder{<76.200000,0.038000,81.915000><76.200000,-1.538000,81.915000>0.406400}
cylinder{<46.355000,0.038000,92.710000><46.355000,-1.538000,92.710000>0.406400}
cylinder{<36.195000,0.038000,92.710000><36.195000,-1.538000,92.710000>0.406400}
cylinder{<137.795000,0.038000,64.135000><137.795000,-1.538000,64.135000>0.406400}
cylinder{<137.795000,0.038000,74.295000><137.795000,-1.538000,74.295000>0.406400}
cylinder{<125.730000,0.038000,12.700000><125.730000,-1.538000,12.700000>0.406400}
cylinder{<125.730000,0.038000,22.860000><125.730000,-1.538000,22.860000>0.406400}
cylinder{<92.075000,0.038000,88.265000><92.075000,-1.538000,88.265000>0.406400}
cylinder{<92.075000,0.038000,85.725000><92.075000,-1.538000,85.725000>0.406400}
cylinder{<12.700000,0.038000,12.700000><12.700000,-1.538000,12.700000>0.457200}
cylinder{<12.700000,0.038000,15.240000><12.700000,-1.538000,15.240000>0.457200}
cylinder{<12.700000,0.038000,17.780000><12.700000,-1.538000,17.780000>0.457200}
cylinder{<12.700000,0.038000,20.320000><12.700000,-1.538000,20.320000>0.457200}
cylinder{<12.700000,0.038000,22.860000><12.700000,-1.538000,22.860000>0.457200}
cylinder{<12.700000,0.038000,25.400000><12.700000,-1.538000,25.400000>0.457200}
cylinder{<12.700000,0.038000,27.940000><12.700000,-1.538000,27.940000>0.457200}
cylinder{<12.700000,0.038000,30.480000><12.700000,-1.538000,30.480000>0.457200}
cylinder{<12.700000,0.038000,38.100000><12.700000,-1.538000,38.100000>0.457200}
cylinder{<12.700000,0.038000,40.640000><12.700000,-1.538000,40.640000>0.457200}
cylinder{<12.700000,0.038000,43.180000><12.700000,-1.538000,43.180000>0.457200}
cylinder{<12.700000,0.038000,45.720000><12.700000,-1.538000,45.720000>0.457200}
cylinder{<12.700000,0.038000,48.260000><12.700000,-1.538000,48.260000>0.457200}
cylinder{<12.700000,0.038000,50.800000><12.700000,-1.538000,50.800000>0.457200}
cylinder{<12.700000,0.038000,53.340000><12.700000,-1.538000,53.340000>0.457200}
cylinder{<12.700000,0.038000,55.880000><12.700000,-1.538000,55.880000>0.457200}
cylinder{<12.700000,0.038000,58.420000><12.700000,-1.538000,58.420000>0.457200}
cylinder{<12.700000,0.038000,60.960000><12.700000,-1.538000,60.960000>0.457200}
cylinder{<12.700000,0.038000,63.500000><12.700000,-1.538000,63.500000>0.457200}
cylinder{<12.700000,0.038000,66.040000><12.700000,-1.538000,66.040000>0.457200}
cylinder{<12.700000,0.038000,68.580000><12.700000,-1.538000,68.580000>0.457200}
cylinder{<12.700000,0.038000,71.120000><12.700000,-1.538000,71.120000>0.457200}
cylinder{<12.700000,0.038000,73.660000><12.700000,-1.538000,73.660000>0.457200}
cylinder{<12.700000,0.038000,76.200000><12.700000,-1.538000,76.200000>0.457200}
cylinder{<133.350000,0.038000,60.960000><133.350000,-1.538000,60.960000>0.457200}
cylinder{<133.350000,0.038000,63.500000><133.350000,-1.538000,63.500000>0.457200}
cylinder{<133.350000,0.038000,66.040000><133.350000,-1.538000,66.040000>0.457200}
cylinder{<133.350000,0.038000,68.580000><133.350000,-1.538000,68.580000>0.457200}
cylinder{<133.350000,0.038000,71.120000><133.350000,-1.538000,71.120000>0.457200}
cylinder{<133.350000,0.038000,73.660000><133.350000,-1.538000,73.660000>0.457200}
cylinder{<12.700000,0.038000,82.550000><12.700000,-1.538000,82.550000>0.457200}
cylinder{<12.700000,0.038000,85.090000><12.700000,-1.538000,85.090000>0.457200}
cylinder{<12.700000,0.038000,87.630000><12.700000,-1.538000,87.630000>0.457200}
cylinder{<12.700000,0.038000,90.170000><12.700000,-1.538000,90.170000>0.457200}
cylinder{<12.700000,0.038000,92.710000><12.700000,-1.538000,92.710000>0.457200}
cylinder{<12.700000,0.038000,95.250000><12.700000,-1.538000,95.250000>0.457200}
cylinder{<12.700000,0.038000,97.790000><12.700000,-1.538000,97.790000>0.457200}
cylinder{<4.445000,0.038000,82.550000><4.445000,-1.538000,82.550000>0.457200}
cylinder{<4.445000,0.038000,85.090000><4.445000,-1.538000,85.090000>0.457200}
cylinder{<4.445000,0.038000,87.630000><4.445000,-1.538000,87.630000>0.457200}
cylinder{<107.950000,0.038000,27.940000><107.950000,-1.538000,27.940000>0.457200}
cylinder{<107.950000,0.038000,25.400000><107.950000,-1.538000,25.400000>0.457200}
cylinder{<107.950000,0.038000,22.860000><107.950000,-1.538000,22.860000>0.457200}
cylinder{<107.950000,0.038000,20.320000><107.950000,-1.538000,20.320000>0.457200}
cylinder{<107.950000,0.038000,17.780000><107.950000,-1.538000,17.780000>0.457200}
cylinder{<107.950000,0.038000,15.240000><107.950000,-1.538000,15.240000>0.457200}
cylinder{<107.950000,0.038000,12.700000><107.950000,-1.538000,12.700000>0.457200}
cylinder{<107.950000,0.038000,10.160000><107.950000,-1.538000,10.160000>0.457200}
cylinder{<68.580000,0.038000,27.940000><68.580000,-1.538000,27.940000>0.457200}
cylinder{<68.580000,0.038000,25.400000><68.580000,-1.538000,25.400000>0.457200}
cylinder{<68.580000,0.038000,22.860000><68.580000,-1.538000,22.860000>0.457200}
cylinder{<68.580000,0.038000,20.320000><68.580000,-1.538000,20.320000>0.457200}
cylinder{<68.580000,0.038000,17.780000><68.580000,-1.538000,17.780000>0.457200}
cylinder{<68.580000,0.038000,15.240000><68.580000,-1.538000,15.240000>0.457200}
cylinder{<68.580000,0.038000,12.700000><68.580000,-1.538000,12.700000>0.457200}
cylinder{<68.580000,0.038000,10.160000><68.580000,-1.538000,10.160000>0.457200}
cylinder{<97.155000,0.038000,92.710000><97.155000,-1.538000,92.710000>0.457200}
cylinder{<97.155000,0.038000,90.170000><97.155000,-1.538000,90.170000>0.457200}
cylinder{<97.155000,0.038000,87.630000><97.155000,-1.538000,87.630000>0.457200}
cylinder{<97.155000,0.038000,85.090000><97.155000,-1.538000,85.090000>0.457200}
cylinder{<146.685000,0.038000,69.215000><146.685000,-1.538000,69.215000>0.457200}
cylinder{<144.145000,0.038000,69.215000><144.145000,-1.538000,69.215000>0.457200}
cylinder{<141.605000,0.038000,69.215000><141.605000,-1.538000,69.215000>0.457200}
//Bohrungen(schnell)/Durchkontaktierungen
cylinder{<75.565000,0.038000,53.340000><75.565000,-1.538000,53.340000>0.350000 }
cylinder{<75.565000,0.038000,36.195000><75.565000,-1.538000,36.195000>0.350000 }
cylinder{<91.440000,0.038000,34.290000><91.440000,-1.538000,34.290000>0.350000 }
cylinder{<91.440000,0.038000,53.340000><91.440000,-1.538000,53.340000>0.350000 }
cylinder{<107.950000,0.038000,53.340000><107.950000,-1.538000,53.340000>0.350000 }
cylinder{<107.950000,0.038000,33.655000><107.950000,-1.538000,33.655000>0.350000 }
cylinder{<19.685000,0.038000,88.900000><19.685000,-1.538000,88.900000>0.350000 }
cylinder{<139.700000,0.038000,60.960000><139.700000,-1.538000,60.960000>0.350000 }
cylinder{<139.700000,0.038000,29.210000><139.700000,-1.538000,29.210000>0.350000 }
cylinder{<137.160000,0.038000,53.340000><137.160000,-1.538000,53.340000>0.350000 }
cylinder{<137.160000,0.038000,21.590000><137.160000,-1.538000,21.590000>0.350000 }
cylinder{<138.430000,0.038000,51.435000><138.430000,-1.538000,51.435000>0.350000 }
cylinder{<138.430000,0.038000,24.130000><138.430000,-1.538000,24.130000>0.350000 }
cylinder{<85.090000,0.038000,80.010000><85.090000,-1.538000,80.010000>0.350000 }
cylinder{<48.260000,0.038000,80.010000><48.260000,-1.538000,80.010000>0.350000 }
cylinder{<31.750000,0.038000,87.630000><31.750000,-1.538000,87.630000>0.350000 }
cylinder{<31.750000,0.038000,59.690000><31.750000,-1.538000,59.690000>0.350000 }
cylinder{<26.670000,0.038000,72.390000><26.670000,-1.538000,72.390000>0.350000 }
cylinder{<26.670000,0.038000,87.630000><26.670000,-1.538000,87.630000>0.350000 }
cylinder{<27.305000,0.038000,92.075000><27.305000,-1.538000,92.075000>0.350000 }
cylinder{<32.385000,0.038000,94.615000><32.385000,-1.538000,94.615000>0.350000 }
cylinder{<116.840000,0.038000,97.790000><116.840000,-1.538000,97.790000>0.350000 }
cylinder{<38.735000,0.038000,97.790000><38.735000,-1.538000,97.790000>0.350000 }
cylinder{<116.840000,0.038000,49.530000><116.840000,-1.538000,49.530000>0.350000 }
cylinder{<116.840000,0.038000,81.280000><116.840000,-1.538000,81.280000>0.350000 }
cylinder{<107.950000,0.038000,67.310000><107.950000,-1.538000,67.310000>0.350000 }
cylinder{<107.950000,0.038000,78.105000><107.950000,-1.538000,78.105000>0.350000 }
cylinder{<45.085000,0.038000,54.610000><45.085000,-1.538000,54.610000>0.350000 }
cylinder{<45.085000,0.038000,38.100000><45.085000,-1.538000,38.100000>0.350000 }
cylinder{<115.570000,0.038000,38.100000><115.570000,-1.538000,38.100000>0.350000 }
cylinder{<115.570000,0.038000,77.470000><115.570000,-1.538000,77.470000>0.350000 }
cylinder{<133.350000,0.038000,53.340000><133.350000,-1.538000,53.340000>0.350000 }
cylinder{<133.350000,0.038000,48.260000><133.350000,-1.538000,48.260000>0.350000 }
cylinder{<39.370000,0.038000,26.670000><39.370000,-1.538000,26.670000>0.350000 }
cylinder{<20.320000,0.038000,26.670000><20.320000,-1.538000,26.670000>0.350000 }
cylinder{<72.390000,0.038000,25.400000><72.390000,-1.538000,25.400000>0.350000 }
cylinder{<72.390000,0.038000,34.925000><72.390000,-1.538000,34.925000>0.350000 }
cylinder{<20.320000,0.038000,34.290000><20.320000,-1.538000,34.290000>0.350000 }
cylinder{<20.320000,0.038000,80.645000><20.320000,-1.538000,80.645000>0.350000 }
cylinder{<39.370000,0.038000,24.130000><39.370000,-1.538000,24.130000>0.350000 }
cylinder{<25.400000,0.038000,24.130000><25.400000,-1.538000,24.130000>0.350000 }
cylinder{<39.370000,0.038000,20.955000><39.370000,-1.538000,20.955000>0.350000 }
cylinder{<30.480000,0.038000,20.955000><30.480000,-1.538000,20.955000>0.350000 }
cylinder{<57.785000,0.038000,5.715000><57.785000,-1.538000,5.715000>0.350000 }
cylinder{<45.085000,0.038000,5.715000><45.085000,-1.538000,5.715000>0.350000 }
cylinder{<135.890000,0.038000,46.355000><135.890000,-1.538000,46.355000>0.350000 }
cylinder{<135.890000,0.038000,41.910000><135.890000,-1.538000,41.910000>0.350000 }
cylinder{<78.105000,0.038000,40.640000><78.105000,-1.538000,40.640000>0.350000 }
cylinder{<78.105000,0.038000,12.700000><78.105000,-1.538000,12.700000>0.350000 }
cylinder{<118.110000,0.038000,43.180000><118.110000,-1.538000,43.180000>0.350000 }
cylinder{<118.110000,0.038000,39.370000><118.110000,-1.538000,39.370000>0.350000 }
cylinder{<109.220000,0.038000,45.720000><109.220000,-1.538000,45.720000>0.350000 }
cylinder{<109.220000,0.038000,40.640000><109.220000,-1.538000,40.640000>0.350000 }
cylinder{<35.560000,0.038000,27.940000><35.560000,-1.538000,27.940000>0.350000 }
cylinder{<22.860000,0.038000,27.940000><22.860000,-1.538000,27.940000>0.350000 }
cylinder{<83.820000,0.038000,20.320000><83.820000,-1.538000,20.320000>0.350000 }
cylinder{<83.820000,0.038000,33.020000><83.820000,-1.538000,33.020000>0.350000 }
cylinder{<59.690000,0.038000,22.860000><59.690000,-1.538000,22.860000>0.350000 }
cylinder{<59.690000,0.038000,2.540000><59.690000,-1.538000,2.540000>0.350000 }
cylinder{<97.790000,0.038000,5.080000><97.790000,-1.538000,5.080000>0.350000 }
cylinder{<97.790000,0.038000,22.860000><97.790000,-1.538000,22.860000>0.350000 }
cylinder{<59.055000,0.038000,25.400000><59.055000,-1.538000,25.400000>0.350000 }
cylinder{<59.055000,0.038000,50.800000><59.055000,-1.538000,50.800000>0.350000 }
cylinder{<95.250000,0.038000,33.655000><95.250000,-1.538000,33.655000>0.350000 }
cylinder{<95.250000,0.038000,40.005000><95.250000,-1.538000,40.005000>0.350000 }
cylinder{<120.015000,0.038000,2.540000><120.015000,-1.538000,2.540000>0.350000 }
cylinder{<120.015000,0.038000,8.890000><120.015000,-1.538000,8.890000>0.350000 }
cylinder{<52.705000,0.038000,78.105000><52.705000,-1.538000,78.105000>0.350000 }
cylinder{<80.010000,0.038000,78.105000><80.010000,-1.538000,78.105000>0.350000 }
cylinder{<142.240000,0.038000,78.105000><142.240000,-1.538000,78.105000>0.350000 }
cylinder{<156.845000,0.038000,78.105000><156.845000,-1.538000,78.105000>0.350000 }
cylinder{<20.955000,0.038000,8.890000><20.955000,-1.538000,8.890000>0.350000 }
cylinder{<20.955000,0.038000,15.240000><20.955000,-1.538000,15.240000>0.350000 }
cylinder{<80.010000,0.038000,1.270000><80.010000,-1.538000,1.270000>0.350000 }
cylinder{<80.010000,0.038000,7.620000><80.010000,-1.538000,7.620000>0.350000 }
cylinder{<114.300000,0.038000,71.120000><114.300000,-1.538000,71.120000>0.350000 }
cylinder{<114.300000,0.038000,86.360000><114.300000,-1.538000,86.360000>0.350000 }
cylinder{<101.600000,0.038000,13.335000><101.600000,-1.538000,13.335000>0.350000 }
cylinder{<101.600000,0.038000,19.050000><101.600000,-1.538000,19.050000>0.350000 }
cylinder{<102.870000,0.038000,26.035000><102.870000,-1.538000,26.035000>0.350000 }
cylinder{<102.870000,0.038000,9.525000><102.870000,-1.538000,9.525000>0.350000 }
cylinder{<63.500000,0.038000,12.700000><63.500000,-1.538000,12.700000>0.350000 }
cylinder{<63.500000,0.038000,19.050000><63.500000,-1.538000,19.050000>0.350000 }
cylinder{<62.230000,0.038000,29.210000><62.230000,-1.538000,29.210000>0.350000 }
cylinder{<62.230000,0.038000,10.160000><62.230000,-1.538000,10.160000>0.350000 }
cylinder{<111.125000,0.038000,53.340000><111.125000,-1.538000,53.340000>0.350000 }
cylinder{<111.125000,0.038000,73.660000><111.125000,-1.538000,73.660000>0.350000 }
cylinder{<148.590000,0.038000,76.200000><148.590000,-1.538000,76.200000>0.350000 }
cylinder{<119.380000,0.038000,76.200000><119.380000,-1.538000,76.200000>0.350000 }
cylinder{<152.400000,0.038000,63.500000><152.400000,-1.538000,63.500000>0.350000 }
cylinder{<152.400000,0.038000,35.560000><152.400000,-1.538000,35.560000>0.350000 }
cylinder{<114.300000,0.038000,30.480000><114.300000,-1.538000,30.480000>0.350000 }
cylinder{<114.300000,0.038000,53.340000><114.300000,-1.538000,53.340000>0.350000 }
cylinder{<73.660000,0.038000,7.620000><73.660000,-1.538000,7.620000>0.350000 }
cylinder{<73.660000,0.038000,2.540000><73.660000,-1.538000,2.540000>0.350000 }
//Bohrungen(schnell)/Platine
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Bestückungsdruck
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.849800,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.849800,0.000000,77.470000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<42.849800,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.849800,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.849800,0.000000,78.105000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<42.849800,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.849800,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,77.470000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<42.849800,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.214800,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.214800,0.000000,77.470000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<42.214800,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.214800,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.214800,0.000000,78.105000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<42.214800,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.214800,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,77.470000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<41.021000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,78.740000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.228000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,78.994000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.116000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,76.200000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.862000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,75.946000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.116000,0.000000,75.946000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<39.116000,0.000000,76.200000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<39.116000,0.000000,78.740000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<45.974000,0.000000,78.740000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<45.974000,0.000000,76.200000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,35.560000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<146.354800,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,36.195000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<146.354800,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.354800,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,35.560000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<146.354800,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,35.560000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<145.719800,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,36.195000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<145.719800,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.719800,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,35.560000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<144.526000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,36.830000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.733000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,37.084000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,34.290000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,34.036000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,34.036000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<142.621000,0.000000,34.290000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<142.621000,0.000000,36.830000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<149.479000,0.000000,36.830000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<149.479000,0.000000,34.290000>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.135200,0.000000,79.375000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.135200,0.000000,78.740000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<91.135200,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.135200,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.135200,0.000000,78.105000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<91.135200,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.135200,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,78.740000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<89.916000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.770200,0.000000,79.375000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.770200,0.000000,78.740000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<91.770200,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.770200,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<91.770200,0.000000,78.105000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<91.770200,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.770200,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.964000,0.000000,78.740000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<91.770200,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,77.470000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.757000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,77.216000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.011000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.123000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.123000,0.000000,80.010000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<95.123000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,80.264000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,80.264000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.011000,0.000000,80.264000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<94.869000,0.000000,80.010000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<94.869000,0.000000,77.470000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<88.011000,0.000000,77.470000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<88.011000,0.000000,80.010000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,73.660000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<146.354800,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<146.354800,0.000000,74.295000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<146.354800,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.354800,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,73.660000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<146.354800,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,73.660000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<145.719800,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<145.719800,0.000000,74.295000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<145.719800,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.719800,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,73.660000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<144.526000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,74.930000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.733000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,75.184000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,72.390000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,72.136000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,72.136000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<142.621000,0.000000,72.390000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<142.621000,0.000000,74.930000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<149.479000,0.000000,74.930000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<149.479000,0.000000,72.390000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<118.745000,0.000000,28.244800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<118.110000,0.000000,28.244800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<118.110000,0.000000,28.244800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<118.110000,0.000000,28.244800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<117.475000,0.000000,28.244800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<117.475000,0.000000,28.244800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.110000,0.000000,28.244800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.110000,0.000000,29.464000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<118.110000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<118.745000,0.000000,27.609800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<118.110000,0.000000,27.609800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<118.110000,0.000000,27.609800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<118.110000,0.000000,27.609800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<117.475000,0.000000,27.609800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<117.475000,0.000000,27.609800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.110000,0.000000,27.609800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.110000,0.000000,26.416000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<118.110000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.380000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,31.623000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.586000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.586000,0.000000,24.511000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<116.586000,0.000000,24.511000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,24.257000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.380000,0.000000,24.257000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,24.257000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.634000,0.000000,24.511000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.634000,0.000000,31.369000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<119.634000,0.000000,31.369000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<119.380000,0.000000,24.511000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<116.840000,0.000000,24.511000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<116.840000,0.000000,31.369000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<119.380000,0.000000,31.369000>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.465200,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.465200,0.000000,31.750000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<64.465200,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.465200,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.465200,0.000000,31.115000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<64.465200,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.465200,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.246000,0.000000,31.750000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<63.246000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<65.100200,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<65.100200,0.000000,31.750000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<65.100200,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<65.100200,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<65.100200,0.000000,31.115000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<65.100200,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.100200,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,31.750000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<65.100200,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.087000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.087000,0.000000,30.480000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.087000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.341000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,30.226000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.341000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.453000,0.000000,33.020000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.453000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.341000,0.000000,33.274000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.341000,0.000000,33.274000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<68.199000,0.000000,33.020000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<68.199000,0.000000,30.480000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<61.341000,0.000000,30.480000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<61.341000,0.000000,33.020000>}
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,93.980000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.009000,0.000000,92.710000> }
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<71.501000,0.000000,92.710000>}
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<71.501000,0.000000,93.980000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,92.202000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.199000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.691000,0.000000,93.980000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.691000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.691000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,94.488000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,94.488000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.199000,0.000000,94.488000> }
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<68.199000,0.000000,92.710000>}
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<68.199000,0.000000,93.980000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,92.583000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,93.345000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<70.154800,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,94.107000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<70.154800,0.000000,94.107000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,92.583000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,93.345000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<69.519800,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,94.107000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<69.519800,0.000000,94.107000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.519800,0.000000,93.345000>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,0.000000,0> translate<68.580000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.154800,0.000000,93.345000>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,0.000000,0> translate<70.154800,0.000000,93.345000> }
box{<-0.190500,0,-0.381000><0.190500,0.036000,0.381000> rotate<0,-180.000000,0> translate<67.500500,0.000000,93.345000>}
box{<-0.190500,0,-0.381000><0.190500,0.036000,0.381000> rotate<0,-180.000000,0> translate<72.199500,0.000000,93.345000>}
//C8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,88.900000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.009000,0.000000,88.900000> }
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<71.501000,0.000000,88.900000>}
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<71.501000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,88.392000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,88.392000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.199000,0.000000,88.392000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.691000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.691000,0.000000,88.900000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.691000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,90.678000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,90.678000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.199000,0.000000,90.678000> }
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<68.199000,0.000000,88.900000>}
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<68.199000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,89.535000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<70.154800,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.154800,0.000000,90.297000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<70.154800,0.000000,90.297000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,89.535000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<69.519800,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.519800,0.000000,90.297000>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,90.000000,0> translate<69.519800,0.000000,90.297000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.519800,0.000000,89.535000>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,0.000000,0> translate<68.580000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.154800,0.000000,89.535000>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,0.000000,0> translate<70.154800,0.000000,89.535000> }
box{<-0.190500,0,-0.381000><0.190500,0.036000,0.381000> rotate<0,-180.000000,0> translate<67.500500,0.000000,89.535000>}
box{<-0.190500,0,-0.381000><0.190500,0.036000,0.381000> rotate<0,-180.000000,0> translate<72.199500,0.000000,89.535000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.662000,0.000000,86.487000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,87.503000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,53.126596,0> translate<88.900000,0.000000,87.503000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,87.503000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.138000,0.000000,86.487000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-53.126596,0> translate<88.138000,0.000000,86.487000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.662000,0.000000,87.503000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,87.503000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.900000,0.000000,87.503000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,87.503000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,88.265000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<88.900000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,87.503000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.138000,0.000000,87.503000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.138000,0.000000,87.503000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.900000,0.000000,86.487000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<88.900000,0.000000,86.487000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.138000,0.000000,86.487000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.662000,0.000000,86.487000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.138000,0.000000,86.487000> }
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,54.610000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,-90.000000,0> translate<120.269000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,74.930000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,90.000000,0> translate<126.111000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,74.930000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<120.269000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.174000,0.000000,54.610000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<120.269000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.206000,0.000000,54.610000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.206000,0.000000,54.610000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<123.190000,0.000000,54.610000>}
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,80.010000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.129000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,97.790000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,97.790000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,80.010000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,80.010000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.066000,0.000000,80.010000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<146.050000,0.000000,80.010000>}
//IC3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,33.020000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,15.240000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.129000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,15.240000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,33.020000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.066000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,33.020000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,33.020000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<146.050000,0.000000,33.020000>}
//IC4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,80.010000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.594000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,97.790000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.436000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,97.790000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.594000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,80.010000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.594000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,80.010000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.531000,0.000000,80.010000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<56.515000,0.000000,80.010000>}
//IC5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,83.185000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.724000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,93.345000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<83.566000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,93.345000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.724000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,83.185000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.724000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.661000,0.000000,83.185000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.661000,0.000000,83.185000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<80.645000,0.000000,83.185000>}
//IC8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,74.930000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.991000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,39.370000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.149000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,39.370000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.149000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.086000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.149000,0.000000,74.930000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<52.070000,0.000000,74.930000>}
//IC9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,74.930000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.501000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.659000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.659000,0.000000,39.370000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.659000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.659000,0.000000,39.370000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.659000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.596000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.596000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.659000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.659000,0.000000,74.930000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<68.580000,0.000000,74.930000>}
//IC10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.361000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.361000,0.000000,31.750000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<94.361000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.519000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.519000,0.000000,6.350000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<88.519000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.361000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.519000,0.000000,6.350000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.519000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.361000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.456000,0.000000,31.750000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.456000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.519000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<90.424000,0.000000,31.750000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.519000,0.000000,31.750000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<91.440000,0.000000,31.750000>}
//IC14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,77.470000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,-90.000000,0> translate<120.269000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,97.790000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,90.000000,0> translate<126.111000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,97.790000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<120.269000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.174000,0.000000,77.470000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<120.269000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.111000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.206000,0.000000,77.470000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.206000,0.000000,77.470000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<123.190000,0.000000,77.470000>}
//IC15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,31.750000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.991000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,6.350000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.149000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,6.350000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.149000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.991000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.086000,0.000000,31.750000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.086000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.149000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,31.750000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.149000,0.000000,31.750000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<52.070000,0.000000,31.750000>}
//IC20 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,74.930000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,90.000000,0> translate<88.011000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.169000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.169000,0.000000,39.370000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.169000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.169000,0.000000,39.370000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.169000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.106000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.106000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.169000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.074000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.169000,0.000000,74.930000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<85.090000,0.000000,74.930000>}
//IC21 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<104.521000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<104.521000,0.000000,74.930000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,90.000000,0> translate<104.521000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.679000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.679000,0.000000,39.370000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,-90.000000,0> translate<98.679000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<104.521000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.679000,0.000000,39.370000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<98.679000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<104.521000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.616000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<102.616000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.679000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.584000,0.000000,74.930000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<98.679000,0.000000,74.930000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<101.600000,0.000000,74.930000>}
//IC23 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,64.770000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,39.370000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.129000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,39.370000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,64.770000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.066000,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,64.770000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,64.770000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<146.050000,0.000000,64.770000>}
//IC34 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.029000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.029000,0.000000,80.010000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<105.029000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.871000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.871000,0.000000,97.790000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.871000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.029000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.871000,0.000000,97.790000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.029000,0.000000,97.790000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.029000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.934000,0.000000,80.010000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.029000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.871000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.966000,0.000000,80.010000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<108.966000,0.000000,80.010000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<107.950000,0.000000,80.010000>}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.100000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.290000,0.000000,87.630000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.290000,0.000000,87.630000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<36.195000,0.000000,85.090000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<36.195000,0.000000,85.090000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<36.195000,0.000000,85.090000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<36.195000,0.000000,85.090000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<36.195000,0.000000,85.090000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<36.195000,0.000000,85.090000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<36.195000,0.000000,85.090000>}
difference{
cylinder{<36.195000,0,85.090000><36.195000,0.036000,85.090000>2.616200 translate<0,0.000000,0>}
cylinder{<36.195000,-0.1,85.090000><36.195000,0.135000,85.090000>2.463800 translate<0,0.000000,0>}}
//LED3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<127.000000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<127.000000,0.000000,32.385000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<127.000000,0.000000,32.385000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<124.460000,0.000000,30.480000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<124.460000,0.000000,30.480000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<124.460000,0.000000,30.480000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<124.460000,0.000000,30.480000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<124.460000,0.000000,30.480000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<124.460000,0.000000,30.480000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<124.460000,0.000000,30.480000>}
difference{
cylinder{<124.460000,0,30.480000><124.460000,0.036000,30.480000>2.616200 translate<0,0.000000,0>}
cylinder{<124.460000,-0.1,30.480000><124.460000,0.135000,30.480000>2.463800 translate<0,0.000000,0>}}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<76.200000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<75.184000,0.000000,81.915000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<75.184000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<66.040000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<67.056000,0.000000,81.915000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<66.040000,0.000000,81.915000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<68.199000,0.000000,82.804000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<68.199000,0.000000,81.026000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<74.041000,0.000000,81.026000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<74.041000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,82.804000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,83.058000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,83.058000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.199000,0.000000,83.058000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.707000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,83.058000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<68.580000,0.000000,83.058000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,80.772000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,80.772000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.199000,0.000000,80.772000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.707000,0.000000,80.899000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,80.772000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<68.580000,0.000000,80.772000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.533000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,83.058000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<73.533000,0.000000,82.931000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.533000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.707000,0.000000,82.931000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.707000,0.000000,82.931000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.533000,0.000000,80.899000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,80.772000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<73.533000,0.000000,80.899000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.533000,0.000000,80.899000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.707000,0.000000,80.899000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.707000,0.000000,80.899000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.041000,0.000000,83.058000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,83.058000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.660000,0.000000,83.058000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.041000,0.000000,80.772000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,80.772000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.660000,0.000000,80.772000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,82.804000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.295000,0.000000,82.804000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<74.726800,0.000000,81.915000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<67.513200,0.000000,81.915000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<36.195000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.211000,0.000000,92.710000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<36.195000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<46.355000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.339000,0.000000,92.710000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<45.339000,0.000000,92.710000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<44.196000,0.000000,91.821000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<44.196000,0.000000,93.599000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.354000,0.000000,93.599000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.354000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,93.599000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,91.821000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,91.567000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,91.567000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<43.688000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,93.853000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,93.853000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,93.853000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.688000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,91.567000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.735000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,91.694000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,93.853000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<38.735000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,93.726000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,91.567000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.354000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,93.853000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,93.853000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.354000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,93.599000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,91.821000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.100000,0.000000,91.821000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<37.668200,0.000000,92.710000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<44.881800,0.000000,92.710000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<137.795000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<137.795000,0.000000,73.279000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<137.795000,0.000000,73.279000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<137.795000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<137.795000,0.000000,65.151000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<137.795000,0.000000,65.151000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<136.906000,0.000000,66.294000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<138.684000,0.000000,66.294000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<138.684000,0.000000,72.136000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<136.906000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.684000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,66.040000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.906000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.652000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.652000,0.000000,66.675000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<136.652000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.779000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.652000,0.000000,66.675000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<136.652000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.938000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.938000,0.000000,66.675000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<138.938000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.811000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.938000,0.000000,66.675000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<138.811000,0.000000,66.802000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.779000,0.000000,71.628000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.652000,0.000000,71.755000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<136.652000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.779000,0.000000,71.628000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.779000,0.000000,66.802000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.779000,0.000000,66.802000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.811000,0.000000,71.628000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.938000,0.000000,71.755000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<138.811000,0.000000,71.628000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.811000,0.000000,71.628000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.811000,0.000000,66.802000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<138.811000,0.000000,66.802000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.652000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.652000,0.000000,71.755000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.652000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.938000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.938000,0.000000,71.755000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<138.938000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.684000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,72.390000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.906000,0.000000,72.390000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<137.795000,0.000000,72.821800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<137.795000,0.000000,65.608200>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<125.730000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<125.730000,0.000000,21.844000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<125.730000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<125.730000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<125.730000,0.000000,13.716000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<125.730000,0.000000,13.716000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<124.841000,0.000000,14.859000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<126.619000,0.000000,14.859000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<126.619000,0.000000,20.701000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<124.841000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.619000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.841000,0.000000,14.605000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.841000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,15.240000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<124.587000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.714000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,15.240000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<124.587000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.873000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.873000,0.000000,15.240000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<126.873000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.873000,0.000000,15.240000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<126.746000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.714000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<124.587000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.714000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.714000,0.000000,15.367000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<124.714000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.873000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<126.746000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,15.367000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<126.746000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.587000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<124.587000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.873000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.873000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<126.873000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.619000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.841000,0.000000,20.955000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.841000,0.000000,20.955000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<125.730000,0.000000,21.386800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<125.730000,0.000000,14.173200>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<92.075000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<92.075000,0.000000,87.376000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<92.075000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<92.075000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<92.075000,0.000000,86.741000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,-90.000000,0> translate<92.075000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<92.075000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<92.075000,0.000000,85.725000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<92.075000,0.000000,85.725000> }
difference{
cylinder{<92.075000,0,88.265000><92.075000,0.036000,88.265000>1.346200 translate<0,0.000000,0>}
cylinder{<92.075000,-0.1,88.265000><92.075000,0.135000,88.265000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<92.075000,0,88.265000><92.075000,0.036000,88.265000>1.092200 translate<0,0.000000,0>}
cylinder{<92.075000,-0.1,88.265000><92.075000,0.135000,88.265000>0.939800 translate<0,0.000000,0>}}
//SL1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,13.716000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.922000,0.000000,13.589000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,13.970000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.049000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,14.224000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<11.049000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,14.351000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.922000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,11.684000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,11.684000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,11.684000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,11.684000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.478000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,12.065000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,13.335000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,13.716000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.605000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,11.684000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,11.684000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,12.446000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,16.764000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.796000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,18.415000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,16.256000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,16.764000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,17.145000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.796000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,18.796000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,17.526000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,17.526000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,16.256000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,14.986000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,12.954000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,11.684000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.256000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.764000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.224000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,13.716000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,16.256000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,16.764000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,15.875000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,13.335000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,16.256000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.986000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,19.304000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,21.336000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.304000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,21.336000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,22.225000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.304000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,20.066000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,20.066000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,29.464000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<11.049000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,29.591000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.922000,0.000000,29.591000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,29.464000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,29.464000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,31.496000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,31.496000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,31.496000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.478000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,31.115000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,31.496000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,31.115000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.956000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,29.464000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,29.845000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,31.496000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,31.496000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,30.226000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,31.496000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,30.734000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,30.226000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,29.464000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,30.226000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,28.956000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,28.956000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.922000,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,29.210000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.049000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,22.606000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,22.606000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,20.574000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.336000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,21.844000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,21.336000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.956000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,29.464000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,29.845000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,28.956000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,18.796000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,18.415000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,21.844000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,23.495000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,23.876000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,24.765000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,25.146000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,25.654000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,25.146000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,25.146000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,23.114000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,23.876000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,24.384000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,23.876000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,23.495000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,24.384000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,26.416000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.416000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,27.305000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,27.686000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,28.194000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,27.686000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,27.686000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,25.654000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.416000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.924000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,26.416000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,28.956000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,28.829000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,28.575000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,26.924000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,26.924000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,12.700000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,15.240000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,17.780000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,20.320000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,22.860000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,27.940000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,25.400000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,30.480000>}
//SL2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,39.116000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.922000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,39.370000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.049000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,39.624000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<11.049000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,39.751000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.922000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,39.116000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,37.084000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,39.116000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,39.624000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,37.084000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,37.084000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,37.084000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.478000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,37.465000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,38.735000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,39.116000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,40.005000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,37.084000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,37.084000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,37.846000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,37.846000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,38.354000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,37.846000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,40.386000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,40.894000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,39.624000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,39.116000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,42.164000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,44.196000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,41.656000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,42.164000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,42.545000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,44.196000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,42.926000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,44.196000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,43.434000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,42.926000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,42.926000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,41.656000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,40.386000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,40.386000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,38.354000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,37.084000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,41.656000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,42.164000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,39.624000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,39.116000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,41.656000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,42.164000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,38.735000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,41.656000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.986000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,42.545000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,44.704000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,44.704000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,46.355000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,46.736000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,47.244000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,47.625000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,44.704000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,45.466000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,45.466000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,45.974000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,45.466000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,48.006000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,48.514000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,75.184000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<11.049000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,75.311000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.922000,0.000000,75.311000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,74.676000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,75.184000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,75.184000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,75.311000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,77.216000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,77.216000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,77.216000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.478000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,76.835000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,77.216000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,76.835000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,76.835000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,74.295000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,74.295000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,75.565000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,75.565000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,74.676000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,75.184000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,75.565000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,77.216000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,76.835000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,77.216000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,75.946000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,77.216000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,76.454000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,75.946000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,75.184000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,75.946000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,74.676000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,74.676000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,74.676000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.922000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,74.930000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.049000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,48.006000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,48.006000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,47.244000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,45.974000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,46.736000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,47.244000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,46.736000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,74.676000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,75.184000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,46.355000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,75.565000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,74.676000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,44.196000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,47.244000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,47.244000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,49.276000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,48.895000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,49.276000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,50.165000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,50.546000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,50.546000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,51.054000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,50.546000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,50.546000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,48.514000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,49.276000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,49.784000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,49.276000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,48.895000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,49.784000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,51.816000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,51.435000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,51.816000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,52.705000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,53.086000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,53.594000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,53.086000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,53.086000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,51.054000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,51.816000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,52.324000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,51.816000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,51.435000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,54.356000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,52.324000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,54.356000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,54.864000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,55.245000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,55.245000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,54.356000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,55.245000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,55.626000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,56.134000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,54.864000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,54.356000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,55.626000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,55.626000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,53.594000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,54.356000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,54.864000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,54.356000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,56.896000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,54.864000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,56.896000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,57.404000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,56.515000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,56.515000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,56.515000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,57.785000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,57.785000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,56.896000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,57.404000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,57.785000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,58.166000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,58.166000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,58.674000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,57.404000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,56.896000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,58.166000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,58.166000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,57.404000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,56.134000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,56.896000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,57.404000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,56.896000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,56.515000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,57.404000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,59.436000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,57.404000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,59.436000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,59.944000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.055000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,59.055000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,59.055000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,60.325000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,60.325000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.436000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.944000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,60.325000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,60.706000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,60.706000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,61.214000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,59.944000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,59.436000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,60.706000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,60.706000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,59.944000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,58.674000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,59.436000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.944000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,59.436000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,59.055000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,59.944000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,61.976000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,59.944000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,61.976000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,62.484000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,61.595000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,61.595000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,61.595000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,62.865000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,62.865000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,61.976000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,62.484000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,62.865000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,63.246000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,63.246000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,63.754000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,62.484000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,61.976000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,63.246000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,63.246000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,62.484000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,61.214000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,61.976000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,62.484000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,61.976000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,61.595000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,62.484000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,64.516000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,62.484000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,64.516000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,65.024000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,64.135000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,64.135000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,64.135000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,65.405000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,65.405000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,64.516000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,65.024000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,65.405000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,65.786000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,66.294000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,66.294000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,65.024000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,64.516000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,65.786000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,65.786000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,65.024000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,63.754000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,64.516000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,65.024000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,64.516000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,64.135000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,65.024000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,67.056000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,65.024000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,67.056000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,67.564000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,66.675000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,66.675000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,66.675000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.945000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,67.945000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.056000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.564000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.945000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,68.326000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,68.326000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,68.834000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,68.834000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,68.834000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,67.564000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,67.056000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,68.834000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,68.326000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,68.326000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,67.564000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,66.294000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,66.294000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,67.056000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.564000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.056000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,66.675000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,67.564000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,69.596000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,67.564000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,69.596000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,70.104000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,69.215000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,69.215000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,69.215000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,69.596000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,70.104000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,70.485000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,70.866000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,70.866000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,71.374000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,71.374000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,70.104000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,69.596000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,70.866000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,70.866000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,70.104000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,68.834000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,68.834000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,69.596000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,70.104000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,69.596000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,69.215000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,70.104000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,72.136000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,70.104000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,72.136000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,72.644000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,71.755000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,71.755000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,73.025000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,73.025000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,72.136000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,72.644000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,73.025000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,73.406000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,73.406000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,73.914000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,72.644000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,72.136000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,73.406000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,73.406000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,72.644000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,71.374000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,71.374000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,72.136000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,72.644000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,72.136000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,72.644000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,74.676000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,74.549000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,74.295000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,72.644000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,72.644000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,38.100000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,40.640000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,43.180000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,45.720000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,48.260000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,53.340000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,50.800000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,76.200000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,55.880000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,58.420000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,60.960000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,63.500000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,66.040000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,68.580000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,71.120000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,73.660000>}
//SL3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,61.976000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<131.572000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.953000,0.000000,62.230000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<131.699000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.953000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,62.484000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<131.699000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,62.611000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<131.572000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,61.976000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,59.944000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.636000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,61.976000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.509000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,62.484000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,59.944000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,59.944000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,59.944000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.128000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,60.325000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<135.128000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,61.595000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,60.325000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,61.595000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,61.595000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,62.865000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,62.865000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,61.976000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,62.484000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,62.865000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,59.944000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<134.874000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,60.325000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,59.944000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,60.706000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,60.706000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,60.706000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,61.214000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,60.706000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.683000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,63.246000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,63.246000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,63.754000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,62.484000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,61.976000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,64.516000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.509000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,65.024000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,65.024000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.636000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.056000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,66.675000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,66.675000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,64.135000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,64.135000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,65.405000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,65.405000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,65.405000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,64.516000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,65.024000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,65.405000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.056000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,66.675000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,65.786000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,67.056000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,66.294000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,66.294000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,65.786000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.683000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,65.024000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,65.786000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,64.516000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.937000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,64.516000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,64.516000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,63.246000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.683000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,63.246000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,62.484000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.937000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,61.214000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.810000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,59.944000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<131.572000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,64.516000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<131.572000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,65.024000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<131.572000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,62.484000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.699000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,61.976000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.699000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,64.516000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,65.024000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,64.135000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,61.595000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.128000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,64.516000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<135.636000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,65.405000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<135.128000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,64.516000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,69.596000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,67.564000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.636000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,69.596000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.509000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,70.104000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.564000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,69.215000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.945000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,69.215000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,69.215000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,69.596000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,70.104000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,70.485000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.564000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<134.874000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,67.945000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,68.326000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,68.326000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,68.326000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,68.834000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,68.834000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,68.834000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,68.834000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,68.326000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.683000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,70.866000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,70.866000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,71.374000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,71.374000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,70.104000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,69.596000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.953000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,72.644000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<131.699000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,72.771000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<131.572000,0.000000,72.771000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,72.136000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.509000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,72.644000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,72.644000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.636000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,72.771000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,74.676000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<131.572000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,74.676000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,74.676000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.128000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,74.295000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.128000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,74.676000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,74.295000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,74.295000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,71.755000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,71.755000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,73.025000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,73.025000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,72.136000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,72.644000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,73.025000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,74.676000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,74.295000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,74.676000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,73.406000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,73.406000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,74.676000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,73.914000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.683000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,73.406000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.683000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,72.644000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,73.406000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,72.136000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.937000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,72.136000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,72.136000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<131.572000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.953000,0.000000,72.390000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<131.699000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,72.136000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,70.866000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.683000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,70.866000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,70.104000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.937000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,68.834000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.810000,0.000000,68.834000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,69.596000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<131.572000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,70.104000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,69.596000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.572000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,72.136000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.699000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.699000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,72.644000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<131.699000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,69.215000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.128000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,72.136000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<135.636000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,73.025000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<135.128000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,72.136000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,67.056000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<131.572000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,70.104000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<131.572000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,72.009000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<131.572000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,67.056000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,67.564000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,67.056000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.509000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.128000,0.000000,66.675000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.128000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,67.056000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<134.874000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.572000,0.000000,67.056000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<131.572000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,67.056000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.937000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,67.056000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,67.056000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,67.056000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,67.564000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.810000,0.000000,67.564000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<133.350000,0.000000,60.960000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<133.350000,0.000000,63.500000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<133.350000,0.000000,66.040000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<133.350000,0.000000,68.580000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<133.350000,0.000000,71.120000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<133.350000,0.000000,73.660000>}
//SL4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,83.566000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.922000,0.000000,83.439000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,83.820000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.049000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,84.074000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<11.049000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,84.201000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.922000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,83.566000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,81.534000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,83.566000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,84.074000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,81.534000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,81.534000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,81.534000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.478000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,81.915000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.185000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,81.915000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,83.185000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,83.185000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.566000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,84.074000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,84.455000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,81.534000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,81.915000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,81.534000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,82.296000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,82.296000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,82.296000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,82.804000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,82.296000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,84.836000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,85.344000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,84.074000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,83.566000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,86.106000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,86.614000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,88.646000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,88.265000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.106000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.995000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,88.646000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,87.376000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,88.646000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,87.884000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,87.376000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,87.376000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,86.106000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,86.106000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,84.836000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,84.836000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,84.074000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,82.804000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,81.534000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,86.106000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,84.074000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,83.566000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.106000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,86.614000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,85.725000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,83.185000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,86.106000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.986000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,86.995000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,91.186000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,89.154000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,91.186000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,91.694000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,89.154000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,90.805000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,89.535000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,90.805000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,90.805000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,92.075000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,92.075000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,91.186000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,91.694000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,92.075000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,89.154000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,89.535000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,89.916000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,89.916000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,90.424000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,90.424000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,90.424000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,89.916000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,92.456000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,92.456000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,92.964000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,91.694000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,91.186000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,96.520000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,96.774000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<11.049000,0.000000,96.774000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,96.901000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.922000,0.000000,96.901000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,96.266000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,96.774000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,96.774000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,98.806000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,96.774000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,96.774000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,96.901000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,98.806000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,98.806000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,98.806000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,98.806000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,98.806000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,98.806000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,98.806000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.478000,0.000000,98.806000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,98.806000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,98.425000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,98.425000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,98.806000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,98.806000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,98.806000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,98.425000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,98.425000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,98.425000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,97.155000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,98.425000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,98.425000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,95.885000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,95.885000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,95.885000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,95.885000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,95.885000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,95.885000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,97.155000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,97.155000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,97.155000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,97.155000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,97.155000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,97.155000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,95.885000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,96.266000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,96.774000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,96.774000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,97.155000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,97.155000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,98.425000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,98.806000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,98.806000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,98.425000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,98.425000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,98.425000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,98.806000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,98.806000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,98.806000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,97.536000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,97.536000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,97.536000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,98.044000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,98.806000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,98.806000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,98.044000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,98.044000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,98.044000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,98.044000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,97.536000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,97.536000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,96.774000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,96.774000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,97.536000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,97.536000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,96.266000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,96.266000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.922000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,96.520000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.049000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,92.456000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,92.456000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,91.694000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,90.424000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,91.186000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,91.694000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,91.186000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,96.266000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,96.774000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,96.774000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.049000,0.000000,96.774000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,90.805000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,95.885000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,97.155000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.478000,0.000000,97.155000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,88.646000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,91.694000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,88.646000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,89.154000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,88.265000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.922000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.287000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,88.646000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,89.154000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,93.726000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,91.694000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,94.234000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,93.726000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.859000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,94.234000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,94.234000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,93.345000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,93.345000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,93.345000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,94.615000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,94.615000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,94.615000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,94.615000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,94.615000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,94.615000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,93.726000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,94.234000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,94.234000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,94.615000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,94.615000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,94.996000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,94.996000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,94.996000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,95.504000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.033000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,94.234000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,94.234000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,93.726000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,94.996000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.033000,0.000000,94.996000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,94.234000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,94.996000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,94.996000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.287000,0.000000,94.234000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.287000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,92.964000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,93.726000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,94.234000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,94.234000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,93.726000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,94.615000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,93.345000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.478000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,94.234000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,96.266000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,94.615000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,95.885000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,95.885000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,94.234000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.986000,0.000000,94.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,94.234000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,96.139000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.922000,0.000000,96.139000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,82.550000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,85.090000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,87.630000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,90.170000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,92.710000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,97.790000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<12.700000,0.000000,95.250000>}
//SL5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,83.566000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.667000,0.000000,83.439000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,83.820000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.794000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,84.074000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<2.794000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,84.201000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<2.667000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,83.566000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,81.534000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.731000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,83.566000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,84.074000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,81.534000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,81.534000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.667000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,81.534000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.223000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,81.915000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.223000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,83.185000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,81.915000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,83.185000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.715000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,83.185000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,83.566000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.969000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,84.074000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.969000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,84.455000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.969000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,81.534000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.969000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,81.915000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,81.534000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,82.296000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.905000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,82.296000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,82.296000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.778000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,82.804000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.778000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,82.296000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<1.778000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,84.836000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.778000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,85.344000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.778000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,84.074000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,83.566000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,86.614000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<2.794000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,86.741000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<2.667000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,86.106000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,86.614000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.731000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,88.646000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.667000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,88.646000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.223000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,88.265000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.223000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,88.646000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.667000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,88.265000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.715000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.106000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.969000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.969000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.995000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.969000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,88.646000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.969000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,88.646000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,87.376000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.778000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,88.646000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.905000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,87.884000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.778000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,87.376000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<1.778000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,87.376000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.905000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,86.106000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<2.032000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,85.979000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,86.106000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.667000,0.000000,85.979000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,86.360000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.794000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,86.106000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.905000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.778000,0.000000,84.836000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<1.778000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,84.836000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.905000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,84.074000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.032000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,82.804000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<1.905000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,81.534000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<2.667000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,85.979000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.667000,0.000000,85.979000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,84.074000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,83.566000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.106000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.794000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,86.614000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.794000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,85.725000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.715000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,83.185000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.223000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,86.106000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.731000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,86.995000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.223000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,86.106000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<4.445000,0.000000,82.550000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<4.445000,0.000000,85.090000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<4.445000,0.000000,87.630000>}
//SL6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,26.924000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<109.601000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,26.670000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<109.347000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,26.416000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<109.347000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,26.289000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<109.601000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,28.956000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.664000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.791000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,28.956000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<109.728000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,28.956000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,28.575000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.172000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.924000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.416000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.035000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,28.956000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.426000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,28.956000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,28.194000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,28.194000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,27.686000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,28.194000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,25.654000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,25.146000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.791000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,23.876000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.664000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,21.844000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,24.384000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,23.495000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,21.844000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,21.844000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,23.114000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,23.114000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.363000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,24.384000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,25.654000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,25.654000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,26.416000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.363000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,27.686000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.490000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,28.956000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<109.728000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,26.289000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,24.384000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.416000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,26.924000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,24.384000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,23.876000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.172000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,24.384000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<105.664000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,23.495000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.172000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,21.336000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.664000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,19.304000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.791000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,21.336000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,19.304000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,18.415000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,21.336000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.426000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,20.574000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,11.176000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<109.347000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,11.049000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<109.601000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,11.684000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.791000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,11.176000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.664000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,9.144000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,9.144000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<109.728000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,9.144000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,9.525000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.172000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,9.144000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,11.684000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,10.795000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,9.144000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,9.144000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,10.414000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,9.144000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,10.414000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,10.414000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,11.684000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.363000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,11.684000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<109.601000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.347000,0.000000,11.430000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<109.347000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,18.034000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.363000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,20.066000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.490000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,19.304000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,18.796000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,19.304000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,11.684000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.601000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,11.176000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.172000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.172000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,21.844000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.791000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.172000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.426000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<109.728000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.363000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,18.796000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.664000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,16.764000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.791000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,16.764000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,15.875000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,15.494000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.363000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,17.526000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.490000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,16.764000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,16.256000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,16.764000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.172000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,16.256000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.664000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.791000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.664000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.172000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,14.224000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.335000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.426000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.490000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<110.363000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.617000,0.000000,12.954000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.617000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,12.954000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.363000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,14.986000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.490000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.716000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,14.224000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.426000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.172000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.490000,0.000000,11.684000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.490000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<109.728000,0.000000,11.811000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<109.728000,0.000000,11.811000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.680000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<106.680000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.664000,0.000000,13.716000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.664000,0.000000,13.716000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,27.940000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,25.400000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,22.860000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,20.320000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,17.780000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,12.700000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,15.240000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<107.950000,0.000000,10.160000>}
//SL7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,26.924000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<70.231000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.977000,0.000000,26.670000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.977000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.977000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,26.416000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<69.977000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,26.289000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<70.231000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,28.956000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.421000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,28.956000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.358000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,28.956000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,28.575000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.802000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.924000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.416000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.035000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,28.956000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.056000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,28.956000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,28.194000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,28.194000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,27.686000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,28.194000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,25.654000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,25.146000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.421000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,23.876000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,21.844000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,24.384000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,23.495000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,21.844000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,21.844000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,23.114000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,23.114000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.993000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,24.384000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,25.654000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,25.654000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,26.416000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.993000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,27.686000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.120000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,28.956000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.358000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,26.289000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,24.384000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.416000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,26.924000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,24.384000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,23.876000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.802000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,24.384000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.294000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,23.495000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.802000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,21.336000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,19.304000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.421000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,21.336000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,19.304000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,18.415000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,21.336000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.056000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,20.574000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.977000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,11.176000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<69.977000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,11.049000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<70.231000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,11.684000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.421000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,11.176000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,9.144000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,9.144000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.358000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,9.144000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,9.525000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.802000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.144000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,11.684000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,10.795000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.144000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,9.144000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,10.414000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,9.144000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,10.414000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,10.414000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,11.684000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.993000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,11.684000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<70.231000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.977000,0.000000,11.430000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.977000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,18.034000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.993000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,20.066000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.120000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,19.304000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,18.796000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,19.304000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,11.684000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,11.176000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.802000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.802000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,21.844000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.421000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.802000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.056000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.358000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.993000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,18.796000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,16.764000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.421000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,16.764000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,15.875000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,15.494000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.993000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,17.526000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.120000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,16.764000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,16.256000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,16.764000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.802000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,16.256000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.421000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.421000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.294000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.802000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,14.224000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,13.335000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.056000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.993000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.247000,0.000000,12.954000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.247000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,12.954000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.993000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,14.986000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.120000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,13.716000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,14.224000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.802000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,11.684000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.120000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,11.811000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.358000,0.000000,11.811000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.294000,0.000000,13.716000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.294000,0.000000,13.716000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,27.940000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,25.400000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,22.860000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,20.320000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,17.780000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,12.700000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,15.240000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<68.580000,0.000000,10.160000>}
//SL8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,91.694000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<98.806000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.552000,0.000000,91.440000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<98.552000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.552000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,91.186000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<98.552000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,91.059000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<98.806000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,91.694000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,93.726000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<94.869000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,91.694000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<94.996000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,91.186000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,93.726000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<98.933000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,93.726000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,93.726000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,93.345000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.377000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,92.075000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,93.345000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,92.075000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.885000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,92.075000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,90.805000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,90.805000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,91.694000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,91.186000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,90.805000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,93.726000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<95.631000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,93.345000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,93.726000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,92.964000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.695000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,92.964000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,92.456000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,92.456000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,92.456000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,92.964000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.822000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,90.424000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,90.424000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,89.916000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,91.186000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.568000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,91.694000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.568000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,89.154000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<94.996000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,88.646000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,88.646000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<94.869000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,86.995000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.885000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,89.535000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,89.535000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,89.154000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,88.265000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,87.884000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,86.614000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.695000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,87.376000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,87.884000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.822000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,88.646000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.568000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,87.884000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.695000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,89.154000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.568000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,89.154000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.568000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,89.154000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.695000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,90.424000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.822000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,90.424000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.695000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,91.186000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.568000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,92.456000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.695000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,93.726000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<98.933000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,91.059000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,89.154000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<98.933000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<98.933000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,91.186000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,91.694000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,89.154000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,88.646000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,89.535000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.885000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,92.075000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<95.377000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,89.154000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<94.869000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,88.265000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.377000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,89.154000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,84.074000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,84.074000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<94.996000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.869000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.869000,0.000000,86.106000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<94.869000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,84.455000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<95.377000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,84.074000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,84.455000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.885000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.614000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.106000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,85.725000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.631000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.885000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.106000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.552000,0.000000,86.360000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<98.552000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,86.614000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.806000,0.000000,86.614000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<98.806000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.552000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,85.979000>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,44.997030,0> translate<98.552000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,85.979000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,84.074000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<98.933000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,85.725000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.377000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.377000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,84.074000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.377000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.568000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.568000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,85.344000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.695000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.568000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.568000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,85.344000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,85.344000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.822000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.822000,0.000000,84.836000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<99.695000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,84.074000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<99.695000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.695000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,84.074000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<98.933000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.933000,0.000000,86.741000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<98.933000,0.000000,86.741000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<97.155000,0.000000,92.710000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<97.155000,0.000000,90.170000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<97.155000,0.000000,87.630000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<97.155000,0.000000,85.090000>}
//SL9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.796000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,67.564000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<145.669000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,67.818000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<145.415000,0.000000,67.818000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,67.818000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,67.564000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<145.161000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,67.437000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<145.034000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.501000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,71.501000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.374000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.161000,0.000000,71.374000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,71.501000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.161000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,67.437000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.701000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,70.739000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.701000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,71.501000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.701000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.320000,0.000000,70.993000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.320000,0.000000,70.993000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,70.739000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.050000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.320000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.320000,0.000000,70.739000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<147.320000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.320000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,70.485000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.050000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.050000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,70.739000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<144.780000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<144.780000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,70.739000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.161000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.320000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.320000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.320000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.320000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<147.320000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,70.993000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.701000,0.000000,70.993000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,66.675000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.939000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,66.548000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.939000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,66.548000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,66.548000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,66.548000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.431000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.399000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.399000,0.000000,66.548000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<144.399000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.891000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.891000,0.000000,66.548000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.891000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,66.675000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.161000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,66.675000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,67.818000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,67.564000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.621000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,67.437000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.494000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,71.374000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,71.374000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,71.501000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.621000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,71.501000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.589000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,67.437000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.589000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,66.675000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<140.589000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,71.501000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.589000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.970000,0.000000,70.993000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.589000,0.000000,70.993000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,70.739000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.589000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.970000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.970000,0.000000,70.739000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<140.970000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.970000,0.000000,70.485000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.970000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.510000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.510000,0.000000,70.739000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.510000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.510000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.510000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.510000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,70.739000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.240000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.240000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.510000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,70.739000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.240000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.970000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.589000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.970000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.970000,0.000000,70.485000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<140.970000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,70.993000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.589000,0.000000,70.993000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,66.548000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.859000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.589000,0.000000,66.675000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.589000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,66.548000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.351000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,66.548000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,66.548000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.351000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,66.675000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.621000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,66.675000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.859000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,66.802000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.621000,0.000000,66.802000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,66.675000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.129000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.256000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,67.564000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<143.129000,0.000000,67.564000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,67.818000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<142.875000,0.000000,67.818000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.891000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,66.675000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.891000,0.000000,66.548000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.399000,0.000000,66.548000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.891000,0.000000,66.548000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.399000,0.000000,66.675000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.399000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,66.802000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.161000,0.000000,66.802000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,66.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,66.675000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.796000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.701000,0.000000,67.437000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.796000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,67.437000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.256000,0.000000,67.437000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.256000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,70.739000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.161000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,70.739000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,70.739000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<143.129000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,67.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.621000,0.000000,70.739000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.621000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.510000,0.000000,70.485000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.510000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,70.993000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,70.993000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,71.501000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.129000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.510000,0.000000,70.993000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.240000,0.000000,70.993000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.240000,0.000000,70.993000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.129000,0.000000,71.501000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<143.129000,0.000000,71.501000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<146.685000,0.000000,69.215000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<144.145000,0.000000,69.215000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<141.605000,0.000000,69.215000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  Z80_MEMORY(-80.000000,0,-50.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//D1	1N4148	D-2.5
//IC5	NE555	DIL-08
