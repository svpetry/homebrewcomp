//POVRay-Datei erstellt mit 3d41.ulp v1.05
//X:/Sven/Elektronik/Eagle/Z80/Z80_Control.brd
//01.08.2010 08:28:57

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
#declare global_seed=seed(81);
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


#macro Z80_CONTROL(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
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
cylinder{<12.065000,0.095000,59.232800><12.065000,-1.595000,59.232800>1.651000 texture{col_hls}}
cylinder{<12.065000,0.095000,84.277200><12.065000,-1.595000,84.277200>1.651000 texture{col_hls}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Bauteile
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_ELKO_2MM5_6MM3("10µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<25.400000,0.000000,83.820000>}#end		//Elko 2,5mm Pitch, 6mm Durchmesser, 11,2mm Hoehe C1 10µ E2,5-6
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_ELKO_2MM5_6MM3("10µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<25.400000,0.000000,69.215000>}#end		//Elko 2,5mm Pitch, 6mm Durchmesser, 11,2mm Hoehe C2 10µ E2,5-6
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_ELKO_2MM5_6MM3("10µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<25.400000,0.000000,91.440000>}#end		//Elko 2,5mm Pitch, 6mm Durchmesser, 11,2mm Hoehe C3 10µ E2,5-6
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_ELKO_2MM5_6MM3("10µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<25.400000,0.000000,76.200000>}#end		//Elko 2,5mm Pitch, 6mm Durchmesser, 11,2mm Hoehe C4 10µ E2,5-6
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_ELKO_3MM5_8MM("47µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<129.540000,0.000000,72.390000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C5 47µ E3,5-8
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<40.005000,0.000000,51.435000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C6 100n C050-030X075
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<46.990000,0.000000,32.385000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C7 100n C050-025X075
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<116.840000,0.000000,30.480000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C8 100n C050-030X075
#ifndef(pack_C9) #declare global_pack_C9=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<138.430000,0.000000,4.445000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C9 100n C050-030X075
#ifndef(pack_C10) #declare global_pack_C10=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<138.430000,0.000000,30.480000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C10 100n C050-030X075
#ifndef(pack_C11) #declare global_pack_C11=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<96.520000,0.000000,75.565000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C11 100n C050-030X075
#ifndef(pack_C12) #declare global_pack_C12=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<38.100000,0.000000,93.345000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C12 100n C050-030X075
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO35_102MM_H("3V3",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<128.270000,0.000000,88.900000>}#end		//Diode DO35 10mm hor. D1 3V3 DO35Z10
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO35_076MM_H("1N4148",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<127.000000,0.000000,83.820000>}#end		//Diode DO35 7mm hor. D2 1N4148 DO35-7
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP40_W("PIC18F4585","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<58.420000,0.000000,64.770000>translate<0,3.000000,0> }#end		//DIP40 IC1 PIC18F4585 DIL40
#ifndef(pack_IC1) object{SOCKET_DIP40W()rotate<0,-90.000000,0> rotate<0,0,0> translate<58.420000,0.000000,64.770000>}#end					//IC-Sockel 40Pin 600mil IC1 PIC18F4585
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP14("74HC08","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<143.510000,0.000000,74.930000>translate<0,3.000000,0> }#end		//DIP14 IC2 74HC08 DIL14
#ifndef(pack_IC2) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<143.510000,0.000000,74.930000>}#end					//IC-Sockel 14Pin IC2 74HC08
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_DIS_DIP20("74LS373N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,45.085000>translate<0,3.000000,0> }#end		//DIP20 IC3 74LS373N DIL20
#ifndef(pack_IC3) object{SOCKET_DIP20()rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,45.085000>}#end					//IC-Sockel 20Pin IC3 74LS373N
#ifndef(pack_IC4) #declare global_pack_IC4=yes; object {IC_DIS_DIP20("74LS373N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,15.240000>translate<0,3.000000,0> }#end		//DIP20 IC4 74LS373N DIL20
#ifndef(pack_IC4) object{SOCKET_DIP20()rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,15.240000>}#end					//IC-Sockel 20Pin IC4 74LS373N
#ifndef(pack_IC16) #declare global_pack_IC16=yes; object {IC_DIS_DIP16("MAX232","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<38.100000,0.000000,80.010000>translate<0,3.000000,0> }#end		//DIP16 IC16 MAX232 DIL16
#ifndef(pack_IC16) object{SOCKET_DIP16()rotate<0,-270.000000,0> rotate<0,0,0> translate<38.100000,0.000000,80.010000>}#end					//IC-Sockel 16Pin IC16 MAX232
#ifndef(pack_IC19) #declare global_pack_IC19=yes; object {IC_DIS_DIP14("74LS08","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<116.840000,0.000000,43.180000>translate<0,3.000000,0> }#end		//DIP14 IC19 74LS08 DIL14
#ifndef(pack_IC19) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<116.840000,0.000000,43.180000>}#end					//IC-Sockel 14Pin IC19 74LS08
#ifndef(pack_IC24) #declare global_pack_IC24=yes; object {IC_DIS_DIP14("74LS74N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<138.430000,0.000000,43.180000>translate<0,3.000000,0> }#end		//DIP14 IC24 74LS74N DIL14
#ifndef(pack_IC24) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<138.430000,0.000000,43.180000>}#end					//IC-Sockel 14Pin IC24 74LS74N
#ifndef(pack_IC27) #declare global_pack_IC27=yes; object {IC_DIS_DIP14("74LS00N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<138.430000,0.000000,15.240000>translate<0,3.000000,0> }#end		//DIP14 IC27 74LS00N DIL14
#ifndef(pack_IC27) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<138.430000,0.000000,15.240000>}#end					//IC-Sockel 14Pin IC27 74LS00N
#ifndef(pack_IC29) #declare global_pack_IC29=yes; object {IC_DIS_DIP14("74F04N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<116.840000,0.000000,15.240000>translate<0,3.000000,0> }#end		//DIP14 IC29 74F04N DIL14
#ifndef(pack_IC29) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<116.840000,0.000000,15.240000>}#end					//IC-Sockel 14Pin IC29 74F04N
#ifndef(pack_IC31) #declare global_pack_IC31=yes; object {IC_DIS_DIP20("74LS245N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<46.990000,0.000000,15.240000>translate<0,3.000000,0> }#end		//DIP20 IC31 74LS245N DIL20
#ifndef(pack_IC31) object{SOCKET_DIP20()rotate<0,-270.000000,0> rotate<0,0,0> translate<46.990000,0.000000,15.240000>}#end					//IC-Sockel 20Pin IC31 74LS245N
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<95.250000,0.000000,46.990000>}#end		//Diskrete 5MM LED LED1 PIC memwr LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Yellow,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<119.380000,0.000000,68.580000>}#end		//Diskrete 5MM LED LED2 SD access LED5MM
#ifndef(pack_QG2) #declare global_pack_QG2=yes; object {SPC_XTAL_OSZ_DIP14("66 MHz",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<83.820000,0.000000,74.930000>}#end		//Quarzoszillator im DIP14 QG2 66 MHz DIL14S
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<114.300000,0.000000,88.900000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R2 56 0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<90.170000,0.000000,53.340000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R3 680 0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<133.350000,0.000000,64.770000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R4 1K 0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<148.590000,0.000000,64.770000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R5 1K 0207/10
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<151.765000,0.000000,83.820000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R6 1K 0207/10
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<74.930000,0.000000,83.820000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R7 470 0207/10
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<47.625000,0.000000,86.360000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R8 470 0207/10
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<114.300000,0.000000,83.820000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R9 470 0207/10
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_DIS_0207_10MM(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<114.300000,0.000000,93.980000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R10 3K3 0207/10
#ifndef(pack_R15) #declare global_pack_R15=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<109.220000,0.000000,73.660000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R15 680 0207/10
#ifndef(pack_SL1) #declare global_pack_SL1=yes; object {PH_1X16()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<7.620000,0.000000,25.400000>}#end		//Stiftleiste 2,54mm Raster 16Pin 1Reihe (pinhead.lib) SL1 address bus 16P
#ifndef(pack_SL2) #declare global_pack_SL2=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<45.720000,0.000000,49.530000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL2 data bus 08P
#ifndef(pack_SL3) #declare global_pack_SL3=yes; object {PH_1X10()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<81.280000,0.000000,52.070000>}#end		//Stiftleiste 2,54mm Raster 10Pin 1Reihe (pinhead.lib) SL3 control bus 10P
#ifndef(pack_SL4) #declare global_pack_SL4=yes; object {PH_1X6()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<82.550000,0.000000,93.980000>}#end		//Stiftleiste 2,54mm Raster 6Pin 1Reihe (pinhead.lib) SL4 keyboard 06P
#ifndef(pack_SL5) #declare global_pack_SL5=yes; object {PH_1X7()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<143.510000,0.000000,93.980000>}#end		//Stiftleiste 2,54mm Raster 7Pin 1Reihe (pinhead.lib) SL5 sd card 07P
#ifndef(pack_SL6) #declare global_pack_SL6=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<95.250000,0.000000,31.750000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL6  03P
#ifndef(pack_T1) #declare global_pack_T1=yes; object {TR_TO92_L("BC337",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<123.190000,0.000000,77.470000>}#end		//TO92 gerade stehend T1 BC337 TO92-EBC
#ifndef(pack_X1) #declare global_pack_X1=yes; object {CON_DSUB_F9()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<12.065000,0.000000,71.755000>}#end		//SUB-D 9polig 90 Grad weiblich X1 RS232 F09HP
}//End union
#end
#if(pcb_pads_smds=on)
//Lötaugen&SMD/Bauteile
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<24.130000,0,69.215000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<26.670000,0,69.215000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<24.130000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<26.670000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<129.540000,0,74.168000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<129.540000,0,70.612000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<40.005000,0,53.975000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<40.005000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<44.450000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<49.530000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<119.380000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<114.300000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<135.890000,0,4.445000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<140.970000,0,4.445000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<135.890000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<140.970000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,73.025000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<96.520000,0,78.105000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<40.640000,0,93.345000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<35.560000,0,93.345000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<123.190000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<133.350000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<123.190000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.810000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<66.040000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<50.800000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<135.890000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<151.130000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<148.590000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<146.050000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<143.510000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<140.970000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<138.430000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<135.890000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,56.515000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,53.975000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,51.435000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,46.355000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,43.815000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,41.275000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,38.735000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,36.195000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,33.655000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,33.655000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,36.195000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,38.735000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,41.275000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,43.815000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,46.355000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,51.435000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,53.975000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,56.515000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<34.290000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<41.910000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_IC24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<142.240000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<134.620000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.650000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC29) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<113.030000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<43.180000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC31) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<50.800000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<95.250000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<95.250000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<120.650000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<118.110000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<91.440000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<76.200000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<76.200000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_QG2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<91.440000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<119.380000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<109.220000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<85.090000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<95.250000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<138.430000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<128.270000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<143.510000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<153.670000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<146.685000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<156.845000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<69.850000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<80.010000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<47.625000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<47.625000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<109.220000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<119.380000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<109.220000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<119.380000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<109.220000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<109.220000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<7.620000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<45.720000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<88.900000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<86.360000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<83.820000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<81.280000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<78.740000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<76.200000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<151.130000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<148.590000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<146.050000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<143.510000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<140.970000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<138.430000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<135.890000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<123.190000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<120.650000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<125.730000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<13.335000,0,66.268600> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<13.335000,0,69.011800> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<13.335000,0,71.755000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<13.335000,0,74.498200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<13.335000,0,77.241400> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<10.795000,0,67.640200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<10.795000,0,70.383400> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<10.795000,0,73.126600> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<10.795000,0,75.869800> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(5.080000,3.302000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<12.065000,0,59.232800> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(5.080000,3.302000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<12.065000,0,84.277200> texture{col_thl}}
//Lötaugen/Durchkontaktierungen
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<12.700000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<12.700000,0,55.245000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<102.235000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<88.900000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<102.870000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<102.870000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<106.045000,0,58.420000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<106.045000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<71.120000,0,45.085000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<71.120000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<69.850000,0,81.280000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<109.220000,0,81.280000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<120.650000,0,81.915000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<146.685000,0,81.915000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<12.065000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<12.065000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<35.560000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<35.560000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<37.465000,0,6.350000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<37.465000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<40.640000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<40.640000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<39.370000,0,6.350000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<39.370000,0,27.305000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<68.580000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<53.340000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<72.390000,0,38.735000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<99.060000,0,38.735000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<126.365000,0,14.605000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<126.365000,0,26.035000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<123.825000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<123.825000,0,43.180000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<38.735000,0,34.925000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<66.040000,0,34.925000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<98.425000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<98.425000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<13.970000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<13.970000,0,47.625000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<53.340000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<60.960000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<17.780000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<17.780000,0,48.895000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<59.690000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<53.340000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<15.875000,0,38.735000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<15.875000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<19.050000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<19.050000,0,39.370000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<31.750000,0,9.525000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<31.750000,0,37.465000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<31.750000,0,64.135000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<31.750000,0,39.370000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,41.275000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.020000,0,45.720000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<34.925000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<34.925000,0,48.895000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<36.830000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<36.830000,0,51.435000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<71.120000,0,90.805000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<143.510000,0,90.805000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<99.695000,0,50.800000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<99.695000,0,73.025000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<130.810000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<130.810000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<95.250000,0,37.465000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<41.910000,0,37.465000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<33.655000,0,56.515000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.514400,0.600000,1,16,2,0) translate<40.640000,0,56.515000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<17.780000,0,61.595000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<17.780000,0,81.280000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signale
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,22.860000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,90.000000,0> translate<2.540000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,43.180000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<2.540000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<3.810000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<3.810000,-1.535000,41.910000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<3.810000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,17.780000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<5.080000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<2.540000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,26.670000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<2.540000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<3.810000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,29.210000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<3.810000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,40.640000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,90.000000,0> translate<5.080000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<3.810000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<3.810000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,11.430000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<5.080000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,17.780000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.080000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,31.750000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<5.080000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,6.350000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<2.540000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,11.430000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.715000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,26.670000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.080000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.080000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,29.210000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.080000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.715000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,46.355000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.255000,-1.535000,70.485000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.255000,-1.535000,73.025000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<8.255000,-1.535000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.525000,-1.535000,22.860000>}
box{<0,0,-0.203200><4.445000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.080000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.525000,-1.535000,40.640000>}
box{<0,0,-0.203200><4.445000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.080000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.525000,-1.535000,43.180000>}
box{<0,0,-0.203200><4.445000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.080000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.255000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.728200,-1.535000,74.498200>}
box{<0,0,-0.304800><2.083419,0.035000,0.304800> rotate<0,-44.997030,0> translate<8.255000,-1.535000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.715000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160000,-1.535000,17.780000>}
box{<0,0,-0.203200><4.445000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.715000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<10.160000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.255000,-1.535000,70.485000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.490200,-1.535000,67.945000>}
box{<0,0,-0.304800><3.383448,0.035000,0.304800> rotate<0,48.649012,0> translate<8.255000,-1.535000,70.485000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.490200,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,67.640200>}
box{<0,0,-0.304800><0.431052,0.035000,0.304800> rotate<0,44.997030,0> translate<10.490200,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,70.383400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,73.126600>}
box{<0,0,-0.304800><2.743200,0.035000,0.304800> rotate<0,90.000000,0> translate<10.795000,-1.535000,73.126600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,67.640200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.963400,-1.535000,67.640200>}
box{<0,0,-0.304800><1.168400,0.035000,0.304800> rotate<0,0.000000,0> translate<10.795000,-1.535000,67.640200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.065000,-1.535000,8.890000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.065000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.065000,0.000000,20.320000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.065000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.525000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.525000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,0.000000,55.245000>}
box{<0,0,-0.304800><28.575000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,41.910000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.540000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,53.975000>}
box{<0,0,-0.304800><15.266435,0.035000,0.304800> rotate<0,-44.997030,0> translate<2.540000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.963400,-1.535000,67.640200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,66.268600>}
box{<0,0,-0.304800><1.939735,0.035000,0.304800> rotate<0,44.997030,0> translate<11.963400,-1.535000,67.640200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,69.011800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,69.215000>}
box{<0,0,-0.304800><0.203200,0.035000,0.304800> rotate<0,90.000000,0> translate<13.335000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.728200,-1.535000,74.498200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,74.498200>}
box{<0,0,-0.304800><3.606800,0.035000,0.304800> rotate<0,0.000000,0> translate<9.728200,-1.535000,74.498200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,7.620000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<13.970000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<11.430000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.525000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,40.640000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.525000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,0.000000,47.625000>}
box{<0,0,-0.304800><26.035000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.970000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,52.705000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<7.620000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,-1.535000,17.780000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,-1.535000,24.130000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,-1.535000,39.370000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,6.350000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<13.970000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,8.255000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<15.240000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.795000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,12.065000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<10.795000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,19.050000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.160000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.525000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,22.860000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.525000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,34.290000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,7.620000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<15.240000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,13.335000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<15.875000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.065000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.065000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,21.590000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<13.970000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,25.400000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.605000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,36.830000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,0.000000,38.735000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.875000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,46.355000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<12.700000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,24.130000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,37.465000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.875000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,45.085000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.335000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,55.245000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,55.245000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.875000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,36.195000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,43.815000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.970000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,11.430000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<15.875000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,42.545000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.605000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,0.000000,48.895000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,51.435000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.970000,-1.535000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,55.245000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,56.515000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<16.510000,-1.535000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,0.000000,81.280000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,95.885000>}
box{<0,0,-0.711200><14.605000,0.035000,0.711200> rotate<0,90.000000,0> translate<17.780000,-1.535000,95.885000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,-1.535000,13.970000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<14.605000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,-1.535000,41.275000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.875000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,15.240000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<15.240000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.145000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,38.735000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<19.050000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,0.000000,39.370000>}
box{<0,0,-0.304800><30.480000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,65.405000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<19.050000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,69.215000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<13.335000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<15.875000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<17.780000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,21.590000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<19.050000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,66.675000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<20.320000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,71.755000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<13.335000,-1.535000,71.755000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,6.350000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.240000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,8.890000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.050000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.415000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.685000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.685000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,21.590000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,24.130000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<16.510000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,26.670000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.700000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,36.195000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.145000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,38.735000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.050000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,41.275000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.415000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,43.815000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.145000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,46.355000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.875000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,48.895000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,51.435000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.335000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,53.975000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<13.335000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,56.515000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.225000,-1.535000,24.130000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.495000,-1.535000,6.350000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.495000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.225000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.495000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<22.225000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,7.620000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.875000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,13.970000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,15.240000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.050000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,52.705000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<13.970000,-1.535000,52.705000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<24.130000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,91.440000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<24.130000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.495000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.765000,-1.535000,5.080000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<23.495000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,6.350000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<24.130000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<24.130000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,37.465000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<16.510000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,42.545000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,45.085000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<16.510000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,53.975000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.130000,-1.535000,52.705000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<24.130000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,15.240000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,-33.687844,0> translate<24.130000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,-33.687844,0> translate<24.130000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,-33.687844,0> translate<24.130000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,81.915000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<24.130000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,10.160000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,36.195000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<25.400000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,43.815000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<25.400000,-1.535000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,46.355000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<25.400000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,80.010000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.130000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,7.620000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<26.670000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.495000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,12.700000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<23.495000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,48.895000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<26.670000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,52.705000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,11.430000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,25.400000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.875000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,6.350000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,11.430000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.035000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,24.130000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<27.940000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,29.210000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,90.000000,0> translate<29.210000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,36.195000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,43.815000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,46.355000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,48.895000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,53.975000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,61.595000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,61.595000>}
box{<0,0,-0.711200><11.430000,0.035000,0.711200> rotate<0,0.000000,0> translate<17.780000,-1.535000,61.595000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,61.595000>}
box{<0,0,-0.711200><5.080000,0.035000,0.711200> rotate<0,90.000000,0> translate<29.210000,-1.535000,61.595000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,66.675000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,65.405000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.050000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,71.755000>}
box{<0,0,-0.304800><4.065984,0.035000,0.304800> rotate<0,-38.657257,0> translate<26.670000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,76.200000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.845000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,24.130000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.495000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,22.860000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<23.495000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,81.915000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.035000,-1.535000,81.915000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,9.525000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.115000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,0.000000,37.465000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,38.735000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,38.735000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,39.370000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,0.000000,64.135000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,80.010000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,82.550000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.115000,-1.535000,81.915000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,88.900000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.670000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.385000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,41.275000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,41.275000>}
box{<0,0,-0.304800><29.845000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,45.720000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,60.960000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,62.865000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.750000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,87.630000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<31.750000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,17.780000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.035000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,27.305000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.480000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<33.655000,-1.535000,56.515000>}
box{<0,0,-0.711200><4.445000,0.035000,0.711200> rotate<0,0.000000,0> translate<29.210000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.750000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,26.035000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.115000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,76.200000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.845000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,78.740000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,86.360000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<31.750000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,15.240000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.035000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,20.955000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<33.020000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.385000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,22.860000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<32.385000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,48.895000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,0.000000,48.895000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,90.000000,0> translate<34.925000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.765000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,5.080000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.765000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,9.525000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.750000,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,13.970000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,52.705000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,52.705000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,61.976000>}
box{<0,0,-0.304800><9.271000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,-1.535000,61.976000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,61.976000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.814000,-1.535000,62.357000>}
box{<0,0,-0.304800><0.457905,0.035000,0.304800> rotate<0,-56.306216,0> translate<35.560000,-1.535000,61.976000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,10.160000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.560000,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.814000,-1.535000,62.357000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,62.865000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-53.126596,0> translate<35.814000,-1.535000,62.357000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,64.770000>}
box{<0,0,-0.304800><3.702654,0.035000,0.304800> rotate<0,-30.961713,0> translate<33.020000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.290000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,51.435000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,0.000000,51.435000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.830000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,61.595000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.830000,-1.535000,61.595000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,69.850000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,-22.618372,0> translate<29.210000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,81.280000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<36.830000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.290000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<36.830000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,87.630000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,6.350000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,10.160000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.195000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,0.000000,13.970000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<37.465000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<33.655000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,26.035000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.290000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,33.655000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.560000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,20.320000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<34.290000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,82.550000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.750000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,82.550000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<38.100000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,-1.535000,19.050000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<34.925000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,-1.535000,34.925000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<37.465000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,3.810000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,0.000000,6.350000>}
box{<0,0,-0.304800><20.955000,0.035000,0.304800> rotate<0,-90.000000,0> translate<39.370000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<37.465000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,27.305000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.655000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,69.215000>}
box{<0,0,-0.304800><10.258739,0.035000,0.304800> rotate<0,-21.799971,0> translate<29.845000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,80.010000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,5.080000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<39.370000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,0.000000,8.890000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,-90.000000,0> translate<40.640000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,20.320000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,0.000000,56.515000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.655000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<40.640000,-1.535000,95.885000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<40.640000,-1.535000,93.345000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<40.640000,-1.535000,93.345000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,95.885000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<40.640000,-1.535000,95.885000>}
box{<0,0,-0.711200><22.860000,0.035000,0.711200> rotate<0,0.000000,0> translate<17.780000,-1.535000,95.885000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,29.210000>}
box{<0,0,-0.711200><12.700000,0.035000,0.711200> rotate<0,0.000000,0> translate<29.210000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,32.385000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,90.000000,0> translate<41.910000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,37.465000>}
box{<0,0,-0.711200><5.080000,0.035000,0.711200> rotate<0,90.000000,0> translate<41.910000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<40.005000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,53.975000>}
box{<0,0,-0.711200><1.905000,0.035000,0.711200> rotate<0,0.000000,0> translate<40.005000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,53.975000>}
box{<0,0,-0.711200><16.510000,0.035000,0.711200> rotate<0,90.000000,0> translate<41.910000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,56.515000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,56.515000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,90.000000,0> translate<41.910000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,59.690000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,90.000000,0> translate<41.910000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,81.280000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<41.910000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<41.910000,-1.535000,88.900000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,-90.000000,0> translate<41.910000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<41.910000,-1.535000,93.345000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,0.000000,0> translate<40.640000,-1.535000,93.345000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,6.350000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,8.890000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,13.970000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<37.465000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,19.050000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.735000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<37.465000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,24.130000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<43.180000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<43.180000,-1.535000,26.670000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<43.180000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<43.180000,-1.535000,29.210000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,0.000000,0> translate<41.910000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<43.180000,-1.535000,60.960000>}
box{<0,0,-0.711200><1.796051,0.035000,0.711200> rotate<0,-44.997030,0> translate<41.910000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<41.910000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<44.450000,-1.535000,32.385000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<41.910000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,76.200000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,80.010000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,61.595000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,66.040000>}
box{<0,0,-0.304800><9.939322,0.035000,0.304800> rotate<0,-26.563298,0> translate<36.830000,-1.535000,61.595000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<44.450000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,96.520000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,7.620000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,10.160000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<37.465000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,12.700000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.925000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,22.860000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.925000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,76.200000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<43.815000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,64.135000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,71.120000>}
box{<0,0,-0.304800><16.764481,0.035000,0.304800> rotate<0,-24.621940,0> translate<31.750000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,6.350000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.180000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.355000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,11.430000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.355000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.355000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,21.590000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<46.355000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,68.580000>}
box{<0,0,-0.304800><12.779128,0.035000,0.304800> rotate<0,-26.563298,0> translate<36.195000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,98.425000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.720000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,13.970000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,17.145000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,7.620000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<47.625000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,17.780000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<48.260000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,83.820000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,44.997030,0> translate<45.720000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,73.660000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.990000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.195000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,71.120000>}
box{<0,0,-0.304800><15.345468,0.035000,0.304800> rotate<0,-24.442342,0> translate<36.195000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,8.890000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,13.970000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,21.590000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.800000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.800000,-1.535000,26.670000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<50.800000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<43.180000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.800000,-1.535000,29.210000>}
box{<0,0,-0.711200><7.620000,0.035000,0.711200> rotate<0,0.000000,0> translate<43.180000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,40.640000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,43.180000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,45.720000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,48.260000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,50.800000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,53.340000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,55.880000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,58.420000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<43.180000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.800000,-1.535000,60.960000>}
box{<0,0,-0.711200><7.620000,0.035000,0.711200> rotate<0,0.000000,0> translate<43.180000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,66.040000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,71.120000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.165000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<49.530000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,76.200000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.355000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,81.280000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.895000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,24.130000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,74.930000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,78.740000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,88.900000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,17.780000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.895000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<54.610000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,85.090000>}
box{<0,0,-0.304800><67.310000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,16.510000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,86.995000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<55.245000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,86.995000>}
box{<0,0,-0.304800><70.485000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,0.000000,19.050000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,86.995000>}
box{<0,0,-0.304800><67.945000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,21.590000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,84.455000>}
box{<0,0,-0.304800><62.865000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,84.455000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,-1.535000,88.900000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.690000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,84.455000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.960000,-1.535000,84.455000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,45.720000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.735000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,0.000000,34.925000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.735000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,36.830000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<63.500000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,36.830000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.865000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,88.900000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<61.595000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,24.130000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,19.050000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<69.215000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,23.495000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<68.580000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,76.200000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,81.280000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,40.640000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,43.180000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,78.740000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,91.440000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,55.880000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,58.420000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,60.960000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,73.660000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,0.000000,73.660000>}
box{<0,0,-0.304800><28.575000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,90.805000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<70.485000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,-1.535000,53.340000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,38.735000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<70.485000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,46.990000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.485000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,86.995000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.295000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,36.830000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,48.260000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,40.640000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,81.915000>}
box{<0,0,-0.304800><8.082231,0.035000,0.304800> rotate<0,-44.997030,0> translate<69.850000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,86.360000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<75.565000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,63.500000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,71.120000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<74.930000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,43.180000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<74.295000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,46.990000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<71.755000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,65.405000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<76.200000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,46.990000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.105000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,48.260000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,50.800000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,53.340000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,91.440000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<74.295000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,93.980000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<78.740000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,83.820000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<80.010000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,90.805000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<75.565000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,90.805000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,96.520000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<80.010000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,40.640000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.105000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<77.470000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,53.340000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-1.535000,93.980000>}
box{<0,0,-0.635000><6.985000,0.035000,0.635000> rotate<0,90.000000,0> translate<81.280000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,67.945000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<80.010000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<82.550000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,96.520000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.010000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.740000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<83.820000,-1.535000,46.990000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<78.740000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,53.340000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,24.765000>}
box{<0,0,-0.304800><17.062487,0.035000,0.304800> rotate<0,44.997030,0> translate<74.930000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,26.035000>}
box{<0,0,-0.304800><24.246692,0.035000,0.304800> rotate<0,44.997030,0> translate<70.485000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,41.910000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<83.820000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,91.440000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<82.550000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,93.980000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<88.900000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,34.290000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,-90.000000,0> translate<95.250000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,36.830000>}
box{<0,0,-0.711200><0.635000,0.035000,0.711200> rotate<0,-90.000000,0> translate<95.250000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,0.000000,37.465000>}
box{<0,0,-0.304800><53.340000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,43.815000>}
box{<0,0,-0.711200><6.350000,0.035000,0.711200> rotate<0,90.000000,0> translate<95.250000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<95.250000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<95.250000,-1.535000,45.720000>}
box{<0,0,-0.406400><0.635000,0.035000,0.406400> rotate<0,90.000000,0> translate<95.250000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,53.340000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.885000,-1.535000,44.450000>}
box{<0,0,-0.711200><0.898026,0.035000,0.711200> rotate<0,-44.997030,0> translate<95.250000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.885000,-1.535000,44.450000>}
box{<0,0,-0.711200><0.898026,0.035000,0.711200> rotate<0,44.997030,0> translate<95.250000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.250000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<96.520000,-1.535000,35.560000>}
box{<0,0,-0.711200><1.796051,0.035000,0.711200> rotate<0,44.997030,0> translate<95.250000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<91.440000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<96.520000,-1.535000,73.025000>}
box{<0,0,-0.711200><5.425442,0.035000,0.711200> rotate<0,-20.554689,0> translate<91.440000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,5.080000>}
box{<0,0,-0.304800><57.785000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,0.000000,22.860000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,90.000000,0> translate<98.425000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,0.000000,38.735000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.390000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,43.180000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<99.060000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,7.620000>}
box{<0,0,-0.304800><50.800000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.895000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<95.885000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,48.260000>}
box{<0,0,-0.711200><5.388154,0.035000,0.711200> rotate<0,-44.997030,0> translate<95.885000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,50.800000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,90.000000,0> translate<99.695000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<96.520000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,73.025000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,0.000000,0> translate<96.520000,-1.535000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<99.695000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<99.695000,0.000000,73.025000>}
box{<0,0,-0.635000><22.225000,0.035000,0.635000> rotate<0,90.000000,0> translate<99.695000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<81.280000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,86.995000>}
box{<0,0,-0.711200><18.415000,0.035000,0.711200> rotate<0,0.000000,0> translate<81.280000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,86.995000>}
box{<0,0,-0.711200><13.970000,0.035000,0.711200> rotate<0,90.000000,0> translate<99.695000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,45.085000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<99.060000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<99.695000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<101.600000,-1.535000,88.900000>}
box{<0,0,-0.711200><2.694077,0.035000,0.711200> rotate<0,-44.997030,0> translate<99.695000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,0.000000,41.910000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,60.960000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,0.000000,60.960000>}
box{<0,0,-0.304800><52.070000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,65.405000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.105000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,3.175000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<99.695000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,67.945000>}
box{<0,0,-0.304800><23.495000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.915000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,-1.535000,58.420000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,0.000000,58.420000>}
box{<0,0,-0.304800><43.180000,0.035000,0.304800> rotate<0,90.000000,0> translate<106.045000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,55.880000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,65.405000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<105.410000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,45.085000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.965000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,98.425000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,98.425000>}
box{<0,0,-0.304800><60.960000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.625000,-1.535000,98.425000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,59.690000>}
box{<0,0,-0.304800><8.082231,0.035000,0.304800> rotate<0,44.997030,0> translate<103.505000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<109.220000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,0.000000,81.280000>}
box{<0,0,-0.304800><39.370000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<109.220000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<101.600000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<109.220000,-1.535000,88.900000>}
box{<0,0,-0.711200><7.620000,0.035000,0.711200> rotate<0,0.000000,0> translate<101.600000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,93.980000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<109.220000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,98.425000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,97.790000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<108.585000,-1.535000,98.425000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<108.585000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<113.030000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<113.030000,-1.535000,7.620000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<113.030000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,15.240000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<106.045000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,22.860000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,0.000000,0> translate<98.425000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<113.030000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<113.030000,-1.535000,33.020000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<113.030000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<96.520000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<113.030000,-1.535000,35.560000>}
box{<0,0,-0.711200><16.510000,0.035000,0.711200> rotate<0,0.000000,0> translate<96.520000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,50.800000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<107.950000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.935000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.030000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.935000,-1.535000,24.765000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.995000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,8.890000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,12.700000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.030000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.935000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,20.955000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<114.935000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,20.955000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,-90.000000,0> translate<115.570000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.935000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,24.130000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<114.935000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.205000,-1.535000,10.160000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.030000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.205000,-1.535000,19.050000>}
box{<0,0,-0.304800><46.990000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.215000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,7.620000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<115.570000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<115.570000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,17.780000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.030000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,21.590000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<116.840000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,26.035000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.030000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,48.260000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.030000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.205000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<116.205000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.205000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<116.205000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<116.840000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<116.840000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,49.530000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<116.840000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,68.580000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.220000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<119.380000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<119.380000,-1.535000,30.480000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<119.380000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<113.030000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<119.380000,-1.535000,33.020000>}
box{<0,0,-0.711200><6.350000,0.035000,0.711200> rotate<0,0.000000,0> translate<113.030000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<109.220000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<119.380000,-1.535000,78.740000>}
box{<0,0,-0.711200><14.368410,0.035000,0.711200> rotate<0,44.997030,0> translate<109.220000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,83.185000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,83.820000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<119.380000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,7.620000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<117.475000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,68.580000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,-90.000000,0> translate<120.650000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<119.380000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<120.650000,-1.535000,78.740000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,0.000000,0> translate<119.380000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,83.185000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,81.915000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<119.380000,-1.535000,83.185000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,17.780000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.650000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,44.450000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<121.920000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<123.190000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,21.590000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,83.820000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.190000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,85.090000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<119.380000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,85.090000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.190000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,15.240000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.650000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,0.000000,43.180000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.825000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,46.990000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<110.490000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,65.405000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.950000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.840000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,13.970000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<116.840000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,41.910000>}
box{<0,0,-0.304800><23.495000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.235000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,-33.687844,0> translate<123.825000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,93.980000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<119.380000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,93.980000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,90.000000,0> translate<125.730000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,14.605000>}
box{<0,0,-0.304800><1.419903,0.035000,0.304800> rotate<0,-26.563298,0> translate<125.095000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,0.000000,26.035000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<126.365000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,27.305000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<126.365000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,46.990000>}
box{<0,0,-0.304800><4.579050,0.035000,0.304800> rotate<0,-33.687844,0> translate<122.555000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<124.460000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<126.365000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,10.160000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.650000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,12.700000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.650000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<126.365000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.905000,-1.535000,16.510000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,38.100000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<125.730000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<125.730000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<129.540000,-1.535000,78.740000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,0.000000,0> translate<125.730000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<129.540000,-1.535000,74.168000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<129.540000,-1.535000,78.740000>}
box{<0,0,-0.711200><4.572000,0.035000,0.711200> rotate<0,90.000000,0> translate<129.540000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<113.030000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,5.080000>}
box{<0,0,-0.635000><17.780000,0.035000,0.635000> rotate<0,0.000000,0> translate<113.030000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,0.000000,5.080000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,-90.000000,0> translate<130.810000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,13.970000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<127.000000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<127.000000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<119.380000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<130.810000,-1.535000,33.020000>}
box{<0,0,-0.711200><11.430000,0.035000,0.711200> rotate<0,0.000000,0> translate<119.380000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.905000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.445000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<128.905000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,49.530000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,72.390000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.635000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<132.080000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<130.810000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,88.900000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<133.350000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,3.175000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,3.175000>}
box{<0,0,-0.304800><29.845000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,3.175000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,59.690000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.220000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,3.175000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,2.540000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<133.985000,-1.535000,3.175000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<130.810000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<134.620000,-1.535000,5.080000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,0.000000,0> translate<130.810000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<134.620000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<134.620000,-1.535000,7.620000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<134.620000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<134.620000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<134.620000,-1.535000,31.750000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,-90.000000,0> translate<134.620000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<130.810000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<134.620000,-1.535000,33.020000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,0.000000,0> translate<130.810000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<134.620000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<134.620000,-1.535000,33.655000>}
box{<0,0,-0.711200><1.905000,0.035000,0.711200> rotate<0,-90.000000,0> translate<134.620000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<134.620000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<134.620000,-1.535000,35.560000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<134.620000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,38.100000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,43.180000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<123.825000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.730000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,48.260000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<125.730000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<133.350000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,33.020000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<134.620000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<134.620000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<135.890000,-1.535000,4.445000>}
box{<0,0,-0.635000><1.419903,0.035000,0.635000> rotate<0,26.563298,0> translate<134.620000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,13.970000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<130.810000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<134.620000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<135.890000,-1.535000,30.480000>}
box{<0,0,-0.711200><1.796051,0.035000,0.711200> rotate<0,44.997030,0> translate<134.620000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<133.350000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<129.540000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<135.890000,-1.535000,78.740000>}
box{<0,0,-0.711200><6.350000,0.035000,0.711200> rotate<0,0.000000,0> translate<129.540000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<135.890000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<135.890000,-1.535000,85.725000>}
box{<0,0,-0.406400><6.985000,0.035000,0.406400> rotate<0,90.000000,0> translate<135.890000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,93.980000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.890000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,97.790000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,97.790000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.220000,-1.535000,97.790000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<130.810000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.445000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,19.050000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<131.445000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,8.890000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<117.475000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<137.160000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<137.160000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,2.540000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,7.620000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<137.795000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,38.100000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,46.990000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,0.000000,0> translate<126.365000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,64.770000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<138.430000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,21.590000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<136.525000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,49.530000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<139.065000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,54.610000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<133.985000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<139.700000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,17.780000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<135.890000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.700000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<138.430000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,73.660000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.700000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<135.890000,-1.535000,85.725000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<139.700000,-1.535000,89.535000>}
box{<0,0,-0.406400><5.388154,0.035000,0.406400> rotate<0,-44.997030,0> translate<135.890000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,96.520000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.700000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,16.510000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<139.700000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,20.320000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<136.525000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,35.560000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<137.795000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,12.700000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<137.160000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,38.100000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<139.700000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<140.970000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,93.980000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<140.970000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,7.620000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.795000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,12.700000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.970000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.335000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.335000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,38.100000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.970000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<140.970000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,88.900000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<140.970000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,88.900000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<142.240000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,64.770000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<143.510000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,0.000000,90.805000>}
box{<0,0,-0.304800><72.390000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.120000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,93.980000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<143.510000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,96.520000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,38.100000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.780000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,49.530000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.065000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<143.510000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,71.120000>}
box{<0,0,-0.304800><18.415000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.780000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,90.805000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,89.535000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<143.510000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,10.160000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,10.160000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<145.415000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,13.970000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.700000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.335000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<145.415000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,21.590000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.065000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,33.020000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.255000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,37.465000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<144.780000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,37.465000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<145.415000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.780000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,78.740000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,-90.000000,0> translate<146.050000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,83.820000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.050000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,7.620000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,15.240000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,15.240000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.685000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,27.305000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,0.000000,0> translate<126.365000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,40.640000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.240000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,40.640000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.685000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,0.000000,81.915000>}
box{<0,0,-0.304800><26.035000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.650000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,81.915000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,81.915000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,81.915000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,83.820000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<148.590000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,93.980000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<148.590000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<148.590000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,81.280000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<148.590000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,81.280000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<149.860000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,93.980000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.130000,-1.535000,93.980000> }
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
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,0.635000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.635000,-1.535000,0.000000>}
box{<0,0,-0.152400><0.898026,0.035000,0.152400> rotate<0,44.997030,0> translate<0.000000,-1.535000,0.635000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,99.695000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,0.635000>}
box{<0,0,-0.152400><99.060000,0.035000,0.152400> rotate<0,-90.000000,0> translate<0.000000,-1.535000,0.635000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.000000,-1.535000,99.695000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.635000,-1.535000,100.330000>}
box{<0,0,-0.152400><0.898026,0.035000,0.152400> rotate<0,-44.997030,0> translate<0.000000,-1.535000,99.695000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.635000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.655000,-1.535000,0.000000>}
box{<0,0,-0.152400><160.020000,0.035000,0.152400> rotate<0,0.000000,0> translate<0.635000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<0.635000,-1.535000,100.330000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.655000,-1.535000,100.330000>}
box{<0,0,-0.152400><160.020000,0.035000,0.152400> rotate<0,0.000000,0> translate<0.635000,-1.535000,100.330000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.655000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<160.655000,-1.535000,100.330000>}
box{<0,0,-0.152400><100.330000,0.035000,0.152400> rotate<0,90.000000,0> translate<160.655000,-1.535000,100.330000> }
texture{col_pol}
}
#end
union{
cylinder{<26.670000,0.038000,83.820000><26.670000,-1.538000,83.820000>0.406400}
cylinder{<24.130000,0.038000,83.820000><24.130000,-1.538000,83.820000>0.406400}
cylinder{<24.130000,0.038000,69.215000><24.130000,-1.538000,69.215000>0.406400}
cylinder{<26.670000,0.038000,69.215000><26.670000,-1.538000,69.215000>0.406400}
cylinder{<26.670000,0.038000,91.440000><26.670000,-1.538000,91.440000>0.406400}
cylinder{<24.130000,0.038000,91.440000><24.130000,-1.538000,91.440000>0.406400}
cylinder{<24.130000,0.038000,76.200000><24.130000,-1.538000,76.200000>0.406400}
cylinder{<26.670000,0.038000,76.200000><26.670000,-1.538000,76.200000>0.406400}
cylinder{<129.540000,0.038000,74.168000><129.540000,-1.538000,74.168000>0.406400}
cylinder{<129.540000,0.038000,70.612000><129.540000,-1.538000,70.612000>0.406400}
cylinder{<40.005000,0.038000,53.975000><40.005000,-1.538000,53.975000>0.406400}
cylinder{<40.005000,0.038000,48.895000><40.005000,-1.538000,48.895000>0.406400}
cylinder{<44.450000,0.038000,32.385000><44.450000,-1.538000,32.385000>0.406400}
cylinder{<49.530000,0.038000,32.385000><49.530000,-1.538000,32.385000>0.406400}
cylinder{<119.380000,0.038000,30.480000><119.380000,-1.538000,30.480000>0.406400}
cylinder{<114.300000,0.038000,30.480000><114.300000,-1.538000,30.480000>0.406400}
cylinder{<135.890000,0.038000,4.445000><135.890000,-1.538000,4.445000>0.406400}
cylinder{<140.970000,0.038000,4.445000><140.970000,-1.538000,4.445000>0.406400}
cylinder{<135.890000,0.038000,30.480000><135.890000,-1.538000,30.480000>0.406400}
cylinder{<140.970000,0.038000,30.480000><140.970000,-1.538000,30.480000>0.406400}
cylinder{<96.520000,0.038000,73.025000><96.520000,-1.538000,73.025000>0.406400}
cylinder{<96.520000,0.038000,78.105000><96.520000,-1.538000,78.105000>0.406400}
cylinder{<40.640000,0.038000,93.345000><40.640000,-1.538000,93.345000>0.406400}
cylinder{<35.560000,0.038000,93.345000><35.560000,-1.538000,93.345000>0.406400}
cylinder{<123.190000,0.038000,88.900000><123.190000,-1.538000,88.900000>0.406400}
cylinder{<133.350000,0.038000,88.900000><133.350000,-1.538000,88.900000>0.406400}
cylinder{<123.190000,0.038000,83.820000><123.190000,-1.538000,83.820000>0.406400}
cylinder{<130.810000,0.038000,83.820000><130.810000,-1.538000,83.820000>0.406400}
cylinder{<66.040000,0.038000,40.640000><66.040000,-1.538000,40.640000>0.406400}
cylinder{<66.040000,0.038000,43.180000><66.040000,-1.538000,43.180000>0.406400}
cylinder{<66.040000,0.038000,45.720000><66.040000,-1.538000,45.720000>0.406400}
cylinder{<66.040000,0.038000,48.260000><66.040000,-1.538000,48.260000>0.406400}
cylinder{<66.040000,0.038000,50.800000><66.040000,-1.538000,50.800000>0.406400}
cylinder{<66.040000,0.038000,53.340000><66.040000,-1.538000,53.340000>0.406400}
cylinder{<66.040000,0.038000,55.880000><66.040000,-1.538000,55.880000>0.406400}
cylinder{<66.040000,0.038000,58.420000><66.040000,-1.538000,58.420000>0.406400}
cylinder{<66.040000,0.038000,60.960000><66.040000,-1.538000,60.960000>0.406400}
cylinder{<66.040000,0.038000,63.500000><66.040000,-1.538000,63.500000>0.406400}
cylinder{<66.040000,0.038000,66.040000><66.040000,-1.538000,66.040000>0.406400}
cylinder{<66.040000,0.038000,68.580000><66.040000,-1.538000,68.580000>0.406400}
cylinder{<66.040000,0.038000,71.120000><66.040000,-1.538000,71.120000>0.406400}
cylinder{<66.040000,0.038000,73.660000><66.040000,-1.538000,73.660000>0.406400}
cylinder{<66.040000,0.038000,76.200000><66.040000,-1.538000,76.200000>0.406400}
cylinder{<66.040000,0.038000,78.740000><66.040000,-1.538000,78.740000>0.406400}
cylinder{<66.040000,0.038000,81.280000><66.040000,-1.538000,81.280000>0.406400}
cylinder{<66.040000,0.038000,83.820000><66.040000,-1.538000,83.820000>0.406400}
cylinder{<66.040000,0.038000,86.360000><66.040000,-1.538000,86.360000>0.406400}
cylinder{<66.040000,0.038000,88.900000><66.040000,-1.538000,88.900000>0.406400}
cylinder{<50.800000,0.038000,88.900000><50.800000,-1.538000,88.900000>0.406400}
cylinder{<50.800000,0.038000,86.360000><50.800000,-1.538000,86.360000>0.406400}
cylinder{<50.800000,0.038000,83.820000><50.800000,-1.538000,83.820000>0.406400}
cylinder{<50.800000,0.038000,81.280000><50.800000,-1.538000,81.280000>0.406400}
cylinder{<50.800000,0.038000,78.740000><50.800000,-1.538000,78.740000>0.406400}
cylinder{<50.800000,0.038000,76.200000><50.800000,-1.538000,76.200000>0.406400}
cylinder{<50.800000,0.038000,73.660000><50.800000,-1.538000,73.660000>0.406400}
cylinder{<50.800000,0.038000,71.120000><50.800000,-1.538000,71.120000>0.406400}
cylinder{<50.800000,0.038000,68.580000><50.800000,-1.538000,68.580000>0.406400}
cylinder{<50.800000,0.038000,66.040000><50.800000,-1.538000,66.040000>0.406400}
cylinder{<50.800000,0.038000,63.500000><50.800000,-1.538000,63.500000>0.406400}
cylinder{<50.800000,0.038000,60.960000><50.800000,-1.538000,60.960000>0.406400}
cylinder{<50.800000,0.038000,58.420000><50.800000,-1.538000,58.420000>0.406400}
cylinder{<50.800000,0.038000,55.880000><50.800000,-1.538000,55.880000>0.406400}
cylinder{<50.800000,0.038000,53.340000><50.800000,-1.538000,53.340000>0.406400}
cylinder{<50.800000,0.038000,50.800000><50.800000,-1.538000,50.800000>0.406400}
cylinder{<50.800000,0.038000,48.260000><50.800000,-1.538000,48.260000>0.406400}
cylinder{<50.800000,0.038000,45.720000><50.800000,-1.538000,45.720000>0.406400}
cylinder{<50.800000,0.038000,43.180000><50.800000,-1.538000,43.180000>0.406400}
cylinder{<50.800000,0.038000,40.640000><50.800000,-1.538000,40.640000>0.406400}
cylinder{<135.890000,0.038000,71.120000><135.890000,-1.538000,71.120000>0.406400}
cylinder{<138.430000,0.038000,71.120000><138.430000,-1.538000,71.120000>0.406400}
cylinder{<140.970000,0.038000,71.120000><140.970000,-1.538000,71.120000>0.406400}
cylinder{<143.510000,0.038000,71.120000><143.510000,-1.538000,71.120000>0.406400}
cylinder{<146.050000,0.038000,71.120000><146.050000,-1.538000,71.120000>0.406400}
cylinder{<148.590000,0.038000,71.120000><148.590000,-1.538000,71.120000>0.406400}
cylinder{<151.130000,0.038000,71.120000><151.130000,-1.538000,71.120000>0.406400}
cylinder{<151.130000,0.038000,78.740000><151.130000,-1.538000,78.740000>0.406400}
cylinder{<148.590000,0.038000,78.740000><148.590000,-1.538000,78.740000>0.406400}
cylinder{<146.050000,0.038000,78.740000><146.050000,-1.538000,78.740000>0.406400}
cylinder{<143.510000,0.038000,78.740000><143.510000,-1.538000,78.740000>0.406400}
cylinder{<140.970000,0.038000,78.740000><140.970000,-1.538000,78.740000>0.406400}
cylinder{<138.430000,0.038000,78.740000><138.430000,-1.538000,78.740000>0.406400}
cylinder{<135.890000,0.038000,78.740000><135.890000,-1.538000,78.740000>0.406400}
cylinder{<21.590000,0.038000,56.515000><21.590000,-1.538000,56.515000>0.406400}
cylinder{<21.590000,0.038000,53.975000><21.590000,-1.538000,53.975000>0.406400}
cylinder{<21.590000,0.038000,51.435000><21.590000,-1.538000,51.435000>0.406400}
cylinder{<21.590000,0.038000,48.895000><21.590000,-1.538000,48.895000>0.406400}
cylinder{<21.590000,0.038000,46.355000><21.590000,-1.538000,46.355000>0.406400}
cylinder{<21.590000,0.038000,43.815000><21.590000,-1.538000,43.815000>0.406400}
cylinder{<21.590000,0.038000,41.275000><21.590000,-1.538000,41.275000>0.406400}
cylinder{<21.590000,0.038000,38.735000><21.590000,-1.538000,38.735000>0.406400}
cylinder{<21.590000,0.038000,36.195000><21.590000,-1.538000,36.195000>0.406400}
cylinder{<21.590000,0.038000,33.655000><21.590000,-1.538000,33.655000>0.406400}
cylinder{<29.210000,0.038000,33.655000><29.210000,-1.538000,33.655000>0.406400}
cylinder{<29.210000,0.038000,36.195000><29.210000,-1.538000,36.195000>0.406400}
cylinder{<29.210000,0.038000,38.735000><29.210000,-1.538000,38.735000>0.406400}
cylinder{<29.210000,0.038000,41.275000><29.210000,-1.538000,41.275000>0.406400}
cylinder{<29.210000,0.038000,43.815000><29.210000,-1.538000,43.815000>0.406400}
cylinder{<29.210000,0.038000,46.355000><29.210000,-1.538000,46.355000>0.406400}
cylinder{<29.210000,0.038000,48.895000><29.210000,-1.538000,48.895000>0.406400}
cylinder{<29.210000,0.038000,51.435000><29.210000,-1.538000,51.435000>0.406400}
cylinder{<29.210000,0.038000,53.975000><29.210000,-1.538000,53.975000>0.406400}
cylinder{<29.210000,0.038000,56.515000><29.210000,-1.538000,56.515000>0.406400}
cylinder{<21.590000,0.038000,26.670000><21.590000,-1.538000,26.670000>0.406400}
cylinder{<21.590000,0.038000,24.130000><21.590000,-1.538000,24.130000>0.406400}
cylinder{<21.590000,0.038000,21.590000><21.590000,-1.538000,21.590000>0.406400}
cylinder{<21.590000,0.038000,19.050000><21.590000,-1.538000,19.050000>0.406400}
cylinder{<21.590000,0.038000,16.510000><21.590000,-1.538000,16.510000>0.406400}
cylinder{<21.590000,0.038000,13.970000><21.590000,-1.538000,13.970000>0.406400}
cylinder{<21.590000,0.038000,11.430000><21.590000,-1.538000,11.430000>0.406400}
cylinder{<21.590000,0.038000,8.890000><21.590000,-1.538000,8.890000>0.406400}
cylinder{<21.590000,0.038000,6.350000><21.590000,-1.538000,6.350000>0.406400}
cylinder{<21.590000,0.038000,3.810000><21.590000,-1.538000,3.810000>0.406400}
cylinder{<29.210000,0.038000,3.810000><29.210000,-1.538000,3.810000>0.406400}
cylinder{<29.210000,0.038000,6.350000><29.210000,-1.538000,6.350000>0.406400}
cylinder{<29.210000,0.038000,8.890000><29.210000,-1.538000,8.890000>0.406400}
cylinder{<29.210000,0.038000,11.430000><29.210000,-1.538000,11.430000>0.406400}
cylinder{<29.210000,0.038000,13.970000><29.210000,-1.538000,13.970000>0.406400}
cylinder{<29.210000,0.038000,16.510000><29.210000,-1.538000,16.510000>0.406400}
cylinder{<29.210000,0.038000,19.050000><29.210000,-1.538000,19.050000>0.406400}
cylinder{<29.210000,0.038000,21.590000><29.210000,-1.538000,21.590000>0.406400}
cylinder{<29.210000,0.038000,24.130000><29.210000,-1.538000,24.130000>0.406400}
cylinder{<29.210000,0.038000,26.670000><29.210000,-1.538000,26.670000>0.406400}
cylinder{<34.290000,0.038000,88.900000><34.290000,-1.538000,88.900000>0.406400}
cylinder{<34.290000,0.038000,86.360000><34.290000,-1.538000,86.360000>0.406400}
cylinder{<34.290000,0.038000,83.820000><34.290000,-1.538000,83.820000>0.406400}
cylinder{<34.290000,0.038000,81.280000><34.290000,-1.538000,81.280000>0.406400}
cylinder{<34.290000,0.038000,78.740000><34.290000,-1.538000,78.740000>0.406400}
cylinder{<34.290000,0.038000,76.200000><34.290000,-1.538000,76.200000>0.406400}
cylinder{<34.290000,0.038000,73.660000><34.290000,-1.538000,73.660000>0.406400}
cylinder{<34.290000,0.038000,71.120000><34.290000,-1.538000,71.120000>0.406400}
cylinder{<41.910000,0.038000,71.120000><41.910000,-1.538000,71.120000>0.406400}
cylinder{<41.910000,0.038000,73.660000><41.910000,-1.538000,73.660000>0.406400}
cylinder{<41.910000,0.038000,76.200000><41.910000,-1.538000,76.200000>0.406400}
cylinder{<41.910000,0.038000,78.740000><41.910000,-1.538000,78.740000>0.406400}
cylinder{<41.910000,0.038000,81.280000><41.910000,-1.538000,81.280000>0.406400}
cylinder{<41.910000,0.038000,83.820000><41.910000,-1.538000,83.820000>0.406400}
cylinder{<41.910000,0.038000,86.360000><41.910000,-1.538000,86.360000>0.406400}
cylinder{<41.910000,0.038000,88.900000><41.910000,-1.538000,88.900000>0.406400}
cylinder{<120.650000,0.038000,35.560000><120.650000,-1.538000,35.560000>0.406400}
cylinder{<120.650000,0.038000,38.100000><120.650000,-1.538000,38.100000>0.406400}
cylinder{<120.650000,0.038000,40.640000><120.650000,-1.538000,40.640000>0.406400}
cylinder{<120.650000,0.038000,43.180000><120.650000,-1.538000,43.180000>0.406400}
cylinder{<120.650000,0.038000,45.720000><120.650000,-1.538000,45.720000>0.406400}
cylinder{<120.650000,0.038000,48.260000><120.650000,-1.538000,48.260000>0.406400}
cylinder{<120.650000,0.038000,50.800000><120.650000,-1.538000,50.800000>0.406400}
cylinder{<113.030000,0.038000,50.800000><113.030000,-1.538000,50.800000>0.406400}
cylinder{<113.030000,0.038000,48.260000><113.030000,-1.538000,48.260000>0.406400}
cylinder{<113.030000,0.038000,45.720000><113.030000,-1.538000,45.720000>0.406400}
cylinder{<113.030000,0.038000,43.180000><113.030000,-1.538000,43.180000>0.406400}
cylinder{<113.030000,0.038000,40.640000><113.030000,-1.538000,40.640000>0.406400}
cylinder{<113.030000,0.038000,38.100000><113.030000,-1.538000,38.100000>0.406400}
cylinder{<113.030000,0.038000,35.560000><113.030000,-1.538000,35.560000>0.406400}
cylinder{<142.240000,0.038000,35.560000><142.240000,-1.538000,35.560000>0.406400}
cylinder{<142.240000,0.038000,38.100000><142.240000,-1.538000,38.100000>0.406400}
cylinder{<142.240000,0.038000,40.640000><142.240000,-1.538000,40.640000>0.406400}
cylinder{<142.240000,0.038000,43.180000><142.240000,-1.538000,43.180000>0.406400}
cylinder{<142.240000,0.038000,45.720000><142.240000,-1.538000,45.720000>0.406400}
cylinder{<142.240000,0.038000,48.260000><142.240000,-1.538000,48.260000>0.406400}
cylinder{<142.240000,0.038000,50.800000><142.240000,-1.538000,50.800000>0.406400}
cylinder{<134.620000,0.038000,50.800000><134.620000,-1.538000,50.800000>0.406400}
cylinder{<134.620000,0.038000,48.260000><134.620000,-1.538000,48.260000>0.406400}
cylinder{<134.620000,0.038000,45.720000><134.620000,-1.538000,45.720000>0.406400}
cylinder{<134.620000,0.038000,43.180000><134.620000,-1.538000,43.180000>0.406400}
cylinder{<134.620000,0.038000,40.640000><134.620000,-1.538000,40.640000>0.406400}
cylinder{<134.620000,0.038000,38.100000><134.620000,-1.538000,38.100000>0.406400}
cylinder{<134.620000,0.038000,35.560000><134.620000,-1.538000,35.560000>0.406400}
cylinder{<142.240000,0.038000,7.620000><142.240000,-1.538000,7.620000>0.406400}
cylinder{<142.240000,0.038000,10.160000><142.240000,-1.538000,10.160000>0.406400}
cylinder{<142.240000,0.038000,12.700000><142.240000,-1.538000,12.700000>0.406400}
cylinder{<142.240000,0.038000,15.240000><142.240000,-1.538000,15.240000>0.406400}
cylinder{<142.240000,0.038000,17.780000><142.240000,-1.538000,17.780000>0.406400}
cylinder{<142.240000,0.038000,20.320000><142.240000,-1.538000,20.320000>0.406400}
cylinder{<142.240000,0.038000,22.860000><142.240000,-1.538000,22.860000>0.406400}
cylinder{<134.620000,0.038000,22.860000><134.620000,-1.538000,22.860000>0.406400}
cylinder{<134.620000,0.038000,20.320000><134.620000,-1.538000,20.320000>0.406400}
cylinder{<134.620000,0.038000,17.780000><134.620000,-1.538000,17.780000>0.406400}
cylinder{<134.620000,0.038000,15.240000><134.620000,-1.538000,15.240000>0.406400}
cylinder{<134.620000,0.038000,12.700000><134.620000,-1.538000,12.700000>0.406400}
cylinder{<134.620000,0.038000,10.160000><134.620000,-1.538000,10.160000>0.406400}
cylinder{<134.620000,0.038000,7.620000><134.620000,-1.538000,7.620000>0.406400}
cylinder{<120.650000,0.038000,7.620000><120.650000,-1.538000,7.620000>0.406400}
cylinder{<120.650000,0.038000,10.160000><120.650000,-1.538000,10.160000>0.406400}
cylinder{<120.650000,0.038000,12.700000><120.650000,-1.538000,12.700000>0.406400}
cylinder{<120.650000,0.038000,15.240000><120.650000,-1.538000,15.240000>0.406400}
cylinder{<120.650000,0.038000,17.780000><120.650000,-1.538000,17.780000>0.406400}
cylinder{<120.650000,0.038000,20.320000><120.650000,-1.538000,20.320000>0.406400}
cylinder{<120.650000,0.038000,22.860000><120.650000,-1.538000,22.860000>0.406400}
cylinder{<113.030000,0.038000,22.860000><113.030000,-1.538000,22.860000>0.406400}
cylinder{<113.030000,0.038000,20.320000><113.030000,-1.538000,20.320000>0.406400}
cylinder{<113.030000,0.038000,17.780000><113.030000,-1.538000,17.780000>0.406400}
cylinder{<113.030000,0.038000,15.240000><113.030000,-1.538000,15.240000>0.406400}
cylinder{<113.030000,0.038000,12.700000><113.030000,-1.538000,12.700000>0.406400}
cylinder{<113.030000,0.038000,10.160000><113.030000,-1.538000,10.160000>0.406400}
cylinder{<113.030000,0.038000,7.620000><113.030000,-1.538000,7.620000>0.406400}
cylinder{<43.180000,0.038000,26.670000><43.180000,-1.538000,26.670000>0.406400}
cylinder{<43.180000,0.038000,24.130000><43.180000,-1.538000,24.130000>0.406400}
cylinder{<43.180000,0.038000,21.590000><43.180000,-1.538000,21.590000>0.406400}
cylinder{<43.180000,0.038000,19.050000><43.180000,-1.538000,19.050000>0.406400}
cylinder{<43.180000,0.038000,16.510000><43.180000,-1.538000,16.510000>0.406400}
cylinder{<43.180000,0.038000,13.970000><43.180000,-1.538000,13.970000>0.406400}
cylinder{<43.180000,0.038000,11.430000><43.180000,-1.538000,11.430000>0.406400}
cylinder{<43.180000,0.038000,8.890000><43.180000,-1.538000,8.890000>0.406400}
cylinder{<43.180000,0.038000,6.350000><43.180000,-1.538000,6.350000>0.406400}
cylinder{<43.180000,0.038000,3.810000><43.180000,-1.538000,3.810000>0.406400}
cylinder{<50.800000,0.038000,3.810000><50.800000,-1.538000,3.810000>0.406400}
cylinder{<50.800000,0.038000,6.350000><50.800000,-1.538000,6.350000>0.406400}
cylinder{<50.800000,0.038000,8.890000><50.800000,-1.538000,8.890000>0.406400}
cylinder{<50.800000,0.038000,11.430000><50.800000,-1.538000,11.430000>0.406400}
cylinder{<50.800000,0.038000,13.970000><50.800000,-1.538000,13.970000>0.406400}
cylinder{<50.800000,0.038000,16.510000><50.800000,-1.538000,16.510000>0.406400}
cylinder{<50.800000,0.038000,19.050000><50.800000,-1.538000,19.050000>0.406400}
cylinder{<50.800000,0.038000,21.590000><50.800000,-1.538000,21.590000>0.406400}
cylinder{<50.800000,0.038000,24.130000><50.800000,-1.538000,24.130000>0.406400}
cylinder{<50.800000,0.038000,26.670000><50.800000,-1.538000,26.670000>0.406400}
cylinder{<95.250000,0.038000,45.720000><95.250000,-1.538000,45.720000>0.406400}
cylinder{<95.250000,0.038000,48.260000><95.250000,-1.538000,48.260000>0.406400}
cylinder{<120.650000,0.038000,68.580000><120.650000,-1.538000,68.580000>0.406400}
cylinder{<118.110000,0.038000,68.580000><118.110000,-1.538000,68.580000>0.406400}
cylinder{<91.440000,0.038000,78.740000><91.440000,-1.538000,78.740000>0.406400}
cylinder{<76.200000,0.038000,78.740000><76.200000,-1.538000,78.740000>0.406400}
cylinder{<76.200000,0.038000,71.120000><76.200000,-1.538000,71.120000>0.406400}
cylinder{<91.440000,0.038000,71.120000><91.440000,-1.538000,71.120000>0.406400}
cylinder{<119.380000,0.038000,88.900000><119.380000,-1.538000,88.900000>0.406400}
cylinder{<109.220000,0.038000,88.900000><109.220000,-1.538000,88.900000>0.406400}
cylinder{<85.090000,0.038000,53.340000><85.090000,-1.538000,53.340000>0.406400}
cylinder{<95.250000,0.038000,53.340000><95.250000,-1.538000,53.340000>0.406400}
cylinder{<138.430000,0.038000,64.770000><138.430000,-1.538000,64.770000>0.406400}
cylinder{<128.270000,0.038000,64.770000><128.270000,-1.538000,64.770000>0.406400}
cylinder{<143.510000,0.038000,64.770000><143.510000,-1.538000,64.770000>0.406400}
cylinder{<153.670000,0.038000,64.770000><153.670000,-1.538000,64.770000>0.406400}
cylinder{<146.685000,0.038000,83.820000><146.685000,-1.538000,83.820000>0.406400}
cylinder{<156.845000,0.038000,83.820000><156.845000,-1.538000,83.820000>0.406400}
cylinder{<69.850000,0.038000,83.820000><69.850000,-1.538000,83.820000>0.406400}
cylinder{<80.010000,0.038000,83.820000><80.010000,-1.538000,83.820000>0.406400}
cylinder{<47.625000,0.038000,81.280000><47.625000,-1.538000,81.280000>0.406400}
cylinder{<47.625000,0.038000,91.440000><47.625000,-1.538000,91.440000>0.406400}
cylinder{<109.220000,0.038000,83.820000><109.220000,-1.538000,83.820000>0.406400}
cylinder{<119.380000,0.038000,83.820000><119.380000,-1.538000,83.820000>0.406400}
cylinder{<109.220000,0.038000,93.980000><109.220000,-1.538000,93.980000>0.406400}
cylinder{<119.380000,0.038000,93.980000><119.380000,-1.538000,93.980000>0.406400}
cylinder{<109.220000,0.038000,68.580000><109.220000,-1.538000,68.580000>0.406400}
cylinder{<109.220000,0.038000,78.740000><109.220000,-1.538000,78.740000>0.406400}
cylinder{<7.620000,0.038000,6.350000><7.620000,-1.538000,6.350000>0.457200}
cylinder{<7.620000,0.038000,8.890000><7.620000,-1.538000,8.890000>0.457200}
cylinder{<7.620000,0.038000,11.430000><7.620000,-1.538000,11.430000>0.457200}
cylinder{<7.620000,0.038000,13.970000><7.620000,-1.538000,13.970000>0.457200}
cylinder{<7.620000,0.038000,16.510000><7.620000,-1.538000,16.510000>0.457200}
cylinder{<7.620000,0.038000,19.050000><7.620000,-1.538000,19.050000>0.457200}
cylinder{<7.620000,0.038000,21.590000><7.620000,-1.538000,21.590000>0.457200}
cylinder{<7.620000,0.038000,24.130000><7.620000,-1.538000,24.130000>0.457200}
cylinder{<7.620000,0.038000,26.670000><7.620000,-1.538000,26.670000>0.457200}
cylinder{<7.620000,0.038000,29.210000><7.620000,-1.538000,29.210000>0.457200}
cylinder{<7.620000,0.038000,31.750000><7.620000,-1.538000,31.750000>0.457200}
cylinder{<7.620000,0.038000,34.290000><7.620000,-1.538000,34.290000>0.457200}
cylinder{<7.620000,0.038000,36.830000><7.620000,-1.538000,36.830000>0.457200}
cylinder{<7.620000,0.038000,39.370000><7.620000,-1.538000,39.370000>0.457200}
cylinder{<7.620000,0.038000,41.910000><7.620000,-1.538000,41.910000>0.457200}
cylinder{<7.620000,0.038000,44.450000><7.620000,-1.538000,44.450000>0.457200}
cylinder{<45.720000,0.038000,58.420000><45.720000,-1.538000,58.420000>0.457200}
cylinder{<45.720000,0.038000,55.880000><45.720000,-1.538000,55.880000>0.457200}
cylinder{<45.720000,0.038000,53.340000><45.720000,-1.538000,53.340000>0.457200}
cylinder{<45.720000,0.038000,50.800000><45.720000,-1.538000,50.800000>0.457200}
cylinder{<45.720000,0.038000,48.260000><45.720000,-1.538000,48.260000>0.457200}
cylinder{<45.720000,0.038000,45.720000><45.720000,-1.538000,45.720000>0.457200}
cylinder{<45.720000,0.038000,43.180000><45.720000,-1.538000,43.180000>0.457200}
cylinder{<45.720000,0.038000,40.640000><45.720000,-1.538000,40.640000>0.457200}
cylinder{<81.280000,0.038000,40.640000><81.280000,-1.538000,40.640000>0.457200}
cylinder{<81.280000,0.038000,43.180000><81.280000,-1.538000,43.180000>0.457200}
cylinder{<81.280000,0.038000,45.720000><81.280000,-1.538000,45.720000>0.457200}
cylinder{<81.280000,0.038000,48.260000><81.280000,-1.538000,48.260000>0.457200}
cylinder{<81.280000,0.038000,50.800000><81.280000,-1.538000,50.800000>0.457200}
cylinder{<81.280000,0.038000,53.340000><81.280000,-1.538000,53.340000>0.457200}
cylinder{<81.280000,0.038000,55.880000><81.280000,-1.538000,55.880000>0.457200}
cylinder{<81.280000,0.038000,58.420000><81.280000,-1.538000,58.420000>0.457200}
cylinder{<81.280000,0.038000,60.960000><81.280000,-1.538000,60.960000>0.457200}
cylinder{<81.280000,0.038000,63.500000><81.280000,-1.538000,63.500000>0.457200}
cylinder{<88.900000,0.038000,93.980000><88.900000,-1.538000,93.980000>0.457200}
cylinder{<86.360000,0.038000,93.980000><86.360000,-1.538000,93.980000>0.457200}
cylinder{<83.820000,0.038000,93.980000><83.820000,-1.538000,93.980000>0.457200}
cylinder{<81.280000,0.038000,93.980000><81.280000,-1.538000,93.980000>0.457200}
cylinder{<78.740000,0.038000,93.980000><78.740000,-1.538000,93.980000>0.457200}
cylinder{<76.200000,0.038000,93.980000><76.200000,-1.538000,93.980000>0.457200}
cylinder{<151.130000,0.038000,93.980000><151.130000,-1.538000,93.980000>0.457200}
cylinder{<148.590000,0.038000,93.980000><148.590000,-1.538000,93.980000>0.457200}
cylinder{<146.050000,0.038000,93.980000><146.050000,-1.538000,93.980000>0.457200}
cylinder{<143.510000,0.038000,93.980000><143.510000,-1.538000,93.980000>0.457200}
cylinder{<140.970000,0.038000,93.980000><140.970000,-1.538000,93.980000>0.457200}
cylinder{<138.430000,0.038000,93.980000><138.430000,-1.538000,93.980000>0.457200}
cylinder{<135.890000,0.038000,93.980000><135.890000,-1.538000,93.980000>0.457200}
cylinder{<95.250000,0.038000,29.210000><95.250000,-1.538000,29.210000>0.457200}
cylinder{<95.250000,0.038000,31.750000><95.250000,-1.538000,31.750000>0.457200}
cylinder{<95.250000,0.038000,34.290000><95.250000,-1.538000,34.290000>0.457200}
cylinder{<123.190000,0.038000,78.740000><123.190000,-1.538000,78.740000>0.406400}
cylinder{<120.650000,0.038000,78.740000><120.650000,-1.538000,78.740000>0.406400}
cylinder{<125.730000,0.038000,78.740000><125.730000,-1.538000,78.740000>0.406400}
cylinder{<13.335000,0.038000,66.268600><13.335000,-1.538000,66.268600>0.508000}
cylinder{<13.335000,0.038000,69.011800><13.335000,-1.538000,69.011800>0.508000}
cylinder{<13.335000,0.038000,71.755000><13.335000,-1.538000,71.755000>0.508000}
cylinder{<13.335000,0.038000,74.498200><13.335000,-1.538000,74.498200>0.508000}
cylinder{<13.335000,0.038000,77.241400><13.335000,-1.538000,77.241400>0.508000}
cylinder{<10.795000,0.038000,67.640200><10.795000,-1.538000,67.640200>0.508000}
cylinder{<10.795000,0.038000,70.383400><10.795000,-1.538000,70.383400>0.508000}
cylinder{<10.795000,0.038000,73.126600><10.795000,-1.538000,73.126600>0.508000}
cylinder{<10.795000,0.038000,75.869800><10.795000,-1.538000,75.869800>0.508000}
//Bohrungen(schnell)/Durchkontaktierungen
cylinder{<12.700000,0.038000,26.670000><12.700000,-1.538000,26.670000>0.300000 }
cylinder{<12.700000,0.038000,55.245000><12.700000,-1.538000,55.245000>0.300000 }
cylinder{<102.235000,0.038000,41.910000><102.235000,-1.538000,41.910000>0.350000 }
cylinder{<88.900000,0.038000,41.910000><88.900000,-1.538000,41.910000>0.350000 }
cylinder{<102.870000,0.038000,60.960000><102.870000,-1.538000,60.960000>0.350000 }
cylinder{<102.870000,0.038000,8.890000><102.870000,-1.538000,8.890000>0.350000 }
cylinder{<106.045000,0.038000,58.420000><106.045000,-1.538000,58.420000>0.350000 }
cylinder{<106.045000,0.038000,15.240000><106.045000,-1.538000,15.240000>0.350000 }
cylinder{<71.120000,0.038000,45.085000><71.120000,-1.538000,45.085000>0.350000 }
cylinder{<71.120000,0.038000,73.660000><71.120000,-1.538000,73.660000>0.350000 }
cylinder{<69.850000,0.038000,81.280000><69.850000,-1.538000,81.280000>0.350000 }
cylinder{<109.220000,0.038000,81.280000><109.220000,-1.538000,81.280000>0.350000 }
cylinder{<120.650000,0.038000,81.915000><120.650000,-1.538000,81.915000>0.350000 }
cylinder{<146.685000,0.038000,81.915000><146.685000,-1.538000,81.915000>0.350000 }
cylinder{<12.065000,0.038000,8.890000><12.065000,-1.538000,8.890000>0.300000 }
cylinder{<12.065000,0.038000,20.320000><12.065000,-1.538000,20.320000>0.300000 }
cylinder{<35.560000,0.038000,13.970000><35.560000,-1.538000,13.970000>0.300000 }
cylinder{<35.560000,0.038000,5.080000><35.560000,-1.538000,5.080000>0.300000 }
cylinder{<37.465000,0.038000,6.350000><37.465000,-1.538000,6.350000>0.300000 }
cylinder{<37.465000,0.038000,13.970000><37.465000,-1.538000,13.970000>0.300000 }
cylinder{<40.640000,0.038000,8.890000><40.640000,-1.538000,8.890000>0.300000 }
cylinder{<40.640000,0.038000,20.320000><40.640000,-1.538000,20.320000>0.300000 }
cylinder{<39.370000,0.038000,6.350000><39.370000,-1.538000,6.350000>0.300000 }
cylinder{<39.370000,0.038000,27.305000><39.370000,-1.538000,27.305000>0.300000 }
cylinder{<68.580000,0.038000,24.130000><68.580000,-1.538000,24.130000>0.300000 }
cylinder{<53.340000,0.038000,24.130000><53.340000,-1.538000,24.130000>0.300000 }
cylinder{<72.390000,0.038000,38.735000><72.390000,-1.538000,38.735000>0.350000 }
cylinder{<99.060000,0.038000,38.735000><99.060000,-1.538000,38.735000>0.350000 }
cylinder{<126.365000,0.038000,14.605000><126.365000,-1.538000,14.605000>0.350000 }
cylinder{<126.365000,0.038000,26.035000><126.365000,-1.538000,26.035000>0.350000 }
cylinder{<123.825000,0.038000,15.240000><123.825000,-1.538000,15.240000>0.350000 }
cylinder{<123.825000,0.038000,43.180000><123.825000,-1.538000,43.180000>0.350000 }
cylinder{<38.735000,0.038000,34.925000><38.735000,-1.538000,34.925000>0.350000 }
cylinder{<66.040000,0.038000,34.925000><66.040000,-1.538000,34.925000>0.350000 }
cylinder{<98.425000,0.038000,5.080000><98.425000,-1.538000,5.080000>0.300000 }
cylinder{<98.425000,0.038000,22.860000><98.425000,-1.538000,22.860000>0.300000 }
cylinder{<13.970000,0.038000,21.590000><13.970000,-1.538000,21.590000>0.300000 }
cylinder{<13.970000,0.038000,47.625000><13.970000,-1.538000,47.625000>0.300000 }
cylinder{<53.340000,0.038000,21.590000><53.340000,-1.538000,21.590000>0.300000 }
cylinder{<60.960000,0.038000,21.590000><60.960000,-1.538000,21.590000>0.300000 }
cylinder{<17.780000,0.038000,20.955000><17.780000,-1.538000,20.955000>0.300000 }
cylinder{<17.780000,0.038000,48.895000><17.780000,-1.538000,48.895000>0.300000 }
cylinder{<59.690000,0.038000,19.050000><59.690000,-1.538000,19.050000>0.300000 }
cylinder{<53.340000,0.038000,19.050000><53.340000,-1.538000,19.050000>0.300000 }
cylinder{<15.875000,0.038000,38.735000><15.875000,-1.538000,38.735000>0.300000 }
cylinder{<15.875000,0.038000,13.970000><15.875000,-1.538000,13.970000>0.300000 }
cylinder{<19.050000,0.038000,8.890000><19.050000,-1.538000,8.890000>0.300000 }
cylinder{<19.050000,0.038000,39.370000><19.050000,-1.538000,39.370000>0.300000 }
cylinder{<31.750000,0.038000,9.525000><31.750000,-1.538000,9.525000>0.300000 }
cylinder{<31.750000,0.038000,37.465000><31.750000,-1.538000,37.465000>0.300000 }
cylinder{<31.750000,0.038000,64.135000><31.750000,-1.538000,64.135000>0.300000 }
cylinder{<31.750000,0.038000,39.370000><31.750000,-1.538000,39.370000>0.300000 }
cylinder{<33.020000,0.038000,11.430000><33.020000,-1.538000,11.430000>0.300000 }
cylinder{<33.020000,0.038000,41.275000><33.020000,-1.538000,41.275000>0.300000 }
cylinder{<33.020000,0.038000,60.960000><33.020000,-1.538000,60.960000>0.300000 }
cylinder{<33.020000,0.038000,45.720000><33.020000,-1.538000,45.720000>0.300000 }
cylinder{<34.925000,0.038000,20.955000><34.925000,-1.538000,20.955000>0.300000 }
cylinder{<34.925000,0.038000,48.895000><34.925000,-1.538000,48.895000>0.300000 }
cylinder{<36.830000,0.038000,24.130000><36.830000,-1.538000,24.130000>0.300000 }
cylinder{<36.830000,0.038000,51.435000><36.830000,-1.538000,51.435000>0.300000 }
cylinder{<71.120000,0.038000,90.805000><71.120000,-1.538000,90.805000>0.350000 }
cylinder{<143.510000,0.038000,90.805000><143.510000,-1.538000,90.805000>0.350000 }
cylinder{<99.695000,0.038000,50.800000><99.695000,-1.538000,50.800000>0.350000 }
cylinder{<99.695000,0.038000,73.025000><99.695000,-1.538000,73.025000>0.350000 }
cylinder{<130.810000,0.038000,5.080000><130.810000,-1.538000,5.080000>0.350000 }
cylinder{<130.810000,0.038000,33.020000><130.810000,-1.538000,33.020000>0.350000 }
cylinder{<95.250000,0.038000,37.465000><95.250000,-1.538000,37.465000>0.350000 }
cylinder{<41.910000,0.038000,37.465000><41.910000,-1.538000,37.465000>0.350000 }
cylinder{<33.655000,0.038000,56.515000><33.655000,-1.538000,56.515000>0.300000 }
cylinder{<40.640000,0.038000,56.515000><40.640000,-1.538000,56.515000>0.300000 }
cylinder{<17.780000,0.038000,61.595000><17.780000,-1.538000,61.595000>0.350000 }
cylinder{<17.780000,0.038000,81.280000><17.780000,-1.538000,81.280000>0.350000 }
//Bohrungen(schnell)/Platine
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Bestückungsdruck
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.432000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,82.550000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.051000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,82.550000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.051000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,82.550000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.670000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,82.169000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.051000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,83.820000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.162000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,85.090000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.162000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,85.090000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,82.550000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.654000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,82.550000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,83.820000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.162000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,83.820000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,83.820000> }
difference{
cylinder{<25.400000,0,83.820000><25.400000,0.036000,83.820000>2.870200 translate<0,0.000000,0>}
cylinder{<25.400000,-0.1,83.820000><25.400000,0.135000,83.820000>2.717800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-180.000000,0> translate<24.892000,0.000000,83.820000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.368000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,70.485000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.368000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,70.485000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.749000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,70.485000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,70.866000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.749000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,69.215000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,67.945000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.638000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,67.945000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.638000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,70.485000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.146000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,70.485000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.638000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,69.215000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.638000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,69.215000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,69.215000> }
difference{
cylinder{<25.400000,0,69.215000><25.400000,0.036000,69.215000>2.870200 translate<0,0.000000,0>}
cylinder{<25.400000,-0.1,69.215000><25.400000,0.135000,69.215000>2.717800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<25.908000,0.000000,69.215000>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.432000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,90.170000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.051000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,90.551000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,90.170000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.051000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,90.170000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.670000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,89.789000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.051000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,91.440000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.162000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.162000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,92.710000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,90.170000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.654000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,90.170000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.162000,0.000000,91.440000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.162000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,91.440000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,91.440000> }
difference{
cylinder{<25.400000,0,91.440000><25.400000,0.036000,91.440000>2.870200 translate<0,0.000000,0>}
cylinder{<25.400000,-0.1,91.440000><25.400000,0.135000,91.440000>2.717800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-180.000000,0> translate<24.892000,0.000000,91.440000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.368000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,77.470000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.368000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,77.470000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.749000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,77.470000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,77.851000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.749000,0.000000,77.851000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,76.200000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,74.930000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.638000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,74.930000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.638000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,77.470000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.146000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,77.470000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.638000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,76.200000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.638000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.051000,0.000000,76.200000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,76.200000> }
difference{
cylinder{<25.400000,0,76.200000><25.400000,0.036000,76.200000>2.870200 translate<0,0.000000,0>}
cylinder{<25.400000,-0.1,76.200000><25.400000,0.135000,76.200000>2.717800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<25.908000,0.000000,76.200000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,75.819000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.683000,0.000000,75.057000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.683000,0.000000,75.057000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.302000,0.000000,75.438000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<131.064000,0.000000,75.438000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.302000,0.000000,75.438000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,74.041000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,73.152000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<129.540000,0.000000,73.152000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,73.152000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,73.152000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.270000,0.000000,73.152000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,73.152000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,72.644000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<128.270000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,72.644000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.270000,0.000000,72.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,73.152000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.810000,0.000000,73.152000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,73.152000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,73.152000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<129.540000,0.000000,73.152000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.540000,0.000000,70.739000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<129.540000,0.000000,70.739000> }
difference{
cylinder{<129.540000,0,72.390000><129.540000,0.036000,72.390000>4.140200 translate<0,0.000000,0>}
cylinder{<129.540000,-0.1,72.390000><129.540000,0.135000,72.390000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-270.000000,0> translate<129.540000,0.000000,71.882000>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.640000,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.005000,0.000000,51.739800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<40.005000,0.000000,51.739800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.005000,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.370000,0.000000,51.739800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<39.370000,0.000000,51.739800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,52.959000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<40.005000,0.000000,52.959000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.640000,0.000000,51.104800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.005000,0.000000,51.104800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<40.005000,0.000000,51.104800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.005000,0.000000,51.104800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.370000,0.000000,51.104800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<39.370000,0.000000,51.104800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,51.104800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,49.911000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.005000,0.000000,49.911000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,55.118000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,55.118000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,55.118000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,48.006000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.481000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,47.752000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,47.752000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,47.752000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,54.864000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.529000,0.000000,54.864000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<41.275000,0.000000,48.006000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.735000,0.000000,48.006000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.735000,0.000000,54.864000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<41.275000,0.000000,54.864000>}
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.685200,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.685200,0.000000,32.385000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<46.685200,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.685200,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.685200,0.000000,31.750000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<46.685200,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.685200,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,32.385000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<45.466000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<47.320200,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<47.320200,0.000000,32.385000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<47.320200,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<47.320200,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<47.320200,0.000000,31.750000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<47.320200,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.320200,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,32.385000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<47.320200,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,31.369000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.307000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,31.115000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.561000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,33.401000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.673000,0.000000,33.401000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,33.655000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.561000,0.000000,33.655000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<50.419000,0.000000,33.401000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<50.419000,0.000000,31.369000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<43.561000,0.000000,31.369000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<43.561000,0.000000,33.401000>}
//C8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<117.144800,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<117.144800,0.000000,30.480000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<117.144800,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<117.144800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<117.144800,0.000000,31.115000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<117.144800,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.144800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.364000,0.000000,30.480000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<117.144800,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<116.509800,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<116.509800,0.000000,30.480000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<116.509800,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<116.509800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<116.509800,0.000000,31.115000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<116.509800,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.509800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.316000,0.000000,30.480000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<115.316000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.523000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.523000,0.000000,31.750000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<120.523000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.411000,0.000000,32.004000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.411000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.157000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.157000,0.000000,29.210000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<113.157000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.411000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.269000,0.000000,28.956000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.411000,0.000000,28.956000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<113.411000,0.000000,29.210000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<113.411000,0.000000,31.750000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<120.269000,0.000000,31.750000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<120.269000,0.000000,29.210000>}
//C9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,4.445000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.125200,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,3.810000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.125200,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.125200,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,4.445000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<136.906000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,4.445000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.760200,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,3.810000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.760200,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.760200,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,4.445000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<138.760200,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.747000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.747000,0.000000,3.175000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<134.747000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.001000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,2.921000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.001000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.113000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.113000,0.000000,5.715000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.113000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.001000,0.000000,5.969000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.001000,0.000000,5.969000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<141.859000,0.000000,5.715000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<141.859000,0.000000,3.175000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<135.001000,0.000000,3.175000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<135.001000,0.000000,5.715000>}
//C10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,30.480000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.125200,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.125200,0.000000,29.845000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.125200,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.125200,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,30.480000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<136.906000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,30.480000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.760200,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.760200,0.000000,29.845000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<138.760200,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.760200,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,30.480000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<138.760200,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.747000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.747000,0.000000,29.210000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<134.747000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.001000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,28.956000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.001000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.113000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.113000,0.000000,31.750000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.113000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.859000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.001000,0.000000,32.004000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.001000,0.000000,32.004000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<141.859000,0.000000,31.750000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<141.859000,0.000000,29.210000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<135.001000,0.000000,29.210000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<135.001000,0.000000,31.750000>}
//C11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<95.885000,0.000000,75.260200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.520000,0.000000,75.260200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<95.885000,0.000000,75.260200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.520000,0.000000,75.260200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<97.155000,0.000000,75.260200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<96.520000,0.000000,75.260200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,75.260200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,74.041000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<96.520000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<95.885000,0.000000,75.895200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.520000,0.000000,75.895200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<95.885000,0.000000,75.895200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.520000,0.000000,75.895200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<97.155000,0.000000,75.895200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<96.520000,0.000000,75.895200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,75.895200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,77.089000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<96.520000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.250000,0.000000,71.882000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.790000,0.000000,71.882000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.250000,0.000000,71.882000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.044000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.044000,0.000000,78.994000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<98.044000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.790000,0.000000,79.248000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.250000,0.000000,79.248000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<95.250000,0.000000,79.248000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,72.136000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<94.996000,0.000000,72.136000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<95.250000,0.000000,78.994000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<97.790000,0.000000,78.994000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<97.790000,0.000000,72.136000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<95.250000,0.000000,72.136000>}
//C12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<38.404800,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<38.404800,0.000000,93.345000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<38.404800,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<38.404800,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<38.404800,0.000000,93.980000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<38.404800,0.000000,93.980000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.404800,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,93.345000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<38.404800,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<37.769800,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<37.769800,0.000000,93.345000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<37.769800,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<37.769800,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<37.769800,0.000000,93.980000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<37.769800,0.000000,93.980000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.769800,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.576000,0.000000,93.345000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<36.576000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,94.615000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.783000,0.000000,94.615000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,94.869000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.671000,0.000000,94.869000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.671000,0.000000,94.869000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.417000,0.000000,94.615000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.417000,0.000000,92.075000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.417000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.671000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,91.821000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.671000,0.000000,91.821000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<34.671000,0.000000,92.075000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<34.671000,0.000000,94.615000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<41.529000,0.000000,94.615000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<41.529000,0.000000,92.075000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<123.190000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<124.079000,0.000000,88.900000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<123.190000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<133.350000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<132.461000,0.000000,88.900000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<132.461000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.905000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.900000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.270000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.254000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.254000,0.000000,89.535000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<127.254000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.254000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.900000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<127.254000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,88.900000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<126.746000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.254000,0.000000,88.265000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<127.254000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,89.535000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<128.270000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.016000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.016000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,88.900000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<128.270000,0.000000,88.900000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<126.238000,0.000000,88.138000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<130.302000,0.000000,88.138000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<130.302000,0.000000,89.662000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<126.238000,0.000000,89.662000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.984000,0.000000,88.138000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.984000,0.000000,89.662000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<125.984000,0.000000,89.662000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.556000,0.000000,88.138000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.556000,0.000000,89.662000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<130.556000,0.000000,89.662000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.302000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.238000,0.000000,87.884000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<126.238000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.302000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.238000,0.000000,89.916000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<126.238000,0.000000,89.916000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-180.000000,0> translate<129.921000,0.000000,88.900000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<125.031500,0.000000,88.900000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<131.508500,0.000000,88.900000>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<123.190000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<124.079000,0.000000,83.820000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<123.190000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<130.810000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<129.921000,0.000000,83.820000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<129.921000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.635000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,83.820000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<127.000000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.984000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.984000,0.000000,84.455000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<125.984000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.984000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,83.820000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<125.984000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.476000,0.000000,83.820000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<125.476000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.984000,0.000000,83.185000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<125.984000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,83.820000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<127.000000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.000000,0.000000,84.455000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<127.000000,0.000000,84.455000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<124.968000,0.000000,83.058000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.714000,0.000000,83.058000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.714000,0.000000,84.582000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<124.714000,0.000000,84.582000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<124.968000,0.000000,84.582000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<129.032000,0.000000,83.058000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<129.032000,0.000000,84.582000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.032000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.968000,0.000000,84.836000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.968000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.286000,0.000000,83.058000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.286000,0.000000,84.582000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<129.286000,0.000000,84.582000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.032000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.968000,0.000000,82.804000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.968000,0.000000,82.804000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-180.000000,0> translate<128.651000,0.000000,83.820000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-180.000000,0> translate<124.396500,0.000000,83.820000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-180.000000,0> translate<129.603500,0.000000,83.820000>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.643000,0.000000,39.370000>}
box{<0,0,-0.076200><4.953000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.690000,0.000000,39.370000> }
object{ARC(1.270000,0.152400,0.000000,180.000000,0.036000) translate<58.420000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.643000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,90.170000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.197000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,39.370000>}
box{<0,0,-0.076200><4.953000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.197000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,90.170000>}
box{<0,0,-0.076200><50.800000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.197000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.643000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.643000,0.000000,90.170000>}
box{<0,0,-0.076200><50.800000,0.036000,0.076200> rotate<0,90.000000,0> translate<64.643000,0.000000,90.170000> }
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.400000,0.000000,77.851000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,77.851000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,77.851000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.400000,0.000000,72.009000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.620000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.400000,0.000000,77.851000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.400000,0.000000,72.009000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.400000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,77.851000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,75.946000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<134.620000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.620000,0.000000,73.914000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.620000,0.000000,73.914000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<134.620000,0.000000,74.930000>}
//IC3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,57.785000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.321000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,32.385000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.479000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,32.385000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,57.785000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.416000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,57.785000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,57.785000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<25.400000,0.000000,57.785000>}
//IC4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,27.940000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.321000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,2.540000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.479000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,2.540000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,27.940000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.416000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,27.940000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,27.940000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<25.400000,0.000000,27.940000>}
//IC16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,90.170000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.021000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,69.850000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.179000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,69.850000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,90.170000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.116000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,90.170000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,90.170000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<38.100000,0.000000,90.170000>}
//IC19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,34.290000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<113.919000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,52.070000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<119.761000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,52.070000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.919000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.824000,0.000000,34.290000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.919000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.856000,0.000000,34.290000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<117.856000,0.000000,34.290000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<116.840000,0.000000,34.290000>}
//IC24 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,34.290000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.509000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,52.070000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.351000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,52.070000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,34.290000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,34.290000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.446000,0.000000,34.290000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<138.430000,0.000000,34.290000>}
//IC27 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,6.350000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.509000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,24.130000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.351000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,24.130000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.509000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,6.350000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.509000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.351000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,6.350000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.446000,0.000000,6.350000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<138.430000,0.000000,6.350000>}
//IC29 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,6.350000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<113.919000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,24.130000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<119.761000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,24.130000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.919000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.919000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.824000,0.000000,6.350000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.919000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<119.761000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.856000,0.000000,6.350000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<117.856000,0.000000,6.350000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<116.840000,0.000000,6.350000>}
//IC31 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.911000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.911000,0.000000,27.940000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.911000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,2.540000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.069000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.911000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,2.540000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.069000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.911000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,27.940000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.006000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,27.940000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.069000,0.000000,27.940000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<46.990000,0.000000,27.940000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<97.155000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<93.345000,0.000000,49.530000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<93.345000,0.000000,49.530000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<95.250000,0.000000,46.990000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<95.250000,0.000000,46.990000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<95.250000,0.000000,46.990000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<95.250000,0.000000,46.990000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<95.250000,0.000000,46.990000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<95.250000,0.000000,46.990000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<95.250000,0.000000,46.990000>}
difference{
cylinder{<95.250000,0,46.990000><95.250000,0.036000,46.990000>2.616200 translate<0,0.000000,0>}
cylinder{<95.250000,-0.1,46.990000><95.250000,0.135000,46.990000>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<116.840000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<116.840000,0.000000,66.675000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,-90.000000,0> translate<116.840000,0.000000,66.675000> }
object{ARC(3.175000,0.254000,216.869898,503.130102,0.036000) translate<119.380000,0.000000,68.580000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<119.380000,0.000000,68.580000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<119.380000,0.000000,68.580000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<119.380000,0.000000,68.580000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<119.380000,0.000000,68.580000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<119.380000,0.000000,68.580000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<119.380000,0.000000,68.580000>}
difference{
cylinder{<119.380000,0,68.580000><119.380000,0.036000,68.580000>2.616200 translate<0,0.000000,0>}
cylinder{<119.380000,-0.1,68.580000><119.380000,0.135000,68.580000>2.463800 translate<0,0.000000,0>}}
//QG2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.980000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<74.930000,0.000000,81.280000>}
box{<0,0,-0.127000><19.050000,0.036000,0.127000> rotate<0,0.000000,0> translate<74.930000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<73.660000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<73.660000,0.000000,69.850000>}
box{<0,0,-0.127000><10.160000,0.036000,0.127000> rotate<0,-90.000000,0> translate<73.660000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<74.930000,0.000000,68.580000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<92.710000,0.000000,68.580000>}
box{<0,0,-0.127000><17.780000,0.036000,0.127000> rotate<0,0.000000,0> translate<74.930000,0.000000,68.580000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.980000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<93.980000,0.000000,69.850000>}
box{<0,0,-0.127000><11.430000,0.036000,0.127000> rotate<0,-90.000000,0> translate<93.980000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,80.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,80.645000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.930000,0.000000,80.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,69.850000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.295000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,69.215000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.930000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.345000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.345000,0.000000,80.010000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<93.345000,0.000000,80.010000> }
object{ARC(1.270000,0.254000,90.000000,180.000000,0.036000) translate<74.930000,0.000000,80.010000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<74.930000,0.000000,80.010000>}
object{ARC(0.635000,0.152400,180.000000,270.000000,0.036000) translate<74.930000,0.000000,69.850000>}
object{ARC(1.270000,0.254000,180.000000,270.000000,0.036000) translate<74.930000,0.000000,69.850000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<92.710000,0.000000,69.850000>}
object{ARC(1.270000,0.254000,270.000000,360.000000,0.036000) translate<92.710000,0.000000,69.850000>}
object{ARC(0.635000,0.152400,0.000000,90.000000,0.036000) translate<92.710000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.150200,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.150200,0.000000,72.390000>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,90.000000,0> translate<84.150200,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.150200,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<83.515200,0.000000,72.390000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<83.515200,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<83.515200,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<83.515200,0.000000,69.850000>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,-90.000000,0> translate<83.515200,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<83.515200,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.150200,0.000000,69.850000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<83.515200,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<82.880200,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<82.880200,0.000000,71.120000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,90.000000,0> translate<82.880200,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.759800,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.759800,0.000000,71.120000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,90.000000,0> translate<84.759800,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.880200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,71.120000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,0.000000,0> translate<81.280000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<82.880200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<82.880200,0.000000,72.390000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,90.000000,0> translate<82.880200,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.759800,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,71.120000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,0.000000,0> translate<84.759800,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.759800,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<84.759800,0.000000,72.390000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,90.000000,0> translate<84.759800,0.000000,72.390000> }
difference{
cylinder{<92.329000,0,79.629000><92.329000,0.036000,79.629000>0.787400 translate<0,0.000000,0>}
cylinder{<92.329000,-0.1,79.629000><92.329000,0.135000,79.629000>0.482600 translate<0,0.000000,0>}}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<109.220000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<110.236000,0.000000,88.900000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<109.220000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<119.380000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<118.364000,0.000000,88.900000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<118.364000,0.000000,88.900000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<117.221000,0.000000,88.011000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<117.221000,0.000000,89.789000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<111.379000,0.000000,89.789000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<111.379000,0.000000,88.011000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.475000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.475000,0.000000,88.011000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<117.475000,0.000000,88.011000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.221000,0.000000,87.757000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,87.757000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,87.757000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,87.757000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<116.713000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.221000,0.000000,90.043000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,90.043000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,90.043000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,90.043000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<116.713000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,87.757000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<111.760000,0.000000,87.757000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,87.884000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.887000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,90.043000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<111.760000,0.000000,90.043000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,89.916000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.887000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.379000,0.000000,87.757000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,87.757000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.379000,0.000000,87.757000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.379000,0.000000,90.043000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,90.043000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.379000,0.000000,90.043000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,88.011000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<111.125000,0.000000,88.011000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<110.693200,0.000000,88.900000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<117.906800,0.000000,88.900000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<95.250000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<94.234000,0.000000,53.340000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<94.234000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<85.090000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<86.106000,0.000000,53.340000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<85.090000,0.000000,53.340000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<87.249000,0.000000,54.229000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<87.249000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<93.091000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<93.091000,0.000000,54.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,54.229000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.995000,0.000000,54.229000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.249000,0.000000,54.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,54.483000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.249000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,54.483000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<87.630000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.249000,0.000000,52.197000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,52.197000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.249000,0.000000,52.197000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,52.197000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<87.630000,0.000000,52.197000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,54.483000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<92.583000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,54.356000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.757000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,52.197000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<92.583000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.757000,0.000000,52.324000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.757000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.091000,0.000000,54.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,54.483000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.091000,0.000000,52.197000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,52.197000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,52.197000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.345000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.345000,0.000000,54.229000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<93.345000,0.000000,54.229000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<93.776800,0.000000,53.340000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<86.563200,0.000000,53.340000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<128.270000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<129.286000,0.000000,64.770000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<128.270000,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<138.430000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<137.414000,0.000000,64.770000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<137.414000,0.000000,64.770000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<136.271000,0.000000,63.881000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<136.271000,0.000000,65.659000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<130.429000,0.000000,65.659000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<130.429000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,63.881000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.525000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,63.627000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.890000,0.000000,63.627000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.890000,0.000000,63.627000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.763000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.890000,0.000000,63.627000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<135.763000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,65.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.890000,0.000000,65.913000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.890000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.763000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.890000,0.000000,65.913000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<135.763000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,63.627000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<130.810000,0.000000,63.627000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.763000,0.000000,63.754000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.937000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,65.913000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<130.810000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.937000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.763000,0.000000,65.786000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.937000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,63.627000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,63.627000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,63.627000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,65.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.810000,0.000000,65.913000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.175000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.175000,0.000000,63.881000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.175000,0.000000,63.881000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<129.743200,0.000000,64.770000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<136.956800,0.000000,64.770000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<153.670000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<152.654000,0.000000,64.770000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<152.654000,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<143.510000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<144.526000,0.000000,64.770000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<143.510000,0.000000,64.770000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<145.669000,0.000000,65.659000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<145.669000,0.000000,63.881000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<151.511000,0.000000,63.881000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<151.511000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,65.659000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,65.659000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,65.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,65.913000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.177000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,65.913000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<146.050000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,63.627000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,63.627000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,63.627000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.177000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.050000,0.000000,63.627000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<146.050000,0.000000,63.627000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,65.913000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<151.003000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.177000,0.000000,65.786000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.177000,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,63.627000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<151.003000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.177000,0.000000,63.754000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.177000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.511000,0.000000,65.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,65.913000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.130000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.511000,0.000000,63.627000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,63.627000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.130000,0.000000,63.627000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,65.659000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<151.765000,0.000000,65.659000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<152.196800,0.000000,64.770000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<144.983200,0.000000,64.770000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<156.845000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<155.829000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<155.829000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<146.685000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<147.701000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<146.685000,0.000000,83.820000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<148.844000,0.000000,84.709000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<148.844000,0.000000,82.931000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<154.686000,0.000000,82.931000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<154.686000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.590000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.590000,0.000000,84.709000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.590000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<149.225000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<149.225000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<154.178000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,84.836000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<154.178000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,82.804000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.305000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.305000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.940000,0.000000,84.709000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<154.940000,0.000000,84.709000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<155.371800,0.000000,83.820000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<148.158200,0.000000,83.820000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<80.010000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<78.994000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<78.994000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<69.850000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<70.866000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<69.850000,0.000000,83.820000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<72.009000,0.000000,84.709000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<72.009000,0.000000,82.931000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<77.851000,0.000000,82.931000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<77.851000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,84.709000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.755000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.009000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.517000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<72.390000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.009000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.009000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.517000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.390000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.343000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.470000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<77.343000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.343000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.517000,0.000000,84.836000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.517000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.343000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.470000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<77.343000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.343000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.517000,0.000000,82.804000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.517000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.851000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.470000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.470000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.851000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.470000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.470000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,84.709000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.105000,0.000000,84.709000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<78.536800,0.000000,83.820000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<71.323200,0.000000,83.820000>}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<47.625000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<47.625000,0.000000,90.424000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<47.625000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<47.625000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<47.625000,0.000000,82.296000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<47.625000,0.000000,82.296000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<46.736000,0.000000,83.439000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<48.514000,0.000000,83.439000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<48.514000,0.000000,89.281000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<46.736000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,83.185000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.736000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.482000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.609000,0.000000,83.947000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.482000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,83.820000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.768000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,83.947000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,83.820000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<48.641000,0.000000,83.947000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.609000,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,88.900000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<46.482000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.609000,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.609000,0.000000,83.947000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.609000,0.000000,83.947000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,88.900000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.641000,0.000000,88.773000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,83.947000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.641000,0.000000,83.947000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,88.900000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.482000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,88.900000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.768000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,89.535000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.736000,0.000000,89.535000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<47.625000,0.000000,89.966800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<47.625000,0.000000,82.753200>}
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<119.380000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<118.364000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<118.364000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<109.220000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<110.236000,0.000000,83.820000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<109.220000,0.000000,83.820000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<111.379000,0.000000,84.709000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<111.379000,0.000000,82.931000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<117.221000,0.000000,82.931000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<117.221000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,84.709000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<111.125000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.379000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.379000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<111.760000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.379000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.379000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<111.760000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,84.963000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<116.713000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,84.836000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.887000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,82.677000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<116.713000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,82.804000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.887000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.221000,0.000000,84.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,84.963000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,84.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.221000,0.000000,82.677000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,82.677000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,82.677000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.475000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.475000,0.000000,84.709000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<117.475000,0.000000,84.709000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<117.906800,0.000000,83.820000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<110.693200,0.000000,83.820000>}
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<119.380000,0.000000,93.980000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<118.364000,0.000000,93.980000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<118.364000,0.000000,93.980000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<109.220000,0.000000,93.980000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<110.236000,0.000000,93.980000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<109.220000,0.000000,93.980000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<111.379000,0.000000,94.869000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<111.379000,0.000000,93.091000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<117.221000,0.000000,93.091000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<117.221000,0.000000,94.869000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,93.091000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,94.869000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<111.125000,0.000000,94.869000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.379000,0.000000,95.123000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,95.123000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.379000,0.000000,95.123000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,94.996000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,95.123000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<111.760000,0.000000,95.123000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.379000,0.000000,92.837000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,92.837000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.379000,0.000000,92.837000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.760000,0.000000,92.837000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<111.760000,0.000000,92.837000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,94.996000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,95.123000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<116.713000,0.000000,94.996000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,94.996000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,94.996000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.887000,0.000000,94.996000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,92.837000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<116.713000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.713000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,92.964000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.887000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.221000,0.000000,95.123000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,95.123000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,95.123000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.221000,0.000000,92.837000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,92.837000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.840000,0.000000,92.837000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.475000,0.000000,93.091000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.475000,0.000000,94.869000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<117.475000,0.000000,94.869000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<117.906800,0.000000,93.980000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<110.693200,0.000000,93.980000>}
//R15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<109.220000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<109.220000,0.000000,77.724000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<109.220000,0.000000,77.724000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<109.220000,0.000000,68.580000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<109.220000,0.000000,69.596000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<109.220000,0.000000,69.596000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<108.331000,0.000000,70.739000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<110.109000,0.000000,70.739000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<110.109000,0.000000,76.581000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<108.331000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.109000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.331000,0.000000,70.485000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<108.331000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.077000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.077000,0.000000,71.120000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<108.077000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.204000,0.000000,71.247000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.077000,0.000000,71.120000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<108.077000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,71.120000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<110.363000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.236000,0.000000,71.247000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,71.120000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<110.236000,0.000000,71.247000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.204000,0.000000,76.073000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.077000,0.000000,76.200000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<108.077000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.204000,0.000000,76.073000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.204000,0.000000,71.247000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<108.204000,0.000000,71.247000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.236000,0.000000,76.073000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,76.200000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<110.236000,0.000000,76.073000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.236000,0.000000,76.073000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.236000,0.000000,71.247000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.236000,0.000000,71.247000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.077000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.077000,0.000000,76.200000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<108.077000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.363000,0.000000,76.200000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<110.363000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<110.109000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<108.331000,0.000000,76.835000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<108.331000,0.000000,76.835000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<109.220000,0.000000,77.266800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<109.220000,0.000000,70.053200>}
//SL1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,7.366000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.842000,0.000000,7.239000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,7.620000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.969000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,7.874000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<5.969000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,8.001000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<5.842000,0.000000,8.001000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.366000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,5.334000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,7.366000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.874000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,5.334000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,5.334000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,5.334000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,5.715000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,6.985000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,5.715000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,6.985000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,6.985000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,8.255000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,8.255000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.366000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.874000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,8.255000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,5.334000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,5.715000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,5.334000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,6.096000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,6.096000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,6.604000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,6.096000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,8.636000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,9.144000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,7.874000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,7.366000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,9.906000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,10.414000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,10.414000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.446000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,9.906000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,10.414000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,10.795000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.446000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,12.446000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,10.414000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,11.176000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,9.906000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.207000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,9.906000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,8.636000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,8.636000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,7.874000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,6.604000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,5.334000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.842000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,9.906000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,10.414000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.874000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,7.366000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,9.906000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,10.414000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,6.985000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,9.906000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.906000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,12.954000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.954000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,15.875000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.954000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,13.716000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,43.434000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<5.969000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,43.561000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<5.842000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,42.926000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,43.434000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,43.434000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,43.561000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,45.466000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,45.466000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,45.466000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.398000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,45.085000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.466000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,45.085000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,42.926000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,43.434000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,43.815000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.466000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,45.466000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,45.466000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,43.434000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,44.196000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,42.926000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.207000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,42.926000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,42.926000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.842000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,43.180000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.969000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,16.256000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.224000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,14.986000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,15.494000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,42.926000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,43.434000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.969000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.398000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,42.926000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,12.446000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.842000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.207000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,15.494000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,17.526000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,17.526000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.415000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,18.796000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,16.764000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,17.526000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.034000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,17.526000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,18.034000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,20.066000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.066000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.955000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,21.336000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,21.336000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,19.304000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,20.066000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.574000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,20.066000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,20.574000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,22.606000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.606000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,23.114000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,23.495000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,23.876000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,23.114000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,21.844000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,22.606000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,23.114000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,22.606000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,23.114000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,25.146000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,23.114000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,25.146000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,25.654000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,25.146000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,25.654000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,26.035000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,25.654000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,25.146000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,26.416000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,26.416000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,25.654000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,24.384000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,25.146000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,25.654000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,25.146000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,25.654000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,27.686000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,25.654000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,27.686000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,28.194000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.686000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,28.194000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,28.575000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,28.956000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,29.464000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,28.194000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,27.686000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,28.956000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,28.194000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,26.924000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,27.686000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,28.194000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,27.686000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,28.194000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,30.226000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,28.194000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,30.226000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,30.734000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,29.845000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,30.226000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,30.734000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,31.115000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,31.496000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,32.004000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,30.734000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,30.226000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,31.496000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,31.496000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,30.734000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,29.464000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,30.226000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,30.734000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,30.226000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,29.845000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,30.734000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,32.766000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,30.734000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,32.766000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,33.274000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,32.385000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,32.385000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,32.385000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,33.655000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,33.655000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,32.766000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,33.274000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,33.655000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,34.036000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,34.544000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,33.274000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,32.766000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,34.036000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,34.036000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,33.274000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,32.004000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,32.766000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,33.274000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,32.766000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,32.385000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,33.274000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,35.306000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,33.274000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,35.306000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,35.814000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,34.925000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,36.195000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,36.195000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,35.306000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,35.814000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,36.195000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,36.576000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,37.084000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,35.814000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,35.306000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,36.576000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,36.576000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,35.814000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,34.544000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,35.306000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,35.814000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,35.306000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,34.925000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,35.814000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,37.846000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,35.814000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,37.846000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,38.354000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,37.465000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,37.846000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,38.354000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,38.735000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,39.116000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,39.624000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,38.354000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,37.846000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,39.116000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,39.116000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,38.354000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,37.084000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,37.846000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,38.354000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,37.846000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,37.465000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,38.354000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,40.386000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,38.354000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,40.386000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.779000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.779000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,40.894000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.779000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.386000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.894000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,41.275000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,40.894000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,40.386000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.080000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,41.656000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,40.894000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,39.624000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,40.386000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.894000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.386000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.842000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.398000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.398000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,40.894000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,42.926000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.842000,0.000000,42.799000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.842000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,42.545000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,40.894000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.906000,0.000000,40.894000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,6.350000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,8.890000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,11.430000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,13.970000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,21.590000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,19.050000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,44.450000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,24.130000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,26.670000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,29.210000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,31.750000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,34.290000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,36.830000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,39.370000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<7.620000,0.000000,41.910000>}
//SL2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,57.404000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.371000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.117000,0.000000,57.150000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.117000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.117000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,56.896000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<47.117000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,56.769000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<47.371000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,57.404000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,59.436000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,57.404000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.561000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,56.896000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,59.436000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.498000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,59.436000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,59.436000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,59.055000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.942000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,57.785000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,59.055000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,57.785000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,57.785000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,56.515000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,56.515000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,57.404000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,56.896000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,56.515000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,59.436000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.196000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,59.055000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,59.436000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,58.674000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,58.674000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,58.166000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,58.166000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,58.166000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,58.674000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,56.134000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,55.626000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,56.896000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,57.404000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.561000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,54.356000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,54.356000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,52.324000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,52.705000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,55.245000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,55.245000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,54.864000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,54.356000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,53.975000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,52.324000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,53.594000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,52.324000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,53.086000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,53.594000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,54.356000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,53.594000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.133000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,54.864000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,54.864000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,56.134000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,56.134000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,56.896000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.133000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,58.166000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.260000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,59.436000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.498000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,54.864000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,54.356000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,56.896000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,57.404000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,54.864000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,54.356000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,55.245000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,57.785000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.942000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,54.864000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.434000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.942000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,54.864000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,51.816000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.561000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,51.816000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,50.165000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,49.784000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,49.276000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,48.895000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,51.816000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.196000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,51.054000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,51.054000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,50.546000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,50.546000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,50.546000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,51.054000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,48.514000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,48.006000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.117000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,41.656000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<47.117000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,41.529000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<47.371000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,42.164000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.561000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,41.656000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,39.624000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,39.624000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.498000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,40.005000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.942000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,39.624000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,42.164000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,41.275000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,39.624000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,39.624000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,40.894000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,39.624000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,40.386000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,40.894000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,40.894000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,42.164000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.133000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,42.164000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.371000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.117000,0.000000,41.910000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.117000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,48.514000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,48.514000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,49.276000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.133000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,50.546000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.260000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,49.784000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,49.276000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,49.784000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,42.164000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,41.656000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,50.165000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.942000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.942000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,52.324000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,49.276000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.561000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,52.705000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.942000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.196000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.498000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.133000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,49.276000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,47.244000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.561000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,47.625000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,47.244000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,46.355000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,45.974000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,45.466000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,45.974000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,45.974000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.133000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,48.006000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.260000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,47.244000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,46.736000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,47.244000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,47.625000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.942000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,46.736000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,44.704000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.561000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,45.085000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,44.704000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,43.815000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.196000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,43.434000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,42.926000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.133000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,43.434000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,43.434000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.133000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,45.466000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.260000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,44.704000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,44.196000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,44.704000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,45.085000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.942000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,42.164000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,42.291000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.498000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,42.545000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,44.196000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.434000,0.000000,44.196000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,58.420000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,55.880000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,53.340000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,50.800000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,48.260000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,43.180000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,45.720000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<45.720000,0.000000,40.640000>}
//SL3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,41.656000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<79.502000,0.000000,41.529000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,41.910000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<79.629000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,42.164000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<79.629000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,42.291000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<79.502000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,39.624000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,39.624000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,39.624000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.058000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,40.005000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<83.058000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,41.656000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,42.164000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,42.545000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,39.624000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.804000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,39.624000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,40.386000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,40.386000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,40.894000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,40.386000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,42.926000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,43.434000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,44.704000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,46.736000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,46.355000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,44.196000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,44.704000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,45.085000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,46.736000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,45.466000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,46.736000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,45.974000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,45.466000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,45.466000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.867000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,44.196000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,42.926000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,42.926000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,42.164000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.867000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,40.894000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.740000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,39.624000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.502000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,44.196000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,44.704000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,42.164000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.629000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,41.656000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.629000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,44.196000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,44.704000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,44.196000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<83.566000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,45.085000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<83.058000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,47.244000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,49.276000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,47.244000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,48.895000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,49.276000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,50.165000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,47.244000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.804000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,48.006000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,48.006000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,48.514000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,48.006000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,50.546000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,50.546000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,51.054000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,62.484000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<79.629000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,62.611000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<79.502000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,61.976000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,62.484000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,62.484000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,64.516000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,64.516000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,64.516000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.058000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,64.135000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,64.516000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,64.135000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,64.135000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,61.595000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,61.595000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,62.865000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,62.865000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,61.976000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,62.484000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,62.865000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,64.516000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,64.135000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,64.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,64.516000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,63.246000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,63.246000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,64.516000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,63.754000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,63.754000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,63.246000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,62.484000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,63.246000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,61.976000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.867000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,61.976000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,61.976000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<79.502000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,62.230000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<79.629000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,50.546000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,50.546000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.867000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,48.514000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.740000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,49.276000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,49.784000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,49.276000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,61.976000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.629000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,62.484000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.629000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,48.895000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,62.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<83.058000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,61.976000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,46.736000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,46.355000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.804000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.502000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.867000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,49.784000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,51.816000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,51.435000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,51.816000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,52.705000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,53.086000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,53.594000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,53.086000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,53.086000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.867000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,51.054000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.740000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,51.816000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,52.324000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,51.816000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,51.435000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,54.356000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,52.324000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,54.356000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,54.864000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,55.245000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,55.245000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,54.356000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,55.245000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,55.626000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,56.134000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,54.864000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,54.356000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,55.626000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,55.626000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.867000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,53.594000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.740000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,54.356000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,54.864000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,54.356000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,56.896000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,54.864000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,56.896000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,57.404000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,56.515000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,56.515000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,56.515000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,57.785000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,57.785000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,56.896000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,57.404000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,57.785000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,57.785000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,58.166000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,58.166000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,58.674000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,57.404000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,56.896000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,58.166000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,58.166000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,57.404000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.867000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,56.134000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.740000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,56.896000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,57.404000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,56.896000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,56.515000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,57.404000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,59.436000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,57.404000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,59.436000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.439000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,59.944000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.439000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.055000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,59.055000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,59.055000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,60.325000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,60.325000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.550000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.436000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.944000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,60.325000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,60.706000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,60.706000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,61.214000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.613000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,59.944000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,59.436000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.740000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.613000,0.000000,60.706000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.613000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,60.706000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,60.706000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.867000,0.000000,59.944000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.867000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,58.674000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.740000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,57.404000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,59.436000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.944000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,59.436000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.502000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.058000,0.000000,59.055000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.058000,0.000000,59.055000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,59.944000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,61.976000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<78.740000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.502000,0.000000,61.849000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.502000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.550000,0.000000,61.595000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.550000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,59.944000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,59.944000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,40.640000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,43.180000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,45.720000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,48.260000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,50.800000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,55.880000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,53.340000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,63.500000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,58.420000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<81.280000,0.000000,60.960000>}
//SL4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,92.329000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<87.884000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,92.583000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<87.630000,0.000000,92.583000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.630000,0.000000,92.583000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,92.329000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<87.376000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.249000,0.000000,92.202000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<87.249000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<87.884000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.884000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.376000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<87.376000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,92.202000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<89.916000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<89.916000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,96.266000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<89.916000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,95.758000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<89.535000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.265000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.265000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<88.265000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<89.535000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.265000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.265000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.265000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.265000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<88.265000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<86.995000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<86.995000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.265000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.884000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.376000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.995000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<89.535000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<89.535000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,95.758000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<89.916000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.154000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<89.154000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.154000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.154000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<89.154000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.646000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.646000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<88.646000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.646000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.154000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.646000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.614000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.614000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<86.614000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.106000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.106000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<86.106000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.376000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.884000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.836000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<84.836000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.185000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.455000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.185000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.725000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.725000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<85.725000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.725000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.725000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<85.725000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.455000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.455000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<84.455000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.455000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.455000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<84.455000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.725000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.344000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.836000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.455000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.455000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.185000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.074000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.074000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<84.074000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.074000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.566000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<84.836000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.074000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.074000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.836000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<85.344000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.106000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.344000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.106000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.614000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.106000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.614000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.614000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.376000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.646000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<87.884000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.011000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<88.011000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.249000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.344000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,92.202000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.836000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<87.376000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.884000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<87.884000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.344000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<84.836000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.725000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.725000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<88.265000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.995000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.376000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.344000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.725000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.455000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.455000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.344000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.264000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.264000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.756000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.756000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.296000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<80.645000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.915000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.915000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<81.915000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.915000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.645000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<80.645000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.375000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.375000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.375000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.375000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.375000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.375000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.264000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.756000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.375000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.375000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.915000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.915000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.915000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.915000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<81.915000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.534000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<81.534000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.026000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.026000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<81.026000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.026000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.026000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.994000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.994000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.994000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.486000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.486000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.486000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.756000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<80.264000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.470000,0.000000,92.583000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,92.329000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<77.216000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.089000,0.000000,92.202000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<77.089000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.216000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<77.216000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.184000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.089000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.184000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<75.184000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,96.266000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<75.184000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.565000,0.000000,95.758000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.184000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<75.184000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.565000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.565000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<75.565000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.565000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.565000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.105000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.105000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.835000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.835000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.724000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.216000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<76.835000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.565000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.184000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.565000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.565000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<75.565000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,95.758000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<75.184000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.454000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.454000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.454000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.184000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.184000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<75.946000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.454000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.946000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.216000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.454000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<76.454000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.216000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.724000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.851000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,92.329000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<77.724000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.470000,0.000000,92.583000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<77.470000,0.000000,92.583000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.486000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.724000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.486000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.994000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.486000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.994000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.994000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.756000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.026000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.264000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,92.202000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.264000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.756000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.264000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<77.724000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.216000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<77.216000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.375000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.105000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.375000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.375000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.724000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.105000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<76.835000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<77.724000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,92.202000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.804000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,92.202000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<79.756000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.851000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.851000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.296000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.296000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.915000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.915000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.296000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,92.202000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.296000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<82.296000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.804000,0.000000,91.567000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.804000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,91.567000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.296000,0.000000,91.567000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<88.900000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<86.360000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<83.820000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<81.280000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<78.740000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<76.200000,0.000000,93.980000>}
//SL5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.241000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,92.329000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<150.114000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,92.583000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<149.860000,0.000000,92.583000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,92.583000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,92.329000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<149.606000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,92.202000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<149.479000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.114000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.114000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.606000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,92.202000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<152.146000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<152.146000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,96.266000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<152.146000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,95.758000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.765000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.495000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<151.765000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.495000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.495000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.225000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.225000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.114000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.225000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.765000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.765000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<151.765000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,95.758000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<152.146000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.384000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.384000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.384000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.384000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<151.384000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.876000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.876000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.876000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.876000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.384000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.876000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<148.844000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.336000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.336000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<148.336000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.114000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.066000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.066000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.034000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.034000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.415000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.685000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.955000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.955000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<147.955000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.955000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.955000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<147.955000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.685000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.685000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.685000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.685000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.685000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.685000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.955000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.574000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.066000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.685000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.685000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.034000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.415000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.796000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.034000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.796000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.796000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.796000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.796000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.796000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<147.066000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.066000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<147.574000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.336000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.574000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.336000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.336000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.876000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.114000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.241000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.146000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.241000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.479000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.574000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,92.202000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.066000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.606000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.114000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.114000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.574000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.066000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.955000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.955000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.225000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.225000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<147.574000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.955000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.685000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.685000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.574000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.574000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.494000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.986000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.986000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<144.526000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.875000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<144.145000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.875000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.875000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.986000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.145000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<144.145000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.764000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.764000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.764000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.764000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.764000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.256000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.256000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<143.256000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.256000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.764000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<143.256000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.224000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.224000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.224000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.716000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.716000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<140.716000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.986000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.494000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,92.583000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,92.329000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<136.906000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.779000,0.000000,92.202000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<136.779000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.906000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<136.906000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.779000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<134.874000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,96.266000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.255000,0.000000,95.758000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.255000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.255000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.255000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.255000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.255000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.795000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.795000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<137.795000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.795000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.795000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<137.795000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.525000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.525000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.795000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.414000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.906000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.525000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.255000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.255000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.255000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.255000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,95.758000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<134.874000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.144000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.144000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.144000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.874000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.874000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.636000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.636000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.144000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.636000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.906000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.144000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.144000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.906000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<137.414000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.541000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,92.329000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<137.414000,0.000000,92.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.160000,0.000000,92.583000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<137.160000,0.000000,92.583000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.716000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.224000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.716000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.224000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.224000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.986000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.256000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,92.202000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.986000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.494000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<137.414000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,92.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.906000,0.000000,95.504000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,90.000000,0> translate<136.906000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.875000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.795000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.525000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.525000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<137.414000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.066000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,92.202000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.034000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,92.202000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.986000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.034000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<144.526000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.526000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.145000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.145000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.526000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,92.202000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.526000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.526000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,91.567000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.034000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.526000,0.000000,91.567000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<144.526000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.954000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.954000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,96.139000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.446000,0.000000,96.139000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,96.139000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,96.266000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.446000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.335000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.335000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<140.335000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.335000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.335000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.335000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.335000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<140.335000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,95.504000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.065000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,95.250000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.065000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.335000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.954000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,95.504000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.446000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,95.504000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.065000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.684000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.684000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<138.684000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.176000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.176000,0.000000,91.313000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<138.176000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.446000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,91.440000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.954000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.176000,0.000000,91.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.684000,0.000000,91.313000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<138.176000,0.000000,91.313000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.684000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<138.684000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,91.567000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.446000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.716000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.954000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,92.202000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.954000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.446000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,95.504000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.954000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,95.758000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.335000,0.000000,95.758000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.065000,0.000000,95.758000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.954000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,92.202000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.446000,0.000000,92.202000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.176000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,91.440000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.414000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.795000,0.000000,95.250000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.795000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.414000,0.000000,96.266000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,96.266000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.414000,0.000000,96.266000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.446000,0.000000,92.202000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.541000,0.000000,92.202000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.541000,0.000000,92.202000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<151.130000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<148.590000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<146.050000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<143.510000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<140.970000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<135.890000,0.000000,93.980000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-180.000000,0> translate<138.430000,0.000000,93.980000>}
//SL6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,30.226000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<93.472000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.853000,0.000000,30.480000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<93.599000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.853000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,30.734000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<93.599000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,30.861000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<93.472000,0.000000,30.861000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,30.226000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<97.409000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,28.194000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.536000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,30.226000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.409000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,30.734000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<97.409000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,28.194000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,28.194000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.472000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,28.194000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<97.028000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,28.575000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<97.028000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,29.845000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.520000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,30.226000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.774000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,30.734000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.774000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,31.115000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.774000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,28.194000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<96.774000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,28.194000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,28.956000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<92.710000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,28.956000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.583000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,29.464000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.583000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<92.583000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,31.496000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.583000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,32.004000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.583000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,30.734000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,30.226000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.853000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,33.274000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<93.599000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,33.401000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<93.472000,0.000000,33.401000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,32.766000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.409000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,33.274000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<97.409000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,33.274000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.536000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,35.306000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<93.472000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,35.306000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,35.306000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<97.028000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,34.925000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.028000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,35.306000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.472000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,34.925000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.520000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,32.385000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,32.385000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,33.655000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,33.655000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,32.766000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.774000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,33.274000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.774000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,33.655000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.774000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,35.306000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.774000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.520000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,35.306000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.774000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,34.036000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.583000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,35.306000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<92.710000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,34.544000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.583000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,34.036000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<92.583000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,33.274000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,34.036000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<92.710000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,32.766000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<92.837000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,32.766000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<92.710000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,32.639000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,32.766000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<93.472000,0.000000,32.639000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.853000,0.000000,33.020000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<93.599000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,32.766000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<92.710000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.583000,0.000000,31.496000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<92.583000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,31.496000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<92.710000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.837000,0.000000,30.734000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<92.837000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.710000,0.000000,29.464000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<92.710000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,28.194000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<93.472000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,32.639000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<93.472000,0.000000,32.639000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,30.734000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.599000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,30.226000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.599000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,32.766000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.599000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.774000,0.000000,33.274000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.599000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.520000,0.000000,32.385000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<96.520000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,29.845000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.028000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,32.766000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<97.536000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.028000,0.000000,33.655000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<97.028000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.409000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.536000,0.000000,32.766000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<97.409000,0.000000,32.766000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<95.250000,0.000000,29.210000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<95.250000,0.000000,31.750000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<95.250000,0.000000,34.290000>}
//T1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<125.285000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.095000,0.000000,80.391000>}
box{<0,0,-0.063500><4.190000,0.036000,0.063500> rotate<0,0.000000,0> translate<121.095000,0.000000,80.391000> }
object{ARC(2.667000,0.127000,205.208327,334.791673,0.036000) translate<123.190000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<122.054000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<124.326000,0.000000,78.867000>}
box{<0,0,-0.063500><2.272000,0.036000,0.063500> rotate<0,0.000000,0> translate<122.054000,0.000000,78.867000> }
object{ARC(2.667000,0.127000,334.789729,362.727231,0.036000) translate<123.190000,0.000000,78.740100>}
object{ARC(2.667000,0.127000,2.731522,25.210271,0.036000) translate<123.190000,0.000000,78.739900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<124.594000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<125.854000,0.000000,78.867000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,0.000000,0> translate<124.594000,0.000000,78.867000> }
object{ARC(2.667000,0.127000,25.210271,38.248808,0.036000) translate<123.190500,0.000000,78.739900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<124.326000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<124.594000,0.000000,78.867000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,0.000000,0> translate<124.326000,0.000000,78.867000> }
object{ARC(2.667000,0.127000,154.789729,177.268478,0.036000) translate<123.190000,0.000000,78.739900>}
object{ARC(2.667000,0.127000,177.272769,205.210271,0.036000) translate<123.190000,0.000000,78.740100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<120.526000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.786000,0.000000,78.867000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,0.000000,0> translate<120.526000,0.000000,78.867000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.786000,0.000000,78.867000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<122.054000,0.000000,78.867000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,0.000000,0> translate<121.786000,0.000000,78.867000> }
object{ARC(2.667000,0.127000,141.751192,155.360649,0.036000) translate<123.189500,0.000000,78.739900>}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,64.008000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,79.502000>}
box{<0,0,-0.076200><15.494000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.381000,0.000000,79.502000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,61.341000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.445000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,56.261000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.397000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,56.261000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,56.261000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.889000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,56.261000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.381000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,87.249000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.381000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,87.249000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.889000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,87.249000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.397000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,87.249000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,58.801000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.889000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,61.341000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.889000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.889000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,61.468000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.397000,0.000000,61.468000> }
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<3.810000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,62.230000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.445000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,62.484000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.445000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,61.468000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.397000,0.000000,61.468000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,62.484000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,81.026000>}
box{<0,0,-0.076200><18.542000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.445000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,81.026000>}
box{<0,0,-0.076200><18.542000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.207000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.207000,0.000000,81.026000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,81.280000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.445000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,82.169000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.445000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,87.249000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.889000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,82.169000>}
box{<0,0,-0.076200><20.828000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.889000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,84.709000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.889000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.889000,0.000000,82.169000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.889000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,82.042000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,82.042000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.397000,0.000000,82.042000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,82.042000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.397000,0.000000,82.169000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.397000,0.000000,82.169000> }
object{ARC(0.635000,0.152400,0.000000,90.000000,0.036000) translate<3.810000,0.000000,81.407000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,56.896000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,56.261000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.605000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,56.261000>}
box{<0,0,-0.076200><10.033000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.572000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,61.722000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,56.896000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,56.896000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,61.722000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.732000,0.000000,62.230000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<14.732000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.732000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,62.230000>}
box{<0,0,-0.076200><10.287000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.732000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,81.280000>}
box{<0,0,-0.076200><10.287000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.732000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,81.788000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.732000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,81.788000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,86.741000>}
box{<0,0,-0.076200><4.953000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.732000,0.000000,87.249000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<14.732000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.732000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.572000,0.000000,87.249000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.572000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<13.208000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<12.192000,0.000000,71.755000>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<12.192000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<13.208000,0.000000,69.011800>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<12.192000,0.000000,69.011800>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<12.192000,0.000000,69.011800> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<13.208000,0.000000,66.268600>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<12.192000,0.000000,66.268600>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<12.192000,0.000000,66.268600> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<10.668000,0.000000,67.640200>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<9.652000,0.000000,67.640200>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<9.652000,0.000000,67.640200> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<10.668000,0.000000,70.383400>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<9.652000,0.000000,70.383400>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<9.652000,0.000000,70.383400> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<10.668000,0.000000,73.101200>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<9.652000,0.000000,73.101200>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<9.652000,0.000000,73.101200> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<13.208000,0.000000,74.498200>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<12.192000,0.000000,74.498200>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<12.192000,0.000000,74.498200> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<10.668000,0.000000,75.869800>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<9.652000,0.000000,75.869800>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<9.652000,0.000000,75.869800> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<13.208000,0.000000,77.241400>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<12.192000,0.000000,77.241400>}
box{<0,0,-0.406400><1.016000,0.036000,0.406400> rotate<0,0.000000,0> translate<12.192000,0.000000,77.241400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,87.249000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.445000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,64.008000>}
box{<0,0,-0.076200><7.747000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.381000,0.000000,64.008000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,79.502000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.381000,0.000000,87.249000>}
box{<0,0,-0.076200><7.747000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.381000,0.000000,87.249000> }
difference{
cylinder{<12.065000,0,59.232800><12.065000,0.036000,59.232800>1.727200 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,59.232800><12.065000,0.135000,59.232800>1.574800 translate<0,0.000000,0>}}
difference{
cylinder{<12.065000,0,84.277200><12.065000,0.036000,84.277200>1.727200 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,84.277200><12.065000,0.135000,84.277200>1.574800 translate<0,0.000000,0>}}
box{<-0.406400,0,-3.619500><0.406400,0.036000,3.619500> rotate<0,-90.000000,0> translate<8.826500,0.000000,66.268600>}
box{<-0.406400,0,-2.349500><0.406400,0.036000,2.349500> rotate<0,-90.000000,0> translate<7.556500,0.000000,67.640200>}
box{<-0.406400,0,-3.619500><0.406400,0.036000,3.619500> rotate<0,-90.000000,0> translate<8.826500,0.000000,69.011800>}
box{<-0.406400,0,-2.349500><0.406400,0.036000,2.349500> rotate<0,-90.000000,0> translate<7.556500,0.000000,70.383400>}
box{<-0.406400,0,-3.619500><0.406400,0.036000,3.619500> rotate<0,-90.000000,0> translate<8.826500,0.000000,71.729600>}
box{<-0.406400,0,-2.349500><0.406400,0.036000,2.349500> rotate<0,-90.000000,0> translate<7.556500,0.000000,73.101200>}
box{<-0.406400,0,-3.619500><0.406400,0.036000,3.619500> rotate<0,-90.000000,0> translate<8.826500,0.000000,74.498200>}
box{<-0.406400,0,-2.349500><0.406400,0.036000,2.349500> rotate<0,-90.000000,0> translate<7.556500,0.000000,75.869800>}
box{<-0.406400,0,-3.619500><0.406400,0.036000,3.619500> rotate<0,-90.000000,0> translate<8.826500,0.000000,77.241400>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  Z80_CONTROL(-80.000000,0,-50.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
