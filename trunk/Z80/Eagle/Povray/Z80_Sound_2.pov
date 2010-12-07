//POVRay-Datei erstellt mit 3d41.ulp v1.05
//X:/Z80/Eagle/Z80_Sound_2.brd
//07.12.2010 10:40:26

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
#local cam_y = 430;
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

#local lgt1_pos_x = 30;
#local lgt1_pos_y = 56;
#local lgt1_pos_z = 53;
#local lgt1_intense = 0.814271;
#local lgt2_pos_x = -30;
#local lgt2_pos_y = 56;
#local lgt2_pos_z = 53;
#local lgt2_intense = 0.814271;
#local lgt3_pos_x = 30;
#local lgt3_pos_y = 56;
#local lgt3_pos_z = -36;
#local lgt3_intense = 0.814271;
#local lgt4_pos_x = -30;
#local lgt4_pos_y = 56;
#local lgt4_pos_z = -36;
#local lgt4_intense = 0.814271;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 79.990000;
#declare pcb_y_size = 100.000000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(269);
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
	//translate<-39.995000,0,-50.000000>
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


#macro Z80_SOUND_2(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Platine
prism{-1.500000,0.000000,8
<0.000000,0.000000><79.990000,0.000000>
<79.990000,0.000000><79.990000,100.000000>
<79.990000,100.000000><0.000000,100.000000>
<0.000000,100.000000><0.000000,0.000000>
texture{col_brd}}
}//End union(Platine)
//Bohrungen(real)/Bauteile
cylinder{<76.200000,1,96.520000><76.200000,-5,96.520000>1.500000 texture{col_hls}}
cylinder{<76.200000,1,3.810000><76.200000,-5,3.810000>1.500000 texture{col_hls}}
cylinder{<3.810000,1,3.810000><3.810000,-5,3.810000>1.500000 texture{col_hls}}
cylinder{<3.810000,1,96.520000><3.810000,-5,96.520000>1.500000 texture{col_hls}}
//Bohrungen(real)/Platine
//Bohrungen(real)/Durchkontaktierungen
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Bauteile
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_WIMA_5_035_072_085("22n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<45.720000,0.000000,43.180000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C1 22n C050-035X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_WIMA_5_035_072_085("22n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<40.640000,0.000000,43.180000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C2 22n C050-035X075
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_WIMA_5_035_072_085("1n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<29.210000,0.000000,39.370000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C3 1n C050-035X075
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_ELKO_5MM_10MM_2("470µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<12.700000,0.000000,54.610000>}#end		//Elko C4 470µ E3,5-10
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_CERAMIC_25MM_44MM("470p",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<25.400000,0.000000,48.260000>}#end		//ceramic disc capacitator C5 470p C025-024X044
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_ELKO_3MM5_8MM("220µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<5.715000,0.000000,32.385000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C6 220µ E3,5-8
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<8.890000,0.000000,80.010000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C7 100n C050-030X075
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<49.530000,0.000000,30.480000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C8 100n C050-030X075
#ifndef(pack_C9) #declare global_pack_C9=yes; object {CAP_DIS_ELKO_3MM5_8MM("10µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<15.240000,0.000000,36.830000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C9 10µ E3,5-8
#ifndef(pack_C10) #declare global_pack_C10=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<58.420000,0.000000,11.430000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C10 100n C050-030X075
#ifndef(pack_C11) #declare global_pack_C11=yes; object {CAP_DIS_CERAMIC_25MM_44MM("27p",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<59.690000,0.000000,5.080000>}#end		//ceramic disc capacitator C11 27p C025-024X044
#ifndef(pack_C12) #declare global_pack_C12=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<63.500000,0.000000,91.440000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C12 100n C050-030X075
#ifndef(pack_C13) #declare global_pack_C13=yes; object {CAP_DIS_ELKO_3MM5_8MM("4µ7",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<48.260000,0.000000,22.860000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C13 4µ7 E3,5-8
#ifndef(pack_C14) #declare global_pack_C14=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<30.480000,0.000000,63.500000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C14 100n C050-030X075
#ifndef(pack_C15) #declare global_pack_C15=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<12.700000,0.000000,72.390000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C15 100n C050-030X075
#ifndef(pack_C16) #declare global_pack_C16=yes; object {CAP_DIS_ELKO_3MM5_8MM("220µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<12.700000,0.000000,64.770000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C16 220µ E3,5-8
#ifndef(pack_C17) #declare global_pack_C17=yes; object {CAP_DIS_CERAMIC_50MM_44MM("47n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<5.080000,0.000000,50.165000>}#end		//ceramic disc capacitator C17 47n C050-024X044
#ifndef(pack_C18) #declare global_pack_C18=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<39.370000,0.000000,71.120000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C18 100n C050-030X075
#ifndef(pack_C19) #declare global_pack_C19=yes; object {CAP_DIS_ELKO_3MM5_8MM("22µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<27.940000,0.000000,6.350000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C19 22µ E3,5-8
#ifndef(pack_C20) #declare global_pack_C20=yes; object {CAP_DIS_ELKO_3MM5_8MM("47µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<33.020000,0.000000,29.210000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C20 47µ E3,5-8
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO35_076MM_H("1N4148",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<45.720000,0.000000,11.430000>}#end		//Diode DO35 7mm hor. D1 1N4148 DO35-7
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO35_076MM_H("1N4148",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<15.240000,0.000000,27.940000>}#end		//Diode DO35 7mm hor. D2 1N4148 DO35-7
#ifndef(pack_D3) #declare global_pack_D3=yes; object {DIODE_DIS_DO35_076MM_H("1N4148",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<15.240000,0.000000,17.780000>}#end		//Diode DO35 7mm hor. D3 1N4148 DO35-7
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP28_W("8580 SID","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,58.420000>translate<0,3.000000,0> }#end		//DIP28 600mil IC1 8580 SID DIL28-6
#ifndef(pack_IC1) object{SOCKET_DIP28W()rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,58.420000>}#end					//IC-Sockel 28Pin 600mil IC1 8580 SID
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP28("PIC18F2525","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,82.550000>translate<0,3.000000,0> }#end		//DIP28 300mil IC2 PIC18F2525 DIL28-3
#ifndef(pack_IC2) object{SOCKET_DIP28()rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,82.550000>}#end					//IC-Sockel 28Pin IC2 PIC18F2525
#ifndef(pack_IC4) #declare global_pack_IC4=yes; object {IC_DIS_DIP14("74LS04","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<63.500000,0.000000,22.860000>translate<0,3.000000,0> }#end		//DIP14 IC4 74LS04 DIL14
#ifndef(pack_IC4) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<63.500000,0.000000,22.860000>}#end					//IC-Sockel 14Pin IC4 74LS04
#ifndef(pack_IC5) #declare global_pack_IC5=yes; object {IC_DIS_DIP14("74LS74N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<63.500000,0.000000,36.830000>translate<0,3.000000,0> }#end		//DIP14 IC5 74LS74N DIL14
#ifndef(pack_IC5) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<63.500000,0.000000,36.830000>}#end					//IC-Sockel 14Pin IC5 74LS74N
#ifndef(pack_IC6) #declare global_pack_IC6=yes; object {TR_TO220_S("7809",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<20.320000,0.000000,63.500000>}#end		//TO220 stehend IC6 7809 TO220V
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<39.370000,0.000000,22.860000>}#end		//Diskrete 5MM LED LED1  LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<75.565000,0.000000,29.210000>}#end		//Diskrete 5MM LED LED2  LED5MM
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {SPC_XTAL_5MM("4 MHz",12,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<67.310000,0.000000,10.160000>}#end		//Quarz 4,9MM Q1 4 MHz HC49/S
#ifndef(pack_Q2) #declare global_pack_Q2=yes; object {TR_TO92_L("BC548",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<20.320000,0.000000,46.990000>}#end		//TO92 gerade stehend Q2 BC548 TO92-EBC
#ifndef(pack_Q3) #declare global_pack_Q3=yes; object {TR_TO92_L("BC548",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<7.620000,0.000000,22.860000>}#end		//TO92 gerade stehend Q3 BC548 TO92-EBC
#ifndef(pack_Q4) #declare global_pack_Q4=yes; object {TR_TO92_L("BC558C",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<5.080000,0.000000,13.970000>}#end		//TO92 gerade stehend Q4 BC558C TO92-EBC
#ifndef(pack_Q5) #declare global_pack_Q5=yes; object {TR_TO92_L("BC548",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<25.400000,0.000000,27.940000>}#end		//TO92 gerade stehend Q5 BC548 TO92-EBC
#ifndef(pack_QG1) #declare global_pack_QG1=yes; object {SPC_XTAL_OSZ_DIP14("40 MHz",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<21.590000,0.000000,82.550000>}#end		//Quarzoszillator im DIP14 QG1 40 MHz DIL14S
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<33.020000,0.000000,49.530000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R1 1K 0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<29.210000,0.000000,49.530000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R2 10K 0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<10.160000,0.000000,43.180000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R3 1K 0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<15.240000,0.000000,22.860000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R4 4K7 0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<54.610000,0.000000,11.430000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R5 680R 0207/10
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<67.310000,0.000000,15.240000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R6 680R 0207/10
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<49.530000,0.000000,11.430000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R7 10K 0207/10
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<29.210000,0.000000,71.120000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R8 47K 0207/10
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<39.370000,0.000000,11.430000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R9 470R 0207/10
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<15.240000,0.000000,12.700000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R10 4K7 0207/10
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<5.080000,0.000000,59.690000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R11 10R 0207/10
#ifndef(pack_R12) #declare global_pack_R12=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<26.670000,0.000000,92.710000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R12 4K7 0207/10
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<27.940000,0.000000,12.700000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R13 4K7 0207/10
#ifndef(pack_R14) #declare global_pack_R14=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Yellow}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<27.940000,0.000000,17.780000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R14 120K 0207/10
#ifndef(pack_R15) #declare global_pack_R15=yes; object {RES_DIS_0207_10MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<27.940000,0.000000,22.860000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R15 22K 0207/10
#ifndef(pack_R16) #declare global_pack_R16=yes; object {RES_DIS_0207_10MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<25.400000,0.000000,39.370000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R16 22K 0207/10
#ifndef(pack_R17) #declare global_pack_R17=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<74.930000,0.000000,49.530000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R17 470R 0207/10
#ifndef(pack_SV1) #declare global_pack_SV1=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<46.990000,0.000000,91.440000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (con-lstb.lib) SV1 comm MA08-1
#ifndef(pack_SV2) #declare global_pack_SV2=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<3.810000,0.000000,41.910000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (con-lstb.lib) SV2 audio out MA03-1
#ifndef(pack_SV3) #declare global_pack_SV3=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<3.810000,0.000000,87.630000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (con-lstb.lib) SV3 5V MA03-1
#ifndef(pack_SV4) #declare global_pack_SV4=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<3.810000,0.000000,71.120000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (con-lstb.lib) SV4 12V MA03-1
}//End union
#end
#if(pcb_pads_smds=on)
//Lötaugen&SMD/Bauteile
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<40.640000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<40.640000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<12.700000,0,56.388000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<12.700000,0,52.832000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<3.937000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<7.493000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<8.890000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<8.890000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<52.070000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<46.990000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<15.240000,0,38.608000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<15.240000,0,35.052000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<58.420000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<58.420000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<58.420000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<60.960000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<60.960000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<66.040000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_C13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.260000,0,21.082000> texture{col_thl}}
#ifndef(global_pack_C13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<48.260000,0,24.638000> texture{col_thl}}
#ifndef(global_pack_C14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<30.480000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_C14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<30.480000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_C15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.160000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_C15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.240000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_C16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<12.700000,0,66.548000> texture{col_thl}}
#ifndef(global_pack_C16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<12.700000,0,62.992000> texture{col_thl}}
#ifndef(global_pack_C17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,47.625000> texture{col_thl}}
#ifndef(global_pack_C17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,52.705000> texture{col_thl}}
#ifndef(global_pack_C18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<36.830000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_C18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<41.910000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_C19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<29.718000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_C19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<26.162000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_C20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<33.020000,0,27.432000> texture{col_thl}}
#ifndef(global_pack_C20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<33.020000,0,30.988000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<11.430000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<19.050000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<11.430000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<71.120000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.960000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.420000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.860000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.860000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.860000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<39.370000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<39.370000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<75.565000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<75.565000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<69.723000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<64.897000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<21.590000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<21.590000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<21.590000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<6.350000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<6.350000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<6.350000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<13.970000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<29.210000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<29.210000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<13.970000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<33.020000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<33.020000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<10.160000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<10.160000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<20.320000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<10.160000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<54.610000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<54.610000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<72.390000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<62.230000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<49.530000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<49.530000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<34.290000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<39.370000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<39.370000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.160000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<20.320000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<31.750000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<21.590000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<22.860000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<33.020000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<22.860000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<33.020000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<33.020000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<22.860000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_R17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<74.930000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_R17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<74.930000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<55.880000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<53.340000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<50.800000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<48.260000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<45.720000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<43.180000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<40.640000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<38.100000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_SV3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_SV3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,87.630000> texture{col_thl}}
#ifndef(global_pack_SV3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_SV4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_SV4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_SV4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.727200,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<3.810000,0,73.660000> texture{col_thl}}
//Lötaugen/Durchkontaktierungen
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<53.340000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<73.660000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<72.390000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<49.530000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<71.755000,0,69.215000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<53.975000,0,69.215000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<58.420000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<33.020000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<60.960000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<74.295000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<35.560000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<27.940000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<29.210000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<44.450000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<17.780000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.511200,0.800000,1,16,2,0) translate<17.780000,0,66.040000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signale
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.810000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.810000,-1.535000,32.385000>}
box{<0,0,-0.508000><12.065000,0.035000,0.508000> rotate<0,90.000000,0> translate<3.810000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.810000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.937000,-1.535000,32.385000>}
box{<0,0,-0.508000><0.127000,0.035000,0.508000> rotate<0,0.000000,0> translate<3.810000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.810000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,44.450000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<3.810000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,47.625000>}
box{<0,0,-0.508000><3.175000,0.035000,0.508000> rotate<0,90.000000,0> translate<5.080000,-1.535000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,54.610000>}
box{<0,0,-0.508000><1.905000,0.035000,0.508000> rotate<0,90.000000,0> translate<5.080000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.810000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,20.320000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<3.810000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,20.320000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,90.000000,0> translate<6.350000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<6.350000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<6.350000,-1.535000,26.670000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,90.000000,0> translate<6.350000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,44.450000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.080000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<3.810000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<6.350000,-1.535000,73.660000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<3.810000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.493000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.493000,-1.535000,32.258000>}
box{<0,0,-0.508000><0.127000,0.035000,0.508000> rotate<0,-90.000000,0> translate<7.493000,-1.535000,32.258000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.493000,-1.535000,32.258000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,32.385000>}
box{<0,0,-0.508000><0.179605,0.035000,0.508000> rotate<0,-44.997030,0> translate<7.493000,-1.535000,32.258000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,43.180000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<6.350000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,43.180000>}
box{<0,0,-0.508000><10.795000,0.035000,0.508000> rotate<0,90.000000,0> translate<7.620000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<6.350000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,72.390000>}
box{<0,0,-0.711200><1.796051,0.035000,0.711200> rotate<0,44.997030,0> translate<6.350000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,72.390000>}
box{<0,0,-0.711200><11.430000,0.035000,0.711200> rotate<0,90.000000,0> translate<7.620000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,12.700000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,-90.000000,0> translate<10.160000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,13.970000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<6.350000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,16.510000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,90.000000,0> translate<10.160000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,22.860000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<6.350000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,26.670000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,90.000000,0> translate<10.160000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<6.350000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.160000,-1.535000,30.480000>}
box{<0,0,-0.711200><5.388154,0.035000,0.711200> rotate<0,-44.997030,0> translate<6.350000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.160000,-1.535000,72.390000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<7.620000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.922000,-1.535000,57.658000>}
box{<0,0,-0.711200><4.669733,0.035000,0.711200> rotate<0,44.997030,0> translate<7.620000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,17.780000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<10.160000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,27.940000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<10.160000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.160000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<11.430000,-1.535000,30.480000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,0.000000,0> translate<10.160000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<11.430000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<11.430000,-1.535000,35.560000>}
box{<0,0,-0.711200><5.080000,0.035000,0.711200> rotate<0,90.000000,0> translate<11.430000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<11.430000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,36.830000>}
box{<0,0,-0.711200><1.796051,0.035000,0.711200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,57.658000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,56.388000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,-90.000000,0> translate<12.700000,-1.535000,56.388000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.922000,-1.535000,57.658000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,57.658000>}
box{<0,0,-0.711200><1.778000,0.035000,0.711200> rotate<0,0.000000,0> translate<10.922000,-1.535000,57.658000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<8.890000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,86.360000>}
box{<0,0,-0.711200><5.388154,0.035000,0.711200> rotate<0,-44.997030,0> translate<8.890000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,66.548000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<13.208000,-1.535000,66.040000>}
box{<0,0,-0.711200><0.718420,0.035000,0.711200> rotate<0,44.997030,0> translate<12.700000,-1.535000,66.548000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<13.970000,-1.535000,86.360000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,0.000000,0> translate<12.700000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,57.658000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<14.478000,-1.535000,57.658000>}
box{<0,0,-0.711200><1.778000,0.035000,0.711200> rotate<0,0.000000,0> translate<12.700000,-1.535000,57.658000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,48.260000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,0.000000,0> translate<10.160000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,48.260000>}
box{<0,0,-0.508000><9.652000,0.035000,0.508000> rotate<0,90.000000,0> translate<15.240000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,49.530000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,90.000000,0> translate<15.240000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,13.970000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,90.000000,0> translate<17.780000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,26.670000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,90.000000,0> translate<17.780000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.700000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,36.830000>}
box{<0,0,-0.711200><5.080000,0.035000,0.711200> rotate<0,0.000000,0> translate<12.700000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,44.450000>}
box{<0,0,-0.711200><7.620000,0.035000,0.711200> rotate<0,90.000000,0> translate<17.780000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<14.478000,-1.535000,57.658000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,60.960000>}
box{<0,0,-0.711200><4.669733,0.035000,0.711200> rotate<0,-44.997030,0> translate<14.478000,-1.535000,57.658000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<13.208000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,66.040000>}
box{<0,0,-0.711200><4.572000,0.035000,0.711200> rotate<0,0.000000,0> translate<13.208000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,0.000000,66.040000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,10.160000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<17.780000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,15.240000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<17.780000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,17.780000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,90.000000,0> translate<19.050000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,19.050000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<17.780000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,19.050000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,90.000000,0> translate<19.050000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,27.940000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<17.780000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,21.590000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,-90.000000,0> translate<20.320000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,22.860000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,-90.000000,0> translate<20.320000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<21.590000,-1.535000,44.450000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,0.000000,0> translate<17.780000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<21.590000,-1.535000,49.530000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,0.000000,0> translate<15.240000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.352000,-1.535000,10.160000>}
box{<0,0,-0.508000><3.302000,0.035000,0.508000> rotate<0,0.000000,0> translate<19.050000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,12.700000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,-90.000000,0> translate<22.860000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,17.780000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,-90.000000,0> translate<22.860000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,19.050000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,44.997030,0> translate<20.320000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,26.670000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<20.320000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,26.670000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,-90.000000,0> translate<22.860000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.860000,-1.535000,30.480000>}
box{<0,0,-0.508000><11.430000,0.035000,0.508000> rotate<0,0.000000,0> translate<11.430000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<22.860000,-1.535000,60.960000>}
box{<0,0,-0.711200><5.080000,0.035000,0.711200> rotate<0,0.000000,0> translate<17.780000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<17.780000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<22.860000,-1.535000,66.040000>}
box{<0,0,-0.711200><5.080000,0.035000,0.711200> rotate<0,0.000000,0> translate<17.780000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,35.052000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,35.052000>}
box{<0,0,-0.508000><8.890000,0.035000,0.508000> rotate<0,0.000000,0> translate<15.240000,-1.535000,35.052000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<13.970000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,86.360000>}
box{<0,0,-0.711200><10.160000,0.035000,0.711200> rotate<0,0.000000,0> translate<13.970000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,86.360000>}
box{<0,0,-0.711200><12.700000,0.035000,0.711200> rotate<0,90.000000,0> translate<24.130000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<3.810000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,90.170000>}
box{<0,0,-0.711200><20.320000,0.035000,0.711200> rotate<0,0.000000,0> translate<3.810000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,90.170000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,90.000000,0> translate<24.130000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,35.052000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,34.290000>}
box{<0,0,-0.508000><1.481062,0.035000,0.508000> rotate<0,30.961713,0> translate<24.130000,-1.535000,35.052000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<21.590000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,46.990000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<21.590000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<21.590000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,49.530000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<21.590000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.352000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.162000,-1.535000,6.350000>}
box{<0,0,-0.508000><5.388154,0.035000,0.508000> rotate<0,44.997030,0> translate<22.352000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,25.400000>}
box{<0,0,-0.508000><8.890000,0.035000,0.508000> rotate<0,90.000000,0> translate<26.670000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,30.480000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,-90.000000,0> translate<26.670000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,33.020000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<25.400000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,55.880000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,52.070000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<26.670000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,57.150000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<26.670000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<27.940000,-1.535000,73.660000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,0.000000,0> translate<24.130000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.210000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.210000,-1.535000,41.910000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,-90.000000,0> translate<29.210000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.210000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.210000,-1.535000,44.450000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,-90.000000,0> translate<29.210000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.210000,-1.535000,46.990000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<25.400000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<27.940000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,73.660000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,0.000000,0> translate<27.940000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<24.130000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,95.250000>}
box{<0,0,-0.711200><7.184205,0.035000,0.711200> rotate<0,-44.997030,0> translate<24.130000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.718000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,-1.535000,7.620000>}
box{<0,0,-0.508000><1.481062,0.035000,0.508000> rotate<0,-59.032347,0> translate<29.718000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,-1.535000,12.700000>}
box{<0,0,-0.508000><5.388154,0.035000,0.508000> rotate<0,44.997030,0> translate<26.670000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,-1.535000,12.700000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,90.000000,0> translate<30.480000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<22.860000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<30.480000,-1.535000,66.040000>}
box{<0,0,-0.711200><7.620000,0.035000,0.711200> rotate<0,0.000000,0> translate<22.860000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,12.700000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<30.480000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,22.860000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,90.000000,0> translate<33.020000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,27.432000>}
box{<0,0,-0.508000><4.572000,0.035000,0.508000> rotate<0,90.000000,0> translate<33.020000,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,27.940000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,0.000000,0> translate<26.670000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,27.940000>}
box{<0,0,-0.508000><0.508000,0.035000,0.508000> rotate<0,90.000000,0> translate<33.020000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.210000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,54.610000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<29.210000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<29.210000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,82.550000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.290000,-1.535000,54.610000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<33.020000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,57.150000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,52.070000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,66.040000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<27.940000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,66.040000>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.560000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.290000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,92.710000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.750000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,50.800000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<38.100000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<30.480000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<38.100000,-1.535000,66.040000>}
box{<0,0,-0.711200><7.620000,0.035000,0.711200> rotate<0,0.000000,0> translate<30.480000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<38.100000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,86.360000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<38.100000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,91.440000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<36.830000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,24.130000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,-90.000000,0> translate<39.370000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<35.560000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<39.370000,-1.535000,34.290000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,0.000000,0> translate<35.560000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,62.230000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<34.290000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<38.100000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,72.390000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,40.640000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<38.100000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,50.800000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.290000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.640000,-1.535000,60.960000>}
box{<0,0,-0.508000><8.980256,0.035000,0.508000> rotate<0,-44.997030,0> translate<34.290000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.640000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.640000,-1.535000,66.040000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,90.000000,0> translate<40.640000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,78.740000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<40.640000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,68.580000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.910000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,-1.535000,74.295000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<42.545000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,19.050000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,50.800000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<41.910000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,69.850000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,74.930000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<42.545000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,78.740000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<42.545000,-1.535000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,71.120000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,0.000000,73.660000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,7.620000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<43.180000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,40.640000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<43.180000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,50.800000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.720000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.720000,-1.535000,66.040000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,-90.000000,0> translate<45.720000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.720000,-1.535000,72.390000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<44.450000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,6.350000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<45.720000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,22.860000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.180000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,53.340000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<45.720000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,74.930000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<46.990000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,15.240000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,45.720000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<48.260000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<48.260000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,52.070000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<46.990000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,78.740000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,6.350000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.990000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<48.260000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,21.082000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,21.082000>}
box{<0,0,-0.304800><4.572000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.530000,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<48.260000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,54.610000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<41.910000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<48.260000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,71.120000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.530000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.800000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,55.880000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<44.450000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,78.740000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.800000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.800000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,22.860000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.990000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,45.720000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<50.800000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,57.150000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<46.990000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<50.800000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,71.120000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.070000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,17.145000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.705000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.832000,-1.535000,21.082000>}
box{<0,0,-0.304800><3.302000,0.035000,0.304800> rotate<0,0.000000,0> translate<49.530000,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,58.420000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<49.530000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,69.215000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<53.340000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,6.350000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<52.705000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.705000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.832000,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.514472,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.832000,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,59.690000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<52.070000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,7.620000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.610000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,26.670000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<52.070000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,30.480000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,0.000000,0> translate<52.070000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,30.480000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,90.000000,0> translate<55.880000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,33.020000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,90.000000,0> translate<55.880000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<39.370000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,34.290000>}
box{<0,0,-0.711200><16.510000,0.035000,0.711200> rotate<0,0.000000,0> translate<39.370000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,34.290000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,90.000000,0> translate<55.880000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,36.830000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,90.000000,0> translate<55.880000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<55.880000,-1.535000,40.640000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,90.000000,0> translate<55.880000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,71.120000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,91.440000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,54.610000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<49.530000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.880000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,83.820000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,5.080000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.420000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,7.620000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,13.970000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.420000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,26.670000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,44.450000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,50.800000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.420000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<57.150000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,71.120000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,76.200000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<58.420000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<58.420000,-1.535000,86.360000>}
box{<0,0,-0.711200><5.080000,0.035000,0.711200> rotate<0,-90.000000,0> translate<58.420000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<58.420000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<58.420000,-1.535000,91.440000>}
box{<0,0,-0.711200><3.810000,0.035000,0.711200> rotate<0,-90.000000,0> translate<58.420000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.210000,-1.535000,95.250000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<58.420000,-1.535000,95.250000>}
box{<0,0,-0.711200><29.210000,0.035000,0.711200> rotate<0,0.000000,0> translate<29.210000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<58.420000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,55.880000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<58.420000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,82.550000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.690000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,11.430000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<58.420000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,15.240000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,22.860000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,33.020000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<60.960000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,54.610000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<59.690000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,71.120000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<58.420000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<60.960000,-1.535000,91.440000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<58.420000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,15.240000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,30.480000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.230000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,36.830000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.960000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,57.150000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,69.850000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.960000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,81.280000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.960000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,33.020000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<63.500000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<62.230000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,50.800000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<63.500000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,55.880000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<62.230000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,66.040000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,71.120000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.230000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,78.740000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<63.500000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,29.210000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,29.210000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.770000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,38.100000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<64.770000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,58.420000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,71.120000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.770000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.897000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,11.303000>}
box{<0,0,-0.304800><1.616446,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.897000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,15.240000>}
box{<0,0,-0.304800><3.937000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,35.560000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<63.500000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,40.640000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.040000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,44.450000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.420000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,50.800000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.040000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,57.150000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<64.770000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,69.850000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.770000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,78.740000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,83.820000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.150000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,86.360000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,7.620000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.420000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,30.480000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,59.690000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,20.320000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<64.770000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,26.670000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.310000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,40.640000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.580000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,45.720000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,50.800000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.580000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<67.310000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,72.390000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<66.040000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,78.740000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,82.550000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.723000,-1.535000,10.033000>}
box{<0,0,-0.304800><3.412497,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.310000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.723000,-1.535000,10.033000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.723000,-1.535000,10.160000>}
box{<0,0,-0.304800><0.127000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.723000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,29.210000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<69.850000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,38.100000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.770000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,48.260000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,59.690000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.850000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,62.230000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,75.565000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.850000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,26.670000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<71.120000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,27.940000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<69.850000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,39.370000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<69.850000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,40.640000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,60.960000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,66.040000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,77.470000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,-56.306216,0> translate<69.850000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,81.280000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,86.360000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,0.000000,69.215000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.975000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,-1.535000,75.565000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.755000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,15.240000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.040000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,44.450000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,0.000000,0> translate<49.530000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.755000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,77.470000>}
box{<0,0,-0.304800><2.289525,0.035000,0.304800> rotate<0,-56.306216,0> translate<71.755000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,88.900000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,88.900000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<73.025000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,39.370000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<69.850000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,39.370000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.660000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<72.390000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.390000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,0.000000,73.660000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,73.660000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<73.660000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,76.200000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,44.450000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.930000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,72.390000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.930000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,30.480000>}
box{<0,0,-0.304800><1.419903,0.035000,0.304800> rotate<0,63.430762,0> translate<74.930000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,73.025000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<74.930000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<74.295000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,74.930000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<75.565000,-1.535000,74.930000> }
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
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.000000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,0.000000>}
box{<0,0,-0.304800><80.010000,0.035000,0.304800> rotate<0,0.000000,0> translate<0.000000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.000000,-1.535000,100.330000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.000000,-1.535000,0.000000>}
box{<0,0,-0.304800><100.330000,0.035000,0.304800> rotate<0,-90.000000,0> translate<0.000000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.000000,-1.535000,100.330000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,100.330000>}
box{<0,0,-0.304800><80.010000,0.035000,0.304800> rotate<0,0.000000,0> translate<0.000000,-1.535000,100.330000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,100.330000>}
box{<0,0,-0.304800><100.330000,0.035000,0.304800> rotate<0,90.000000,0> translate<80.010000,-1.535000,100.330000> }
texture{col_pol}
}
#end
union{
cylinder{<45.720000,0.038000,45.720000><45.720000,-1.538000,45.720000>0.406400}
cylinder{<45.720000,0.038000,40.640000><45.720000,-1.538000,40.640000>0.406400}
cylinder{<40.640000,0.038000,45.720000><40.640000,-1.538000,45.720000>0.406400}
cylinder{<40.640000,0.038000,40.640000><40.640000,-1.538000,40.640000>0.406400}
cylinder{<29.210000,0.038000,36.830000><29.210000,-1.538000,36.830000>0.406400}
cylinder{<29.210000,0.038000,41.910000><29.210000,-1.538000,41.910000>0.406400}
cylinder{<12.700000,0.038000,56.388000><12.700000,-1.538000,56.388000>0.406400}
cylinder{<12.700000,0.038000,52.832000><12.700000,-1.538000,52.832000>0.406400}
cylinder{<25.400000,0.038000,46.990000><25.400000,-1.538000,46.990000>0.406400}
cylinder{<25.400000,0.038000,49.530000><25.400000,-1.538000,49.530000>0.406400}
cylinder{<3.937000,0.038000,32.385000><3.937000,-1.538000,32.385000>0.406400}
cylinder{<7.493000,0.038000,32.385000><7.493000,-1.538000,32.385000>0.406400}
cylinder{<8.890000,0.038000,82.550000><8.890000,-1.538000,82.550000>0.406400}
cylinder{<8.890000,0.038000,77.470000><8.890000,-1.538000,77.470000>0.406400}
cylinder{<52.070000,0.038000,30.480000><52.070000,-1.538000,30.480000>0.406400}
cylinder{<46.990000,0.038000,30.480000><46.990000,-1.538000,30.480000>0.406400}
cylinder{<15.240000,0.038000,38.608000><15.240000,-1.538000,38.608000>0.406400}
cylinder{<15.240000,0.038000,35.052000><15.240000,-1.538000,35.052000>0.406400}
cylinder{<58.420000,0.038000,13.970000><58.420000,-1.538000,13.970000>0.406400}
cylinder{<58.420000,0.038000,8.890000><58.420000,-1.538000,8.890000>0.406400}
cylinder{<58.420000,0.038000,5.080000><58.420000,-1.538000,5.080000>0.406400}
cylinder{<60.960000,0.038000,5.080000><60.960000,-1.538000,5.080000>0.406400}
cylinder{<60.960000,0.038000,91.440000><60.960000,-1.538000,91.440000>0.406400}
cylinder{<66.040000,0.038000,91.440000><66.040000,-1.538000,91.440000>0.406400}
cylinder{<48.260000,0.038000,21.082000><48.260000,-1.538000,21.082000>0.406400}
cylinder{<48.260000,0.038000,24.638000><48.260000,-1.538000,24.638000>0.406400}
cylinder{<30.480000,0.038000,66.040000><30.480000,-1.538000,66.040000>0.406400}
cylinder{<30.480000,0.038000,60.960000><30.480000,-1.538000,60.960000>0.406400}
cylinder{<10.160000,0.038000,72.390000><10.160000,-1.538000,72.390000>0.406400}
cylinder{<15.240000,0.038000,72.390000><15.240000,-1.538000,72.390000>0.406400}
cylinder{<12.700000,0.038000,66.548000><12.700000,-1.538000,66.548000>0.406400}
cylinder{<12.700000,0.038000,62.992000><12.700000,-1.538000,62.992000>0.406400}
cylinder{<5.080000,0.038000,47.625000><5.080000,-1.538000,47.625000>0.406400}
cylinder{<5.080000,0.038000,52.705000><5.080000,-1.538000,52.705000>0.406400}
cylinder{<36.830000,0.038000,71.120000><36.830000,-1.538000,71.120000>0.406400}
cylinder{<41.910000,0.038000,71.120000><41.910000,-1.538000,71.120000>0.406400}
cylinder{<29.718000,0.038000,6.350000><29.718000,-1.538000,6.350000>0.406400}
cylinder{<26.162000,0.038000,6.350000><26.162000,-1.538000,6.350000>0.406400}
cylinder{<33.020000,0.038000,27.432000><33.020000,-1.538000,27.432000>0.406400}
cylinder{<33.020000,0.038000,30.988000><33.020000,-1.538000,30.988000>0.406400}
cylinder{<45.720000,0.038000,15.240000><45.720000,-1.538000,15.240000>0.406400}
cylinder{<45.720000,0.038000,7.620000><45.720000,-1.538000,7.620000>0.406400}
cylinder{<11.430000,0.038000,27.940000><11.430000,-1.538000,27.940000>0.406400}
cylinder{<19.050000,0.038000,27.940000><19.050000,-1.538000,27.940000>0.406400}
cylinder{<19.050000,0.038000,17.780000><19.050000,-1.538000,17.780000>0.406400}
cylinder{<11.430000,0.038000,17.780000><11.430000,-1.538000,17.780000>0.406400}
cylinder{<38.100000,0.038000,50.800000><38.100000,-1.538000,50.800000>0.406400}
cylinder{<40.640000,0.038000,50.800000><40.640000,-1.538000,50.800000>0.406400}
cylinder{<43.180000,0.038000,50.800000><43.180000,-1.538000,50.800000>0.406400}
cylinder{<45.720000,0.038000,50.800000><45.720000,-1.538000,50.800000>0.406400}
cylinder{<48.260000,0.038000,50.800000><48.260000,-1.538000,50.800000>0.406400}
cylinder{<50.800000,0.038000,50.800000><50.800000,-1.538000,50.800000>0.406400}
cylinder{<53.340000,0.038000,50.800000><53.340000,-1.538000,50.800000>0.406400}
cylinder{<55.880000,0.038000,50.800000><55.880000,-1.538000,50.800000>0.406400}
cylinder{<58.420000,0.038000,50.800000><58.420000,-1.538000,50.800000>0.406400}
cylinder{<60.960000,0.038000,50.800000><60.960000,-1.538000,50.800000>0.406400}
cylinder{<63.500000,0.038000,50.800000><63.500000,-1.538000,50.800000>0.406400}
cylinder{<66.040000,0.038000,50.800000><66.040000,-1.538000,50.800000>0.406400}
cylinder{<68.580000,0.038000,50.800000><68.580000,-1.538000,50.800000>0.406400}
cylinder{<71.120000,0.038000,50.800000><71.120000,-1.538000,50.800000>0.406400}
cylinder{<71.120000,0.038000,66.040000><71.120000,-1.538000,66.040000>0.406400}
cylinder{<68.580000,0.038000,66.040000><68.580000,-1.538000,66.040000>0.406400}
cylinder{<66.040000,0.038000,66.040000><66.040000,-1.538000,66.040000>0.406400}
cylinder{<63.500000,0.038000,66.040000><63.500000,-1.538000,66.040000>0.406400}
cylinder{<60.960000,0.038000,66.040000><60.960000,-1.538000,66.040000>0.406400}
cylinder{<58.420000,0.038000,66.040000><58.420000,-1.538000,66.040000>0.406400}
cylinder{<55.880000,0.038000,66.040000><55.880000,-1.538000,66.040000>0.406400}
cylinder{<53.340000,0.038000,66.040000><53.340000,-1.538000,66.040000>0.406400}
cylinder{<50.800000,0.038000,66.040000><50.800000,-1.538000,66.040000>0.406400}
cylinder{<48.260000,0.038000,66.040000><48.260000,-1.538000,66.040000>0.406400}
cylinder{<45.720000,0.038000,66.040000><45.720000,-1.538000,66.040000>0.406400}
cylinder{<43.180000,0.038000,66.040000><43.180000,-1.538000,66.040000>0.406400}
cylinder{<40.640000,0.038000,66.040000><40.640000,-1.538000,66.040000>0.406400}
cylinder{<38.100000,0.038000,66.040000><38.100000,-1.538000,66.040000>0.406400}
cylinder{<38.100000,0.038000,78.740000><38.100000,-1.538000,78.740000>0.406400}
cylinder{<40.640000,0.038000,78.740000><40.640000,-1.538000,78.740000>0.406400}
cylinder{<43.180000,0.038000,78.740000><43.180000,-1.538000,78.740000>0.406400}
cylinder{<45.720000,0.038000,78.740000><45.720000,-1.538000,78.740000>0.406400}
cylinder{<48.260000,0.038000,78.740000><48.260000,-1.538000,78.740000>0.406400}
cylinder{<50.800000,0.038000,78.740000><50.800000,-1.538000,78.740000>0.406400}
cylinder{<53.340000,0.038000,78.740000><53.340000,-1.538000,78.740000>0.406400}
cylinder{<55.880000,0.038000,78.740000><55.880000,-1.538000,78.740000>0.406400}
cylinder{<58.420000,0.038000,78.740000><58.420000,-1.538000,78.740000>0.406400}
cylinder{<60.960000,0.038000,78.740000><60.960000,-1.538000,78.740000>0.406400}
cylinder{<63.500000,0.038000,78.740000><63.500000,-1.538000,78.740000>0.406400}
cylinder{<66.040000,0.038000,78.740000><66.040000,-1.538000,78.740000>0.406400}
cylinder{<68.580000,0.038000,78.740000><68.580000,-1.538000,78.740000>0.406400}
cylinder{<71.120000,0.038000,78.740000><71.120000,-1.538000,78.740000>0.406400}
cylinder{<71.120000,0.038000,86.360000><71.120000,-1.538000,86.360000>0.406400}
cylinder{<68.580000,0.038000,86.360000><68.580000,-1.538000,86.360000>0.406400}
cylinder{<66.040000,0.038000,86.360000><66.040000,-1.538000,86.360000>0.406400}
cylinder{<63.500000,0.038000,86.360000><63.500000,-1.538000,86.360000>0.406400}
cylinder{<60.960000,0.038000,86.360000><60.960000,-1.538000,86.360000>0.406400}
cylinder{<58.420000,0.038000,86.360000><58.420000,-1.538000,86.360000>0.406400}
cylinder{<55.880000,0.038000,86.360000><55.880000,-1.538000,86.360000>0.406400}
cylinder{<53.340000,0.038000,86.360000><53.340000,-1.538000,86.360000>0.406400}
cylinder{<50.800000,0.038000,86.360000><50.800000,-1.538000,86.360000>0.406400}
cylinder{<48.260000,0.038000,86.360000><48.260000,-1.538000,86.360000>0.406400}
cylinder{<45.720000,0.038000,86.360000><45.720000,-1.538000,86.360000>0.406400}
cylinder{<43.180000,0.038000,86.360000><43.180000,-1.538000,86.360000>0.406400}
cylinder{<40.640000,0.038000,86.360000><40.640000,-1.538000,86.360000>0.406400}
cylinder{<38.100000,0.038000,86.360000><38.100000,-1.538000,86.360000>0.406400}
cylinder{<55.880000,0.038000,19.050000><55.880000,-1.538000,19.050000>0.406400}
cylinder{<58.420000,0.038000,19.050000><58.420000,-1.538000,19.050000>0.406400}
cylinder{<60.960000,0.038000,19.050000><60.960000,-1.538000,19.050000>0.406400}
cylinder{<63.500000,0.038000,19.050000><63.500000,-1.538000,19.050000>0.406400}
cylinder{<66.040000,0.038000,19.050000><66.040000,-1.538000,19.050000>0.406400}
cylinder{<68.580000,0.038000,19.050000><68.580000,-1.538000,19.050000>0.406400}
cylinder{<71.120000,0.038000,19.050000><71.120000,-1.538000,19.050000>0.406400}
cylinder{<71.120000,0.038000,26.670000><71.120000,-1.538000,26.670000>0.406400}
cylinder{<68.580000,0.038000,26.670000><68.580000,-1.538000,26.670000>0.406400}
cylinder{<66.040000,0.038000,26.670000><66.040000,-1.538000,26.670000>0.406400}
cylinder{<63.500000,0.038000,26.670000><63.500000,-1.538000,26.670000>0.406400}
cylinder{<60.960000,0.038000,26.670000><60.960000,-1.538000,26.670000>0.406400}
cylinder{<58.420000,0.038000,26.670000><58.420000,-1.538000,26.670000>0.406400}
cylinder{<55.880000,0.038000,26.670000><55.880000,-1.538000,26.670000>0.406400}
cylinder{<55.880000,0.038000,33.020000><55.880000,-1.538000,33.020000>0.406400}
cylinder{<58.420000,0.038000,33.020000><58.420000,-1.538000,33.020000>0.406400}
cylinder{<60.960000,0.038000,33.020000><60.960000,-1.538000,33.020000>0.406400}
cylinder{<63.500000,0.038000,33.020000><63.500000,-1.538000,33.020000>0.406400}
cylinder{<66.040000,0.038000,33.020000><66.040000,-1.538000,33.020000>0.406400}
cylinder{<68.580000,0.038000,33.020000><68.580000,-1.538000,33.020000>0.406400}
cylinder{<71.120000,0.038000,33.020000><71.120000,-1.538000,33.020000>0.406400}
cylinder{<71.120000,0.038000,40.640000><71.120000,-1.538000,40.640000>0.406400}
cylinder{<68.580000,0.038000,40.640000><68.580000,-1.538000,40.640000>0.406400}
cylinder{<66.040000,0.038000,40.640000><66.040000,-1.538000,40.640000>0.406400}
cylinder{<63.500000,0.038000,40.640000><63.500000,-1.538000,40.640000>0.406400}
cylinder{<60.960000,0.038000,40.640000><60.960000,-1.538000,40.640000>0.406400}
cylinder{<58.420000,0.038000,40.640000><58.420000,-1.538000,40.640000>0.406400}
cylinder{<55.880000,0.038000,40.640000><55.880000,-1.538000,40.640000>0.406400}
cylinder{<22.860000,0.038000,60.960000><22.860000,-1.538000,60.960000>0.508000}
cylinder{<22.860000,0.038000,63.500000><22.860000,-1.538000,63.500000>0.508000}
cylinder{<22.860000,0.038000,66.040000><22.860000,-1.538000,66.040000>0.508000}
cylinder{<39.370000,0.038000,24.130000><39.370000,-1.538000,24.130000>0.406400}
cylinder{<39.370000,0.038000,21.590000><39.370000,-1.538000,21.590000>0.406400}
cylinder{<75.565000,0.038000,30.480000><75.565000,-1.538000,30.480000>0.406400}
cylinder{<75.565000,0.038000,27.940000><75.565000,-1.538000,27.940000>0.406400}
cylinder{<69.723000,0.038000,10.160000><69.723000,-1.538000,10.160000>0.406400}
cylinder{<64.897000,0.038000,10.160000><64.897000,-1.538000,10.160000>0.406400}
cylinder{<21.590000,0.038000,46.990000><21.590000,-1.538000,46.990000>0.406400}
cylinder{<21.590000,0.038000,44.450000><21.590000,-1.538000,44.450000>0.406400}
cylinder{<21.590000,0.038000,49.530000><21.590000,-1.538000,49.530000>0.406400}
cylinder{<6.350000,0.038000,22.860000><6.350000,-1.538000,22.860000>0.406400}
cylinder{<6.350000,0.038000,25.400000><6.350000,-1.538000,25.400000>0.406400}
cylinder{<6.350000,0.038000,20.320000><6.350000,-1.538000,20.320000>0.406400}
cylinder{<6.350000,0.038000,13.970000><6.350000,-1.538000,13.970000>0.406400}
cylinder{<6.350000,0.038000,11.430000><6.350000,-1.538000,11.430000>0.406400}
cylinder{<6.350000,0.038000,16.510000><6.350000,-1.538000,16.510000>0.406400}
cylinder{<26.670000,0.038000,27.940000><26.670000,-1.538000,27.940000>0.406400}
cylinder{<26.670000,0.038000,25.400000><26.670000,-1.538000,25.400000>0.406400}
cylinder{<26.670000,0.038000,30.480000><26.670000,-1.538000,30.480000>0.406400}
cylinder{<13.970000,0.038000,78.740000><13.970000,-1.538000,78.740000>0.406400}
cylinder{<29.210000,0.038000,78.740000><29.210000,-1.538000,78.740000>0.406400}
cylinder{<29.210000,0.038000,86.360000><29.210000,-1.538000,86.360000>0.406400}
cylinder{<13.970000,0.038000,86.360000><13.970000,-1.538000,86.360000>0.406400}
cylinder{<33.020000,0.038000,54.610000><33.020000,-1.538000,54.610000>0.406400}
cylinder{<33.020000,0.038000,44.450000><33.020000,-1.538000,44.450000>0.406400}
cylinder{<29.210000,0.038000,44.450000><29.210000,-1.538000,44.450000>0.406400}
cylinder{<29.210000,0.038000,54.610000><29.210000,-1.538000,54.610000>0.406400}
cylinder{<10.160000,0.038000,48.260000><10.160000,-1.538000,48.260000>0.406400}
cylinder{<10.160000,0.038000,38.100000><10.160000,-1.538000,38.100000>0.406400}
cylinder{<20.320000,0.038000,22.860000><20.320000,-1.538000,22.860000>0.406400}
cylinder{<10.160000,0.038000,22.860000><10.160000,-1.538000,22.860000>0.406400}
cylinder{<54.610000,0.038000,16.510000><54.610000,-1.538000,16.510000>0.406400}
cylinder{<54.610000,0.038000,6.350000><54.610000,-1.538000,6.350000>0.406400}
cylinder{<72.390000,0.038000,15.240000><72.390000,-1.538000,15.240000>0.406400}
cylinder{<62.230000,0.038000,15.240000><62.230000,-1.538000,15.240000>0.406400}
cylinder{<49.530000,0.038000,16.510000><49.530000,-1.538000,16.510000>0.406400}
cylinder{<49.530000,0.038000,6.350000><49.530000,-1.538000,6.350000>0.406400}
cylinder{<34.290000,0.038000,71.120000><34.290000,-1.538000,71.120000>0.406400}
cylinder{<24.130000,0.038000,71.120000><24.130000,-1.538000,71.120000>0.406400}
cylinder{<39.370000,0.038000,16.510000><39.370000,-1.538000,16.510000>0.406400}
cylinder{<39.370000,0.038000,6.350000><39.370000,-1.538000,6.350000>0.406400}
cylinder{<10.160000,0.038000,12.700000><10.160000,-1.538000,12.700000>0.406400}
cylinder{<20.320000,0.038000,12.700000><20.320000,-1.538000,12.700000>0.406400}
cylinder{<5.080000,0.038000,54.610000><5.080000,-1.538000,54.610000>0.406400}
cylinder{<5.080000,0.038000,64.770000><5.080000,-1.538000,64.770000>0.406400}
cylinder{<31.750000,0.038000,92.710000><31.750000,-1.538000,92.710000>0.406400}
cylinder{<21.590000,0.038000,92.710000><21.590000,-1.538000,92.710000>0.406400}
cylinder{<22.860000,0.038000,12.700000><22.860000,-1.538000,12.700000>0.406400}
cylinder{<33.020000,0.038000,12.700000><33.020000,-1.538000,12.700000>0.406400}
cylinder{<22.860000,0.038000,17.780000><22.860000,-1.538000,17.780000>0.406400}
cylinder{<33.020000,0.038000,17.780000><33.020000,-1.538000,17.780000>0.406400}
cylinder{<33.020000,0.038000,22.860000><33.020000,-1.538000,22.860000>0.406400}
cylinder{<22.860000,0.038000,22.860000><22.860000,-1.538000,22.860000>0.406400}
cylinder{<25.400000,0.038000,34.290000><25.400000,-1.538000,34.290000>0.406400}
cylinder{<25.400000,0.038000,44.450000><25.400000,-1.538000,44.450000>0.406400}
cylinder{<74.930000,0.038000,54.610000><74.930000,-1.538000,54.610000>0.406400}
cylinder{<74.930000,0.038000,44.450000><74.930000,-1.538000,44.450000>0.406400}
cylinder{<55.880000,0.038000,91.440000><55.880000,-1.538000,91.440000>0.508000}
cylinder{<53.340000,0.038000,91.440000><53.340000,-1.538000,91.440000>0.508000}
cylinder{<50.800000,0.038000,91.440000><50.800000,-1.538000,91.440000>0.508000}
cylinder{<48.260000,0.038000,91.440000><48.260000,-1.538000,91.440000>0.508000}
cylinder{<45.720000,0.038000,91.440000><45.720000,-1.538000,91.440000>0.508000}
cylinder{<43.180000,0.038000,91.440000><43.180000,-1.538000,91.440000>0.508000}
cylinder{<40.640000,0.038000,91.440000><40.640000,-1.538000,91.440000>0.508000}
cylinder{<38.100000,0.038000,91.440000><38.100000,-1.538000,91.440000>0.508000}
cylinder{<3.810000,0.038000,39.370000><3.810000,-1.538000,39.370000>0.508000}
cylinder{<3.810000,0.038000,41.910000><3.810000,-1.538000,41.910000>0.508000}
cylinder{<3.810000,0.038000,44.450000><3.810000,-1.538000,44.450000>0.508000}
cylinder{<3.810000,0.038000,85.090000><3.810000,-1.538000,85.090000>0.508000}
cylinder{<3.810000,0.038000,87.630000><3.810000,-1.538000,87.630000>0.508000}
cylinder{<3.810000,0.038000,90.170000><3.810000,-1.538000,90.170000>0.508000}
cylinder{<3.810000,0.038000,68.580000><3.810000,-1.538000,68.580000>0.508000}
cylinder{<3.810000,0.038000,71.120000><3.810000,-1.538000,71.120000>0.508000}
cylinder{<3.810000,0.038000,73.660000><3.810000,-1.538000,73.660000>0.508000}
//Bohrungen(schnell)/Durchkontaktierungen
cylinder{<53.340000,0.038000,73.660000><53.340000,-1.538000,73.660000>0.400000 }
cylinder{<73.660000,0.038000,73.660000><73.660000,-1.538000,73.660000>0.400000 }
cylinder{<72.390000,0.038000,44.450000><72.390000,-1.538000,44.450000>0.400000 }
cylinder{<49.530000,0.038000,44.450000><49.530000,-1.538000,44.450000>0.400000 }
cylinder{<71.755000,0.038000,69.215000><71.755000,-1.538000,69.215000>0.400000 }
cylinder{<53.975000,0.038000,69.215000><53.975000,-1.538000,69.215000>0.400000 }
cylinder{<58.420000,0.038000,76.200000><58.420000,-1.538000,76.200000>0.400000 }
cylinder{<33.020000,0.038000,76.200000><33.020000,-1.538000,76.200000>0.400000 }
cylinder{<60.960000,0.038000,76.200000><60.960000,-1.538000,76.200000>0.400000 }
cylinder{<74.295000,0.038000,76.200000><74.295000,-1.538000,76.200000>0.400000 }
cylinder{<35.560000,0.038000,34.290000><35.560000,-1.538000,34.290000>0.400000 }
cylinder{<27.940000,0.038000,73.660000><27.940000,-1.538000,73.660000>0.400000 }
cylinder{<29.210000,0.038000,73.660000><29.210000,-1.538000,73.660000>0.400000 }
cylinder{<44.450000,0.038000,73.660000><44.450000,-1.538000,73.660000>0.400000 }
cylinder{<17.780000,0.038000,44.450000><17.780000,-1.538000,44.450000>0.400000 }
cylinder{<17.780000,0.038000,66.040000><17.780000,-1.538000,66.040000>0.400000 }
//Bohrungen(schnell)/Platine
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Bestückungsdruck
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.355000,0.000000,43.484800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<45.720000,0.000000,43.484800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<45.720000,0.000000,43.484800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<45.720000,0.000000,43.484800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<45.085000,0.000000,43.484800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<45.085000,0.000000,43.484800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,43.484800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,44.704000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<45.720000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.355000,0.000000,42.849800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<45.720000,0.000000,42.849800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<45.720000,0.000000,42.849800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<45.720000,0.000000,42.849800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<45.085000,0.000000,42.849800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<45.085000,0.000000,42.849800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,42.849800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,41.656000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.720000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,46.863000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,46.863000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,46.863000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,39.751000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.942000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,39.497000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,46.609000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.498000,0.000000,46.609000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<47.244000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<44.196000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<44.196000,0.000000,46.609000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<47.244000,0.000000,46.609000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<41.275000,0.000000,43.484800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.640000,0.000000,43.484800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<40.640000,0.000000,43.484800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.640000,0.000000,43.484800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.005000,0.000000,43.484800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<40.005000,0.000000,43.484800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,43.484800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,44.704000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<41.275000,0.000000,42.849800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.640000,0.000000,42.849800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<40.640000,0.000000,42.849800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.640000,0.000000,42.849800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.005000,0.000000,42.849800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<40.005000,0.000000,42.849800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,42.849800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,41.656000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.640000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.164000,0.000000,46.863000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,46.863000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.116000,0.000000,46.863000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,39.751000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.862000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.164000,0.000000,39.497000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.116000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.418000,0.000000,46.609000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.418000,0.000000,46.609000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<42.164000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<39.116000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<39.116000,0.000000,46.609000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<42.164000,0.000000,46.609000>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<28.575000,0.000000,39.065200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.210000,0.000000,39.065200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<28.575000,0.000000,39.065200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.210000,0.000000,39.065200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.845000,0.000000,39.065200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<29.210000,0.000000,39.065200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,39.065200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,37.846000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.210000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<28.575000,0.000000,39.700200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.210000,0.000000,39.700200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<28.575000,0.000000,39.700200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.210000,0.000000,39.700200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.845000,0.000000,39.700200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<29.210000,0.000000,39.700200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,39.700200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,40.894000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<29.210000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.686000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,35.687000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.686000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,42.799000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.988000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.686000,0.000000,43.053000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.686000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.432000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.432000,0.000000,35.941000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.432000,0.000000,35.941000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<27.686000,0.000000,42.799000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<30.734000,0.000000,42.799000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<30.734000,0.000000,35.941000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<27.686000,0.000000,35.941000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,57.277000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.843000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,57.658000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,57.658000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.462000,0.000000,57.658000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,56.261000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,55.372000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.700000,0.000000,55.372000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,55.372000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,55.372000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.430000,0.000000,55.372000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,55.372000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,54.864000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.430000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,54.864000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.430000,0.000000,54.864000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,54.864000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,55.372000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,55.372000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,55.372000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,55.372000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.700000,0.000000,55.372000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,52.959000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.700000,0.000000,52.959000> }
difference{
cylinder{<12.700000,0,54.610000><12.700000,0.036000,54.610000>5.156200 translate<0,0.000000,0>}
cylinder{<12.700000,-0.1,54.610000><12.700000,0.135000,54.610000>5.003800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-270.000000,0> translate<12.700000,0.000000,54.102000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,46.101000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,46.101000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,46.101000> }
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<24.765000,0.000000,46.609000>}
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<26.035000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,46.609000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.257000,0.000000,46.609000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,50.419000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,50.419000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,46.609000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.543000,0.000000,46.609000> }
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<24.765000,0.000000,49.911000>}
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<26.035000,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<24.638000,0.000000,47.955200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<26.162000,0.000000,47.955200>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<24.638000,0.000000,47.955200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<24.638000,0.000000,48.590200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<26.162000,0.000000,48.590200>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<24.638000,0.000000,48.590200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,48.590200>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.400000,0.000000,48.590200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,47.955200>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,47.955200> }
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.286000,0.000000,33.528000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.048000,0.000000,33.528000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.286000,0.000000,33.528000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.667000,0.000000,33.909000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.667000,0.000000,33.909000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,32.385000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.064000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,31.115000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.461000,0.000000,31.115000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.461000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.461000,0.000000,33.655000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.461000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.461000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,33.655000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.953000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.953000,0.000000,32.385000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.953000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,32.385000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,32.385000> }
difference{
cylinder{<5.715000,0,32.385000><5.715000,0.036000,32.385000>4.140200 translate<0,0.000000,0>}
cylinder{<5.715000,-0.1,32.385000><5.715000,0.135000,32.385000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<6.223000,0.000000,32.385000>}
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.525000,0.000000,80.314800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.890000,0.000000,80.314800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<8.890000,0.000000,80.314800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.890000,0.000000,80.314800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.255000,0.000000,80.314800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<8.255000,0.000000,80.314800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,80.314800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,81.534000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.525000,0.000000,79.679800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.890000,0.000000,79.679800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<8.890000,0.000000,79.679800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.890000,0.000000,79.679800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.255000,0.000000,79.679800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<8.255000,0.000000,79.679800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,79.679800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,78.486000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.890000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,83.693000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,83.693000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,83.693000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,76.581000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.366000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,76.327000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,76.327000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,76.327000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,83.439000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.414000,0.000000,83.439000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<10.160000,0.000000,76.581000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<7.620000,0.000000,76.581000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<7.620000,0.000000,83.439000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<10.160000,0.000000,83.439000>}
//C8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.834800,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.834800,0.000000,30.480000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<49.834800,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.834800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.834800,0.000000,31.115000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<49.834800,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.834800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.054000,0.000000,30.480000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<49.834800,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.199800,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.199800,0.000000,30.480000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<49.199800,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.199800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<49.199800,0.000000,31.115000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<49.199800,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.199800,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,30.480000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<48.006000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,31.750000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.213000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.959000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,32.004000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.101000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,29.210000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.847000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.959000,0.000000,28.956000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.101000,0.000000,28.956000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<46.101000,0.000000,29.210000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<46.101000,0.000000,31.750000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<52.959000,0.000000,31.750000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<52.959000,0.000000,29.210000>}
//C9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,39.497000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.383000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.002000,0.000000,39.878000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,39.878000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.002000,0.000000,39.878000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,38.481000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,37.592000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,37.592000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,37.592000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,37.592000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,37.592000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,37.592000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,37.084000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.970000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,37.084000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.970000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,37.592000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.510000,0.000000,37.592000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,37.592000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,37.592000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.240000,0.000000,37.592000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,35.179000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,35.179000> }
difference{
cylinder{<15.240000,0,36.830000><15.240000,0.036000,36.830000>4.140200 translate<0,0.000000,0>}
cylinder{<15.240000,-0.1,36.830000><15.240000,0.135000,36.830000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-270.000000,0> translate<15.240000,0.000000,36.322000>}
//C10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<59.055000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<58.420000,0.000000,11.734800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<58.420000,0.000000,11.734800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<58.420000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<57.785000,0.000000,11.734800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<57.785000,0.000000,11.734800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,12.954000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<58.420000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<59.055000,0.000000,11.099800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<58.420000,0.000000,11.099800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<58.420000,0.000000,11.099800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<58.420000,0.000000,11.099800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<57.785000,0.000000,11.099800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<57.785000,0.000000,11.099800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,11.099800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,9.906000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.420000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,15.113000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,15.113000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,15.113000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,8.001000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.896000,0.000000,8.001000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,7.747000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,7.747000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,14.859000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.944000,0.000000,14.859000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<59.690000,0.000000,8.001000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<57.150000,0.000000,8.001000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<57.150000,0.000000,14.859000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<59.690000,0.000000,14.859000>}
//C11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,5.715000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.531000,0.000000,5.715000> }
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<58.039000,0.000000,5.715000>}
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<58.039000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.341000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.039000,0.000000,6.223000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.039000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,5.715000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.849000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.341000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.039000,0.000000,3.937000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.039000,0.000000,3.937000> }
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<61.341000,0.000000,5.715000>}
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<61.341000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<59.385200,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<59.385200,0.000000,4.318000>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,-90.000000,0> translate<59.385200,0.000000,4.318000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.020200,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.020200,0.000000,4.318000>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,-90.000000,0> translate<60.020200,0.000000,4.318000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.960000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.020200,0.000000,5.080000>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,0.000000,0> translate<60.020200,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.385200,0.000000,5.080000>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,5.080000> }
//C12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.195200,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.195200,0.000000,91.440000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<63.195200,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.195200,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.195200,0.000000,90.805000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<63.195200,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.195200,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.976000,0.000000,91.440000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<61.976000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.830200,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.830200,0.000000,91.440000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<63.830200,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.830200,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.830200,0.000000,90.805000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<63.830200,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.830200,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,91.440000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<63.830200,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.817000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.817000,0.000000,90.170000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.817000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,89.916000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.071000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.183000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.183000,0.000000,92.710000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.183000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,92.964000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.071000,0.000000,92.964000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<66.929000,0.000000,92.710000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<66.929000,0.000000,90.170000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<60.071000,0.000000,90.170000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<60.071000,0.000000,92.710000>}
//C13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.117000,0.000000,19.431000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.117000,0.000000,20.193000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.117000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.498000,0.000000,19.812000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,19.812000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.736000,0.000000,19.812000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,22.098000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.260000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,22.098000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,22.606000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.530000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,22.606000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.990000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,22.098000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.990000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,22.098000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.990000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,24.511000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.260000,0.000000,24.511000> }
difference{
cylinder{<48.260000,0,22.860000><48.260000,0.036000,22.860000>4.140200 translate<0,0.000000,0>}
cylinder{<48.260000,-0.1,22.860000><48.260000,0.135000,22.860000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<48.260000,0.000000,23.368000>}
//C14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<31.115000,0.000000,63.804800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<30.480000,0.000000,63.804800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<30.480000,0.000000,63.804800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<30.480000,0.000000,63.804800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.845000,0.000000,63.804800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<29.845000,0.000000,63.804800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,63.804800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,65.024000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<30.480000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<31.115000,0.000000,63.169800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<30.480000,0.000000,63.169800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<30.480000,0.000000,63.169800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<30.480000,0.000000,63.169800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<29.845000,0.000000,63.169800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<29.845000,0.000000,63.169800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,63.169800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,61.976000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.480000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,67.183000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,67.183000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.210000,0.000000,67.183000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.956000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.956000,0.000000,60.071000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.956000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,59.817000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,59.817000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.210000,0.000000,59.817000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,66.929000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.004000,0.000000,66.929000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<31.750000,0.000000,60.071000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<29.210000,0.000000,60.071000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<29.210000,0.000000,66.929000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<31.750000,0.000000,66.929000>}
//C15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<12.395200,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<12.395200,0.000000,72.390000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<12.395200,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<12.395200,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<12.395200,0.000000,71.755000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<12.395200,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.395200,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,72.390000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<13.030200,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<13.030200,0.000000,72.390000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<13.030200,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<13.030200,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<13.030200,0.000000,71.755000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<13.030200,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.030200,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,72.390000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<13.030200,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,71.120000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.017000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,70.866000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,70.866000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,70.866000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,73.660000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.383000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,73.914000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,73.914000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<16.129000,0.000000,73.660000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<16.129000,0.000000,71.120000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<9.271000,0.000000,71.120000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<9.271000,0.000000,73.660000>}
//C16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,67.437000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.843000,0.000000,67.437000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,67.818000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,67.818000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.462000,0.000000,67.818000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,65.532000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.700000,0.000000,65.532000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,65.532000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,65.532000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.430000,0.000000,65.532000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,65.532000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,65.024000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.430000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,65.024000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.430000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,65.532000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.970000,0.000000,65.532000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,65.532000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,65.532000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.700000,0.000000,65.532000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,63.119000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.700000,0.000000,63.119000> }
difference{
cylinder{<12.700000,0,64.770000><12.700000,0.036000,64.770000>4.140200 translate<0,0.000000,0>}
cylinder{<12.700000,-0.1,64.770000><12.700000,0.135000,64.770000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-270.000000,0> translate<12.700000,0.000000,64.262000>}
//C17 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,48.006000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,48.006000> }
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<4.445000,0.000000,48.514000>}
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<5.715000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,48.514000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.937000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,52.324000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,48.514000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.223000,0.000000,48.514000> }
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<4.445000,0.000000,51.816000>}
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<5.715000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.318000,0.000000,49.860200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,49.860200>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,0.000000,0> translate<4.318000,0.000000,49.860200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,49.860200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.842000,0.000000,49.860200>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,0.000000,0> translate<5.080000,0.000000,49.860200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.318000,0.000000,50.495200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,50.495200>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,0.000000,0> translate<4.318000,0.000000,50.495200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,50.495200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.842000,0.000000,50.495200>}
box{<0,0,-0.152400><0.762000,0.036000,0.152400> rotate<0,0.000000,0> translate<5.080000,0.000000,50.495200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,50.495200>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,50.495200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,49.860200>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,49.860200> }
box{<-0.190500,0,-0.381000><0.190500,0.036000,0.381000> rotate<0,-90.000000,0> translate<5.080000,0.000000,52.514500>}
box{<-0.190500,0,-0.381000><0.190500,0.036000,0.381000> rotate<0,-90.000000,0> translate<5.080000,0.000000,47.815500>}
//C18 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.065200,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.065200,0.000000,71.120000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<39.065200,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.065200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.065200,0.000000,70.485000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<39.065200,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.065200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,71.120000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<37.846000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.700200,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.700200,0.000000,71.120000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<39.700200,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.700200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<39.700200,0.000000,70.485000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<39.700200,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.700200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.894000,0.000000,71.120000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<39.700200,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.687000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.687000,0.000000,69.850000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.687000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,69.596000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.941000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,72.390000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.053000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,72.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,72.644000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.941000,0.000000,72.644000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<42.799000,0.000000,72.390000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<42.799000,0.000000,69.850000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<35.941000,0.000000,69.850000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<35.941000,0.000000,72.390000>}
//C19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.369000,0.000000,5.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.607000,0.000000,5.207000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.607000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,5.588000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,4.826000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.988000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.591000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,6.350000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.702000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,7.620000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.702000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,7.620000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.194000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,5.080000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.194000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,5.080000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.194000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.702000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,6.350000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.289000,0.000000,6.350000> }
difference{
cylinder{<27.940000,0,6.350000><27.940000,0.036000,6.350000>4.140200 translate<0,0.000000,0>}
cylinder{<27.940000,-0.1,6.350000><27.940000,0.135000,6.350000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-180.000000,0> translate<27.432000,0.000000,6.350000>}
//C20 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,26.543000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.877000,0.000000,26.543000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.258000,0.000000,26.162000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.496000,0.000000,26.162000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.496000,0.000000,26.162000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,28.448000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.020000,0.000000,28.448000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,28.448000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,28.448000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.020000,0.000000,28.448000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,28.448000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.290000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,28.956000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,28.448000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.750000,0.000000,28.448000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,28.448000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,28.448000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,28.448000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,30.861000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.020000,0.000000,30.861000> }
difference{
cylinder{<33.020000,0,29.210000><33.020000,0.036000,29.210000>4.140200 translate<0,0.000000,0>}
cylinder{<33.020000,-0.1,29.210000><33.020000,0.135000,29.210000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<33.020000,0.000000,29.718000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<45.720000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<45.720000,0.000000,14.351000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<45.720000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<45.720000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<45.720000,0.000000,8.509000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,90.000000,0> translate<45.720000,0.000000,8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,11.430000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.720000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,12.446000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,11.430000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<45.720000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,12.954000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.720000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,12.446000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<45.085000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,11.430000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,11.430000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.720000,0.000000,11.430000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<44.958000,0.000000,13.462000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,13.716000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,13.716000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<46.482000,0.000000,13.462000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<44.958000,0.000000,9.398000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<46.482000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,13.462000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.736000,0.000000,13.462000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,9.144000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,13.462000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,13.462000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-90.000000,0> translate<45.720000,0.000000,9.779000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-90.000000,0> translate<45.720000,0.000000,14.033500>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-90.000000,0> translate<45.720000,0.000000,8.826500>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<11.430000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<12.319000,0.000000,27.940000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<11.430000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<19.050000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<18.161000,0.000000,27.940000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<18.161000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.940000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.240000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.575000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.224000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.940000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<14.224000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,27.940000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,27.305000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<14.224000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.940000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,28.575000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,28.575000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<13.208000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,28.702000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.954000,0.000000,28.702000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<13.208000,0.000000,28.702000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<17.272000,0.000000,27.178000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<17.272000,0.000000,28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.272000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,28.956000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,28.702000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.526000,0.000000,28.702000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.272000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,26.924000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,26.924000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-180.000000,0> translate<16.891000,0.000000,27.940000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-180.000000,0> translate<12.636500,0.000000,27.940000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-180.000000,0> translate<17.843500,0.000000,27.940000>}
//D3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<19.050000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<18.161000,0.000000,17.780000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<18.161000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<11.430000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<12.319000,0.000000,17.780000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<11.430000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.780000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.256000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.780000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<15.240000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,17.780000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.240000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,18.415000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<15.240000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.780000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.145000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,17.145000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<17.272000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,17.018000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<17.526000,0.000000,17.018000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<17.272000,0.000000,17.018000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<13.208000,0.000000,18.542000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<13.208000,0.000000,17.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.272000,0.000000,16.764000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,17.018000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.954000,0.000000,17.018000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.272000,0.000000,18.796000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,18.796000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-0.000000,0> translate<13.589000,0.000000,17.780000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-0.000000,0> translate<17.843500,0.000000,17.780000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-0.000000,0> translate<12.636500,0.000000,17.780000>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,51.816000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.957000,0.000000,51.816000> }
object{ARC(1.270000,0.152400,270.000000,450.000000,0.036000) translate<36.957000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,65.024000>}
box{<0,0,-0.076200><13.208000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.263000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,59.690000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.957000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,65.024000>}
box{<0,0,-0.076200><35.306000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,51.816000>}
box{<0,0,-0.076200><35.306000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,51.816000> }
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,80.010000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.830000,0.000000,80.010000> }
object{ARC(1.270000,0.152400,270.000000,450.000000,0.036000) translate<36.830000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,85.090000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.390000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,83.820000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.830000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,85.090000>}
box{<0,0,-0.076200><35.560000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.830000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,80.010000>}
box{<0,0,-0.076200><35.433000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,80.010000> }
//IC4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,25.781000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.610000,0.000000,25.781000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,19.939000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.610000,0.000000,19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,19.939000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.390000,0.000000,19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,23.876000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.610000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,21.844000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.610000,0.000000,21.844000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<54.610000,0.000000,22.860000>}
//IC5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,39.751000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.610000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,33.909000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,33.909000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.610000,0.000000,33.909000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,33.909000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.390000,0.000000,33.909000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,37.846000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.610000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,33.909000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,35.814000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.610000,0.000000,35.814000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<54.610000,0.000000,36.830000>}
//IC6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.463000,0.000000,68.580000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.384000,0.000000,68.453000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,2.489389,0> translate<21.463000,0.000000,68.580000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.638000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.384000,0.000000,68.453000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,44.997030,0> translate<24.384000,0.000000,68.453000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.638000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.638000,0.000000,58.801000>}
box{<0,0,-0.063500><9.398000,0.036000,0.063500> rotate<0,-90.000000,0> translate<24.638000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.384000,0.000000,58.547000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.638000,0.000000,58.801000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,-44.997030,0> translate<24.384000,0.000000,58.547000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.384000,0.000000,58.547000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.463000,0.000000,58.420000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,-2.489389,0> translate<21.463000,0.000000,58.420000> }
difference{
cylinder{<24.028400,0,59.004200><24.028400,0.036000,59.004200>0.317500 translate<0,0.000000,0>}
cylinder{<24.028400,-0.1,59.004200><24.028400,0.135000,59.004200>0.190500 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<20.701000,0.000000,63.500000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<21.336000,0.000000,59.118500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<21.336000,0.000000,62.230000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<21.336000,0.000000,60.960000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<21.336000,0.000000,64.770000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<21.336000,0.000000,67.881500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<21.336000,0.000000,63.500000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<21.336000,0.000000,66.040000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,20.320000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,20.320000> }
object{ARC(3.175000,0.254000,306.869898,593.130102,0.036000) translate<39.370000,0.000000,22.860000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<39.370000,0.000000,22.860000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<39.370000,0.000000,22.860000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<39.370000,0.000000,22.860000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<39.370000,0.000000,22.860000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<39.370000,0.000000,22.860000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<39.370000,0.000000,22.860000>}
difference{
cylinder{<39.370000,0,22.860000><39.370000,0.036000,22.860000>2.616200 translate<0,0.000000,0>}
cylinder{<39.370000,-0.1,22.860000><39.370000,0.135000,22.860000>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<73.660000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<77.470000,0.000000,26.670000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<73.660000,0.000000,26.670000> }
object{ARC(3.175000,0.254000,306.869898,593.130102,0.036000) translate<75.565000,0.000000,29.210000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<75.565000,0.000000,29.210000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<75.565000,0.000000,29.210000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<75.565000,0.000000,29.210000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<75.565000,0.000000,29.210000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<75.565000,0.000000,29.210000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<75.565000,0.000000,29.210000>}
difference{
cylinder{<75.565000,0,29.210000><75.565000,0.036000,29.210000>2.616200 translate<0,0.000000,0>}
cylinder{<75.565000,-0.1,29.210000><75.565000,0.135000,29.210000>2.463800 translate<0,0.000000,0>}}
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<70.358000,0.000000,12.319000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<64.262000,0.000000,12.319000>}
box{<0,0,-0.203200><6.096000,0.036000,0.203200> rotate<0,0.000000,0> translate<64.262000,0.000000,12.319000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<70.358000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<64.262000,0.000000,8.001000>}
box{<0,0,-0.203200><6.096000,0.036000,0.203200> rotate<0,0.000000,0> translate<64.262000,0.000000,8.001000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.262000,0.000000,11.811000>}
box{<0,0,-0.076200><6.096000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.262000,0.000000,11.811000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.262000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.358000,0.000000,8.509000>}
box{<0,0,-0.076200><6.096000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.262000,0.000000,8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.398000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,10.922000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.056000,0.000000,10.922000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.056000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,10.922000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.056000,0.000000,10.922000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,10.922000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,9.398000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.564000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,10.160000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.675000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,10.922000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.675000,0.000000,10.922000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,10.160000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,10.922000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,10.922000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,10.160000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.040000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,10.160000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.945000,0.000000,10.160000> }
object{ARC(2.159000,0.406400,270.000000,450.000000,0.036000) translate<70.358000,0.000000,10.160000>}
object{ARC(2.159000,0.406400,90.000000,270.000000,0.036000) translate<64.262000,0.000000,10.160000>}
object{ARC(1.651000,0.152400,270.000000,450.000000,0.036000) translate<70.358000,0.000000,10.160000>}
object{ARC(1.651000,0.152400,90.000000,270.000000,0.036000) translate<64.262000,0.000000,10.160000>}
//Q2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.241000,0.000000,44.895000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.241000,0.000000,49.085000>}
box{<0,0,-0.063500><4.190000,0.036000,0.063500> rotate<0,90.000000,0> translate<23.241000,0.000000,49.085000> }
object{ARC(2.667000,0.127000,115.208327,244.791673,0.036000) translate<21.590000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,48.126000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,45.854000>}
box{<0,0,-0.063500><2.272000,0.036000,0.063500> rotate<0,-90.000000,0> translate<21.717000,0.000000,45.854000> }
object{ARC(2.667000,0.127000,244.789729,272.727231,0.036000) translate<21.590100,0.000000,46.990000>}
object{ARC(2.667000,0.127000,272.731522,295.210271,0.036000) translate<21.589900,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,45.586000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,44.326000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,-90.000000,0> translate<21.717000,0.000000,44.326000> }
object{ARC(2.667000,0.127000,295.210271,308.248808,0.036000) translate<21.589900,0.000000,46.989500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,45.854000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,45.586000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,-90.000000,0> translate<21.717000,0.000000,45.586000> }
object{ARC(2.667000,0.127000,64.789729,87.268478,0.036000) translate<21.589900,0.000000,46.990000>}
object{ARC(2.667000,0.127000,87.272769,115.210271,0.036000) translate<21.590100,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,49.654000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,48.394000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,-90.000000,0> translate<21.717000,0.000000,48.394000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,48.394000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.717000,0.000000,48.126000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,-90.000000,0> translate<21.717000,0.000000,48.126000> }
object{ARC(2.667000,0.127000,51.751192,65.360649,0.036000) translate<21.589900,0.000000,46.990500>}
//Q3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.699000,0.000000,24.955000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.699000,0.000000,20.765000>}
box{<0,0,-0.063500><4.190000,0.036000,0.063500> rotate<0,-90.000000,0> translate<4.699000,0.000000,20.765000> }
object{ARC(2.667000,0.127000,295.208327,424.791673,0.036000) translate<6.350000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,21.724000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,23.996000>}
box{<0,0,-0.063500><2.272000,0.036000,0.063500> rotate<0,90.000000,0> translate<6.223000,0.000000,23.996000> }
object{ARC(2.667000,0.127000,64.789729,92.727231,0.036000) translate<6.349900,0.000000,22.860000>}
object{ARC(2.667000,0.127000,92.731522,115.210271,0.036000) translate<6.350100,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,24.264000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,25.524000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,90.000000,0> translate<6.223000,0.000000,25.524000> }
object{ARC(2.667000,0.127000,115.210271,128.248808,0.036000) translate<6.350100,0.000000,22.860500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,23.996000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,24.264000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,90.000000,0> translate<6.223000,0.000000,24.264000> }
object{ARC(2.667000,0.127000,244.789729,267.268478,0.036000) translate<6.350100,0.000000,22.860000>}
object{ARC(2.667000,0.127000,267.272769,295.210271,0.036000) translate<6.349900,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,20.196000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,21.456000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,90.000000,0> translate<6.223000,0.000000,21.456000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,21.456000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.223000,0.000000,21.724000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,90.000000,0> translate<6.223000,0.000000,21.724000> }
object{ARC(2.667000,0.127000,231.751192,245.360649,0.036000) translate<6.350100,0.000000,22.859500>}
//Q4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.001000,0.000000,11.875000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.001000,0.000000,16.065000>}
box{<0,0,-0.063500><4.190000,0.036000,0.063500> rotate<0,90.000000,0> translate<8.001000,0.000000,16.065000> }
object{ARC(2.667000,0.127000,115.208327,244.791673,0.036000) translate<6.350000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,15.106000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,12.834000>}
box{<0,0,-0.063500><2.272000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.477000,0.000000,12.834000> }
object{ARC(2.667000,0.127000,244.791673,295.208327,0.036000) translate<6.350000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,12.566000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,11.306000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.477000,0.000000,11.306000> }
object{ARC(2.667000,0.127000,295.210271,308.248808,0.036000) translate<6.349900,0.000000,13.969500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,12.834000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,12.566000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.477000,0.000000,12.566000> }
object{ARC(2.667000,0.127000,64.791673,115.208327,0.036000) translate<6.350000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,16.634000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,15.374000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.477000,0.000000,15.374000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,15.374000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.477000,0.000000,15.106000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.477000,0.000000,15.106000> }
object{ARC(2.667000,0.127000,51.751192,65.360649,0.036000) translate<6.349900,0.000000,13.970500>}
//Q5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.321000,0.000000,25.845000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.321000,0.000000,30.035000>}
box{<0,0,-0.063500><4.190000,0.036000,0.063500> rotate<0,90.000000,0> translate<28.321000,0.000000,30.035000> }
object{ARC(2.667000,0.127000,115.208327,244.791673,0.036000) translate<26.670000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,29.076000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,26.804000>}
box{<0,0,-0.063500><2.272000,0.036000,0.063500> rotate<0,-90.000000,0> translate<26.797000,0.000000,26.804000> }
object{ARC(2.667000,0.127000,244.789729,272.727231,0.036000) translate<26.670100,0.000000,27.940000>}
object{ARC(2.667000,0.127000,272.731522,295.210271,0.036000) translate<26.669900,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,26.536000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,25.276000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,-90.000000,0> translate<26.797000,0.000000,25.276000> }
object{ARC(2.667000,0.127000,295.210271,308.248808,0.036000) translate<26.669900,0.000000,27.939500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,26.804000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,26.536000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,-90.000000,0> translate<26.797000,0.000000,26.536000> }
object{ARC(2.667000,0.127000,64.789729,87.268478,0.036000) translate<26.669900,0.000000,27.940000>}
object{ARC(2.667000,0.127000,87.272769,115.210271,0.036000) translate<26.670100,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,30.604000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,29.344000>}
box{<0,0,-0.063500><1.260000,0.036000,0.063500> rotate<0,-90.000000,0> translate<26.797000,0.000000,29.344000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,29.344000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.797000,0.000000,29.076000>}
box{<0,0,-0.063500><0.268000,0.036000,0.063500> rotate<0,-90.000000,0> translate<26.797000,0.000000,29.076000> }
object{ARC(2.667000,0.127000,51.751192,65.360649,0.036000) translate<26.669900,0.000000,27.940500>}
//QG1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<11.430000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<30.480000,0.000000,76.200000>}
box{<0,0,-0.127000><19.050000,0.036000,0.127000> rotate<0,0.000000,0> translate<11.430000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.750000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.750000,0.000000,87.630000>}
box{<0,0,-0.127000><10.160000,0.036000,0.127000> rotate<0,90.000000,0> translate<31.750000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<30.480000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.700000,0.000000,88.900000>}
box{<0,0,-0.127000><17.780000,0.036000,0.127000> rotate<0,0.000000,0> translate<12.700000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<11.430000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<11.430000,0.000000,87.630000>}
box{<0,0,-0.127000><11.430000,0.036000,0.127000> rotate<0,90.000000,0> translate<11.430000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,76.835000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.700000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,87.630000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,88.265000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.700000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,77.470000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.065000,0.000000,77.470000> }
object{ARC(1.270000,0.254000,270.000000,360.000000,0.036000) translate<30.480000,0.000000,77.470000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<30.480000,0.000000,77.470000>}
object{ARC(0.635000,0.152400,0.000000,90.000000,0.036000) translate<30.480000,0.000000,87.630000>}
object{ARC(1.270000,0.254000,0.000000,90.000000,0.036000) translate<30.480000,0.000000,87.630000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<12.700000,0.000000,87.630000>}
object{ARC(1.270000,0.254000,90.000000,180.000000,0.036000) translate<12.700000,0.000000,87.630000>}
object{ARC(0.635000,0.152400,180.000000,270.000000,0.036000) translate<12.700000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.259800,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.259800,0.000000,85.090000>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,-90.000000,0> translate<21.259800,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.259800,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.894800,0.000000,85.090000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<21.259800,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.894800,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.894800,0.000000,87.630000>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,90.000000,0> translate<21.894800,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.894800,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.259800,0.000000,87.630000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<21.259800,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.529800,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.529800,0.000000,86.360000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,-90.000000,0> translate<22.529800,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<20.650200,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<20.650200,0.000000,86.360000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,-90.000000,0> translate<20.650200,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.529800,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,86.360000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,0.000000,0> translate<22.529800,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.529800,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.529800,0.000000,85.090000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,-90.000000,0> translate<22.529800,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.650200,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,86.360000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,0.000000,0> translate<19.050000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<20.650200,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<20.650200,0.000000,85.090000>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,-90.000000,0> translate<20.650200,0.000000,85.090000> }
difference{
cylinder{<13.081000,0,77.851000><13.081000,0.036000,77.851000>0.787400 translate<0,0.000000,0>}
cylinder{<13.081000,-0.1,77.851000><13.081000,0.135000,77.851000>0.482600 translate<0,0.000000,0>}}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,45.466000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<33.020000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,53.594000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<33.020000,0.000000,53.594000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<33.909000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<32.131000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<32.131000,0.000000,46.609000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<33.909000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.131000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.909000,0.000000,52.705000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.131000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.163000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.036000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.877000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<31.877000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<34.036000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,51.943000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.036000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.877000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,51.943000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.004000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.163000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.877000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.131000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.909000,0.000000,46.355000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.131000,0.000000,46.355000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<33.020000,0.000000,45.923200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<33.020000,0.000000,53.136800>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.210000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.210000,0.000000,53.594000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<29.210000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.210000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.210000,0.000000,45.466000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<29.210000,0.000000,45.466000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<28.321000,0.000000,46.609000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<30.099000,0.000000,46.609000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<30.099000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<28.321000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.099000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,46.355000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.321000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.067000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<28.067000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.353000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.226000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<30.226000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<28.067000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.194000,0.000000,47.117000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.194000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.226000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.226000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.226000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.226000,0.000000,47.117000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.226000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.067000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.353000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.099000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,52.705000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.321000,0.000000,52.705000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<29.210000,0.000000,53.136800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<29.210000,0.000000,45.923200>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,39.116000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<10.160000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,47.244000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<10.160000,0.000000,47.244000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<11.049000,0.000000,46.101000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<9.271000,0.000000,46.101000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<9.271000,0.000000,40.259000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<11.049000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,46.355000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,46.101000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,45.720000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.303000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,45.593000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,45.720000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.176000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,46.101000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,45.720000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.017000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.593000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,45.720000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<9.017000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,40.640000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<11.176000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,45.593000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.176000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,40.640000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.017000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,45.593000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.303000,0.000000,40.640000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.303000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,0.000000,40.640000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.017000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.049000,0.000000,40.005000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,40.005000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<10.160000,0.000000,39.573200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<10.160000,0.000000,46.786800>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<11.176000,0.000000,22.860000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<10.160000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<20.320000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<19.304000,0.000000,22.860000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<19.304000,0.000000,22.860000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<18.161000,0.000000,21.971000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<18.161000,0.000000,23.749000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<12.319000,0.000000,23.749000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<12.319000,0.000000,21.971000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,21.971000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.415000,0.000000,21.971000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.161000,0.000000,21.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,21.717000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.780000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,21.717000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.653000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.161000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.003000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.780000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.003000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.653000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,21.717000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.700000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,21.844000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.827000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,24.003000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<12.700000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,23.876000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.827000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.319000,0.000000,21.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,21.717000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.319000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.319000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,24.003000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.319000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,21.971000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.065000,0.000000,21.971000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<11.633200,0.000000,22.860000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<18.846800,0.000000,22.860000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,7.366000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<54.610000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,15.494000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<54.610000,0.000000,15.494000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<55.499000,0.000000,14.351000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.721000,0.000000,14.351000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.721000,0.000000,8.509000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<55.499000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,14.605000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.721000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,13.970000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.753000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,13.970000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<55.626000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,13.970000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.467000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,13.970000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.467000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,8.890000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<55.626000,0.000000,9.017000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,13.843000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.626000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,8.890000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.467000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,13.843000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.594000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,8.890000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.753000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,8.890000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.467000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,8.255000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.721000,0.000000,8.255000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<54.610000,0.000000,7.823200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<54.610000,0.000000,15.036800>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<62.230000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<63.246000,0.000000,15.240000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<62.230000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<72.390000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<71.374000,0.000000,15.240000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<71.374000,0.000000,15.240000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<70.231000,0.000000,14.351000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<70.231000,0.000000,16.129000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<64.389000,0.000000,16.129000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<64.389000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,16.129000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,14.351000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.485000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,14.097000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,14.097000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.850000,0.000000,14.097000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,14.097000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<69.723000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.231000,0.000000,16.383000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,16.383000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.850000,0.000000,16.383000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,16.383000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.723000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.897000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,14.097000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.770000,0.000000,14.097000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.897000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,14.224000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.897000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.897000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,16.383000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<64.770000,0.000000,16.383000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.897000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,16.256000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.897000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.389000,0.000000,14.097000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,14.097000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.389000,0.000000,14.097000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.389000,0.000000,16.383000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,16.383000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.389000,0.000000,16.383000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,16.129000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,14.351000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.135000,0.000000,14.351000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<63.703200,0.000000,15.240000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<70.916800,0.000000,15.240000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.530000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.530000,0.000000,7.366000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<49.530000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.530000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.530000,0.000000,15.494000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<49.530000,0.000000,15.494000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<50.419000,0.000000,14.351000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<48.641000,0.000000,14.351000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<48.641000,0.000000,8.509000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<50.419000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,14.605000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.641000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,13.970000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.673000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,13.970000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.546000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,13.970000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.387000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,13.970000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<48.387000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,8.890000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<50.546000,0.000000,9.017000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,13.843000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.546000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,8.890000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.387000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,13.843000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.514000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,8.890000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.673000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,8.890000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,8.255000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.641000,0.000000,8.255000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<49.530000,0.000000,7.823200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<49.530000,0.000000,15.036800>}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.130000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.146000,0.000000,71.120000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.130000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<34.290000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.274000,0.000000,71.120000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<33.274000,0.000000,71.120000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<32.131000,0.000000,70.231000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<32.131000,0.000000,72.009000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<26.289000,0.000000,72.009000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<26.289000,0.000000,70.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,70.231000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.385000,0.000000,70.231000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.131000,0.000000,69.977000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,69.977000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,69.977000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.623000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,69.977000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<31.623000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.131000,0.000000,72.263000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,72.263000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,72.263000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.623000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,72.263000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.623000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.797000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,69.977000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<26.670000,0.000000,69.977000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.797000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.623000,0.000000,70.104000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.797000,0.000000,70.104000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.797000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,72.263000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<26.670000,0.000000,72.263000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.797000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.623000,0.000000,72.136000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.797000,0.000000,72.136000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,69.977000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,69.977000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.289000,0.000000,69.977000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,72.263000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,72.263000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.289000,0.000000,72.263000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,70.231000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.035000,0.000000,70.231000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<25.603200,0.000000,71.120000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<32.816800,0.000000,71.120000>}
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.370000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.370000,0.000000,7.366000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<39.370000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.370000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.370000,0.000000,15.494000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<39.370000,0.000000,15.494000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<40.259000,0.000000,14.351000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.481000,0.000000,14.351000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.481000,0.000000,8.509000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<40.259000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,14.605000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.481000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,13.970000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.513000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,13.970000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.386000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,13.970000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.227000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,13.970000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<38.227000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,8.890000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<40.386000,0.000000,9.017000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.386000,0.000000,13.843000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.386000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,8.890000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.227000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.354000,0.000000,13.843000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.354000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,8.890000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.513000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,8.890000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.227000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,8.255000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.481000,0.000000,8.255000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<39.370000,0.000000,7.823200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<39.370000,0.000000,15.036800>}
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<20.320000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<19.304000,0.000000,12.700000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<19.304000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<11.176000,0.000000,12.700000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<10.160000,0.000000,12.700000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<12.319000,0.000000,13.589000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<12.319000,0.000000,11.811000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<18.161000,0.000000,11.811000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<18.161000,0.000000,13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,13.589000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,13.589000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.319000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,13.843000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.319000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,13.843000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<12.700000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.319000,0.000000,11.557000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,11.557000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.319000,0.000000,11.557000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,11.557000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.700000,0.000000,11.557000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,13.843000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.653000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,13.716000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.827000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,11.557000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.653000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.653000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,11.684000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.827000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.161000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,13.843000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.780000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.161000,0.000000,11.557000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,11.557000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.780000,0.000000,11.557000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,13.589000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.415000,0.000000,13.589000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<18.846800,0.000000,12.700000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<11.633200,0.000000,12.700000>}
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,63.754000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<5.080000,0.000000,63.754000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<5.080000,0.000000,55.626000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<5.080000,0.000000,55.626000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<4.191000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<5.969000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<5.969000,0.000000,62.611000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<4.191000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,56.515000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.191000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.937000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.937000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.223000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<6.096000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<3.937000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.064000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.096000,0.000000,62.103000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.096000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.937000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.223000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.223000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.969000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.191000,0.000000,62.865000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.191000,0.000000,62.865000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<5.080000,0.000000,63.296800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<5.080000,0.000000,56.083200>}
//R12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.590000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.606000,0.000000,92.710000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<21.590000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<31.750000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<30.734000,0.000000,92.710000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<30.734000,0.000000,92.710000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<29.591000,0.000000,91.821000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<29.591000,0.000000,93.599000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<23.749000,0.000000,93.599000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<23.749000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,93.599000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,91.821000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.845000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.591000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,91.567000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.210000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,91.567000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<29.083000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.591000,0.000000,93.853000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,93.853000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.210000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,93.853000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.083000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,91.567000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.130000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,91.694000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.257000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,93.853000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.130000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,93.726000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.257000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,91.567000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,91.567000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,91.567000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,93.853000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,93.853000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.749000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,93.599000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,91.821000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.495000,0.000000,91.821000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.063200,0.000000,92.710000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<30.276800,0.000000,92.710000>}
//R13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.004000,0.000000,12.700000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<32.004000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.860000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<23.876000,0.000000,12.700000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<22.860000,0.000000,12.700000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<25.019000,0.000000,13.589000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<25.019000,0.000000,11.811000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<30.861000,0.000000,11.811000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<30.861000,0.000000,13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,13.589000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.765000,0.000000,13.589000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,13.843000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.019000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,13.843000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<25.400000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,11.557000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,11.557000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.019000,0.000000,11.557000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,11.557000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.400000,0.000000,11.557000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,13.843000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.353000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,13.716000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,11.557000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<30.353000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,11.684000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,13.843000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,13.843000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.480000,0.000000,13.843000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,11.557000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,11.557000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.480000,0.000000,11.557000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,13.589000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,13.589000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<31.546800,0.000000,12.700000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<24.333200,0.000000,12.700000>}
//R14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.004000,0.000000,17.780000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<32.004000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.860000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<23.876000,0.000000,17.780000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<22.860000,0.000000,17.780000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<25.019000,0.000000,18.669000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<25.019000,0.000000,16.891000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<30.861000,0.000000,16.891000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<30.861000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,16.891000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,18.669000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.765000,0.000000,18.669000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,18.923000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.019000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,18.923000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<25.400000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,16.637000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,16.637000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.019000,0.000000,16.637000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,16.637000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.400000,0.000000,16.637000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,18.923000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.353000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,18.796000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,16.637000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<30.353000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,16.764000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,18.923000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.480000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,16.637000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,16.637000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.480000,0.000000,16.637000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,16.891000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,18.669000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,18.669000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<31.546800,0.000000,17.780000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<24.333200,0.000000,17.780000>}
//R15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<22.860000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<23.876000,0.000000,22.860000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<22.860000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.004000,0.000000,22.860000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<32.004000,0.000000,22.860000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<30.861000,0.000000,21.971000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<30.861000,0.000000,23.749000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<25.019000,0.000000,23.749000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<25.019000,0.000000,21.971000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,21.971000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.115000,0.000000,21.971000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,21.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,21.717000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.480000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,21.717000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<30.353000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,24.003000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.480000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,24.003000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.353000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,21.717000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.400000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,21.844000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,24.003000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<25.400000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,23.876000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,21.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,21.717000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.019000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,24.003000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.019000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,23.749000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,21.971000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.765000,0.000000,21.971000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<24.333200,0.000000,22.860000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<31.546800,0.000000,22.860000>}
//R16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,43.434000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,35.306000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<25.400000,0.000000,35.306000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<24.511000,0.000000,36.449000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<26.289000,0.000000,36.449000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<26.289000,0.000000,42.291000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<24.511000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,36.195000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,36.830000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.257000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,36.957000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,36.830000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.257000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,36.830000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.543000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,36.957000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,36.830000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<26.416000,0.000000,36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,41.910000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.257000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,36.957000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.384000,0.000000,36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,41.910000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<26.416000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,36.957000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,41.910000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.257000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,41.910000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.543000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,42.545000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,42.545000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,42.976800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,35.763200>}
//R17 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,45.466000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<74.930000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,53.594000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<74.930000,0.000000,53.594000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<75.819000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<74.041000,0.000000,52.451000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<74.041000,0.000000,46.609000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<75.819000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.041000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.819000,0.000000,52.705000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.041000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.073000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<75.946000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.787000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<73.787000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<75.946000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,51.943000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<75.946000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<73.787000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,51.943000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.914000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.073000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.787000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.041000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.819000,0.000000,46.355000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.041000,0.000000,46.355000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<74.930000,0.000000,45.923200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<74.930000,0.000000,53.136800>}
//SV1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.245000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<54.610000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<54.610000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,90.170000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.975000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.705000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<52.070000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<52.070000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.705000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,92.075000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<53.975000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,92.075000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.150000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<56.515000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<56.515000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.245000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,90.170000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<51.435000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<49.530000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<49.530000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,92.075000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<51.435000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<46.990000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.990000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.895000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<48.895000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<44.450000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.450000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,90.170000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,92.075000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.355000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<46.355000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,90.170000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.275000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.005000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<39.370000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.370000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.005000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,92.075000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.275000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.465000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<36.830000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,92.075000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.830000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.830000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.735000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,92.710000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<38.735000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,92.710000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.465000,0.000000,92.710000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<53.340000,0.000000,91.440000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<55.880000,0.000000,91.440000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<50.800000,0.000000,91.440000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<48.260000,0.000000,91.440000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<43.180000,0.000000,91.440000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<45.720000,0.000000,91.440000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<40.640000,0.000000,91.440000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<38.100000,0.000000,91.440000>}
//SV2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,40.640000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,40.005000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,41.275000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,42.545000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,43.180000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,42.545000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,40.640000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,38.100000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,38.100000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,38.735000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,38.735000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,43.815000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,45.085000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,45.720000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,45.085000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,43.180000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,45.720000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,45.720000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,41.910000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,39.370000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,44.450000>}
//SV3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,85.725000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,86.360000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,85.725000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,86.995000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,88.265000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,88.900000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,88.265000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,86.995000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,86.360000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,83.820000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,83.820000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,84.455000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,84.455000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,89.535000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,90.805000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,91.440000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,90.805000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,89.535000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,88.900000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,91.440000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,91.440000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,87.630000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,85.090000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,90.170000>}
//SV4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,69.215000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,69.850000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,69.215000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,70.485000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,72.390000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,71.755000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,70.485000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,70.485000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,70.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,69.850000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,67.310000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,67.310000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,67.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,67.310000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,67.945000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,67.310000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,67.945000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,73.025000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,74.295000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,74.930000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,74.295000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,73.025000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,72.390000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,74.930000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,74.930000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,71.120000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,68.580000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<3.810000,0.000000,73.660000>}
//U$1 silk screen
difference{
cylinder{<76.200000,0,96.520000><76.200000,0.036000,96.520000>3.556000 translate<0,0.000000,0>}
cylinder{<76.200000,-0.1,96.520000><76.200000,0.135000,96.520000>3.302000 translate<0,0.000000,0>}}
difference{
cylinder{<76.200000,0,96.520000><76.200000,0.036000,96.520000>0.990600 translate<0,0.000000,0>}
cylinder{<76.200000,-0.1,96.520000><76.200000,0.135000,96.520000>0.533400 translate<0,0.000000,0>}}
//U$2 silk screen
difference{
cylinder{<76.200000,0,3.810000><76.200000,0.036000,3.810000>3.556000 translate<0,0.000000,0>}
cylinder{<76.200000,-0.1,3.810000><76.200000,0.135000,3.810000>3.302000 translate<0,0.000000,0>}}
difference{
cylinder{<76.200000,0,3.810000><76.200000,0.036000,3.810000>0.990600 translate<0,0.000000,0>}
cylinder{<76.200000,-0.1,3.810000><76.200000,0.135000,3.810000>0.533400 translate<0,0.000000,0>}}
//U$3 silk screen
difference{
cylinder{<3.810000,0,3.810000><3.810000,0.036000,3.810000>3.556000 translate<0,0.000000,0>}
cylinder{<3.810000,-0.1,3.810000><3.810000,0.135000,3.810000>3.302000 translate<0,0.000000,0>}}
difference{
cylinder{<3.810000,0,3.810000><3.810000,0.036000,3.810000>0.990600 translate<0,0.000000,0>}
cylinder{<3.810000,-0.1,3.810000><3.810000,0.135000,3.810000>0.533400 translate<0,0.000000,0>}}
//U$4 silk screen
difference{
cylinder{<3.810000,0,96.520000><3.810000,0.036000,96.520000>3.556000 translate<0,0.000000,0>}
cylinder{<3.810000,-0.1,96.520000><3.810000,0.135000,96.520000>3.302000 translate<0,0.000000,0>}}
difference{
cylinder{<3.810000,0,96.520000><3.810000,0.036000,96.520000>0.990600 translate<0,0.000000,0>}
cylinder{<3.810000,-0.1,96.520000><3.810000,0.135000,96.520000>0.533400 translate<0,0.000000,0>}}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  Z80_SOUND_2(-39.995000,0,-50.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//U$1		DRIL-3
//U$2		DRIL-3
//U$3		DRIL-3
//U$4		DRIL-3
