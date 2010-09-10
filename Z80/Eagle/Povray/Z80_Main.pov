//POVRay-Datei erstellt mit 3d41.ulp v1.05
//X:/Sven/Elektronik/Eagle/Z80/Z80_Main.brd
//01.08.2010 08:32:34

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
#declare global_seed=seed(283);
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


#macro Z80_MAIN(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
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
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<143.510000,0.000000,46.990000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C1 100n C050-025X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<5.080000,0.000000,63.500000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C2 100n C050-025X075
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<27.940000,0.000000,29.210000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C3 100n C050-025X075
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<78.105000,0.000000,28.575000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C4 100n C050-025X075
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<101.600000,0.000000,96.520000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C5 100n C050-025X075
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_WIMA_5_025_072_065("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<63.500000,0.000000,91.440000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C6 100n C050-025X075
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_DIS_ELKO_3MM5_8MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<38.100000,0.000000,8.890000>}#end		//Elko 3,5mm Pitch, 8mm Durchmesser, 11,5mm Hoehe C7  E3,5-8
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP40_W("Z80 CPU","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<92.710000,0.000000,33.020000>translate<0,3.000000,0> }#end		//DIP40 IC2 Z80 CPU DIL40
#ifndef(pack_IC2) object{SOCKET_DIP40W()rotate<0,-270.000000,0> rotate<0,0,0> translate<92.710000,0.000000,33.020000>}#end					//IC-Sockel 40Pin 600mil IC2 Z80 CPU
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_DIS_DIP16("74LS367N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<133.350000,0.000000,13.970000>translate<0,3.000000,0> }#end		//DIP16 IC3 74LS367N DIL16
#ifndef(pack_IC3) object{SOCKET_DIP16()rotate<0,-270.000000,0> rotate<0,0,0> translate<133.350000,0.000000,13.970000>}#end					//IC-Sockel 16Pin IC3 74LS367N
#ifndef(pack_IC4) #declare global_pack_IC4=yes; object {IC_DIS_DIP16("74LS367N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<133.350000,0.000000,38.100000>translate<0,3.000000,0> }#end		//DIP16 IC4 74LS367N DIL16
#ifndef(pack_IC4) object{SOCKET_DIP16()rotate<0,-270.000000,0> rotate<0,0,0> translate<133.350000,0.000000,38.100000>}#end					//IC-Sockel 16Pin IC4 74LS367N
#ifndef(pack_IC5) #declare global_pack_IC5=yes; object {IC_DIS_DIP16("74LS367N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<133.350000,0.000000,67.310000>translate<0,3.000000,0> }#end		//DIP16 IC5 74LS367N DIL16
#ifndef(pack_IC5) object{SOCKET_DIP16()rotate<0,-270.000000,0> rotate<0,0,0> translate<133.350000,0.000000,67.310000>}#end					//IC-Sockel 16Pin IC5 74LS367N
#ifndef(pack_IC6) #declare global_pack_IC6=yes; object {IC_DIS_DIP14("74F04N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<40.640000,0.000000,29.210000>translate<0,3.000000,0> }#end		//DIP14 IC6 74F04N DIL14
#ifndef(pack_IC6) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<40.640000,0.000000,29.210000>}#end					//IC-Sockel 14Pin IC6 74F04N
#ifndef(pack_IC7) #declare global_pack_IC7=yes; object {IC_DIS_DIP20("74LS245N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<92.710000,0.000000,82.550000>translate<0,3.000000,0> }#end		//DIP20 IC7 74LS245N DIL20
#ifndef(pack_IC7) object{SOCKET_DIP20()rotate<0,-270.000000,0> rotate<0,0,0> translate<92.710000,0.000000,82.550000>}#end					//IC-Sockel 20Pin IC7 74LS245N
#ifndef(pack_IC11) #declare global_pack_IC11=yes; object {IC_DIS_DIP14("74LS00N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<40.640000,0.000000,63.500000>translate<0,3.000000,0> }#end		//DIP14 IC11 74LS00N DIL14
#ifndef(pack_IC11) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<40.640000,0.000000,63.500000>}#end					//IC-Sockel 14Pin IC11 74LS00N
#ifndef(pack_IC19) #declare global_pack_IC19=yes; object {IC_DIS_DIP14("74LS08","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<17.780000,0.000000,63.500000>translate<0,3.000000,0> }#end		//DIP14 IC19 74LS08 DIL14
#ifndef(pack_IC19) object{SOCKET_DIP14()rotate<0,0.000000,0> rotate<0,0,0> translate<17.780000,0.000000,63.500000>}#end					//IC-Sockel 14Pin IC19 74LS08
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<48.895000,0.000000,86.360000>}#end		//Diskrete 5MM LED LED1 power LED5MM
#ifndef(pack_QG1) #declare global_pack_QG1=yes; object {SPC_XTAL_OSZ_DIP14("25 MHz",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<62.230000,0.000000,78.740000>}#end		//Quarzoszillator im DIP14 QG1 25 MHz DIL14S
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<81.280000,0.000000,21.590000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R1 1K5 0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<22.225000,0.000000,36.830000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R2 1K5 0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<22.225000,0.000000,40.640000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R3 1K5 0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<43.815000,0.000000,91.440000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R4 470 0207/10
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<30.480000,0.000000,44.450000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R11 4K7 0207/10
#ifndef(pack_R12) #declare global_pack_R12=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<39.370000,0.000000,48.260000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R12 4K7 0207/10
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<35.560000,0.000000,38.100000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R13 4K7 0207/10
#ifndef(pack_R14) #declare global_pack_R14=yes; object {RES_DIS_0207_10MM(texture{pigment{Yellow}finish{phong 0.2}},texture{pigment{Violet*1.2}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<30.480000,0.000000,21.590000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R14 4K7 0207/10
#ifndef(pack_SL1) #declare global_pack_SL1=yes; object {PH_1X16()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<152.400000,0.000000,24.130000>}#end		//Stiftleiste 2,54mm Raster 16Pin 1Reihe (pinhead.lib) SL1 address bus 16P
#ifndef(pack_SL2) #declare global_pack_SL2=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<151.130000,0.000000,83.820000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL2 data bus 08P
#ifndef(pack_SL3) #declare global_pack_SL3=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<16.510000,0.000000,16.510000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL3 control bus 08P
#ifndef(pack_X1) #declare global_pack_X1=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<29.210000,0.000000,83.820000>}#end		//Wannenstecker 10Pin X1 to controller module PAK100/2500-10
}//End union
#end
#if(pcb_pads_smds=on)
//Lötaugen&SMD/Bauteile
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<140.970000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<146.050000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<5.080000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<5.080000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<27.940000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<27.940000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<80.645000,0,28.575000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<75.565000,0,28.575000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<99.060000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<104.140000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<66.040000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<60.960000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<36.322000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<39.878000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,52.070000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<85.090000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,49.530000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,52.070000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<100.330000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,46.990000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<129.540000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<137.160000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,83.820000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,88.900000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,91.440000> texture{col_thl}}
#ifndef(global_pack_IC7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,93.980000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.180000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.640000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,59.690000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<47.625000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<50.165000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<58.420000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<58.420000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<66.040000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_QG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<66.040000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<81.280000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<81.280000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<27.305000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<17.145000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<27.305000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<17.145000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.815000,0,96.520000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.815000,0,86.360000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<35.560000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<25.400000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<44.450000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<34.290000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<40.640000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<30.480000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<35.560000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<25.400000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<152.400000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,92.710000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,90.170000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,87.630000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,80.010000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<151.130000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<34.290000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<34.290000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<31.750000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<31.750000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<29.210000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<29.210000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,85.090000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,82.550000> texture{col_thl}}
//Lötaugen/Durchkontaktierungen
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<15.240000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<33.020000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<45.720000,0,78.740000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<35.560000,0,78.740000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<38.100000,0,55.880000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<27.305000,0,55.880000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<20.955000,0,52.070000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<45.720000,0,52.070000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<18.415000,0,71.120000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<33.020000,0,71.120000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<21.590000,0,89.535000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<29.210000,0,89.535000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<15.875000,0,73.025000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<48.260000,0,73.025000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<54.610000,0,40.640000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<35.560000,0,40.640000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<68.580000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<41.275000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<54.610000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<40.640000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<19.685000,0,77.470000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<53.975000,0,77.470000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<14.605000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<53.340000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<120.650000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<120.650000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<102.870000,0,59.690000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<85.090000,0,59.690000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<124.460000,0,29.210000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<124.460000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<127.000000,0,23.495000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<127.000000,0,47.625000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<124.460000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<124.460000,0,48.895000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<121.920000,0,23.495000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<121.920000,0,6.350000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<80.010000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<67.310000,0,44.450000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<74.930000,0,75.565000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<81.915000,0,75.565000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<48.260000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<48.260000,0,22.225000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<140.335000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<140.335000,0,43.815000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<8.890000,0,69.850000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<29.845000,0,69.850000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<139.700000,0,48.895000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<139.700000,0,76.200000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<81.280000,0,31.115000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<24.765000,0,23.495000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<47.625000,0,55.880000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<41.275000,0,55.880000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signale
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,19.050000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<5.715000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<5.080000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<6.350000,-1.535000,67.310000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<5.080000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,16.510000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.620000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<6.350000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<8.890000,-1.535000,67.310000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<6.350000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<8.890000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<8.890000,-1.535000,67.310000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<8.890000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.890000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.890000,-1.535000,86.995000>}
box{<0,0,-0.965200><17.145000,0.035000,0.965200> rotate<0,90.000000,0> translate<8.890000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,21.590000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.160000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<8.890000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.160000,-1.535000,67.310000>}
box{<0,0,-0.711200><1.270000,0.035000,0.711200> rotate<0,0.000000,0> translate<8.890000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.620000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.620000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,14.605000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,18.415000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<11.430000,-1.535000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,19.050000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,20.955000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,69.215000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<11.430000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,59.690000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,86.360000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.700000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,27.305000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,-44.997030,0> translate<5.715000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,50.165000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<12.700000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,50.165000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.970000,-1.535000,50.165000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,64.770000>}
box{<0,0,-0.304800><4.579050,0.035000,0.304800> rotate<0,-33.687844,0> translate<10.160000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,85.725000>}
box{<0,0,-0.304800><20.955000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.970000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.715000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,12.700000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<5.715000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.160000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,26.670000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<10.160000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,40.640000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,52.070000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,55.245000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.605000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,55.245000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,59.690000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,72.390000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,-1.535000,73.025000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,53.340000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,64.135000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,90.000000,0> translate<16.510000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,40.640000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.240000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,19.685000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.510000,-1.535000,64.135000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,65.405000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<16.510000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,67.310000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.780000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.890000,-1.535000,86.995000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<18.415000,-1.535000,96.520000>}
box{<0,0,-0.965200><13.470384,0.035000,0.965200> rotate<0,-44.997030,0> translate<8.890000,-1.535000,86.995000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.430000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,28.575000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<11.430000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.145000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,36.830000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.145000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,36.830000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,53.975000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<17.780000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,70.485000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,70.485000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,71.120000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.415000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,70.485000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,71.120000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<19.050000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,93.345000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,-44.997030,0> translate<12.700000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<20.320000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<20.320000,-1.535000,16.510000>}
box{<0,0,-0.965200><3.810000,0.035000,0.965200> rotate<0,90.000000,0> translate<20.320000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<20.320000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<20.320000,-1.535000,19.050000>}
box{<0,0,-0.965200><2.540000,0.035000,0.965200> rotate<0,90.000000,0> translate<20.320000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.700000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,27.940000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<12.700000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,51.435000>}
box{<0,0,-0.304800><23.495000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,67.310000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,-90.000000,0> translate<20.320000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,76.835000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<19.685000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.970000,-1.535000,85.725000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,92.075000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.970000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.955000,-1.535000,52.070000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.320000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,26.670000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,48.895000>}
box{<0,0,-0.304800><22.225000,0.035000,0.304800> rotate<0,90.000000,0> translate<21.590000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,63.500000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.320000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,76.835000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,90.000000,0> translate<21.590000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,89.535000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<21.590000,-1.535000,89.535000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,24.765000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<17.780000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,45.085000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.050000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,57.785000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<19.050000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,57.785000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,59.690000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,67.310000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.860000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<20.320000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.130000,-1.535000,8.890000>}
box{<0,0,-0.965200><5.388154,0.035000,0.965200> rotate<0,44.997030,0> translate<20.320000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,51.435000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.590000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,62.230000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<22.860000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,51.435000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.130000,-1.535000,62.230000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,90.000000,0> translate<24.130000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<20.320000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.765000,-1.535000,23.495000>}
box{<0,0,-0.965200><6.286179,0.035000,0.965200> rotate<0,-44.997030,0> translate<20.320000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.765000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.765000,-1.535000,33.020000>}
box{<0,0,-0.965200><9.525000,0.035000,0.965200> rotate<0,90.000000,0> translate<24.765000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.765000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.008046,0.035000,0.304800> rotate<0,71.560328,0> translate<24.765000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,83.820000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<24.130000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,83.820000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,90.000000,0> translate<25.400000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,82.550000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.670000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,92.075000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,85.090000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,-90.000000,0> translate<26.670000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,92.075000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,92.075000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.320000,-1.535000,92.075000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<27.940000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<27.940000,-1.535000,31.750000>}
box{<0,0,-0.965200><1.270000,0.035000,0.965200> rotate<0,-90.000000,0> translate<27.940000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.765000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<27.940000,-1.535000,33.020000>}
box{<0,0,-0.965200><3.175000,0.035000,0.965200> rotate<0,0.000000,0> translate<24.765000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,50.165000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.860000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,55.880000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,50.165000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,55.880000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.940000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,78.105000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<25.400000,-1.535000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,78.105000>}
box{<0,0,-0.304800><22.225000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.940000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.670000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,78.740000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<26.670000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.210000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,85.090000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<29.210000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,0.000000,89.535000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.590000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<27.940000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,33.020000>}
box{<0,0,-0.965200><1.905000,0.035000,0.965200> rotate<0,0.000000,0> translate<27.940000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,36.830000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,36.830000>}
box{<0,0,-0.965200><3.810000,0.035000,0.965200> rotate<0,90.000000,0> translate<29.845000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,38.100000>}
box{<0,0,-0.965200><1.270000,0.035000,0.965200> rotate<0,90.000000,0> translate<29.845000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,40.640000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,40.640000>}
box{<0,0,-0.965200><2.540000,0.035000,0.965200> rotate<0,90.000000,0> translate<29.845000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.400000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,44.450000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.400000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,44.450000>}
box{<0,0,-0.965200><3.810000,0.035000,0.965200> rotate<0,90.000000,0> translate<29.845000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,48.260000>}
box{<0,0,-0.965200><3.810000,0.035000,0.965200> rotate<0,90.000000,0> translate<29.845000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,67.310000>}
box{<0,0,-0.965200><19.050000,0.035000,0.965200> rotate<0,90.000000,0> translate<29.845000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.890000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,0.000000,69.850000>}
box{<0,0,-0.304800><20.955000,0.035000,0.304800> rotate<0,0.000000,0> translate<8.890000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.845000,-1.535000,69.850000>}
box{<0,0,-0.965200><2.540000,0.035000,0.965200> rotate<0,90.000000,0> translate<29.845000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,38.100000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.845000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,83.820000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<29.210000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,83.820000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,-90.000000,0> translate<30.480000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,88.265000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.480000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,88.265000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<31.115000,-1.535000,88.265000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,93.345000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.685000,-1.535000,93.345000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,64.770000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.750000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,20.320000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.240000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.845000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<33.020000,-1.535000,33.020000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,0.000000,0> translate<29.845000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.020000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<29.845000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<33.020000,-1.535000,67.310000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,0.000000,0> translate<29.845000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.415000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,0.000000,71.120000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.415000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.750000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,83.820000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<31.750000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,48.260000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.845000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,33.020000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.560000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,44.450000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.560000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,64.770000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.750000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.560000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,78.740000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<31.750000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-1.535000,83.820000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<33.020000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.130000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<36.322000,-1.535000,8.890000>}
box{<0,0,-0.965200><12.192000,0.035000,0.965200> rotate<0,0.000000,0> translate<24.130000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,16.510000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<33.020000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,82.550000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.290000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<38.100000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.750000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,53.340000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.750000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,53.340000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<38.100000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.305000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,0.000000,55.880000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.305000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,59.690000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<38.100000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,63.500000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,67.310000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<38.100000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,83.820000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,27.305000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<39.370000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,31.115000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,40.005000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,90.000000,0> translate<39.370000,-1.535000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,54.610000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,54.610000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<39.370000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,64.770000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<39.370000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,69.850000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,22.860000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<39.370000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,73.660000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.210000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,29.845000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,33.020000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<40.640000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,38.100000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,41.910000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,59.690000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.640000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,67.310000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<40.640000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,71.120000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,22.860000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.005000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,41.910000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,55.880000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<40.640000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,55.880000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.275000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,17.780000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<38.100000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,23.495000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.275000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,28.575000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.910000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,31.115000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.640000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.910000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.910000,-1.535000,34.925000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<41.910000,-1.535000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.290000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,85.090000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.290000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,29.845000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.910000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,33.020000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.910000,-1.535000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.180000,-1.535000,36.195000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.910000,-1.535000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<41.275000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,44.450000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,50.165000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,59.690000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,62.230000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,64.770000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<18.415000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.815000,-1.535000,96.520000>}
box{<0,0,-0.965200><25.400000,0.035000,0.965200> rotate<0,0.000000,0> translate<18.415000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,29.210000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.005000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,69.850000>}
box{<0,0,-0.304800><5.854411,0.035000,0.304800> rotate<0,40.598615,0> translate<40.005000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,69.850000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,75.565000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,44.997030,0> translate<37.465000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,47.625000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<44.450000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,47.625000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.085000,-1.535000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,76.835000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,44.997030,0> translate<38.100000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,25.400000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,30.480000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.450000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,33.020000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,43.815000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<45.085000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,43.815000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.955000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,0.000000,52.070000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.955000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,59.690000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<44.450000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,67.310000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<45.720000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,0.000000,78.740000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,61.595000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<45.720000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,61.595000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<46.990000,-1.535000,61.595000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,80.010000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<41.910000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,0.000000,55.880000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,55.880000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<46.990000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.625000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.815000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,0.000000,22.225000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,50.165000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,50.165000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.180000,-1.535000,50.165000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,50.165000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.260000,-1.535000,50.165000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,-90.000000,0> translate<48.260000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.875000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,0.000000,73.025000>}
box{<0,0,-0.304800><32.385000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.875000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,75.565000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,76.835000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.085000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,78.740000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.990000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,80.010000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.990000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<49.530000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,73.660000>}
box{<0,0,-0.304800><20.955000,0.035000,0.304800> rotate<0,90.000000,0> translate<51.435000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,4.445000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,-90.000000,0> translate<52.070000,-1.535000,4.445000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,16.510000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.720000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.720000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,40.640000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.070000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,74.295000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<50.165000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,74.295000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.705000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,5.715000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,-90.000000,0> translate<53.340000,-1.535000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,17.780000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,19.050000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,33.655000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.340000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.340000,-1.535000,37.465000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<53.340000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.605000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,0.000000,54.610000>}
box{<0,0,-0.304800><38.735000,0.035000,0.304800> rotate<0,0.000000,0> translate<14.605000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,77.470000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<50.800000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,42.545000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.070000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,74.930000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<50.165000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,74.930000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.975000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,0.000000,77.470000>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.685000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,77.470000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,0.000000,35.560000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,35.560000>}
box{<0,0,-0.304800><28.575000,0.035000,0.304800> rotate<0,90.000000,0> translate<54.610000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.560000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,0.000000,40.640000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.560000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,75.565000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<53.340000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,75.565000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.245000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,8.890000>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,-90.000000,0> translate<55.880000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,-1.535000,33.655000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,-90.000000,0> translate<55.880000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.340000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,-1.535000,37.465000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<53.340000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,40.640000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,52.705000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<51.435000,-1.535000,52.705000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,54.610000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,39.370000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<55.880000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,39.370000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.150000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,12.700000>}
box{<0,0,-0.304800><29.845000,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.420000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,42.545000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.975000,-1.535000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,52.705000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,50.165000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<55.880000,-1.535000,52.705000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,50.165000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.420000,-1.535000,50.165000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,15.240000>}
box{<0,0,-0.304800><35.560000,0.035000,0.304800> rotate<0,-90.000000,0> translate<59.690000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,50.800000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<55.880000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,51.435000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<52.705000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,51.435000>}
box{<0,0,-0.304800><33.655000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.960000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,52.070000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<53.975000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,52.070000>}
box{<0,0,-0.304800><33.020000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.230000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,52.705000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<55.245000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,52.705000>}
box{<0,0,-0.304800><32.385000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,52.705000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.040000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.040000,-1.535000,86.360000>}
box{<0,0,-0.965200><5.080000,0.035000,0.965200> rotate<0,-90.000000,0> translate<66.040000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.040000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.040000,-1.535000,91.440000>}
box{<0,0,-0.965200><5.080000,0.035000,0.965200> rotate<0,-90.000000,0> translate<66.040000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.815000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.040000,-1.535000,96.520000>}
box{<0,0,-0.965200><22.225000,0.035000,0.965200> rotate<0,0.000000,0> translate<43.815000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<66.040000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,-1.535000,69.850000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,90.000000,0> translate<67.310000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,41.910000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<68.580000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,80.010000>}
box{<0,0,-0.304800><36.830000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.850000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,79.375000>}
box{<0,0,-0.304800><40.640000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,79.375000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,78.740000>}
box{<0,0,-0.304800><39.370000,0.035000,0.304800> rotate<0,90.000000,0> translate<72.390000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,74.295000>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,90.000000,0> translate<73.660000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,76.835000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,90.000000,0> translate<73.660000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,78.105000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<73.660000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,75.565000>}
box{<0,0,-0.304800><34.925000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.930000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,74.295000>}
box{<0,0,-0.304800><33.020000,0.035000,0.304800> rotate<0,90.000000,0> translate<76.200000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<76.200000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<76.200000,-1.535000,76.835000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,90.000000,0> translate<76.200000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<76.200000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,32.385000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,32.385000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,90.000000,0> translate<77.470000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,78.105000>}
box{<0,0,-0.304800><36.195000,0.035000,0.304800> rotate<0,90.000000,0> translate<77.470000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,33.020000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<72.390000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,33.020000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<78.740000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,36.830000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<74.930000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.740000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.740000,-1.535000,46.355000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,90.000000,0> translate<78.740000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,77.470000>}
box{<0,0,-0.304800><31.115000,0.035000,0.304800> rotate<0,90.000000,0> translate<78.740000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.375000,-1.535000,17.780000>}
box{<0,0,-0.304800><18.415000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,15.240000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,0.000000,44.450000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.310000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,82.550000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<76.200000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,90.170000>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,-44.997030,0> translate<69.850000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,14.605000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<80.010000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,33.020000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,44.997030,0> translate<73.660000,-1.535000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,36.830000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<76.200000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,73.660000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,90.000000,0> translate<80.645000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,81.280000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<77.470000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,79.375000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,88.900000>}
box{<0,0,-0.304800><13.470384,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.120000,-1.535000,79.375000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<81.280000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<81.280000,-1.535000,26.670000>}
box{<0,0,-0.711200><1.905000,0.035000,0.711200> rotate<0,-90.000000,0> translate<81.280000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<80.645000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<81.280000,-1.535000,28.575000>}
box{<0,0,-0.711200><0.635000,0.035000,0.711200> rotate<0,0.000000,0> translate<80.645000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<81.280000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<81.280000,-1.535000,28.575000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<81.280000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,34.290000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<78.740000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<80.645000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<81.280000,-1.535000,45.720000>}
box{<0,0,-0.203200><0.898026,0.035000,0.203200> rotate<0,44.997030,0> translate<80.645000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,87.630000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.390000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,14.605000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,0.000000,75.565000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<74.930000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,76.200000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<81.915000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,86.360000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,-44.997030,0> translate<73.660000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,15.240000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<81.915000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.765000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,0.000000,23.495000>}
box{<0,0,-0.304800><57.785000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.765000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,0.000000,31.115000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,0.000000,31.115000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<82.550000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,50.800000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<82.550000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,8.890000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.150000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,11.430000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.150000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.230000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,19.050000>}
box{<0,0,-0.304800><22.860000,0.035000,0.304800> rotate<0,0.000000,0> translate<62.230000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,21.590000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<77.470000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,24.130000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<81.280000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<85.090000,-1.535000,31.750000>}
box{<0,0,-0.711200><3.862554,0.035000,0.711200> rotate<0,-9.461698,0> translate<81.280000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,34.290000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,36.830000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,41.910000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<77.470000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,44.450000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.010000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<82.550000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<85.090000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,90.170000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.010000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,93.980000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<86.360000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<79.375000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<87.630000,-1.535000,17.780000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<79.375000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,29.210000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,33.020000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,33.020000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<87.630000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,39.370000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.740000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<87.630000,-1.535000,43.180000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,0.000000,0> translate<78.740000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<87.630000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,26.670000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<81.280000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.900000,-1.535000,45.720000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<81.280000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,45.720000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<88.900000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,73.660000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,76.200000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.915000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,81.280000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,86.360000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.915000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,88.900000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.360000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,93.980000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.360000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,54.610000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,66.675000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,90.000000,0> translate<90.805000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,78.740000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<91.440000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,82.550000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.010000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,87.630000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.280000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,91.440000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,91.440000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<91.440000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,52.070000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,65.405000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,90.000000,0> translate<92.075000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,12.700000>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.420000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,15.240000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<82.550000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,77.470000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.900000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,83.820000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<92.710000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.345000,-1.535000,50.800000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<82.550000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.345000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.345000,-1.535000,64.135000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,90.000000,0> translate<93.345000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<92.710000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,91.440000>}
box{<0,0,-0.304800><22.225000,0.035000,0.304800> rotate<0,90.000000,0> translate<93.980000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<94.615000,-1.535000,49.530000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<94.615000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<94.615000,-1.535000,62.865000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,90.000000,0> translate<94.615000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,15.240000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<92.710000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,20.320000>}
box{<0,0,-0.304800><33.020000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,43.180000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<96.520000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,91.440000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,91.440000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.980000,-1.535000,91.440000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<96.520000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<96.520000,-1.535000,93.980000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,-90.000000,0> translate<96.520000,-1.535000,93.980000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<96.520000,-1.535000,93.980000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<96.520000,-1.535000,95.250000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<96.520000,-1.535000,95.250000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.040000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<96.520000,-1.535000,96.520000>}
box{<0,0,-0.965200><30.480000,0.035000,0.965200> rotate<0,0.000000,0> translate<66.040000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.155000,-1.535000,17.780000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.630000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,21.590000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<96.520000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,40.640000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,52.070000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<97.790000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.155000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<97.155000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<96.520000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<99.060000,-1.535000,96.520000>}
box{<0,0,-0.965200><2.540000,0.035000,0.965200> rotate<0,0.000000,0> translate<96.520000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-1.535000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,6.985000>}
box{<0,0,-0.304800><45.720000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,-1.535000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,8.890000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.330000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,16.510000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.980000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,19.050000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<98.425000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,21.590000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,31.750000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,34.290000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,52.070000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,59.690000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<100.330000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,73.660000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,76.200000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,78.740000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,81.280000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,83.820000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,86.360000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,88.900000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<99.060000,-1.535000,96.520000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<100.965000,-1.535000,94.615000>}
box{<0,0,-0.965200><2.694077,0.035000,0.965200> rotate<0,44.997030,0> translate<99.060000,-1.535000,96.520000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,69.215000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.980000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,39.370000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,49.530000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,5.715000>}
box{<0,0,-0.304800><49.530000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.340000,-1.535000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,11.430000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,11.430000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<102.870000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,15.240000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,36.830000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,40.640000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,0.000000,59.690000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,40.005000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<102.870000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,41.910000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<102.235000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,59.055000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<102.870000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.070000,-1.535000,4.445000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,4.445000>}
box{<0,0,-0.304800><52.070000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.070000,-1.535000,4.445000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,12.065000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<102.235000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,4.445000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,12.065000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<104.140000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,43.180000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<104.140000,-1.535000,60.960000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<101.600000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,85.090000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,87.630000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,90.170000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,92.710000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,42.545000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<104.140000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,44.450000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,60.325000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<104.140000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,6.350000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<105.410000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,12.700000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<102.870000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,83.820000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,82.550000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,31.750000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<102.870000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,31.750000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<107.950000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,81.280000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,76.200000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,-44.997030,0> translate<101.600000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,32.385000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,44.997030,0> translate<102.235000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,32.385000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<109.220000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,80.010000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.330000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,25.400000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<110.490000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,33.020000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,44.997030,0> translate<103.505000,-1.535000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,33.655000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<103.505000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,33.655000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<111.760000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,26.670000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<113.030000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,34.290000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<104.775000,-1.535000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,34.925000>}
box{<0,0,-0.304800><13.470384,0.035000,0.304800> rotate<0,44.997030,0> translate<104.775000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,34.925000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<114.300000,-1.535000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,45.720000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,46.990000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.745000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.745000,-1.535000,40.640000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<118.745000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.745000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<117.475000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.745000,-1.535000,48.260000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<103.505000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,12.700000>}
box{<0,0,-0.304800><16.164461,0.035000,0.304800> rotate<0,44.997030,0> translate<107.950000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,20.320000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<113.030000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,66.675000>}
box{<0,0,-0.304800><28.575000,0.035000,0.304800> rotate<0,0.000000,0> translate<90.805000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,13.970000>}
box{<0,0,-0.304800><15.266435,0.035000,0.304800> rotate<0,44.997030,0> translate<109.220000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,21.590000>}
box{<0,0,-0.304800><8.082231,0.035000,0.304800> rotate<0,44.997030,0> translate<114.300000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,45.085000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<118.110000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,65.405000>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.075000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,15.240000>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,44.997030,0> translate<110.490000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,0.000000,41.910000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,-90.000000,0> translate<120.650000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,44.450000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<120.015000,-1.535000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,54.610000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.345000,-1.535000,64.135000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,64.135000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.345000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.760000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,16.510000>}
box{<0,0,-0.304800><13.470384,0.035000,0.304800> rotate<0,44.997030,0> translate<111.760000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.745000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<118.745000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<94.615000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,62.865000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<94.615000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,6.350000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,0.000000,23.495000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<121.920000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,63.500000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<121.285000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,59.055000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,50.800000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,-90.000000,0> translate<122.555000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,59.055000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,59.055000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<103.505000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,68.580000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<120.015000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,52.070000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,-90.000000,0> translate<123.825000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.775000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,60.325000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.775000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,64.135000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,67.310000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<120.650000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,29.210000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<124.460000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,0.000000,41.910000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<124.460000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,76.200000>}
box{<0,0,-0.304800><15.875000,0.035000,0.304800> rotate<0,0.000000,0> translate<108.585000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,0.000000,76.200000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,90.000000,0> translate<124.460000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.745000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,34.290000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<118.745000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,66.675000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,73.660000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,-44.997030,0> translate<119.380000,-1.535000,66.675000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,8.890000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<127.000000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,10.160000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<127.000000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,12.700000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<119.380000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,23.495000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<121.920000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,35.560000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<120.650000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,47.625000>}
box{<0,0,-0.304800><2.839806,0.035000,0.304800> rotate<0,26.563298,0> translate<124.460000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,0.000000,47.625000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,90.000000,0> translate<127.000000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<127.000000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<124.460000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.905000,-1.535000,24.765000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<128.270000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,10.160000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,15.240000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.650000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.380000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,20.320000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<119.380000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.618172,0.035000,0.304800> rotate<0,14.035317,0> translate<127.000000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,34.290000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<125.095000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,41.910000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<124.460000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.650000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,44.450000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.650000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,46.990000>}
box{<0,0,-0.304800><2.618172,0.035000,0.304800> rotate<0,14.035317,0> translate<127.000000,-1.535000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,63.500000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<121.920000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,68.580000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<123.190000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,73.660000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<126.365000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,76.200000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<124.460000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,6.350000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,8.890000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,12.700000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,12.700000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,21.590000>}
box{<0,0,-0.304800><12.065000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.015000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,31.750000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,35.560000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,39.370000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,39.370000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<132.080000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,45.720000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<121.285000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,59.690000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,59.690000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,62.230000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,66.040000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.080000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,71.120000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,16.510000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<121.285000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,36.830000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,60.960000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,2.540000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.350000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,5.080000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,7.620000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,10.160000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.350000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,13.970000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.015000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,22.860000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,27.940000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.350000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,30.480000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,33.020000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.350000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,34.290000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,62.230000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.350000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,67.310000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<123.825000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,17.780000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,35.560000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<132.715000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,44.450000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.985000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.540000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,46.990000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<129.540000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,59.690000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<132.715000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,59.690000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<133.985000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,3.810000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<134.620000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,6.350000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<133.350000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,12.700000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<134.620000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,14.605000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<132.715000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,31.750000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<133.350000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,36.830000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<134.620000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<133.350000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,68.580000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,68.580000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<134.620000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,16.510000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<133.985000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,55.245000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,62.230000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<134.620000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,7.620000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<133.350000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.080000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,17.780000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<132.080000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,20.320000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<133.350000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,56.515000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<133.985000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,7.620000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,12.700000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,17.780000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,20.320000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,31.750000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,36.830000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,44.450000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<133.985000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,5.080000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,10.160000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,3.810000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,16.510000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.255000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,2.540000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<133.350000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<137.160000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<139.700000,-1.535000,46.990000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<137.160000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<139.700000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<139.700000,-1.535000,46.990000>}
box{<0,0,-0.711200><1.905000,0.035000,0.711200> rotate<0,-90.000000,0> translate<139.700000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,0.000000,48.895000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,-90.000000,0> translate<139.700000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<137.160000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<139.700000,-1.535000,76.200000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<137.160000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,15.240000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<137.160000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<140.335000,-1.535000,22.860000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,0.000000,0> translate<137.160000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,0.000000,22.860000>}
box{<0,0,-0.304800><20.955000,0.035000,0.304800> rotate<0,-90.000000,0> translate<140.335000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<140.335000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<140.335000,-1.535000,43.815000>}
box{<0,0,-0.711200><3.175000,0.035000,0.711200> rotate<0,-90.000000,0> translate<140.335000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<139.700000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.335000,-1.535000,46.990000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,0.000000,0> translate<139.700000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,39.370000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<140.335000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<140.970000,-1.535000,46.990000>}
box{<0,0,-0.711200><0.635000,0.035000,0.711200> rotate<0,0.000000,0> translate<140.335000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,19.050000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<139.065000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.905000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,24.765000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<128.905000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,41.910000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,50.800000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,0.000000,0> translate<122.555000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,34.290000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,41.910000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<141.605000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.825000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,52.070000>}
box{<0,0,-0.304800><18.415000,0.035000,0.304800> rotate<0,0.000000,0> translate<123.825000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,17.780000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<140.335000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,35.560000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<133.985000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.620000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,40.640000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<134.620000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,42.545000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<142.240000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,42.545000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,-90.000000,0> translate<142.875000,-1.535000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,49.530000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<141.605000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,15.240000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<138.430000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,27.940000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<133.350000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,80.010000>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.220000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,29.210000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<142.875000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,50.165000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,41.910000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.145000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,50.165000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<142.240000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<139.700000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<144.145000,-1.535000,76.200000>}
box{<0,0,-0.711200><4.445000,0.035000,0.711200> rotate<0,0.000000,0> translate<139.700000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,81.280000>}
box{<0,0,-0.304800><36.195000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.950000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.700000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,7.620000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<139.700000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,62.230000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.255000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,82.550000>}
box{<0,0,-0.304800><38.100000,0.035000,0.304800> rotate<0,0.000000,0> translate<106.680000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,83.820000>}
box{<0,0,-0.304800><39.370000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.065000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,10.160000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<139.065000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,27.940000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<144.145000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,83.820000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.780000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.430000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,12.700000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<138.430000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<141.605000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,25.400000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<143.510000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,30.480000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<142.240000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,55.245000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,55.245000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.255000,-1.535000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,31.750000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<142.875000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,56.515000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,58.420000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,82.550000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<145.415000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.970000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,33.020000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<140.970000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,80.010000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<144.780000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,44.450000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<147.955000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<144.145000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<147.955000,-1.535000,72.390000>}
box{<0,0,-0.711200><5.388154,0.035000,0.711200> rotate<0,44.997030,0> translate<144.145000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,77.470000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<144.145000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,74.930000>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<143.510000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,43.815000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<149.225000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,19.050000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,0.000000,0> translate<141.605000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,31.750000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.685000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,38.100000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<147.955000,-1.535000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,46.355000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<147.955000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,55.245000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,51.435000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<146.050000,-1.535000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,51.435000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<149.860000,-1.535000,51.435000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.495000,-1.535000,40.640000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<149.225000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<149.225000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,52.070000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<146.685000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,52.070000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.130000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,74.930000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<148.590000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,77.470000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.955000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,80.010000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,82.550000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.685000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,85.090000>}
box{<0,0,-0.304800><46.990000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,87.630000>}
box{<0,0,-0.304800><46.990000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,90.170000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,90.170000>}
box{<0,0,-0.304800><46.990000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,90.170000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.140000,-1.535000,92.710000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.130000,-1.535000,92.710000>}
box{<0,0,-0.304800><46.990000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.140000,-1.535000,92.710000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,7.620000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.780000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,10.160000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<145.415000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,12.700000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<143.510000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,15.240000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<143.510000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.875000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,17.780000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.875000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,25.400000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,27.940000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<145.415000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.050000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,30.480000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.050000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,33.020000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<147.320000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,38.100000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.860000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.495000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,40.640000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<150.495000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,52.705000>}
box{<0,0,-0.304800><8.082231,0.035000,0.304800> rotate<0,44.997030,0> translate<146.685000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,52.705000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,90.000000,0> translate<152.400000,-1.535000,52.705000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.780000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,53.340000>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<144.780000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,53.340000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.670000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<150.495000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<154.305000,-1.535000,21.590000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,0.000000,0> translate<150.495000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<150.495000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<154.305000,-1.535000,34.290000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,0.000000,0> translate<150.495000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<147.955000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<154.305000,-1.535000,72.390000>}
box{<0,0,-0.711200><6.350000,0.035000,0.711200> rotate<0,0.000000,0> translate<147.955000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<154.305000,-1.535000,94.615000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<154.305000,-1.535000,72.390000>}
box{<0,0,-0.711200><22.225000,0.035000,0.711200> rotate<0,-90.000000,0> translate<154.305000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<100.965000,-1.535000,94.615000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<154.305000,-1.535000,94.615000>}
box{<0,0,-0.711200><53.340000,0.035000,0.711200> rotate<0,0.000000,0> translate<100.965000,-1.535000,94.615000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,5.080000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<152.400000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,5.080000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,-90.000000,0> translate<154.940000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<149.860000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<154.940000,-1.535000,19.050000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<149.860000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,22.860000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<152.400000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,22.860000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,-90.000000,0> translate<154.940000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<149.860000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<154.940000,-1.535000,31.750000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<149.860000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.400000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<152.400000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.670000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,44.450000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<153.670000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.940000,-1.535000,44.450000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<154.940000,-1.535000,44.450000> }
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
cylinder{<140.970000,0.038000,46.990000><140.970000,-1.538000,46.990000>0.406400}
cylinder{<146.050000,0.038000,46.990000><146.050000,-1.538000,46.990000>0.406400}
cylinder{<5.080000,0.038000,66.040000><5.080000,-1.538000,66.040000>0.406400}
cylinder{<5.080000,0.038000,60.960000><5.080000,-1.538000,60.960000>0.406400}
cylinder{<27.940000,0.038000,31.750000><27.940000,-1.538000,31.750000>0.406400}
cylinder{<27.940000,0.038000,26.670000><27.940000,-1.538000,26.670000>0.406400}
cylinder{<80.645000,0.038000,28.575000><80.645000,-1.538000,28.575000>0.406400}
cylinder{<75.565000,0.038000,28.575000><75.565000,-1.538000,28.575000>0.406400}
cylinder{<99.060000,0.038000,96.520000><99.060000,-1.538000,96.520000>0.406400}
cylinder{<104.140000,0.038000,96.520000><104.140000,-1.538000,96.520000>0.406400}
cylinder{<66.040000,0.038000,91.440000><66.040000,-1.538000,91.440000>0.406400}
cylinder{<60.960000,0.038000,91.440000><60.960000,-1.538000,91.440000>0.406400}
cylinder{<36.322000,0.038000,8.890000><36.322000,-1.538000,8.890000>0.406400}
cylinder{<39.878000,0.038000,8.890000><39.878000,-1.538000,8.890000>0.406400}
cylinder{<85.090000,0.038000,57.150000><85.090000,-1.538000,57.150000>0.406400}
cylinder{<85.090000,0.038000,54.610000><85.090000,-1.538000,54.610000>0.406400}
cylinder{<85.090000,0.038000,52.070000><85.090000,-1.538000,52.070000>0.406400}
cylinder{<85.090000,0.038000,49.530000><85.090000,-1.538000,49.530000>0.406400}
cylinder{<85.090000,0.038000,46.990000><85.090000,-1.538000,46.990000>0.406400}
cylinder{<85.090000,0.038000,44.450000><85.090000,-1.538000,44.450000>0.406400}
cylinder{<85.090000,0.038000,41.910000><85.090000,-1.538000,41.910000>0.406400}
cylinder{<85.090000,0.038000,39.370000><85.090000,-1.538000,39.370000>0.406400}
cylinder{<85.090000,0.038000,36.830000><85.090000,-1.538000,36.830000>0.406400}
cylinder{<85.090000,0.038000,34.290000><85.090000,-1.538000,34.290000>0.406400}
cylinder{<85.090000,0.038000,31.750000><85.090000,-1.538000,31.750000>0.406400}
cylinder{<85.090000,0.038000,29.210000><85.090000,-1.538000,29.210000>0.406400}
cylinder{<85.090000,0.038000,26.670000><85.090000,-1.538000,26.670000>0.406400}
cylinder{<85.090000,0.038000,24.130000><85.090000,-1.538000,24.130000>0.406400}
cylinder{<85.090000,0.038000,21.590000><85.090000,-1.538000,21.590000>0.406400}
cylinder{<85.090000,0.038000,19.050000><85.090000,-1.538000,19.050000>0.406400}
cylinder{<85.090000,0.038000,16.510000><85.090000,-1.538000,16.510000>0.406400}
cylinder{<85.090000,0.038000,13.970000><85.090000,-1.538000,13.970000>0.406400}
cylinder{<85.090000,0.038000,11.430000><85.090000,-1.538000,11.430000>0.406400}
cylinder{<85.090000,0.038000,8.890000><85.090000,-1.538000,8.890000>0.406400}
cylinder{<100.330000,0.038000,8.890000><100.330000,-1.538000,8.890000>0.406400}
cylinder{<100.330000,0.038000,11.430000><100.330000,-1.538000,11.430000>0.406400}
cylinder{<100.330000,0.038000,13.970000><100.330000,-1.538000,13.970000>0.406400}
cylinder{<100.330000,0.038000,16.510000><100.330000,-1.538000,16.510000>0.406400}
cylinder{<100.330000,0.038000,19.050000><100.330000,-1.538000,19.050000>0.406400}
cylinder{<100.330000,0.038000,21.590000><100.330000,-1.538000,21.590000>0.406400}
cylinder{<100.330000,0.038000,24.130000><100.330000,-1.538000,24.130000>0.406400}
cylinder{<100.330000,0.038000,26.670000><100.330000,-1.538000,26.670000>0.406400}
cylinder{<100.330000,0.038000,29.210000><100.330000,-1.538000,29.210000>0.406400}
cylinder{<100.330000,0.038000,31.750000><100.330000,-1.538000,31.750000>0.406400}
cylinder{<100.330000,0.038000,34.290000><100.330000,-1.538000,34.290000>0.406400}
cylinder{<100.330000,0.038000,36.830000><100.330000,-1.538000,36.830000>0.406400}
cylinder{<100.330000,0.038000,39.370000><100.330000,-1.538000,39.370000>0.406400}
cylinder{<100.330000,0.038000,41.910000><100.330000,-1.538000,41.910000>0.406400}
cylinder{<100.330000,0.038000,44.450000><100.330000,-1.538000,44.450000>0.406400}
cylinder{<100.330000,0.038000,46.990000><100.330000,-1.538000,46.990000>0.406400}
cylinder{<100.330000,0.038000,49.530000><100.330000,-1.538000,49.530000>0.406400}
cylinder{<100.330000,0.038000,52.070000><100.330000,-1.538000,52.070000>0.406400}
cylinder{<100.330000,0.038000,54.610000><100.330000,-1.538000,54.610000>0.406400}
cylinder{<100.330000,0.038000,57.150000><100.330000,-1.538000,57.150000>0.406400}
cylinder{<129.540000,0.038000,22.860000><129.540000,-1.538000,22.860000>0.406400}
cylinder{<129.540000,0.038000,20.320000><129.540000,-1.538000,20.320000>0.406400}
cylinder{<129.540000,0.038000,17.780000><129.540000,-1.538000,17.780000>0.406400}
cylinder{<129.540000,0.038000,15.240000><129.540000,-1.538000,15.240000>0.406400}
cylinder{<129.540000,0.038000,12.700000><129.540000,-1.538000,12.700000>0.406400}
cylinder{<129.540000,0.038000,10.160000><129.540000,-1.538000,10.160000>0.406400}
cylinder{<129.540000,0.038000,7.620000><129.540000,-1.538000,7.620000>0.406400}
cylinder{<129.540000,0.038000,5.080000><129.540000,-1.538000,5.080000>0.406400}
cylinder{<137.160000,0.038000,5.080000><137.160000,-1.538000,5.080000>0.406400}
cylinder{<137.160000,0.038000,7.620000><137.160000,-1.538000,7.620000>0.406400}
cylinder{<137.160000,0.038000,10.160000><137.160000,-1.538000,10.160000>0.406400}
cylinder{<137.160000,0.038000,12.700000><137.160000,-1.538000,12.700000>0.406400}
cylinder{<137.160000,0.038000,15.240000><137.160000,-1.538000,15.240000>0.406400}
cylinder{<137.160000,0.038000,17.780000><137.160000,-1.538000,17.780000>0.406400}
cylinder{<137.160000,0.038000,20.320000><137.160000,-1.538000,20.320000>0.406400}
cylinder{<137.160000,0.038000,22.860000><137.160000,-1.538000,22.860000>0.406400}
cylinder{<129.540000,0.038000,46.990000><129.540000,-1.538000,46.990000>0.406400}
cylinder{<129.540000,0.038000,44.450000><129.540000,-1.538000,44.450000>0.406400}
cylinder{<129.540000,0.038000,41.910000><129.540000,-1.538000,41.910000>0.406400}
cylinder{<129.540000,0.038000,39.370000><129.540000,-1.538000,39.370000>0.406400}
cylinder{<129.540000,0.038000,36.830000><129.540000,-1.538000,36.830000>0.406400}
cylinder{<129.540000,0.038000,34.290000><129.540000,-1.538000,34.290000>0.406400}
cylinder{<129.540000,0.038000,31.750000><129.540000,-1.538000,31.750000>0.406400}
cylinder{<129.540000,0.038000,29.210000><129.540000,-1.538000,29.210000>0.406400}
cylinder{<137.160000,0.038000,29.210000><137.160000,-1.538000,29.210000>0.406400}
cylinder{<137.160000,0.038000,31.750000><137.160000,-1.538000,31.750000>0.406400}
cylinder{<137.160000,0.038000,34.290000><137.160000,-1.538000,34.290000>0.406400}
cylinder{<137.160000,0.038000,36.830000><137.160000,-1.538000,36.830000>0.406400}
cylinder{<137.160000,0.038000,39.370000><137.160000,-1.538000,39.370000>0.406400}
cylinder{<137.160000,0.038000,41.910000><137.160000,-1.538000,41.910000>0.406400}
cylinder{<137.160000,0.038000,44.450000><137.160000,-1.538000,44.450000>0.406400}
cylinder{<137.160000,0.038000,46.990000><137.160000,-1.538000,46.990000>0.406400}
cylinder{<129.540000,0.038000,76.200000><129.540000,-1.538000,76.200000>0.406400}
cylinder{<129.540000,0.038000,73.660000><129.540000,-1.538000,73.660000>0.406400}
cylinder{<129.540000,0.038000,71.120000><129.540000,-1.538000,71.120000>0.406400}
cylinder{<129.540000,0.038000,68.580000><129.540000,-1.538000,68.580000>0.406400}
cylinder{<129.540000,0.038000,66.040000><129.540000,-1.538000,66.040000>0.406400}
cylinder{<129.540000,0.038000,63.500000><129.540000,-1.538000,63.500000>0.406400}
cylinder{<129.540000,0.038000,60.960000><129.540000,-1.538000,60.960000>0.406400}
cylinder{<129.540000,0.038000,58.420000><129.540000,-1.538000,58.420000>0.406400}
cylinder{<137.160000,0.038000,58.420000><137.160000,-1.538000,58.420000>0.406400}
cylinder{<137.160000,0.038000,60.960000><137.160000,-1.538000,60.960000>0.406400}
cylinder{<137.160000,0.038000,63.500000><137.160000,-1.538000,63.500000>0.406400}
cylinder{<137.160000,0.038000,66.040000><137.160000,-1.538000,66.040000>0.406400}
cylinder{<137.160000,0.038000,68.580000><137.160000,-1.538000,68.580000>0.406400}
cylinder{<137.160000,0.038000,71.120000><137.160000,-1.538000,71.120000>0.406400}
cylinder{<137.160000,0.038000,73.660000><137.160000,-1.538000,73.660000>0.406400}
cylinder{<137.160000,0.038000,76.200000><137.160000,-1.538000,76.200000>0.406400}
cylinder{<33.020000,0.038000,25.400000><33.020000,-1.538000,25.400000>0.406400}
cylinder{<35.560000,0.038000,25.400000><35.560000,-1.538000,25.400000>0.406400}
cylinder{<38.100000,0.038000,25.400000><38.100000,-1.538000,25.400000>0.406400}
cylinder{<40.640000,0.038000,25.400000><40.640000,-1.538000,25.400000>0.406400}
cylinder{<43.180000,0.038000,25.400000><43.180000,-1.538000,25.400000>0.406400}
cylinder{<45.720000,0.038000,25.400000><45.720000,-1.538000,25.400000>0.406400}
cylinder{<48.260000,0.038000,25.400000><48.260000,-1.538000,25.400000>0.406400}
cylinder{<48.260000,0.038000,33.020000><48.260000,-1.538000,33.020000>0.406400}
cylinder{<45.720000,0.038000,33.020000><45.720000,-1.538000,33.020000>0.406400}
cylinder{<43.180000,0.038000,33.020000><43.180000,-1.538000,33.020000>0.406400}
cylinder{<40.640000,0.038000,33.020000><40.640000,-1.538000,33.020000>0.406400}
cylinder{<38.100000,0.038000,33.020000><38.100000,-1.538000,33.020000>0.406400}
cylinder{<35.560000,0.038000,33.020000><35.560000,-1.538000,33.020000>0.406400}
cylinder{<33.020000,0.038000,33.020000><33.020000,-1.538000,33.020000>0.406400}
cylinder{<88.900000,0.038000,93.980000><88.900000,-1.538000,93.980000>0.406400}
cylinder{<88.900000,0.038000,91.440000><88.900000,-1.538000,91.440000>0.406400}
cylinder{<88.900000,0.038000,88.900000><88.900000,-1.538000,88.900000>0.406400}
cylinder{<88.900000,0.038000,86.360000><88.900000,-1.538000,86.360000>0.406400}
cylinder{<88.900000,0.038000,83.820000><88.900000,-1.538000,83.820000>0.406400}
cylinder{<88.900000,0.038000,81.280000><88.900000,-1.538000,81.280000>0.406400}
cylinder{<88.900000,0.038000,78.740000><88.900000,-1.538000,78.740000>0.406400}
cylinder{<88.900000,0.038000,76.200000><88.900000,-1.538000,76.200000>0.406400}
cylinder{<88.900000,0.038000,73.660000><88.900000,-1.538000,73.660000>0.406400}
cylinder{<88.900000,0.038000,71.120000><88.900000,-1.538000,71.120000>0.406400}
cylinder{<96.520000,0.038000,71.120000><96.520000,-1.538000,71.120000>0.406400}
cylinder{<96.520000,0.038000,73.660000><96.520000,-1.538000,73.660000>0.406400}
cylinder{<96.520000,0.038000,76.200000><96.520000,-1.538000,76.200000>0.406400}
cylinder{<96.520000,0.038000,78.740000><96.520000,-1.538000,78.740000>0.406400}
cylinder{<96.520000,0.038000,81.280000><96.520000,-1.538000,81.280000>0.406400}
cylinder{<96.520000,0.038000,83.820000><96.520000,-1.538000,83.820000>0.406400}
cylinder{<96.520000,0.038000,86.360000><96.520000,-1.538000,86.360000>0.406400}
cylinder{<96.520000,0.038000,88.900000><96.520000,-1.538000,88.900000>0.406400}
cylinder{<96.520000,0.038000,91.440000><96.520000,-1.538000,91.440000>0.406400}
cylinder{<96.520000,0.038000,93.980000><96.520000,-1.538000,93.980000>0.406400}
cylinder{<33.020000,0.038000,59.690000><33.020000,-1.538000,59.690000>0.406400}
cylinder{<35.560000,0.038000,59.690000><35.560000,-1.538000,59.690000>0.406400}
cylinder{<38.100000,0.038000,59.690000><38.100000,-1.538000,59.690000>0.406400}
cylinder{<40.640000,0.038000,59.690000><40.640000,-1.538000,59.690000>0.406400}
cylinder{<43.180000,0.038000,59.690000><43.180000,-1.538000,59.690000>0.406400}
cylinder{<45.720000,0.038000,59.690000><45.720000,-1.538000,59.690000>0.406400}
cylinder{<48.260000,0.038000,59.690000><48.260000,-1.538000,59.690000>0.406400}
cylinder{<48.260000,0.038000,67.310000><48.260000,-1.538000,67.310000>0.406400}
cylinder{<45.720000,0.038000,67.310000><45.720000,-1.538000,67.310000>0.406400}
cylinder{<43.180000,0.038000,67.310000><43.180000,-1.538000,67.310000>0.406400}
cylinder{<40.640000,0.038000,67.310000><40.640000,-1.538000,67.310000>0.406400}
cylinder{<38.100000,0.038000,67.310000><38.100000,-1.538000,67.310000>0.406400}
cylinder{<35.560000,0.038000,67.310000><35.560000,-1.538000,67.310000>0.406400}
cylinder{<33.020000,0.038000,67.310000><33.020000,-1.538000,67.310000>0.406400}
cylinder{<10.160000,0.038000,59.690000><10.160000,-1.538000,59.690000>0.406400}
cylinder{<12.700000,0.038000,59.690000><12.700000,-1.538000,59.690000>0.406400}
cylinder{<15.240000,0.038000,59.690000><15.240000,-1.538000,59.690000>0.406400}
cylinder{<17.780000,0.038000,59.690000><17.780000,-1.538000,59.690000>0.406400}
cylinder{<20.320000,0.038000,59.690000><20.320000,-1.538000,59.690000>0.406400}
cylinder{<22.860000,0.038000,59.690000><22.860000,-1.538000,59.690000>0.406400}
cylinder{<25.400000,0.038000,59.690000><25.400000,-1.538000,59.690000>0.406400}
cylinder{<25.400000,0.038000,67.310000><25.400000,-1.538000,67.310000>0.406400}
cylinder{<22.860000,0.038000,67.310000><22.860000,-1.538000,67.310000>0.406400}
cylinder{<20.320000,0.038000,67.310000><20.320000,-1.538000,67.310000>0.406400}
cylinder{<17.780000,0.038000,67.310000><17.780000,-1.538000,67.310000>0.406400}
cylinder{<15.240000,0.038000,67.310000><15.240000,-1.538000,67.310000>0.406400}
cylinder{<12.700000,0.038000,67.310000><12.700000,-1.538000,67.310000>0.406400}
cylinder{<10.160000,0.038000,67.310000><10.160000,-1.538000,67.310000>0.406400}
cylinder{<47.625000,0.038000,86.360000><47.625000,-1.538000,86.360000>0.406400}
cylinder{<50.165000,0.038000,86.360000><50.165000,-1.538000,86.360000>0.406400}
cylinder{<58.420000,0.038000,86.360000><58.420000,-1.538000,86.360000>0.406400}
cylinder{<58.420000,0.038000,71.120000><58.420000,-1.538000,71.120000>0.406400}
cylinder{<66.040000,0.038000,71.120000><66.040000,-1.538000,71.120000>0.406400}
cylinder{<66.040000,0.038000,86.360000><66.040000,-1.538000,86.360000>0.406400}
cylinder{<81.280000,0.038000,26.670000><81.280000,-1.538000,26.670000>0.406400}
cylinder{<81.280000,0.038000,16.510000><81.280000,-1.538000,16.510000>0.406400}
cylinder{<27.305000,0.038000,36.830000><27.305000,-1.538000,36.830000>0.406400}
cylinder{<17.145000,0.038000,36.830000><17.145000,-1.538000,36.830000>0.406400}
cylinder{<27.305000,0.038000,40.640000><27.305000,-1.538000,40.640000>0.406400}
cylinder{<17.145000,0.038000,40.640000><17.145000,-1.538000,40.640000>0.406400}
cylinder{<43.815000,0.038000,96.520000><43.815000,-1.538000,96.520000>0.406400}
cylinder{<43.815000,0.038000,86.360000><43.815000,-1.538000,86.360000>0.406400}
cylinder{<35.560000,0.038000,44.450000><35.560000,-1.538000,44.450000>0.406400}
cylinder{<25.400000,0.038000,44.450000><25.400000,-1.538000,44.450000>0.406400}
cylinder{<44.450000,0.038000,48.260000><44.450000,-1.538000,48.260000>0.406400}
cylinder{<34.290000,0.038000,48.260000><34.290000,-1.538000,48.260000>0.406400}
cylinder{<40.640000,0.038000,38.100000><40.640000,-1.538000,38.100000>0.406400}
cylinder{<30.480000,0.038000,38.100000><30.480000,-1.538000,38.100000>0.406400}
cylinder{<35.560000,0.038000,21.590000><35.560000,-1.538000,21.590000>0.406400}
cylinder{<25.400000,0.038000,21.590000><25.400000,-1.538000,21.590000>0.406400}
cylinder{<152.400000,0.038000,5.080000><152.400000,-1.538000,5.080000>0.457200}
cylinder{<152.400000,0.038000,7.620000><152.400000,-1.538000,7.620000>0.457200}
cylinder{<152.400000,0.038000,10.160000><152.400000,-1.538000,10.160000>0.457200}
cylinder{<152.400000,0.038000,12.700000><152.400000,-1.538000,12.700000>0.457200}
cylinder{<152.400000,0.038000,15.240000><152.400000,-1.538000,15.240000>0.457200}
cylinder{<152.400000,0.038000,17.780000><152.400000,-1.538000,17.780000>0.457200}
cylinder{<152.400000,0.038000,20.320000><152.400000,-1.538000,20.320000>0.457200}
cylinder{<152.400000,0.038000,22.860000><152.400000,-1.538000,22.860000>0.457200}
cylinder{<152.400000,0.038000,25.400000><152.400000,-1.538000,25.400000>0.457200}
cylinder{<152.400000,0.038000,27.940000><152.400000,-1.538000,27.940000>0.457200}
cylinder{<152.400000,0.038000,30.480000><152.400000,-1.538000,30.480000>0.457200}
cylinder{<152.400000,0.038000,33.020000><152.400000,-1.538000,33.020000>0.457200}
cylinder{<152.400000,0.038000,35.560000><152.400000,-1.538000,35.560000>0.457200}
cylinder{<152.400000,0.038000,38.100000><152.400000,-1.538000,38.100000>0.457200}
cylinder{<152.400000,0.038000,40.640000><152.400000,-1.538000,40.640000>0.457200}
cylinder{<152.400000,0.038000,43.180000><152.400000,-1.538000,43.180000>0.457200}
cylinder{<151.130000,0.038000,92.710000><151.130000,-1.538000,92.710000>0.457200}
cylinder{<151.130000,0.038000,90.170000><151.130000,-1.538000,90.170000>0.457200}
cylinder{<151.130000,0.038000,87.630000><151.130000,-1.538000,87.630000>0.457200}
cylinder{<151.130000,0.038000,85.090000><151.130000,-1.538000,85.090000>0.457200}
cylinder{<151.130000,0.038000,82.550000><151.130000,-1.538000,82.550000>0.457200}
cylinder{<151.130000,0.038000,80.010000><151.130000,-1.538000,80.010000>0.457200}
cylinder{<151.130000,0.038000,77.470000><151.130000,-1.538000,77.470000>0.457200}
cylinder{<151.130000,0.038000,74.930000><151.130000,-1.538000,74.930000>0.457200}
cylinder{<7.620000,0.038000,16.510000><7.620000,-1.538000,16.510000>0.457200}
cylinder{<10.160000,0.038000,16.510000><10.160000,-1.538000,16.510000>0.457200}
cylinder{<12.700000,0.038000,16.510000><12.700000,-1.538000,16.510000>0.457200}
cylinder{<15.240000,0.038000,16.510000><15.240000,-1.538000,16.510000>0.457200}
cylinder{<17.780000,0.038000,16.510000><17.780000,-1.538000,16.510000>0.457200}
cylinder{<20.320000,0.038000,16.510000><20.320000,-1.538000,16.510000>0.457200}
cylinder{<22.860000,0.038000,16.510000><22.860000,-1.538000,16.510000>0.457200}
cylinder{<25.400000,0.038000,16.510000><25.400000,-1.538000,16.510000>0.457200}
cylinder{<34.290000,0.038000,85.090000><34.290000,-1.538000,85.090000>0.500000}
cylinder{<34.290000,0.038000,82.550000><34.290000,-1.538000,82.550000>0.500000}
cylinder{<31.750000,0.038000,85.090000><31.750000,-1.538000,85.090000>0.500000}
cylinder{<31.750000,0.038000,82.550000><31.750000,-1.538000,82.550000>0.500000}
cylinder{<29.210000,0.038000,85.090000><29.210000,-1.538000,85.090000>0.500000}
cylinder{<29.210000,0.038000,82.550000><29.210000,-1.538000,82.550000>0.500000}
cylinder{<26.670000,0.038000,85.090000><26.670000,-1.538000,85.090000>0.500000}
cylinder{<26.670000,0.038000,82.550000><26.670000,-1.538000,82.550000>0.500000}
cylinder{<24.130000,0.038000,85.090000><24.130000,-1.538000,85.090000>0.500000}
cylinder{<24.130000,0.038000,82.550000><24.130000,-1.538000,82.550000>0.500000}
//Bohrungen(schnell)/Durchkontaktierungen
cylinder{<15.240000,0.038000,20.320000><15.240000,-1.538000,20.320000>0.350000 }
cylinder{<33.020000,0.038000,20.320000><33.020000,-1.538000,20.320000>0.350000 }
cylinder{<45.720000,0.038000,78.740000><45.720000,-1.538000,78.740000>0.350000 }
cylinder{<35.560000,0.038000,78.740000><35.560000,-1.538000,78.740000>0.350000 }
cylinder{<38.100000,0.038000,55.880000><38.100000,-1.538000,55.880000>0.350000 }
cylinder{<27.305000,0.038000,55.880000><27.305000,-1.538000,55.880000>0.350000 }
cylinder{<20.955000,0.038000,52.070000><20.955000,-1.538000,52.070000>0.350000 }
cylinder{<45.720000,0.038000,52.070000><45.720000,-1.538000,52.070000>0.350000 }
cylinder{<18.415000,0.038000,71.120000><18.415000,-1.538000,71.120000>0.350000 }
cylinder{<33.020000,0.038000,71.120000><33.020000,-1.538000,71.120000>0.350000 }
cylinder{<21.590000,0.038000,89.535000><21.590000,-1.538000,89.535000>0.350000 }
cylinder{<29.210000,0.038000,89.535000><29.210000,-1.538000,89.535000>0.350000 }
cylinder{<15.875000,0.038000,73.025000><15.875000,-1.538000,73.025000>0.350000 }
cylinder{<48.260000,0.038000,73.025000><48.260000,-1.538000,73.025000>0.350000 }
cylinder{<54.610000,0.038000,40.640000><54.610000,-1.538000,40.640000>0.350000 }
cylinder{<35.560000,0.038000,40.640000><35.560000,-1.538000,40.640000>0.350000 }
cylinder{<68.580000,0.038000,41.910000><68.580000,-1.538000,41.910000>0.350000 }
cylinder{<41.275000,0.038000,41.910000><41.275000,-1.538000,41.910000>0.350000 }
cylinder{<54.610000,0.038000,35.560000><54.610000,-1.538000,35.560000>0.350000 }
cylinder{<40.640000,0.038000,35.560000><40.640000,-1.538000,35.560000>0.350000 }
cylinder{<19.685000,0.038000,77.470000><19.685000,-1.538000,77.470000>0.350000 }
cylinder{<53.975000,0.038000,77.470000><53.975000,-1.538000,77.470000>0.350000 }
cylinder{<14.605000,0.038000,54.610000><14.605000,-1.538000,54.610000>0.350000 }
cylinder{<53.340000,0.038000,54.610000><53.340000,-1.538000,54.610000>0.350000 }
cylinder{<120.650000,0.038000,41.910000><120.650000,-1.538000,41.910000>0.350000 }
cylinder{<120.650000,0.038000,54.610000><120.650000,-1.538000,54.610000>0.350000 }
cylinder{<102.870000,0.038000,59.690000><102.870000,-1.538000,59.690000>0.350000 }
cylinder{<85.090000,0.038000,59.690000><85.090000,-1.538000,59.690000>0.350000 }
cylinder{<124.460000,0.038000,29.210000><124.460000,-1.538000,29.210000>0.350000 }
cylinder{<124.460000,0.038000,41.910000><124.460000,-1.538000,41.910000>0.350000 }
cylinder{<127.000000,0.038000,23.495000><127.000000,-1.538000,23.495000>0.350000 }
cylinder{<127.000000,0.038000,47.625000><127.000000,-1.538000,47.625000>0.350000 }
cylinder{<124.460000,0.038000,76.200000><124.460000,-1.538000,76.200000>0.350000 }
cylinder{<124.460000,0.038000,48.895000><124.460000,-1.538000,48.895000>0.350000 }
cylinder{<121.920000,0.038000,23.495000><121.920000,-1.538000,23.495000>0.350000 }
cylinder{<121.920000,0.038000,6.350000><121.920000,-1.538000,6.350000>0.350000 }
cylinder{<80.010000,0.038000,44.450000><80.010000,-1.538000,44.450000>0.350000 }
cylinder{<67.310000,0.038000,44.450000><67.310000,-1.538000,44.450000>0.350000 }
cylinder{<74.930000,0.038000,75.565000><74.930000,-1.538000,75.565000>0.350000 }
cylinder{<81.915000,0.038000,75.565000><81.915000,-1.538000,75.565000>0.350000 }
cylinder{<48.260000,0.038000,13.970000><48.260000,-1.538000,13.970000>0.350000 }
cylinder{<48.260000,0.038000,22.225000><48.260000,-1.538000,22.225000>0.350000 }
cylinder{<140.335000,0.038000,22.860000><140.335000,-1.538000,22.860000>0.350000 }
cylinder{<140.335000,0.038000,43.815000><140.335000,-1.538000,43.815000>0.350000 }
cylinder{<8.890000,0.038000,69.850000><8.890000,-1.538000,69.850000>0.350000 }
cylinder{<29.845000,0.038000,69.850000><29.845000,-1.538000,69.850000>0.350000 }
cylinder{<139.700000,0.038000,48.895000><139.700000,-1.538000,48.895000>0.350000 }
cylinder{<139.700000,0.038000,76.200000><139.700000,-1.538000,76.200000>0.350000 }
cylinder{<81.280000,0.038000,31.115000><81.280000,-1.538000,31.115000>0.350000 }
cylinder{<24.765000,0.038000,23.495000><24.765000,-1.538000,23.495000>0.350000 }
cylinder{<47.625000,0.038000,55.880000><47.625000,-1.538000,55.880000>0.350000 }
cylinder{<41.275000,0.038000,55.880000><41.275000,-1.538000,55.880000>0.350000 }
//Bohrungen(schnell)/Platine
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Bestückungsdruck
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,46.990000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.205200,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,46.355000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.205200,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.205200,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,46.990000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<141.986000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,46.990000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.840200,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,46.355000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.840200,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.840200,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,46.990000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<143.840200,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,45.974000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.827000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.081000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,45.720000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.081000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.193000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.193000,0.000000,48.006000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.193000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.081000,0.000000,48.260000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.081000,0.000000,48.260000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<146.939000,0.000000,48.006000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<146.939000,0.000000,45.974000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<140.081000,0.000000,45.974000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<140.081000,0.000000,48.006000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.715000,0.000000,63.804800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,63.804800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<5.080000,0.000000,63.804800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,63.804800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.445000,0.000000,63.804800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<4.445000,0.000000,63.804800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,63.804800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,65.024000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.715000,0.000000,63.169800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,63.169800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<5.080000,0.000000,63.169800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<5.080000,0.000000,63.169800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<4.445000,0.000000,63.169800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<4.445000,0.000000,63.169800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,63.169800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,61.976000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,67.183000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,67.183000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.064000,0.000000,67.183000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,60.071000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,0.000000,59.817000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,59.817000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.064000,0.000000,59.817000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,66.929000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,66.929000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<6.096000,0.000000,60.071000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<4.064000,0.000000,60.071000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<4.064000,0.000000,66.929000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<6.096000,0.000000,66.929000>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<28.575000,0.000000,29.514800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<27.940000,0.000000,29.514800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<27.940000,0.000000,29.514800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<27.940000,0.000000,29.514800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<27.305000,0.000000,29.514800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<27.305000,0.000000,29.514800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,29.514800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,30.734000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<27.940000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<28.575000,0.000000,28.879800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<27.940000,0.000000,28.879800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<27.940000,0.000000,28.879800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<27.940000,0.000000,28.879800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<27.305000,0.000000,28.879800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<27.305000,0.000000,28.879800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,28.879800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,27.686000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.940000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.956000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.924000,0.000000,32.893000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.924000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,32.639000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,25.781000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.670000,0.000000,25.781000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.924000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.956000,0.000000,25.527000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.924000,0.000000,25.527000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,32.639000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<29.210000,0.000000,32.639000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<28.956000,0.000000,25.781000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<26.924000,0.000000,25.781000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<26.924000,0.000000,32.639000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<28.956000,0.000000,32.639000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<78.409800,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<78.409800,0.000000,28.575000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<78.409800,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<78.409800,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<78.409800,0.000000,29.210000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<78.409800,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.409800,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,28.575000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<78.409800,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<77.774800,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<77.774800,0.000000,28.575000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<77.774800,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<77.774800,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<77.774800,0.000000,29.210000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<77.774800,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.774800,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.581000,0.000000,28.575000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<76.581000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.788000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.788000,0.000000,29.591000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<81.788000,0.000000,29.591000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,29.845000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.676000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,27.559000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.422000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,27.305000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.676000,0.000000,27.305000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<74.676000,0.000000,27.559000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<74.676000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<81.534000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<81.534000,0.000000,27.559000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.295200,0.000000,97.155000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.295200,0.000000,96.520000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<101.295200,0.000000,96.520000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.295200,0.000000,96.520000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.295200,0.000000,95.885000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<101.295200,0.000000,95.885000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.295200,0.000000,96.520000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.076000,0.000000,96.520000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<100.076000,0.000000,96.520000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.930200,0.000000,97.155000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.930200,0.000000,96.520000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<101.930200,0.000000,96.520000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.930200,0.000000,96.520000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<101.930200,0.000000,95.885000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<101.930200,0.000000,95.885000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.930200,0.000000,96.520000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<103.124000,0.000000,96.520000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<101.930200,0.000000,96.520000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.917000,0.000000,97.536000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.917000,0.000000,95.504000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<97.917000,0.000000,95.504000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.171000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.029000,0.000000,95.250000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<98.171000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.283000,0.000000,95.504000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.283000,0.000000,97.536000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.283000,0.000000,97.536000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.029000,0.000000,97.790000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.171000,0.000000,97.790000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<98.171000,0.000000,97.790000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<105.029000,0.000000,97.536000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<105.029000,0.000000,95.504000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<98.171000,0.000000,95.504000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<98.171000,0.000000,97.536000>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.804800,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.804800,0.000000,91.440000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<63.804800,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.804800,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.804800,0.000000,92.075000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<63.804800,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.804800,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.024000,0.000000,91.440000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<63.804800,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.169800,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.169800,0.000000,91.440000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<63.169800,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.169800,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<63.169800,0.000000,92.075000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<63.169800,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.169800,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.976000,0.000000,91.440000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<61.976000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.183000,0.000000,90.424000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.183000,0.000000,92.456000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.183000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,92.710000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,92.710000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.071000,0.000000,92.710000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.817000,0.000000,92.456000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.817000,0.000000,90.424000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.817000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,90.170000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.071000,0.000000,90.170000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<60.071000,0.000000,90.424000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<60.071000,0.000000,92.456000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<66.929000,0.000000,92.456000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<66.929000,0.000000,90.424000>}
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.671000,0.000000,10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,10.033000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.671000,0.000000,10.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,10.414000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.052000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.449000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.338000,0.000000,8.890000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.449000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.338000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.338000,0.000000,7.620000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.338000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.338000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,7.620000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.338000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,10.160000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.846000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.338000,0.000000,10.160000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.338000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.338000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.338000,0.000000,8.890000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.338000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.751000,0.000000,8.890000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,8.890000> }
difference{
cylinder{<38.100000,0,8.890000><38.100000,0.036000,8.890000>4.140200 translate<0,0.000000,0>}
cylinder{<38.100000,-0.1,8.890000><38.100000,0.135000,8.890000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<38.608000,0.000000,8.890000>}
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.441000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.441000,0.000000,58.420000>}
box{<0,0,-0.076200><50.800000,0.036000,0.076200> rotate<0,90.000000,0> translate<99.441000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.979000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.979000,0.000000,7.620000>}
box{<0,0,-0.076200><50.800000,0.036000,0.076200> rotate<0,-90.000000,0> translate<85.979000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.441000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.979000,0.000000,7.620000>}
box{<0,0,-0.076200><13.462000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.979000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.441000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.599000,0.000000,58.420000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.599000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.979000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.567000,0.000000,58.420000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.979000,0.000000,58.420000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<92.583000,0.000000,58.420000>}
//IC3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,24.130000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,90.000000,0> translate<136.271000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,3.810000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.429000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,3.810000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.366000,0.000000,24.130000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.366000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.334000,0.000000,24.130000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,24.130000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<133.350000,0.000000,24.130000>}
//IC4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,48.260000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,90.000000,0> translate<136.271000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,27.940000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.429000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,27.940000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.366000,0.000000,48.260000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.366000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.334000,0.000000,48.260000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,48.260000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<133.350000,0.000000,48.260000>}
//IC5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,77.470000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,90.000000,0> translate<136.271000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,57.150000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,-90.000000,0> translate<130.429000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,57.150000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.271000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<134.366000,0.000000,77.470000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<134.366000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<130.429000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<132.334000,0.000000,77.470000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<130.429000,0.000000,77.470000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<133.350000,0.000000,77.470000>}
//IC6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,32.131000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,26.289000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,26.289000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,26.289000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,26.289000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.530000,0.000000,26.289000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,30.226000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.750000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,26.289000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,28.194000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.750000,0.000000,28.194000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<31.750000,0.000000,29.210000>}
//IC7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,95.250000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<95.631000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.789000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.789000,0.000000,69.850000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<89.789000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.789000,0.000000,69.850000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<89.789000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.726000,0.000000,95.250000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.726000,0.000000,95.250000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.789000,0.000000,95.250000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<91.694000,0.000000,95.250000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<89.789000,0.000000,95.250000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<92.710000,0.000000,95.250000>}
//IC11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,66.421000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,66.421000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,60.579000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.750000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,60.579000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.530000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,64.516000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.750000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,62.484000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.750000,0.000000,62.484000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<31.750000,0.000000,63.500000>}
//IC19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,66.421000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,66.421000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,60.579000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,60.579000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.670000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,64.516000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.890000,0.000000,64.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,62.484000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,62.484000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<8.890000,0.000000,63.500000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.435000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.435000,0.000000,88.265000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<51.435000,0.000000,88.265000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<48.895000,0.000000,86.360000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<48.895000,0.000000,86.360000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<48.895000,0.000000,86.360000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<48.895000,0.000000,86.360000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<48.895000,0.000000,86.360000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<48.895000,0.000000,86.360000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<48.895000,0.000000,86.360000>}
difference{
cylinder{<48.895000,0,86.360000><48.895000,0.036000,86.360000>2.616200 translate<0,0.000000,0>}
cylinder{<48.895000,-0.1,86.360000><48.895000,0.135000,86.360000>2.463800 translate<0,0.000000,0>}}
//QG1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<55.880000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<55.880000,0.000000,69.850000>}
box{<0,0,-0.127000><19.050000,0.036000,0.127000> rotate<0,-90.000000,0> translate<55.880000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<57.150000,0.000000,68.580000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<67.310000,0.000000,68.580000>}
box{<0,0,-0.127000><10.160000,0.036000,0.127000> rotate<0,0.000000,0> translate<57.150000,0.000000,68.580000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<68.580000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<68.580000,0.000000,87.630000>}
box{<0,0,-0.127000><17.780000,0.036000,0.127000> rotate<0,90.000000,0> translate<68.580000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<55.880000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<67.310000,0.000000,88.900000>}
box{<0,0,-0.127000><11.430000,0.036000,0.127000> rotate<0,0.000000,0> translate<55.880000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,69.850000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.515000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,69.215000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,87.630000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,88.265000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,88.265000> }
object{ARC(1.270000,0.254000,180.000000,270.000000,0.036000) translate<57.150000,0.000000,69.850000>}
object{ARC(0.635000,0.152400,180.000000,270.000000,0.036000) translate<57.150000,0.000000,69.850000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<67.310000,0.000000,69.850000>}
object{ARC(1.270000,0.254000,270.000000,360.000000,0.036000) translate<67.310000,0.000000,69.850000>}
object{ARC(0.635000,0.152400,0.000000,90.000000,0.036000) translate<67.310000,0.000000,87.630000>}
object{ARC(1.270000,0.254000,0.000000,90.000000,0.036000) translate<67.310000,0.000000,87.630000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<57.150000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<67.310000,0.000000,79.070200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.770000,0.000000,79.070200>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,0.000000,0> translate<64.770000,0.000000,79.070200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.770000,0.000000,79.070200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.770000,0.000000,78.435200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<64.770000,0.000000,78.435200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.770000,0.000000,78.435200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<67.310000,0.000000,78.435200>}
box{<0,0,-0.152400><2.540000,0.036000,0.152400> rotate<0,0.000000,0> translate<64.770000,0.000000,78.435200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<67.310000,0.000000,78.435200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<67.310000,0.000000,79.070200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<67.310000,0.000000,79.070200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<67.310000,0.000000,77.800200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<66.040000,0.000000,77.800200>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<66.040000,0.000000,77.800200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<67.310000,0.000000,79.679800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<66.040000,0.000000,79.679800>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<66.040000,0.000000,79.679800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,77.800200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,76.200000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.040000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<66.040000,0.000000,77.800200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.770000,0.000000,77.800200>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<64.770000,0.000000,77.800200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,79.679800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,81.280000>}
box{<0,0,-0.076200><1.600200,0.036000,0.076200> rotate<0,90.000000,0> translate<66.040000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<66.040000,0.000000,79.679800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<64.770000,0.000000,79.679800>}
box{<0,0,-0.152400><1.270000,0.036000,0.152400> rotate<0,0.000000,0> translate<64.770000,0.000000,79.679800> }
difference{
cylinder{<57.531000,0,87.249000><57.531000,0.036000,87.249000>0.787400 translate<0,0.000000,0>}
cylinder{<57.531000,-0.1,87.249000><57.531000,0.135000,87.249000>0.482600 translate<0,0.000000,0>}}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<81.280000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<81.280000,0.000000,17.526000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<81.280000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<81.280000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<81.280000,0.000000,25.654000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<81.280000,0.000000,25.654000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<82.169000,0.000000,24.511000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<80.391000,0.000000,24.511000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<80.391000,0.000000,18.669000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<82.169000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.391000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.169000,0.000000,24.765000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.391000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.423000,0.000000,24.511000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.423000,0.000000,24.130000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.423000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.423000,0.000000,24.130000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<82.296000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,24.511000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,24.130000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<80.137000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,24.130000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<80.137000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.423000,0.000000,19.050000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<82.296000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.296000,0.000000,24.003000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.296000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,19.050000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<80.137000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.264000,0.000000,24.003000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.264000,0.000000,24.003000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.423000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.423000,0.000000,19.050000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.423000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.137000,0.000000,19.050000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.137000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.391000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.169000,0.000000,18.415000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.391000,0.000000,18.415000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<81.280000,0.000000,17.983200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<81.280000,0.000000,25.196800>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.145000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<18.161000,0.000000,36.830000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<17.145000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<27.305000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.289000,0.000000,36.830000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<26.289000,0.000000,36.830000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<25.146000,0.000000,35.941000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<25.146000,0.000000,37.719000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<19.304000,0.000000,37.719000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<19.304000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,37.719000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,35.941000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.400000,0.000000,35.941000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,35.687000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,35.687000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.638000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,37.973000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,37.973000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,37.973000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,37.973000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.638000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,35.687000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.685000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,35.814000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.812000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,37.973000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<19.685000,0.000000,37.973000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,37.846000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.812000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,35.687000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,37.973000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,37.973000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,37.973000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,37.719000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,35.941000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.050000,0.000000,35.941000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<18.618200,0.000000,36.830000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<25.831800,0.000000,36.830000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.145000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<18.161000,0.000000,40.640000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<17.145000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<27.305000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.289000,0.000000,40.640000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<26.289000,0.000000,40.640000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<25.146000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<25.146000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<19.304000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<19.304000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.400000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.638000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.638000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.685000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,39.624000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.812000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<19.685000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.812000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.050000,0.000000,39.751000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<18.618200,0.000000,40.640000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<25.831800,0.000000,40.640000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.815000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.815000,0.000000,87.376000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<43.815000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.815000,0.000000,96.520000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.815000,0.000000,95.504000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<43.815000,0.000000,95.504000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<44.704000,0.000000,94.361000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<42.926000,0.000000,94.361000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<42.926000,0.000000,88.519000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<44.704000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,94.615000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,94.615000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,94.615000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,94.361000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,93.980000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.958000,0.000000,93.980000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.831000,0.000000,93.853000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,93.980000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.831000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,94.361000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,93.980000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.672000,0.000000,93.980000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,93.853000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,93.980000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<42.672000,0.000000,93.980000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.831000,0.000000,89.027000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,88.900000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<44.831000,0.000000,89.027000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.831000,0.000000,89.027000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.831000,0.000000,93.853000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.831000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,89.027000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,88.900000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.672000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,89.027000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,93.853000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.799000,0.000000,93.853000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,88.900000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.958000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,88.900000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.672000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,88.265000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,88.265000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<43.815000,0.000000,87.833200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<43.815000,0.000000,95.046800>}
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.416000,0.000000,44.450000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<25.400000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.560000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<34.544000,0.000000,44.450000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<34.544000,0.000000,44.450000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<33.401000,0.000000,43.561000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<33.401000,0.000000,45.339000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<27.559000,0.000000,45.339000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<27.559000,0.000000,43.561000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,45.339000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,43.561000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.655000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.401000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,43.307000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.020000,0.000000,43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,43.307000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<32.893000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.401000,0.000000,45.593000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,45.593000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.020000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,45.593000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.893000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,43.307000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.940000,0.000000,43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,43.434000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.067000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,45.593000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<27.940000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,45.466000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.067000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.559000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,43.307000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.559000,0.000000,43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.559000,0.000000,45.593000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,45.593000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.559000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,45.339000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,43.561000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.305000,0.000000,43.561000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<26.873200,0.000000,44.450000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<34.086800,0.000000,44.450000>}
//R12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<34.290000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.306000,0.000000,48.260000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<34.290000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<44.450000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.434000,0.000000,48.260000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<43.434000,0.000000,48.260000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<42.291000,0.000000,47.371000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<42.291000,0.000000,49.149000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<36.449000,0.000000,49.149000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<36.449000,0.000000,47.371000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,49.149000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,47.371000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.545000,0.000000,47.371000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.291000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,47.117000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.910000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,47.117000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<41.783000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.291000,0.000000,49.403000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,49.403000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.910000,0.000000,49.403000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,49.403000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.783000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,47.117000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.830000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,47.244000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,49.403000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<36.830000,0.000000,49.403000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,49.276000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.449000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,47.117000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.449000,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.449000,0.000000,49.403000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,49.403000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.449000,0.000000,49.403000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,49.149000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,47.371000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.195000,0.000000,47.371000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<35.763200,0.000000,48.260000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<42.976800,0.000000,48.260000>}
//R13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<30.480000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<31.496000,0.000000,38.100000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<30.480000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<40.640000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.624000,0.000000,38.100000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<39.624000,0.000000,38.100000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<38.481000,0.000000,37.211000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<38.481000,0.000000,38.989000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<32.639000,0.000000,38.989000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<32.639000,0.000000,37.211000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,37.211000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.735000,0.000000,37.211000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,36.957000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,36.957000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,36.957000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<37.973000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,39.243000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,39.243000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,39.243000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,39.243000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<37.973000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.147000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,36.957000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.020000,0.000000,36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.147000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,37.084000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.147000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.147000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,39.243000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<33.020000,0.000000,39.243000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.147000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,39.116000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.147000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.639000,0.000000,36.957000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,36.957000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.639000,0.000000,36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.639000,0.000000,39.243000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,39.243000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.639000,0.000000,39.243000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,37.211000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.385000,0.000000,37.211000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<31.953200,0.000000,38.100000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<39.166800,0.000000,38.100000>}
//R14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.416000,0.000000,21.590000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<25.400000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.560000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<34.544000,0.000000,21.590000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<34.544000,0.000000,21.590000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<33.401000,0.000000,20.701000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<33.401000,0.000000,22.479000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<27.559000,0.000000,22.479000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<27.559000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,20.701000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.655000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.401000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,20.447000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.020000,0.000000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,20.447000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<32.893000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.401000,0.000000,22.733000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,22.733000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.020000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,22.733000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.893000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,20.447000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.940000,0.000000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,20.574000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.067000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,22.733000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<27.940000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.067000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,22.606000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.067000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.559000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,20.447000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.559000,0.000000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.559000,0.000000,22.733000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,22.733000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.559000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,20.701000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.305000,0.000000,20.701000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<26.873200,0.000000,21.590000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<34.086800,0.000000,21.590000>}
//SL1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,6.096000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<150.622000,0.000000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,6.350000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<150.749000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,6.604000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<150.749000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,6.731000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<150.622000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,6.096000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,4.064000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,6.096000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,6.604000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,4.064000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,4.064000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,4.064000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.178000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,4.445000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<154.178000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,5.715000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,4.445000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,5.715000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,5.715000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.985000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,6.985000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.096000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.604000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.985000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,4.064000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.924000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,4.445000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,4.064000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,4.826000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,4.826000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,5.334000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,4.826000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,7.366000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,7.874000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,6.604000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,6.096000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,8.636000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,9.144000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,9.144000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,11.176000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,8.255000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,8.255000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,8.636000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,9.144000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,9.525000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,11.176000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,11.176000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,10.414000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,9.906000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,9.144000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,9.906000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,8.636000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.987000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,8.636000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,8.636000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,7.366000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,7.366000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,6.604000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,5.334000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,4.064000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.622000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,8.636000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,9.144000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.604000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,6.096000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,8.636000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,9.144000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,8.255000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,5.715000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,8.636000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<154.686000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<154.178000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,8.636000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,11.684000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,11.684000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,13.335000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,13.716000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,14.605000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,11.684000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.924000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,12.446000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,42.164000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<150.749000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,42.291000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<150.622000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,42.164000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,44.196000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,44.196000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.178000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,43.815000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,44.196000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,41.656000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,42.164000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,42.545000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,44.196000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,44.196000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,42.926000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,44.196000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,43.434000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,42.926000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,42.926000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.987000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,41.656000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<150.622000,0.000000,41.529000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.003000,0.000000,41.910000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<150.749000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,14.986000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,12.954000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,13.716000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,14.224000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,13.716000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,41.656000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,42.164000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,13.335000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,42.545000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<154.178000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,11.176000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.924000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.622000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.987000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,15.875000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,16.256000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,16.764000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,17.145000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,17.526000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,17.526000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,16.764000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,15.494000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,16.256000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,16.764000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,16.256000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,15.875000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,16.764000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,16.764000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,18.415000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,18.796000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,19.304000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,19.685000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,20.066000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,20.066000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,19.304000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,18.034000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,18.796000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,19.304000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,18.796000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,18.415000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,19.304000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,19.304000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,21.336000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,21.336000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,22.225000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,22.606000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,22.606000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,20.574000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,21.336000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,21.844000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,21.336000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,21.844000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,21.844000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,23.495000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,23.876000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,24.765000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,25.146000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,25.654000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,25.146000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,25.146000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,23.114000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,23.876000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,24.384000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,23.876000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,23.495000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,24.384000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,24.384000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,26.416000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,26.035000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.416000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,27.305000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,27.686000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,28.194000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,26.924000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,26.416000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,27.686000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,27.686000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,25.654000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,26.416000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.924000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,26.416000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,26.924000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,28.956000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,26.924000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,28.956000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,29.464000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,28.575000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,28.575000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,28.956000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,29.464000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,29.845000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,30.226000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,30.734000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,29.464000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,28.956000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,30.226000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,30.226000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,29.464000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,28.194000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,28.956000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,29.464000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,28.956000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,28.575000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,29.464000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,31.496000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,29.464000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,31.496000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,32.004000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,31.115000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,31.115000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,32.385000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,32.385000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,31.496000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,32.004000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,32.385000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,32.766000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,33.274000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,32.004000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,31.496000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,32.766000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,32.766000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,32.004000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,30.734000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,31.496000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,32.004000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,31.496000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,31.115000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,32.004000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,34.036000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,32.004000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,34.036000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,34.544000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,33.655000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,33.655000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,33.655000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.036000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.544000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.925000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,35.306000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,35.814000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,34.544000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,34.036000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,35.306000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,35.306000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,34.544000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,33.274000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,34.036000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.544000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,34.036000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,33.655000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,34.544000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,36.576000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,34.544000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,36.576000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,37.084000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,36.195000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,36.195000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,36.195000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,36.576000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,37.084000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,37.465000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,37.846000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,38.354000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,37.084000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,36.576000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,37.846000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,37.846000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,37.084000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,35.814000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,36.576000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,37.084000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,36.576000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,36.195000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,37.084000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,39.116000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,37.084000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,39.116000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.559000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.559000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,39.624000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.559000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,38.735000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.924000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,39.116000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,40.005000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.924000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,40.386000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,40.894000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.733000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,39.624000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,39.116000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.860000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.733000,0.000000,40.386000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.733000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,40.386000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.987000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.987000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,38.354000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,39.116000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,39.624000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.924000,0.000000,39.116000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.622000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.178000,0.000000,38.735000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.178000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,41.656000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.860000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.622000,0.000000,41.529000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.622000,0.000000,41.529000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.686000,0.000000,39.624000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.686000,0.000000,39.624000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,5.080000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,7.620000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,10.160000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,12.700000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,15.240000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,20.320000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,17.780000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,43.180000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,22.860000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,25.400000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,27.940000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,30.480000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,33.020000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,35.560000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,38.100000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<152.400000,0.000000,40.640000>}
//SL2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,91.694000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<152.781000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.527000,0.000000,91.440000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<152.527000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.527000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,91.186000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<152.527000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,91.059000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<152.781000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.694000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,93.726000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.844000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,91.694000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.186000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,93.726000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<152.908000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,93.726000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,93.726000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,93.345000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.352000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,92.075000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,93.345000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,92.075000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,92.075000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,90.805000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,90.805000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,92.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.694000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.186000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,90.805000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,93.726000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.606000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,93.345000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,93.345000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,93.345000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,93.726000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,93.726000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,92.964000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,92.964000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,92.964000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,92.456000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,92.456000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,92.456000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,92.964000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,92.964000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,90.424000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,90.424000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,89.916000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,91.186000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,91.694000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,89.154000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,88.646000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,88.646000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.844000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.614000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,86.995000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,89.535000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,89.535000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,88.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,88.265000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,89.154000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,88.265000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.614000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.995000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,86.995000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,87.884000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,87.884000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,86.614000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,87.376000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,87.376000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,87.376000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,87.884000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,88.646000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,87.884000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,87.884000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,89.154000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.543000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,89.154000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,89.154000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,90.424000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,90.424000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,90.424000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,91.186000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.543000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,92.456000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,92.456000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,93.726000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<152.908000,0.000000,93.726000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,91.059000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,89.154000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,88.646000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.186000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,91.186000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,91.694000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,91.694000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,89.154000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,88.646000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,89.535000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,89.535000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,92.075000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.352000,0.000000,92.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,91.186000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,89.154000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<148.844000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,88.265000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.352000,0.000000,88.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,89.154000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,84.074000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,86.106000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.844000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,84.074000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,83.566000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.106000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,84.455000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,84.455000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,83.185000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,83.185000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,84.074000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,83.566000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,83.185000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.106000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.606000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,85.725000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,85.725000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,85.344000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,85.344000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,84.836000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,84.836000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,85.344000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,85.344000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,82.804000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,82.804000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,82.296000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,82.296000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,83.566000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,84.074000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.527000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,75.946000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<152.527000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,75.819000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<152.781000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,76.454000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,75.946000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,75.946000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.844000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,75.819000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,73.914000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,73.914000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<152.908000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,73.914000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,74.295000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.352000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,73.914000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,74.295000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,74.295000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,76.835000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,76.835000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,75.565000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,75.565000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,76.454000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,75.946000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,75.565000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,73.914000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,74.295000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,74.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,73.914000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,73.914000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,75.184000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,75.184000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,73.914000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,73.914000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,74.676000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,74.676000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,74.676000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,75.184000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,75.946000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,75.184000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,75.184000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,76.454000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.543000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,76.454000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,76.454000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<152.781000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.527000,0.000000,76.200000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<152.527000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,82.296000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,82.804000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,82.804000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,82.804000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,83.566000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.543000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,84.836000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,84.836000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,84.074000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,83.566000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,84.074000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,84.074000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,76.454000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.781000,0.000000,75.946000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,75.946000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,75.946000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,84.455000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.352000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,75.565000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.352000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,76.454000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,86.614000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,84.074000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,83.566000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,85.725000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,86.995000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.352000,0.000000,86.995000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.606000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<152.908000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,86.614000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.543000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,86.614000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,86.106000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,86.106000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,86.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,81.534000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,83.566000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.844000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,81.534000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,81.026000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.915000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,83.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,81.915000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,81.915000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,80.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,80.645000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,80.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,80.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,80.645000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,80.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.915000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.534000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.026000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,80.645000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,80.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,80.264000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,80.264000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,80.264000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,79.756000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,79.756000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,79.756000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,81.026000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,81.534000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,79.756000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,80.264000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,80.264000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,80.264000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,80.264000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,81.026000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.543000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,82.296000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,81.534000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.026000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,81.534000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,81.534000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,80.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,81.915000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.352000,0.000000,81.915000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,81.534000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,81.026000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,78.994000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,81.026000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.844000,0.000000,81.026000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,78.486000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,78.994000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.971000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.971000,0.000000,78.486000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,78.486000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<148.844000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,79.375000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,79.375000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,79.375000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,80.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,79.375000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,79.375000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,79.375000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,79.375000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,79.375000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.105000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.352000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,78.105000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,79.375000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.994000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.486000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.486000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.105000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.606000,0.000000,78.105000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,77.724000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,77.724000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,77.724000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,77.216000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.670000,0.000000,77.216000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,78.486000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,78.486000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,78.994000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<153.543000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.797000,0.000000,77.724000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.797000,0.000000,77.724000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,78.486000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,77.724000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,77.724000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.543000,0.000000,78.486000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.543000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,79.756000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<153.670000,0.000000,79.756000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,81.026000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,78.994000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,78.486000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.486000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.606000,0.000000,78.994000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<149.606000,0.000000,78.994000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.352000,0.000000,79.375000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<149.352000,0.000000,79.375000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,78.994000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,78.486000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,78.486000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,77.216000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<153.670000,0.000000,76.454000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<153.670000,0.000000,76.454000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,78.486000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.908000,0.000000,76.581000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.908000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.860000,0.000000,76.835000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.860000,0.000000,76.835000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,76.454000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<148.844000,0.000000,78.486000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<148.844000,0.000000,78.486000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,92.710000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,90.170000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,87.630000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,85.090000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,82.550000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,77.470000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,80.010000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-270.000000,0> translate<151.130000,0.000000,74.930000>}
//SL3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,18.161000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<8.509000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,17.907000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<8.636000,0.000000,18.161000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,17.907000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.161000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.890000,0.000000,17.907000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,18.288000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.144000,0.000000,18.161000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,14.351000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.636000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,18.288000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,14.732000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.255000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.985000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.985000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.255000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.525000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.525000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.636000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.985000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,14.732000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.366000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.874000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.366000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.906000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.414000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<9.144000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.636000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,14.351000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.684000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.716000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.335000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.795000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.795000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.335000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.446000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.954000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.954000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.446000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.684000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.446000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,18.923000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.176000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.906000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.906000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.923000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.636000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.874000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,18.288000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.604000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,18.288000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.271000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,18.288000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.986000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.144000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,14.986000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.176000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.684000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.525000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,14.732000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.144000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.144000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,14.732000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.176000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.256000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,14.351000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.875000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.605000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.875000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.145000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.145000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.605000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.986000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.494000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.986000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.526000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.034000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.256000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,17.907000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,18.161000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.130000,0.000000,17.907000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,18.288000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.384000,0.000000,18.161000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,14.351000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.876000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.384000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.384000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,18.288000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.416000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.224000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,14.732000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.035000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.765000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.495000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.495000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.765000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.765000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.876000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.384000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.035000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,14.732000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.146000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.146000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.384000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.384000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,18.923000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.876000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.876000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,18.161000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<23.749000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,17.907000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<23.876000,0.000000,18.161000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,18.923000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.494000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.494000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,18.288000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.224000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.256000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,14.986000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.876000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,14.986000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.384000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,14.732000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,14.732000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.876000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,18.288000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.684000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.256000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,18.288000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.256000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.716000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,14.351000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,14.732000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,18.288000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,18.923000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.716000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,18.923000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.716000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.224000,0.000000,18.923000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.224000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.796000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,14.351000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.304000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.415000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.145000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.415000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.685000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.685000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.066000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.574000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.304000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.796000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.066000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,18.923000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.034000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,18.288000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.304000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.796000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,14.732000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,18.288000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.796000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.336000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,14.351000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.844000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.685000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,14.986000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.225000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,15.240000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.225000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.606000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,19.177000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.114000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.844000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,19.050000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.336000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,19.177000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.606000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,18.923000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,18.923000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,18.923000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.574000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.574000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.304000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,18.288000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.304000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.844000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.336000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,14.732000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,18.288000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,19.050000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.114000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.749000,0.000000,18.288000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.225000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,14.224000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,14.224000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<7.620000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<10.160000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<12.700000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<15.240000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<17.780000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<22.860000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<20.320000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-0.000000,0> translate<25.400000,0.000000,16.510000>}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.210000,0.000000,79.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.210000,0.000000,79.620000>}
box{<0,0,-0.101600><20.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<19.210000,0.000000,79.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.210000,0.000000,79.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.210000,0.000000,88.020000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,90.000000,0> translate<19.210000,0.000000,88.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.210000,0.000000,88.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.272000,0.000000,88.020000>}
box{<0,0,-0.101600><4.062000,0.036000,0.101600> rotate<0,0.000000,0> translate<19.210000,0.000000,88.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.272000,0.000000,88.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.272000,0.000000,87.720000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,-90.000000,0> translate<23.272000,0.000000,87.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.272000,0.000000,87.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.751000,0.000000,87.720000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,0.000000,0> translate<23.272000,0.000000,87.720000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.751000,0.000000,87.720000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.751000,0.000000,88.020000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,90.000000,0> translate<24.751000,0.000000,88.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<24.751000,0.000000,88.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.327000,0.000000,88.020000>}
box{<0,0,-0.101600><2.576000,0.036000,0.101600> rotate<0,0.000000,0> translate<24.751000,0.000000,88.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.327000,0.000000,88.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.327000,0.000000,86.470000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,-90.000000,0> translate<27.327000,0.000000,86.470000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.327000,0.000000,86.470000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.093000,0.000000,86.470000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.327000,0.000000,86.470000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.093000,0.000000,86.470000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.093000,0.000000,88.020000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,90.000000,0> translate<31.093000,0.000000,88.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.327000,0.000000,88.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.093000,0.000000,88.020000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,0.000000,0> translate<27.327000,0.000000,88.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.093000,0.000000,88.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.210000,0.000000,88.020000>}
box{<0,0,-0.101600><8.117000,0.036000,0.101600> rotate<0,0.000000,0> translate<31.093000,0.000000,88.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.210000,0.000000,88.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.210000,0.000000,79.620000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,-90.000000,0> translate<39.210000,0.000000,79.620000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.085000,0.000000,80.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.335000,0.000000,80.545000>}
box{<0,0,-0.101600><17.750000,0.036000,0.101600> rotate<0,0.000000,0> translate<20.335000,0.000000,80.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.335000,0.000000,80.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.335000,0.000000,87.095000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,90.000000,0> translate<20.335000,0.000000,87.095000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.335000,0.000000,87.095000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<27.327000,0.000000,87.095000>}
box{<0,0,-0.101600><6.992000,0.036000,0.101600> rotate<0,0.000000,0> translate<20.335000,0.000000,87.095000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.093000,0.000000,87.095000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.085000,0.000000,87.095000>}
box{<0,0,-0.101600><6.992000,0.036000,0.101600> rotate<0,0.000000,0> translate<31.093000,0.000000,87.095000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.085000,0.000000,87.095000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.085000,0.000000,80.545000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,-90.000000,0> translate<38.085000,0.000000,80.545000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  Z80_MAIN(-80.000000,0,-50.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
