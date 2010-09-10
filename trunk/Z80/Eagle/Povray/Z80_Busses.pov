//POVRay-Datei erstellt mit 3d41.ulp v1.05
//X:/Sven/Elektronik/Eagle/Z80/Z80_Busses.brd
//01.08.2010 08:39:56

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
#declare global_seed=seed(703);
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


#macro Z80_BUSSES(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
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
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<76.200000,0.000000,57.150000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C1 100n C050-030X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<98.425000,0.000000,57.150000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C2 100n C050-030X075
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<143.510000,0.000000,60.960000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C3 100n C050-030X075
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<97.155000,0.000000,10.160000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C4 100n C050-030X075
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_WIMA_5_030_072_075("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<122.555000,0.000000,12.065000>}#end		//WIMA-Kondensator Raster 5.08 (capacitator-wima.lib) C5 100n C050-030X075
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_ELKO_5MM_10MM_2("220µ",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<123.825000,0.000000,43.815000>}#end		//Elko C6 220µ E3,5-10
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP14("7430N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<99.060000,0.000000,69.850000>translate<0,3.000000,0> }#end		//DIP14 IC1 7430N DIL14
#ifndef(pack_IC1) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<99.060000,0.000000,69.850000>}#end					//IC-Sockel 14Pin IC1 7430N
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP14("7404N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<76.835000,0.000000,69.850000>translate<0,3.000000,0> }#end		//DIP14 IC2 7404N DIL14
#ifndef(pack_IC2) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<76.835000,0.000000,69.850000>}#end					//IC-Sockel 14Pin IC2 7404N
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_DIS_DIP16("74367N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<126.365000,0.000000,72.390000>translate<0,3.000000,0> }#end		//DIP16 IC3 74367N DIL16
#ifndef(pack_IC3) object{SOCKET_DIP16()rotate<0,-90.000000,0> rotate<0,0,0> translate<126.365000,0.000000,72.390000>}#end					//IC-Sockel 16Pin IC3 74367N
#ifndef(pack_IC4) #declare global_pack_IC4=yes; object {IC_DIS_DIP14("7432N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<123.825000,0.000000,27.305000>translate<0,3.000000,0> }#end		//DIP14 IC4 7432N DIL14
#ifndef(pack_IC4) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<123.825000,0.000000,27.305000>}#end					//IC-Sockel 14Pin IC4 7432N
#ifndef(pack_IC10) #declare global_pack_IC10=yes; object {IC_DIS_DIP20("74LS373N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<103.505000,0.000000,26.035000>translate<0,3.000000,0> }#end		//DIP20 IC10 74LS373N DIL20
#ifndef(pack_IC10) object{SOCKET_DIP20()rotate<0,-90.000000,0> rotate<0,0,0> translate<103.505000,0.000000,26.035000>}#end					//IC-Sockel 20Pin IC10 74LS373N
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Blue,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<46.355000,0.000000,75.565000>}#end		//Diskrete 5MM LED LED1 /MEMRD LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Blue,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<37.465000,0.000000,75.565000>}#end		//Diskrete 5MM LED LED2 /IORD LED5MM
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {DIODE_DIS_LED_5MM(Blue,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<28.575000,0.000000,75.565000>}#end		//Diskrete 5MM LED LED3 /MEMWR LED5MM
#ifndef(pack_LED4) #declare global_pack_LED4=yes; object {DIODE_DIS_LED_5MM(Blue,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<19.685000,0.000000,75.565000>}#end		//Diskrete 5MM LED LED4 /IOWR LED5MM
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,81.280000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R1 680 0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,84.455000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R2 680 0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,87.630000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R3 680 0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,90.805000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R4 680 0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,12.700000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R5 1K5 0204V
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,12.700000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R6 1K5 0204V
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,15.240000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R7 1K5 0204V
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,15.240000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R8 1K5 0204V
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,17.780000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R9 1K5 0204V
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,17.780000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R10 1K5 0204V
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,20.320000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R11 1K5 0204V
#ifndef(pack_R12) #declare global_pack_R12=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,20.320000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R12 1K5 0204V
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,25.400000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R13 1K5 0204V
#ifndef(pack_R14) #declare global_pack_R14=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,25.400000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R14 1K5 0204V
#ifndef(pack_R15) #declare global_pack_R15=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,27.940000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R15 1K5 0204V
#ifndef(pack_R16) #declare global_pack_R16=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,27.940000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R16 1K5 0204V
#ifndef(pack_R17) #declare global_pack_R17=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,30.480000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R17 1K5 0204V
#ifndef(pack_R18) #declare global_pack_R18=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,30.480000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R18 1K5 0204V
#ifndef(pack_R19) #declare global_pack_R19=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,33.020000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R19 1K5 0204V
#ifndef(pack_R20) #declare global_pack_R20=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,33.020000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R20 1K5 0204V
#ifndef(pack_R21) #declare global_pack_R21=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,35.560000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R21 1K5 0204V
#ifndef(pack_R22) #declare global_pack_R22=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,35.560000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R22 1K5 0204V
#ifndef(pack_R23) #declare global_pack_R23=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,38.100000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R23 1K5 0204V
#ifndef(pack_R24) #declare global_pack_R24=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,38.100000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R24 1K5 0204V
#ifndef(pack_R25) #declare global_pack_R25=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,40.640000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R25 1K5 0204V
#ifndef(pack_R26) #declare global_pack_R26=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,40.640000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R26 1K5 0204V
#ifndef(pack_R27) #declare global_pack_R27=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<14.605000,0.000000,43.180000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R27 1K5 0204V
#ifndef(pack_R28) #declare global_pack_R28=yes; object {RES_DIS_0204_025MMV(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.525000,0.000000,43.180000>}#end		//Diskreter Widerstand 0,15W stehend 100mil R28 1K5 0204V
#ifndef(pack_R30) #declare global_pack_R30=yes; object {RES_DIS_0207_10MM(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<61.595000,0.000000,69.215000>}#end		//Diskreter Widerstand 0,3W 10MM Raster R30 3K3 0207/10
#ifndef(pack_SL1) #declare global_pack_SL1=yes; object {PH_1X10()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<144.145000,0.000000,79.375000>}#end		//Stiftleiste 2,54mm Raster 10Pin 1Reihe (pinhead.lib) SL1 memory module 10P
#ifndef(pack_SL2) #declare global_pack_SL2=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<144.145000,0.000000,15.240000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL2 vga module 08P
#ifndef(pack_SL3) #declare global_pack_SL3=yes; object {PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<144.145000,0.000000,44.450000>}#end		//Stiftleiste 2,54mm Raster 8Pin 1Reihe (pinhead.lib) SL3 cpu module 08P
#ifndef(pack_SL4) #declare global_pack_SL4=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<14.605000,0.000000,60.325000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL4  03P
#ifndef(pack_SL5) #declare global_pack_SL5=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<24.130000,0.000000,60.325000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL5  03P
#ifndef(pack_SL6) #declare global_pack_SL6=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<33.655000,0.000000,60.325000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL6  03P
#ifndef(pack_SL7) #declare global_pack_SL7=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<43.180000,0.000000,60.325000>}#end		//Stiftleiste 2,54mm Raster 3Pin 1Reihe (pinhead.lib) SL7  03P
#ifndef(pack_X1) #declare global_pack_X1=yes; object {CON_DIS_WS26G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<38.100000,0.000000,27.940000>}#end		//Wannenstecker 26Pin X1 data + addr bus PAK100/2500-26
#ifndef(pack_X2) #declare global_pack_X2=yes; object {CON_DIS_WS26G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<50.165000,0.000000,27.940000>}#end		//Wannenstecker 26Pin X2 data + addr bus PAK100/2500-26
#ifndef(pack_X3) #declare global_pack_X3=yes; object {CON_DIS_WS26G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<62.230000,0.000000,27.940000>}#end		//Wannenstecker 26Pin X3 data + addr bus PAK100/2500-26
#ifndef(pack_X4) #declare global_pack_X4=yes; object {CON_DIS_WS26G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<74.295000,0.000000,27.940000>}#end		//Wannenstecker 26Pin X4 data + addr bus PAK100/2500-26
#ifndef(pack_X5) #declare global_pack_X5=yes; object {CON_DIS_WS26G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<26.035000,0.000000,27.940000>}#end		//Wannenstecker 26Pin X5 data + addr bus PAK100/2500-26
}//End union
#end
#if(pcb_pads_smds=on)
//Lötaugen&SMD/Bauteile
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<73.660000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<78.740000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<95.885000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<100.965000,0,57.150000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<140.970000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<146.050000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<99.695000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<94.615000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<122.555000,0,14.605000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<122.555000,0,9.525000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<122.047000,0,43.815000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<125.603000,0,43.815000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.905000,1.193800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<56.515000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.905000,1.193800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<56.515000,0,64.135000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<102.870000,0,62.230000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<102.870000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<102.870000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<102.870000,0,69.850000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<102.870000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<102.870000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<102.870000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,69.850000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<95.250000,0,62.230000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<80.645000,0,62.230000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<80.645000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<80.645000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<80.645000,0,69.850000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<80.645000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<80.645000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<80.645000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<73.025000,0,77.470000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<73.025000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<73.025000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<73.025000,0,69.850000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<73.025000,0,67.310000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<73.025000,0,64.770000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<73.025000,0,62.230000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<130.175000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,78.740000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,73.660000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,71.120000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,66.040000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<122.555000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.635000,0,19.685000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.635000,0,22.225000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.635000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.635000,0,27.305000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.635000,0,29.845000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.635000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<127.635000,0,34.925000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.015000,0,34.925000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.015000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.015000,0,29.845000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.015000,0,27.305000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.015000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.015000,0,22.225000> texture{col_thl}}
#ifndef(global_pack_IC4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.015000,0,19.685000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,14.605000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,17.145000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,19.685000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,22.225000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,27.305000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,29.845000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,34.925000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<107.315000,0,37.465000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,37.465000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,34.925000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,29.845000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,27.305000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,24.765000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,22.225000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,19.685000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,17.145000> texture{col_thl}}
#ifndef(global_pack_IC10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<99.695000,0,14.605000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<46.355000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<46.355000,0,76.835000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<37.465000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<37.465000,0,76.835000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<28.575000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<28.575000,0,76.835000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<19.685000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<19.685000,0,76.835000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<74.930000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<64.770000,0,81.280000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<74.930000,0,84.455000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<64.770000,0,84.455000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<74.930000,0,87.630000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<64.770000,0,87.630000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<74.930000,0,90.805000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<64.770000,0,90.805000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_R19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_R20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_R20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_R21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_R21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_R22) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_R22) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_R23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_R23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_R24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_R24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_R25) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R25) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R26) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R26) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.335000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_R27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<15.875000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_R28) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.255000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_R28) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<10.795000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_R30) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<61.595000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_R30) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<61.595000,0,64.135000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,67.945000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,70.485000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,73.025000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,75.565000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,78.105000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,80.645000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,83.185000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,85.725000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,88.265000> texture{col_thl}}
#ifndef(global_pack_SL1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,90.805000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_SL2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_SL3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<144.145000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<14.605000,0,57.785000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<14.605000,0,60.325000> texture{col_thl}}
#ifndef(global_pack_SL4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<14.605000,0,62.865000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<24.130000,0,57.785000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<24.130000,0,60.325000> texture{col_thl}}
#ifndef(global_pack_SL5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<24.130000,0,62.865000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<33.655000,0,57.785000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<33.655000,0,60.325000> texture{col_thl}}
#ifndef(global_pack_SL6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<33.655000,0,62.865000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,57.785000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,60.325000> texture{col_thl}}
#ifndef(global_pack_SL7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,62.865000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<48.895000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<63.500000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<60.960000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<75.565000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<73.025000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.711200,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<24.765000,0,43.180000> texture{col_thl}}
//Lötaugen/Durchkontaktierungen
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<149.860000,0,83.185000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<149.860000,0,76.835000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<137.795000,0,17.780000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<137.795000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<113.665000,0,62.865000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<113.665000,0,38.735000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<86.995000,0,73.660000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<86.995000,0,59.055000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<83.185000,0,56.515000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<83.185000,0,72.390000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<81.915000,0,6.985000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<113.030000,0,6.985000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<86.995000,0,33.655000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<86.995000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<85.090000,0,36.195000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<85.090000,0,15.875000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<89.535000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<89.535000,0,17.145000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<145.415000,0,64.770000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<156.210000,0,64.770000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<130.810000,0,10.795000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<130.810000,0,37.465000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<110.490000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<110.490000,0,17.145000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<92.075000,0,67.945000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<92.075000,0,61.595000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<135.890000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<135.890000,0,14.605000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<95.250000,0,53.975000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<73.025000,0,53.975000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<133.985000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(2.184400,0.700000,1,16,2,0) translate<133.985000,0,50.800000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<90.805000,0,80.010000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.614400,0.700000,1,16,2,0) translate<90.805000,0,55.880000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signale
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,13.970000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,15.240000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,16.510000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,17.780000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,19.050000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,20.320000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,24.130000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,25.400000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,26.670000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,27.940000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,29.210000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,30.480000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,31.750000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,33.020000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,34.290000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,35.560000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,36.830000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,38.100000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,39.370000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,40.640000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,41.910000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,43.180000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,45.720000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<8.255000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.525000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<8.255000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,13.970000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,16.510000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,19.050000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,24.130000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,26.670000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,29.210000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,31.750000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,34.290000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,36.830000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,39.370000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.795000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.255000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,41.910000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.255000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.525000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.065000,-1.535000,11.430000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<9.525000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.795000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.065000,-1.535000,44.450000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.795000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.430000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.430000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.065000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.065000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<14.605000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<14.605000,-1.535000,62.865000>}
box{<0,0,-1.092200><2.540000,0.035000,1.092200> rotate<0,-90.000000,0> translate<14.605000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,12.700000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,13.970000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,15.240000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,16.510000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,17.780000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,19.050000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,20.320000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,21.590000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,25.400000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,26.670000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,27.940000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,29.210000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,30.480000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,31.750000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,33.020000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,34.290000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,35.560000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,36.830000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,38.100000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,39.370000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,40.640000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,41.910000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.875000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,43.180000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<15.875000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.065000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,44.450000>}
box{<0,0,-0.203200><10.795000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.065000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<22.860000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<24.130000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<24.130000,-1.535000,62.865000>}
box{<0,0,-1.092200><2.540000,0.035000,1.092200> rotate<0,-90.000000,0> translate<24.130000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<14.605000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<24.130000,-1.535000,65.405000>}
box{<0,0,-1.092200><9.525000,0.035000,1.092200> rotate<0,0.000000,0> translate<14.605000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.765000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<24.765000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.765000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-1.535000,44.450000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<24.765000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.400000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<26.035000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.685000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.575000,-1.535000,74.295000>}
box{<0,0,-0.406400><8.890000,0.035000,0.406400> rotate<0,0.000000,0> translate<19.685000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<33.655000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<33.655000,-1.535000,62.865000>}
box{<0,0,-1.092200><2.540000,0.035000,1.092200> rotate<0,-90.000000,0> translate<33.655000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<24.130000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<33.655000,-1.535000,65.405000>}
box{<0,0,-1.092200><9.525000,0.035000,1.092200> rotate<0,0.000000,0> translate<24.130000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,90.805000>}
box{<0,0,-0.304800><19.756563,0.035000,0.304800> rotate<0,-44.997030,0> translate<19.685000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,12.700000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,13.970000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,15.240000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,16.510000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,17.780000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,19.050000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,20.320000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,21.590000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.035000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,25.400000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,26.670000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,27.940000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,29.210000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,30.480000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,31.750000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,33.020000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,34.290000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,35.560000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,36.830000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,38.100000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,39.370000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,40.640000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,41.910000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.670000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.305000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,43.180000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.305000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-1.535000,44.450000>}
box{<0,0,-0.203200><9.525000,0.035000,0.203200> rotate<0,0.000000,0> translate<26.035000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.925000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<34.925000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<35.560000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.195000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.195000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.575000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.465000,-1.535000,74.295000>}
box{<0,0,-0.406400><8.890000,0.035000,0.406400> rotate<0,0.000000,0> translate<28.575000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.100000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<36.830000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.465000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,44.450000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.465000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.575000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,87.630000>}
box{<0,0,-0.304800><15.266435,0.035000,0.304800> rotate<0,-44.997030,0> translate<28.575000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<43.180000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<43.180000,-1.535000,62.865000>}
box{<0,0,-1.092200><2.540000,0.035000,1.092200> rotate<0,-90.000000,0> translate<43.180000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<33.655000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<43.180000,-1.535000,65.405000>}
box{<0,0,-1.092200><9.525000,0.035000,1.092200> rotate<0,0.000000,0> translate<33.655000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.465000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,84.455000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<37.465000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,12.700000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,13.970000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,15.240000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,16.510000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,17.780000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,19.050000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,20.320000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.100000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,21.590000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.100000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,25.400000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,26.670000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,27.940000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,29.210000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,30.480000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,31.750000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,33.020000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,34.290000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,35.560000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,36.830000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,38.100000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,39.370000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,40.640000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,41.910000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,43.180000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.370000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.465000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<46.355000,-1.535000,74.295000>}
box{<0,0,-0.406400><8.890000,0.035000,0.406400> rotate<0,0.000000,0> translate<37.465000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<46.355000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<46.355000,-1.535000,74.295000>}
box{<0,0,-0.406400><1.270000,0.035000,0.406400> rotate<0,90.000000,0> translate<46.355000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.355000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<46.355000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.735000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,44.450000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.735000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<47.625000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.895000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.895000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.625000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.165000,-1.535000,24.130000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<47.625000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.530000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,44.450000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.530000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,81.280000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<46.355000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.165000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<50.165000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<43.180000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<53.975000,-1.535000,65.405000>}
box{<0,0,-1.092200><10.795000,0.035000,1.092200> rotate<0,0.000000,0> translate<43.180000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<46.355000,-1.535000,73.025000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.975000,-1.535000,65.405000>}
box{<0,0,-0.406400><10.776307,0.035000,0.406400> rotate<0,44.997030,0> translate<46.355000,-1.535000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<53.975000,-1.535000,65.405000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<56.197500,-1.535000,63.182500>}
box{<0,0,-1.092200><3.143090,0.035000,1.092200> rotate<0,44.997030,0> translate<53.975000,-1.535000,65.405000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.197500,-1.535000,63.182500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.197500,-1.535000,63.500000>}
box{<0,0,-0.304800><0.317500,0.035000,0.304800> rotate<0,90.000000,0> translate<56.197500,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.197500,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.515000,-1.535000,64.135000>}
box{<0,0,-0.304800><0.709952,0.035000,0.304800> rotate<0,-63.430762,0> translate<56.197500,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,12.700000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,13.970000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,15.240000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,16.510000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,17.780000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,19.050000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,20.320000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,25.400000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,26.670000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,27.940000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,29.210000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,30.480000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,31.750000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,33.020000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,34.290000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,35.560000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,36.830000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,38.100000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,39.370000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,40.640000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,41.910000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.435000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,43.180000>}
box{<0,0,-0.203200><6.985000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.435000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<56.197500,-1.535000,63.182500>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<59.055000,-1.535000,60.325000>}
box{<0,0,-1.092200><4.041115,0.035000,1.092200> rotate<0,44.997030,0> translate<56.197500,-1.535000,63.182500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,21.590000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.420000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<58.420000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.800000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,44.450000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.800000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<59.690000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<59.690000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.690000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.960000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<59.055000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<61.595000,-1.535000,60.325000>}
box{<0,0,-1.092200><2.540000,0.035000,1.092200> rotate<0,0.000000,0> translate<59.055000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,-1.535000,64.135000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<61.595000,-1.535000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.595000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,44.450000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.595000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.800000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,81.280000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.800000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,-1.535000,84.455000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,84.455000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.085000,-1.535000,84.455000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,87.630000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,90.805000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,-1.535000,90.805000>}
box{<0,0,-0.304800><31.115000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.655000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,94.615000>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.215000,-1.535000,94.615000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,74.930000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<69.215000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,93.345000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<70.485000,-1.535000,93.345000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,12.700000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,13.970000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,15.240000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,16.510000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,17.780000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,19.050000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,20.320000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,25.400000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,26.670000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,27.940000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,29.210000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,30.480000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,31.750000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,33.020000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,34.290000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,35.560000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,36.830000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,38.100000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,39.370000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,40.640000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,41.910000>}
box{<0,0,-0.203200><8.255000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,43.180000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.500000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<8.255000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<71.120000,-1.535000,45.720000>}
box{<0,0,-0.635000><62.865000,0.035000,0.635000> rotate<0,0.000000,0> translate<8.255000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-1.535000,21.590000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<71.755000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,27.940000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,30.480000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,33.020000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,38.100000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,-90.000000,0> translate<73.025000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,44.450000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.865000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<73.025000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<73.025000,-1.535000,57.785000>}
box{<0,0,-1.092200><3.810000,0.035000,1.092200> rotate<0,90.000000,0> translate<73.025000,-1.535000,57.785000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<61.595000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<73.025000,-1.535000,60.325000>}
box{<0,0,-1.092200><11.430000,0.035000,1.092200> rotate<0,0.000000,0> translate<61.595000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<73.025000,-1.535000,57.785000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<73.025000,-1.535000,60.325000>}
box{<0,0,-1.092200><2.540000,0.035000,1.092200> rotate<0,90.000000,0> translate<73.025000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<73.025000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<73.025000,-1.535000,62.230000>}
box{<0,0,-0.406400><1.905000,0.035000,0.406400> rotate<0,90.000000,0> translate<73.025000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,74.930000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.850000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,12.700000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<73.025000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<73.025000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<73.025000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<73.025000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.025000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,40.640000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<73.025000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<71.120000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-1.535000,48.260000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,-44.997030,0> translate<71.120000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.025000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-1.535000,53.340000>}
box{<0,0,-0.635000><0.898026,0.035000,0.635000> rotate<0,44.997030,0> translate<73.025000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-1.535000,53.340000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<73.660000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.025000,-1.535000,57.785000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-1.535000,57.150000>}
box{<0,0,-0.635000><0.898026,0.035000,0.635000> rotate<0,44.997030,0> translate<73.025000,-1.535000,57.785000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,24.130000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,29.210000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,31.750000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,34.290000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,36.830000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,39.370000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,72.390000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.025000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,15.240000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,20.320000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.660000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,43.180000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<73.660000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.120000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<72.390000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,11.430000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<72.390000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,12.700000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<75.565000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,15.240000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,17.780000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<74.295000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<74.295000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,30.480000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<74.295000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<74.295000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<74.295000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<74.295000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.295000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<74.295000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<75.565000,-1.535000,43.180000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,46.990000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<73.025000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,60.960000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<75.565000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<74.295000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,76.200000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<70.485000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,76.200000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<75.565000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,77.470000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.025000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,69.850000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.025000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<76.835000,-1.535000,13.970000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<76.835000,-1.535000,16.510000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<76.835000,-1.535000,19.050000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<76.835000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.930000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<76.835000,-1.535000,41.910000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<74.930000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,60.325000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<76.835000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,62.230000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<75.565000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,83.185000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<74.930000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,90.805000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,88.900000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<74.930000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,71.755000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<76.200000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,76.200000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<78.105000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,80.010000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<75.565000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,67.310000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<78.740000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,5.715000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,-90.000000,0> translate<80.010000,-1.535000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,11.430000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,5.080000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<80.010000,-1.535000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,62.230000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,67.310000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,13.970000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,6.985000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<81.915000,-1.535000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.280000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,13.335000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<81.280000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,15.240000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,60.325000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.740000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.740000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<82.550000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,-1.535000,5.080000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,-1.535000,41.910000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,-1.535000,56.515000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<83.185000,-1.535000,56.515000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,-1.535000,72.390000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,0.000000,72.390000>}
box{<0,0,-0.304800><15.875000,0.035000,0.304800> rotate<0,90.000000,0> translate<83.185000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.185000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,5.715000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<83.185000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,12.065000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<83.820000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.550000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,13.970000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<82.550000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.455000,-1.535000,16.510000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.455000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,15.875000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<84.455000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,0.000000,36.195000>}
box{<0,0,-0.304800><20.320000,0.035000,0.304800> rotate<0,90.000000,0> translate<85.090000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<85.090000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,74.930000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.725000,-1.535000,40.640000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.725000,-1.535000,66.040000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<81.915000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,13.970000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<83.820000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,0.000000,33.655000>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,90.000000,0> translate<86.995000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.725000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<85.725000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,59.055000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<86.995000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,0.000000,73.660000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<86.995000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.820000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,12.065000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<83.820000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,17.780000>}
box{<0,0,-0.304800><13.335000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.900000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,17.145000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<88.900000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,0.000000,31.750000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,90.000000,0> translate<89.535000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,32.385000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<89.535000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,54.610000>}
box{<0,0,-0.304800><17.145000,0.035000,0.304800> rotate<0,90.000000,0> translate<89.535000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,64.770000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<80.645000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,19.050000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,21.590000>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,55.880000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<89.535000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,63.500000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<89.535000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,80.010000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.105000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,0.000000,80.010000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,90.000000,0> translate<90.805000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.630000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,15.875000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<87.630000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,18.415000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<90.805000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,20.320000>}
box{<0,0,-0.304800><15.875000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.565000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,0.000000,67.945000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<92.075000,0.000000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,23.495000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<90.805000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,61.595000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,62.230000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<92.075000,-1.535000,61.595000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.075000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,67.310000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<92.075000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.105000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,76.200000>}
box{<0,0,-0.304800><14.605000,0.035000,0.304800> rotate<0,0.000000,0> translate<78.105000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.345000,-1.535000,22.225000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<91.440000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<92.710000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.025000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,0.000000,53.975000>}
box{<0,0,-0.304800><22.225000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.025000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<95.250000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<95.250000,-1.535000,57.785000>}
box{<0,0,-1.092200><3.810000,0.035000,1.092200> rotate<0,90.000000,0> translate<95.250000,-1.535000,57.785000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<95.250000,-1.535000,57.785000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<95.250000,-1.535000,59.690000>}
box{<0,0,-1.092200><1.905000,0.035000,1.092200> rotate<0,90.000000,0> translate<95.250000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,62.230000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<95.250000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<95.250000,-1.535000,62.230000>}
box{<0,0,-0.406400><2.540000,0.035000,0.406400> rotate<0,90.000000,0> translate<95.250000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,67.310000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,69.850000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<95.250000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.980000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.980000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<95.250000,-1.535000,57.785000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<95.885000,-1.535000,57.150000>}
box{<0,0,-0.635000><0.898026,0.035000,0.635000> rotate<0,44.997030,0> translate<95.250000,-1.535000,57.785000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<95.250000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,77.470000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<95.250000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.725000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.155000,-1.535000,66.040000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.725000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.155000,-1.535000,73.660000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.995000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,67.310000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<97.790000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,71.120000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.155000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,64.770000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<97.155000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<99.060000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.155000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,71.755000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<97.155000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<99.695000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<99.695000,-1.535000,10.160000>}
box{<0,0,-0.965200><6.350000,0.035000,0.965200> rotate<0,90.000000,0> translate<99.695000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<99.695000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<99.695000,-1.535000,14.605000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,90.000000,0> translate<99.695000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<93.345000,-1.535000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,22.225000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<93.345000,-1.535000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,32.385000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<89.535000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.535000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,37.465000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<89.535000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,73.660000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<96.520000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,19.685000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<99.695000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.695000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,29.845000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<99.695000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,18.415000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<91.440000,-1.535000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,29.210000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<100.965000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<96.520000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,31.115000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<96.520000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.090000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,36.195000>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.090000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<90.805000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,63.500000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<90.805000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<91.440000,-1.535000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,15.875000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<91.440000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.965000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,20.955000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<100.965000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,20.955000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<102.235000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<92.710000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,23.495000>}
box{<0,0,-0.304800><9.525000,0.035000,0.304800> rotate<0,0.000000,0> translate<92.710000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.995000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,33.655000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<86.995000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<95.250000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<102.235000,-1.535000,59.690000>}
box{<0,0,-1.092200><6.985000,0.035000,1.092200> rotate<0,0.000000,0> translate<95.250000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,62.230000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<101.600000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.425000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,64.770000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<98.425000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<97.790000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,67.310000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<97.790000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<99.060000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,69.850000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<99.060000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,20.320000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<101.600000,-1.535000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,26.035000>}
box{<0,0,-0.304800><3.702654,0.035000,0.304800> rotate<0,59.032347,0> translate<101.600000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.505000,-1.535000,26.035000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,90.000000,0> translate<103.505000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.600000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,32.385000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<101.600000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,-1.535000,19.685000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<102.235000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.235000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,-1.535000,29.845000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<102.235000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,72.390000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,19.685000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<106.045000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.045000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,29.845000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<106.045000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,32.385000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.330000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,73.660000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<100.330000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.870000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,74.930000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.870000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,83.185000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,83.185000>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,83.185000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.410000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,23.495000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<105.410000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,84.455000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,84.455000>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,0.000000,0> translate<74.930000,-1.535000,84.455000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,17.145000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.315000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,0.000000,60.960000>}
box{<0,0,-0.304800><43.815000,0.035000,0.304800> rotate<0,90.000000,0> translate<110.490000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.680000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,68.580000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<106.680000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.490000,-1.535000,68.580000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<110.490000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<102.235000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<111.125000,-1.535000,50.800000>}
box{<0,0,-1.092200><12.572359,0.035000,1.092200> rotate<0,44.997030,0> translate<102.235000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.915000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,0.000000,6.985000>}
box{<0,0,-0.304800><31.115000,0.035000,0.304800> rotate<0,0.000000,0> translate<81.915000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,22.225000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.315000,-1.535000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.030000,-1.535000,22.225000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,90.000000,0> translate<113.030000,-1.535000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.665000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.665000,0.000000,38.735000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,-90.000000,0> translate<113.665000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.665000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.665000,-1.535000,62.865000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,-90.000000,0> translate<113.665000,-1.535000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.665000,-1.535000,67.310000>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<107.315000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,24.765000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.315000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.315000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,27.305000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<107.315000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.665000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.935000,-1.535000,37.465000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<113.665000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<107.950000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,67.310000>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<107.950000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,87.630000>}
box{<0,0,-0.304800><42.545000,0.035000,0.304800> rotate<0,0.000000,0> translate<74.930000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,20.955000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<114.300000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.300000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,23.495000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<114.300000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,88.900000>}
box{<0,0,-0.304800><41.275000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.835000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<99.695000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<120.015000,-1.535000,3.810000>}
box{<0,0,-0.965200><20.320000,0.035000,0.965200> rotate<0,0.000000,0> translate<99.695000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<120.015000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<120.015000,-1.535000,3.810000>}
box{<0,0,-0.965200><10.795000,0.035000,0.965200> rotate<0,-90.000000,0> translate<120.015000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<120.015000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<120.015000,-1.535000,19.685000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<120.015000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,69.850000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<120.015000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.585000,-1.535000,83.185000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,71.755000>}
box{<0,0,-0.304800><16.164461,0.035000,0.304800> rotate<0,44.997030,0> translate<108.585000,-1.535000,83.185000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,80.010000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<120.015000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.475000,-1.535000,87.630000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,85.090000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<117.475000,-1.535000,87.630000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.220000,-1.535000,84.455000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,72.390000>}
box{<0,0,-0.304800><17.062487,0.035000,0.304800> rotate<0,44.997030,0> translate<109.220000,-1.535000,84.455000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,20.955000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<122.047000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<122.047000,-1.535000,43.815000>}
box{<0,0,-1.092200><6.985000,0.035000,1.092200> rotate<0,-90.000000,0> translate<122.047000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<111.125000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<122.047000,-1.535000,50.800000>}
box{<0,0,-1.092200><10.922000,0.035000,1.092200> rotate<0,0.000000,0> translate<111.125000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<120.015000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<122.555000,-1.535000,14.605000>}
box{<0,0,-0.965200><2.540000,0.035000,0.965200> rotate<0,0.000000,0> translate<120.015000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,23.495000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<118.110000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<114.935000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,37.465000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<114.935000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<122.047000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<122.555000,-1.535000,50.800000>}
box{<0,0,-0.965200><0.508000,0.035000,0.965200> rotate<0,0.000000,0> translate<122.047000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<122.555000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<122.555000,-1.535000,63.500000>}
box{<0,0,-0.406400><12.700000,0.035000,0.406400> rotate<0,90.000000,0> translate<122.555000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,84.455000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,81.280000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,-90.000000,0> translate<122.555000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.110000,-1.535000,88.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,84.455000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<118.110000,-1.535000,88.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,78.740000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<122.555000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,24.130000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,-90.000000,0> translate<124.460000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,29.845000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,-90.000000,0> translate<124.460000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<122.555000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.555000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,20.955000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<122.555000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.285000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,72.390000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<121.285000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.920000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,16.510000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<121.920000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,22.225000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<124.460000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,69.850000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.015000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,73.660000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<125.095000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.015000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,80.010000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.015000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.570000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,67.310000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<115.570000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.190000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,74.930000>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<123.190000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,22.225000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<126.365000,-1.535000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.460000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,29.845000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<124.460000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,68.580000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<126.365000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,70.485000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,71.755000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<127.635000,-1.535000,71.755000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,78.740000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<126.365000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,66.040000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<127.000000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,70.485000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,69.850000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<127.635000,-1.535000,70.485000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,72.390000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<127.635000,-1.535000,71.755000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.905000,-1.535000,19.685000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.635000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.175000,-1.535000,66.040000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<128.270000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.175000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.635000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.175000,-1.535000,73.660000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<126.365000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.175000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.635000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.905000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,17.780000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<128.905000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.095000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,20.955000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<125.095000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,24.765000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.635000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,0.000000,37.465000>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,90.000000,0> translate<130.810000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.445000,-1.535000,32.385000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.635000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,19.050000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<130.810000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.175000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,66.040000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<130.175000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,69.850000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<128.270000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,69.850000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<132.715000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.445000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,34.290000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<131.445000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,38.735000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<133.350000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.270000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,72.390000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<128.270000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.175000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,76.200000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<130.175000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,0.000000,25.400000>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,-90.000000,0> translate<133.985000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<122.555000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<133.985000,-1.535000,50.800000>}
box{<0,0,-1.092200><11.430000,0.035000,1.092200> rotate<0,0.000000,0> translate<122.555000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.175000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,71.120000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<130.175000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.000000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,74.930000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.000000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,44.997030,0> translate<130.810000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,78.105000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<133.350000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<122.555000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<135.890000,-1.535000,14.605000>}
box{<0,0,-0.965200><13.335000,0.035000,0.965200> rotate<0,0.000000,0> translate<122.555000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,0.000000,14.605000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.890000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<133.985000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<135.890000,-1.535000,25.400000>}
box{<0,0,-0.965200><1.905000,0.035000,0.965200> rotate<0,0.000000,0> translate<133.985000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,76.835000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<133.985000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,75.565000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<133.350000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.985000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,74.295000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<133.985000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.810000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,17.780000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<130.810000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<133.985000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<137.795000,-1.535000,21.590000>}
box{<0,0,-0.635000><5.388154,0.035000,0.635000> rotate<0,44.997030,0> translate<133.985000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,0.000000,35.560000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,90.000000,0> translate<137.795000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<133.350000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,43.180000>}
box{<0,0,-0.304800><6.286179,0.035000,0.304800> rotate<0,-44.997030,0> translate<133.350000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,48.260000>}
box{<0,0,-1.092200><2.540000,0.035000,1.092200> rotate<0,-90.000000,0> translate<139.700000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<133.985000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,50.800000>}
box{<0,0,-1.092200><5.715000,0.035000,1.092200> rotate<0,0.000000,0> translate<133.985000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,60.960000>}
box{<0,0,-1.092200><10.160000,0.035000,1.092200> rotate<0,90.000000,0> translate<139.700000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,67.945000>}
box{<0,0,-1.092200><6.985000,0.035000,1.092200> rotate<0,90.000000,0> translate<139.700000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,80.645000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,-90.000000,0> translate<140.335000,-1.535000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,93.345000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,93.345000>}
box{<0,0,-0.304800><69.850000,0.035000,0.304800> rotate<0,0.000000,0> translate<70.485000,-1.535000,93.345000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<139.700000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<140.970000,-1.535000,60.960000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,0.000000,0> translate<139.700000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,38.100000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<141.605000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.160000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,74.295000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.160000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.890000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,76.835000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.890000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.240000,-1.535000,20.320000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.255000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.365000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,16.510000>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<126.365000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.715000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,19.050000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.715000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<137.795000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<144.145000,-1.535000,21.590000>}
box{<0,0,-0.635000><6.350000,0.035000,0.635000> rotate<0,0.000000,0> translate<137.795000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,35.560000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.795000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.605000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,38.100000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<141.605000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.795000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,43.180000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.795000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<144.145000,-1.535000,48.260000>}
box{<0,0,-1.092200><4.445000,0.035000,1.092200> rotate<0,0.000000,0> translate<139.700000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<139.700000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>1.092200 translate<144.145000,-1.535000,67.945000>}
box{<0,0,-1.092200><4.445000,0.035000,1.092200> rotate<0,0.000000,0> translate<139.700000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.525000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,75.565000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<136.525000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.255000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,78.105000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.255000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.335000,-1.535000,80.645000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,80.645000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.335000,-1.535000,80.645000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,94.615000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,90.805000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.145000,-1.535000,90.805000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,-1.535000,94.615000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,94.615000>}
box{<0,0,-0.304800><74.930000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.215000,-1.535000,94.615000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<141.605000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<146.685000,-1.535000,10.160000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<141.605000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<141.605000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<146.685000,-1.535000,12.700000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<141.605000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,13.970000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,13.970000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<146.685000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<142.240000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<146.685000,-1.535000,20.320000>}
box{<0,0,-0.203200><4.445000,0.035000,0.203200> rotate<0,0.000000,0> translate<142.240000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<141.605000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<146.685000,-1.535000,41.910000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<141.605000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<141.605000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<146.685000,-1.535000,74.295000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<141.605000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<141.605000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<146.685000,-1.535000,76.835000>}
box{<0,0,-0.203200><5.080000,0.035000,0.203200> rotate<0,0.000000,0> translate<141.605000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,75.565000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,74.295000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,73.025000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<146.685000,-1.535000,74.295000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.955000,-1.535000,73.025000>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,90.000000,0> translate<147.955000,-1.535000,73.025000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,78.105000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,11.430000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,11.430000>}
box{<0,0,-0.304800><15.875000,0.035000,0.304800> rotate<0,-90.000000,0> translate<149.225000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.635000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,27.305000>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<127.635000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,41.910000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.685000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,41.910000>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,-90.000000,0> translate<149.225000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.320000,-1.535000,75.565000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,73.660000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<147.320000,-1.535000,75.565000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.590000,-1.535000,78.105000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,78.740000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<148.590000,-1.535000,78.105000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.685000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,76.835000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.685000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,83.185000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,83.185000>}
box{<0,0,-0.304800><5.715000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,83.185000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,0.000000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,0.000000,83.185000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<149.860000,0.000000,83.185000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.495000,-1.535000,40.640000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.860000,-1.535000,76.835000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.495000,-1.535000,76.200000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<149.860000,-1.535000,76.835000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.495000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.495000,-1.535000,76.200000>}
box{<0,0,-0.304800><35.560000,0.035000,0.304800> rotate<0,90.000000,0> translate<150.495000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,35.560000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,76.200000>}
box{<0,0,-0.304800><40.640000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.765000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.225000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.225000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.765000,-1.535000,78.740000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<151.765000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.035000,-1.535000,8.890000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,85.725000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.035000,-1.535000,85.725000>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.035000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.035000,-1.535000,85.725000>}
box{<0,0,-0.304800><76.835000,0.035000,0.304800> rotate<0,90.000000,0> translate<153.035000,-1.535000,85.725000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.305000,-1.535000,6.350000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.145000,-1.535000,88.265000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.305000,-1.535000,88.265000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.145000,-1.535000,88.265000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.305000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.305000,-1.535000,88.265000>}
box{<0,0,-0.304800><81.915000,0.035000,0.304800> rotate<0,90.000000,0> translate<154.305000,-1.535000,88.265000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<145.415000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.210000,0.000000,64.770000>}
box{<0,0,-0.304800><10.795000,0.035000,0.304800> rotate<0,0.000000,0> translate<145.415000,0.000000,64.770000> }
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
cylinder{<73.660000,0.038000,57.150000><73.660000,-1.538000,57.150000>0.406400}
cylinder{<78.740000,0.038000,57.150000><78.740000,-1.538000,57.150000>0.406400}
cylinder{<95.885000,0.038000,57.150000><95.885000,-1.538000,57.150000>0.406400}
cylinder{<100.965000,0.038000,57.150000><100.965000,-1.538000,57.150000>0.406400}
cylinder{<140.970000,0.038000,60.960000><140.970000,-1.538000,60.960000>0.406400}
cylinder{<146.050000,0.038000,60.960000><146.050000,-1.538000,60.960000>0.406400}
cylinder{<99.695000,0.038000,10.160000><99.695000,-1.538000,10.160000>0.406400}
cylinder{<94.615000,0.038000,10.160000><94.615000,-1.538000,10.160000>0.406400}
cylinder{<122.555000,0.038000,14.605000><122.555000,-1.538000,14.605000>0.406400}
cylinder{<122.555000,0.038000,9.525000><122.555000,-1.538000,9.525000>0.406400}
cylinder{<122.047000,0.038000,43.815000><122.047000,-1.538000,43.815000>0.406400}
cylinder{<125.603000,0.038000,43.815000><125.603000,-1.538000,43.815000>0.406400}
cylinder{<56.515000,0.038000,74.295000><56.515000,-1.538000,74.295000>0.596900}
cylinder{<56.515000,0.038000,64.135000><56.515000,-1.538000,64.135000>0.596900}
cylinder{<102.870000,0.038000,62.230000><102.870000,-1.538000,62.230000>0.406400}
cylinder{<102.870000,0.038000,64.770000><102.870000,-1.538000,64.770000>0.406400}
cylinder{<102.870000,0.038000,67.310000><102.870000,-1.538000,67.310000>0.406400}
cylinder{<102.870000,0.038000,69.850000><102.870000,-1.538000,69.850000>0.406400}
cylinder{<102.870000,0.038000,72.390000><102.870000,-1.538000,72.390000>0.406400}
cylinder{<102.870000,0.038000,74.930000><102.870000,-1.538000,74.930000>0.406400}
cylinder{<102.870000,0.038000,77.470000><102.870000,-1.538000,77.470000>0.406400}
cylinder{<95.250000,0.038000,77.470000><95.250000,-1.538000,77.470000>0.406400}
cylinder{<95.250000,0.038000,74.930000><95.250000,-1.538000,74.930000>0.406400}
cylinder{<95.250000,0.038000,72.390000><95.250000,-1.538000,72.390000>0.406400}
cylinder{<95.250000,0.038000,69.850000><95.250000,-1.538000,69.850000>0.406400}
cylinder{<95.250000,0.038000,67.310000><95.250000,-1.538000,67.310000>0.406400}
cylinder{<95.250000,0.038000,64.770000><95.250000,-1.538000,64.770000>0.406400}
cylinder{<95.250000,0.038000,62.230000><95.250000,-1.538000,62.230000>0.406400}
cylinder{<80.645000,0.038000,62.230000><80.645000,-1.538000,62.230000>0.406400}
cylinder{<80.645000,0.038000,64.770000><80.645000,-1.538000,64.770000>0.406400}
cylinder{<80.645000,0.038000,67.310000><80.645000,-1.538000,67.310000>0.406400}
cylinder{<80.645000,0.038000,69.850000><80.645000,-1.538000,69.850000>0.406400}
cylinder{<80.645000,0.038000,72.390000><80.645000,-1.538000,72.390000>0.406400}
cylinder{<80.645000,0.038000,74.930000><80.645000,-1.538000,74.930000>0.406400}
cylinder{<80.645000,0.038000,77.470000><80.645000,-1.538000,77.470000>0.406400}
cylinder{<73.025000,0.038000,77.470000><73.025000,-1.538000,77.470000>0.406400}
cylinder{<73.025000,0.038000,74.930000><73.025000,-1.538000,74.930000>0.406400}
cylinder{<73.025000,0.038000,72.390000><73.025000,-1.538000,72.390000>0.406400}
cylinder{<73.025000,0.038000,69.850000><73.025000,-1.538000,69.850000>0.406400}
cylinder{<73.025000,0.038000,67.310000><73.025000,-1.538000,67.310000>0.406400}
cylinder{<73.025000,0.038000,64.770000><73.025000,-1.538000,64.770000>0.406400}
cylinder{<73.025000,0.038000,62.230000><73.025000,-1.538000,62.230000>0.406400}
cylinder{<130.175000,0.038000,63.500000><130.175000,-1.538000,63.500000>0.406400}
cylinder{<130.175000,0.038000,66.040000><130.175000,-1.538000,66.040000>0.406400}
cylinder{<130.175000,0.038000,68.580000><130.175000,-1.538000,68.580000>0.406400}
cylinder{<130.175000,0.038000,71.120000><130.175000,-1.538000,71.120000>0.406400}
cylinder{<130.175000,0.038000,73.660000><130.175000,-1.538000,73.660000>0.406400}
cylinder{<130.175000,0.038000,76.200000><130.175000,-1.538000,76.200000>0.406400}
cylinder{<130.175000,0.038000,78.740000><130.175000,-1.538000,78.740000>0.406400}
cylinder{<130.175000,0.038000,81.280000><130.175000,-1.538000,81.280000>0.406400}
cylinder{<122.555000,0.038000,81.280000><122.555000,-1.538000,81.280000>0.406400}
cylinder{<122.555000,0.038000,78.740000><122.555000,-1.538000,78.740000>0.406400}
cylinder{<122.555000,0.038000,76.200000><122.555000,-1.538000,76.200000>0.406400}
cylinder{<122.555000,0.038000,73.660000><122.555000,-1.538000,73.660000>0.406400}
cylinder{<122.555000,0.038000,71.120000><122.555000,-1.538000,71.120000>0.406400}
cylinder{<122.555000,0.038000,68.580000><122.555000,-1.538000,68.580000>0.406400}
cylinder{<122.555000,0.038000,66.040000><122.555000,-1.538000,66.040000>0.406400}
cylinder{<122.555000,0.038000,63.500000><122.555000,-1.538000,63.500000>0.406400}
cylinder{<127.635000,0.038000,19.685000><127.635000,-1.538000,19.685000>0.406400}
cylinder{<127.635000,0.038000,22.225000><127.635000,-1.538000,22.225000>0.406400}
cylinder{<127.635000,0.038000,24.765000><127.635000,-1.538000,24.765000>0.406400}
cylinder{<127.635000,0.038000,27.305000><127.635000,-1.538000,27.305000>0.406400}
cylinder{<127.635000,0.038000,29.845000><127.635000,-1.538000,29.845000>0.406400}
cylinder{<127.635000,0.038000,32.385000><127.635000,-1.538000,32.385000>0.406400}
cylinder{<127.635000,0.038000,34.925000><127.635000,-1.538000,34.925000>0.406400}
cylinder{<120.015000,0.038000,34.925000><120.015000,-1.538000,34.925000>0.406400}
cylinder{<120.015000,0.038000,32.385000><120.015000,-1.538000,32.385000>0.406400}
cylinder{<120.015000,0.038000,29.845000><120.015000,-1.538000,29.845000>0.406400}
cylinder{<120.015000,0.038000,27.305000><120.015000,-1.538000,27.305000>0.406400}
cylinder{<120.015000,0.038000,24.765000><120.015000,-1.538000,24.765000>0.406400}
cylinder{<120.015000,0.038000,22.225000><120.015000,-1.538000,22.225000>0.406400}
cylinder{<120.015000,0.038000,19.685000><120.015000,-1.538000,19.685000>0.406400}
cylinder{<107.315000,0.038000,14.605000><107.315000,-1.538000,14.605000>0.406400}
cylinder{<107.315000,0.038000,17.145000><107.315000,-1.538000,17.145000>0.406400}
cylinder{<107.315000,0.038000,19.685000><107.315000,-1.538000,19.685000>0.406400}
cylinder{<107.315000,0.038000,22.225000><107.315000,-1.538000,22.225000>0.406400}
cylinder{<107.315000,0.038000,24.765000><107.315000,-1.538000,24.765000>0.406400}
cylinder{<107.315000,0.038000,27.305000><107.315000,-1.538000,27.305000>0.406400}
cylinder{<107.315000,0.038000,29.845000><107.315000,-1.538000,29.845000>0.406400}
cylinder{<107.315000,0.038000,32.385000><107.315000,-1.538000,32.385000>0.406400}
cylinder{<107.315000,0.038000,34.925000><107.315000,-1.538000,34.925000>0.406400}
cylinder{<107.315000,0.038000,37.465000><107.315000,-1.538000,37.465000>0.406400}
cylinder{<99.695000,0.038000,37.465000><99.695000,-1.538000,37.465000>0.406400}
cylinder{<99.695000,0.038000,34.925000><99.695000,-1.538000,34.925000>0.406400}
cylinder{<99.695000,0.038000,32.385000><99.695000,-1.538000,32.385000>0.406400}
cylinder{<99.695000,0.038000,29.845000><99.695000,-1.538000,29.845000>0.406400}
cylinder{<99.695000,0.038000,27.305000><99.695000,-1.538000,27.305000>0.406400}
cylinder{<99.695000,0.038000,24.765000><99.695000,-1.538000,24.765000>0.406400}
cylinder{<99.695000,0.038000,22.225000><99.695000,-1.538000,22.225000>0.406400}
cylinder{<99.695000,0.038000,19.685000><99.695000,-1.538000,19.685000>0.406400}
cylinder{<99.695000,0.038000,17.145000><99.695000,-1.538000,17.145000>0.406400}
cylinder{<99.695000,0.038000,14.605000><99.695000,-1.538000,14.605000>0.406400}
cylinder{<46.355000,0.038000,74.295000><46.355000,-1.538000,74.295000>0.406400}
cylinder{<46.355000,0.038000,76.835000><46.355000,-1.538000,76.835000>0.406400}
cylinder{<37.465000,0.038000,74.295000><37.465000,-1.538000,74.295000>0.406400}
cylinder{<37.465000,0.038000,76.835000><37.465000,-1.538000,76.835000>0.406400}
cylinder{<28.575000,0.038000,74.295000><28.575000,-1.538000,74.295000>0.406400}
cylinder{<28.575000,0.038000,76.835000><28.575000,-1.538000,76.835000>0.406400}
cylinder{<19.685000,0.038000,74.295000><19.685000,-1.538000,74.295000>0.406400}
cylinder{<19.685000,0.038000,76.835000><19.685000,-1.538000,76.835000>0.406400}
cylinder{<74.930000,0.038000,81.280000><74.930000,-1.538000,81.280000>0.406400}
cylinder{<64.770000,0.038000,81.280000><64.770000,-1.538000,81.280000>0.406400}
cylinder{<74.930000,0.038000,84.455000><74.930000,-1.538000,84.455000>0.406400}
cylinder{<64.770000,0.038000,84.455000><64.770000,-1.538000,84.455000>0.406400}
cylinder{<74.930000,0.038000,87.630000><74.930000,-1.538000,87.630000>0.406400}
cylinder{<64.770000,0.038000,87.630000><64.770000,-1.538000,87.630000>0.406400}
cylinder{<74.930000,0.038000,90.805000><74.930000,-1.538000,90.805000>0.406400}
cylinder{<64.770000,0.038000,90.805000><64.770000,-1.538000,90.805000>0.406400}
cylinder{<13.335000,0.038000,12.700000><13.335000,-1.538000,12.700000>0.406400}
cylinder{<15.875000,0.038000,12.700000><15.875000,-1.538000,12.700000>0.406400}
cylinder{<8.255000,0.038000,12.700000><8.255000,-1.538000,12.700000>0.406400}
cylinder{<10.795000,0.038000,12.700000><10.795000,-1.538000,12.700000>0.406400}
cylinder{<13.335000,0.038000,15.240000><13.335000,-1.538000,15.240000>0.406400}
cylinder{<15.875000,0.038000,15.240000><15.875000,-1.538000,15.240000>0.406400}
cylinder{<8.255000,0.038000,15.240000><8.255000,-1.538000,15.240000>0.406400}
cylinder{<10.795000,0.038000,15.240000><10.795000,-1.538000,15.240000>0.406400}
cylinder{<13.335000,0.038000,17.780000><13.335000,-1.538000,17.780000>0.406400}
cylinder{<15.875000,0.038000,17.780000><15.875000,-1.538000,17.780000>0.406400}
cylinder{<8.255000,0.038000,17.780000><8.255000,-1.538000,17.780000>0.406400}
cylinder{<10.795000,0.038000,17.780000><10.795000,-1.538000,17.780000>0.406400}
cylinder{<13.335000,0.038000,20.320000><13.335000,-1.538000,20.320000>0.406400}
cylinder{<15.875000,0.038000,20.320000><15.875000,-1.538000,20.320000>0.406400}
cylinder{<8.255000,0.038000,20.320000><8.255000,-1.538000,20.320000>0.406400}
cylinder{<10.795000,0.038000,20.320000><10.795000,-1.538000,20.320000>0.406400}
cylinder{<13.335000,0.038000,25.400000><13.335000,-1.538000,25.400000>0.406400}
cylinder{<15.875000,0.038000,25.400000><15.875000,-1.538000,25.400000>0.406400}
cylinder{<8.255000,0.038000,25.400000><8.255000,-1.538000,25.400000>0.406400}
cylinder{<10.795000,0.038000,25.400000><10.795000,-1.538000,25.400000>0.406400}
cylinder{<13.335000,0.038000,27.940000><13.335000,-1.538000,27.940000>0.406400}
cylinder{<15.875000,0.038000,27.940000><15.875000,-1.538000,27.940000>0.406400}
cylinder{<8.255000,0.038000,27.940000><8.255000,-1.538000,27.940000>0.406400}
cylinder{<10.795000,0.038000,27.940000><10.795000,-1.538000,27.940000>0.406400}
cylinder{<13.335000,0.038000,30.480000><13.335000,-1.538000,30.480000>0.406400}
cylinder{<15.875000,0.038000,30.480000><15.875000,-1.538000,30.480000>0.406400}
cylinder{<8.255000,0.038000,30.480000><8.255000,-1.538000,30.480000>0.406400}
cylinder{<10.795000,0.038000,30.480000><10.795000,-1.538000,30.480000>0.406400}
cylinder{<13.335000,0.038000,33.020000><13.335000,-1.538000,33.020000>0.406400}
cylinder{<15.875000,0.038000,33.020000><15.875000,-1.538000,33.020000>0.406400}
cylinder{<8.255000,0.038000,33.020000><8.255000,-1.538000,33.020000>0.406400}
cylinder{<10.795000,0.038000,33.020000><10.795000,-1.538000,33.020000>0.406400}
cylinder{<13.335000,0.038000,35.560000><13.335000,-1.538000,35.560000>0.406400}
cylinder{<15.875000,0.038000,35.560000><15.875000,-1.538000,35.560000>0.406400}
cylinder{<8.255000,0.038000,35.560000><8.255000,-1.538000,35.560000>0.406400}
cylinder{<10.795000,0.038000,35.560000><10.795000,-1.538000,35.560000>0.406400}
cylinder{<13.335000,0.038000,38.100000><13.335000,-1.538000,38.100000>0.406400}
cylinder{<15.875000,0.038000,38.100000><15.875000,-1.538000,38.100000>0.406400}
cylinder{<8.255000,0.038000,38.100000><8.255000,-1.538000,38.100000>0.406400}
cylinder{<10.795000,0.038000,38.100000><10.795000,-1.538000,38.100000>0.406400}
cylinder{<13.335000,0.038000,40.640000><13.335000,-1.538000,40.640000>0.406400}
cylinder{<15.875000,0.038000,40.640000><15.875000,-1.538000,40.640000>0.406400}
cylinder{<8.255000,0.038000,40.640000><8.255000,-1.538000,40.640000>0.406400}
cylinder{<10.795000,0.038000,40.640000><10.795000,-1.538000,40.640000>0.406400}
cylinder{<13.335000,0.038000,43.180000><13.335000,-1.538000,43.180000>0.406400}
cylinder{<15.875000,0.038000,43.180000><15.875000,-1.538000,43.180000>0.406400}
cylinder{<8.255000,0.038000,43.180000><8.255000,-1.538000,43.180000>0.406400}
cylinder{<10.795000,0.038000,43.180000><10.795000,-1.538000,43.180000>0.406400}
cylinder{<61.595000,0.038000,74.295000><61.595000,-1.538000,74.295000>0.406400}
cylinder{<61.595000,0.038000,64.135000><61.595000,-1.538000,64.135000>0.406400}
cylinder{<144.145000,0.038000,67.945000><144.145000,-1.538000,67.945000>0.457200}
cylinder{<144.145000,0.038000,70.485000><144.145000,-1.538000,70.485000>0.457200}
cylinder{<144.145000,0.038000,73.025000><144.145000,-1.538000,73.025000>0.457200}
cylinder{<144.145000,0.038000,75.565000><144.145000,-1.538000,75.565000>0.457200}
cylinder{<144.145000,0.038000,78.105000><144.145000,-1.538000,78.105000>0.457200}
cylinder{<144.145000,0.038000,80.645000><144.145000,-1.538000,80.645000>0.457200}
cylinder{<144.145000,0.038000,83.185000><144.145000,-1.538000,83.185000>0.457200}
cylinder{<144.145000,0.038000,85.725000><144.145000,-1.538000,85.725000>0.457200}
cylinder{<144.145000,0.038000,88.265000><144.145000,-1.538000,88.265000>0.457200}
cylinder{<144.145000,0.038000,90.805000><144.145000,-1.538000,90.805000>0.457200}
cylinder{<144.145000,0.038000,6.350000><144.145000,-1.538000,6.350000>0.457200}
cylinder{<144.145000,0.038000,8.890000><144.145000,-1.538000,8.890000>0.457200}
cylinder{<144.145000,0.038000,11.430000><144.145000,-1.538000,11.430000>0.457200}
cylinder{<144.145000,0.038000,13.970000><144.145000,-1.538000,13.970000>0.457200}
cylinder{<144.145000,0.038000,16.510000><144.145000,-1.538000,16.510000>0.457200}
cylinder{<144.145000,0.038000,19.050000><144.145000,-1.538000,19.050000>0.457200}
cylinder{<144.145000,0.038000,21.590000><144.145000,-1.538000,21.590000>0.457200}
cylinder{<144.145000,0.038000,24.130000><144.145000,-1.538000,24.130000>0.457200}
cylinder{<144.145000,0.038000,35.560000><144.145000,-1.538000,35.560000>0.457200}
cylinder{<144.145000,0.038000,38.100000><144.145000,-1.538000,38.100000>0.457200}
cylinder{<144.145000,0.038000,40.640000><144.145000,-1.538000,40.640000>0.457200}
cylinder{<144.145000,0.038000,43.180000><144.145000,-1.538000,43.180000>0.457200}
cylinder{<144.145000,0.038000,45.720000><144.145000,-1.538000,45.720000>0.457200}
cylinder{<144.145000,0.038000,48.260000><144.145000,-1.538000,48.260000>0.457200}
cylinder{<144.145000,0.038000,50.800000><144.145000,-1.538000,50.800000>0.457200}
cylinder{<144.145000,0.038000,53.340000><144.145000,-1.538000,53.340000>0.457200}
cylinder{<14.605000,0.038000,57.785000><14.605000,-1.538000,57.785000>0.457200}
cylinder{<14.605000,0.038000,60.325000><14.605000,-1.538000,60.325000>0.457200}
cylinder{<14.605000,0.038000,62.865000><14.605000,-1.538000,62.865000>0.457200}
cylinder{<24.130000,0.038000,57.785000><24.130000,-1.538000,57.785000>0.457200}
cylinder{<24.130000,0.038000,60.325000><24.130000,-1.538000,60.325000>0.457200}
cylinder{<24.130000,0.038000,62.865000><24.130000,-1.538000,62.865000>0.457200}
cylinder{<33.655000,0.038000,57.785000><33.655000,-1.538000,57.785000>0.457200}
cylinder{<33.655000,0.038000,60.325000><33.655000,-1.538000,60.325000>0.457200}
cylinder{<33.655000,0.038000,62.865000><33.655000,-1.538000,62.865000>0.457200}
cylinder{<43.180000,0.038000,57.785000><43.180000,-1.538000,57.785000>0.457200}
cylinder{<43.180000,0.038000,60.325000><43.180000,-1.538000,60.325000>0.457200}
cylinder{<43.180000,0.038000,62.865000><43.180000,-1.538000,62.865000>0.457200}
cylinder{<39.370000,0.038000,12.700000><39.370000,-1.538000,12.700000>0.500000}
cylinder{<36.830000,0.038000,12.700000><36.830000,-1.538000,12.700000>0.500000}
cylinder{<39.370000,0.038000,15.240000><39.370000,-1.538000,15.240000>0.500000}
cylinder{<36.830000,0.038000,15.240000><36.830000,-1.538000,15.240000>0.500000}
cylinder{<39.370000,0.038000,17.780000><39.370000,-1.538000,17.780000>0.500000}
cylinder{<36.830000,0.038000,17.780000><36.830000,-1.538000,17.780000>0.500000}
cylinder{<39.370000,0.038000,20.320000><39.370000,-1.538000,20.320000>0.500000}
cylinder{<36.830000,0.038000,20.320000><36.830000,-1.538000,20.320000>0.500000}
cylinder{<39.370000,0.038000,22.860000><39.370000,-1.538000,22.860000>0.500000}
cylinder{<36.830000,0.038000,22.860000><36.830000,-1.538000,22.860000>0.500000}
cylinder{<39.370000,0.038000,25.400000><39.370000,-1.538000,25.400000>0.500000}
cylinder{<36.830000,0.038000,25.400000><36.830000,-1.538000,25.400000>0.500000}
cylinder{<39.370000,0.038000,27.940000><39.370000,-1.538000,27.940000>0.500000}
cylinder{<36.830000,0.038000,27.940000><36.830000,-1.538000,27.940000>0.500000}
cylinder{<39.370000,0.038000,30.480000><39.370000,-1.538000,30.480000>0.500000}
cylinder{<36.830000,0.038000,30.480000><36.830000,-1.538000,30.480000>0.500000}
cylinder{<39.370000,0.038000,33.020000><39.370000,-1.538000,33.020000>0.500000}
cylinder{<36.830000,0.038000,33.020000><36.830000,-1.538000,33.020000>0.500000}
cylinder{<39.370000,0.038000,35.560000><39.370000,-1.538000,35.560000>0.500000}
cylinder{<36.830000,0.038000,35.560000><36.830000,-1.538000,35.560000>0.500000}
cylinder{<39.370000,0.038000,38.100000><39.370000,-1.538000,38.100000>0.500000}
cylinder{<36.830000,0.038000,38.100000><36.830000,-1.538000,38.100000>0.500000}
cylinder{<39.370000,0.038000,40.640000><39.370000,-1.538000,40.640000>0.500000}
cylinder{<36.830000,0.038000,40.640000><36.830000,-1.538000,40.640000>0.500000}
cylinder{<39.370000,0.038000,43.180000><39.370000,-1.538000,43.180000>0.500000}
cylinder{<36.830000,0.038000,43.180000><36.830000,-1.538000,43.180000>0.500000}
cylinder{<51.435000,0.038000,12.700000><51.435000,-1.538000,12.700000>0.500000}
cylinder{<48.895000,0.038000,12.700000><48.895000,-1.538000,12.700000>0.500000}
cylinder{<51.435000,0.038000,15.240000><51.435000,-1.538000,15.240000>0.500000}
cylinder{<48.895000,0.038000,15.240000><48.895000,-1.538000,15.240000>0.500000}
cylinder{<51.435000,0.038000,17.780000><51.435000,-1.538000,17.780000>0.500000}
cylinder{<48.895000,0.038000,17.780000><48.895000,-1.538000,17.780000>0.500000}
cylinder{<51.435000,0.038000,20.320000><51.435000,-1.538000,20.320000>0.500000}
cylinder{<48.895000,0.038000,20.320000><48.895000,-1.538000,20.320000>0.500000}
cylinder{<51.435000,0.038000,22.860000><51.435000,-1.538000,22.860000>0.500000}
cylinder{<48.895000,0.038000,22.860000><48.895000,-1.538000,22.860000>0.500000}
cylinder{<51.435000,0.038000,25.400000><51.435000,-1.538000,25.400000>0.500000}
cylinder{<48.895000,0.038000,25.400000><48.895000,-1.538000,25.400000>0.500000}
cylinder{<51.435000,0.038000,27.940000><51.435000,-1.538000,27.940000>0.500000}
cylinder{<48.895000,0.038000,27.940000><48.895000,-1.538000,27.940000>0.500000}
cylinder{<51.435000,0.038000,30.480000><51.435000,-1.538000,30.480000>0.500000}
cylinder{<48.895000,0.038000,30.480000><48.895000,-1.538000,30.480000>0.500000}
cylinder{<51.435000,0.038000,33.020000><51.435000,-1.538000,33.020000>0.500000}
cylinder{<48.895000,0.038000,33.020000><48.895000,-1.538000,33.020000>0.500000}
cylinder{<51.435000,0.038000,35.560000><51.435000,-1.538000,35.560000>0.500000}
cylinder{<48.895000,0.038000,35.560000><48.895000,-1.538000,35.560000>0.500000}
cylinder{<51.435000,0.038000,38.100000><51.435000,-1.538000,38.100000>0.500000}
cylinder{<48.895000,0.038000,38.100000><48.895000,-1.538000,38.100000>0.500000}
cylinder{<51.435000,0.038000,40.640000><51.435000,-1.538000,40.640000>0.500000}
cylinder{<48.895000,0.038000,40.640000><48.895000,-1.538000,40.640000>0.500000}
cylinder{<51.435000,0.038000,43.180000><51.435000,-1.538000,43.180000>0.500000}
cylinder{<48.895000,0.038000,43.180000><48.895000,-1.538000,43.180000>0.500000}
cylinder{<63.500000,0.038000,12.700000><63.500000,-1.538000,12.700000>0.500000}
cylinder{<60.960000,0.038000,12.700000><60.960000,-1.538000,12.700000>0.500000}
cylinder{<63.500000,0.038000,15.240000><63.500000,-1.538000,15.240000>0.500000}
cylinder{<60.960000,0.038000,15.240000><60.960000,-1.538000,15.240000>0.500000}
cylinder{<63.500000,0.038000,17.780000><63.500000,-1.538000,17.780000>0.500000}
cylinder{<60.960000,0.038000,17.780000><60.960000,-1.538000,17.780000>0.500000}
cylinder{<63.500000,0.038000,20.320000><63.500000,-1.538000,20.320000>0.500000}
cylinder{<60.960000,0.038000,20.320000><60.960000,-1.538000,20.320000>0.500000}
cylinder{<63.500000,0.038000,22.860000><63.500000,-1.538000,22.860000>0.500000}
cylinder{<60.960000,0.038000,22.860000><60.960000,-1.538000,22.860000>0.500000}
cylinder{<63.500000,0.038000,25.400000><63.500000,-1.538000,25.400000>0.500000}
cylinder{<60.960000,0.038000,25.400000><60.960000,-1.538000,25.400000>0.500000}
cylinder{<63.500000,0.038000,27.940000><63.500000,-1.538000,27.940000>0.500000}
cylinder{<60.960000,0.038000,27.940000><60.960000,-1.538000,27.940000>0.500000}
cylinder{<63.500000,0.038000,30.480000><63.500000,-1.538000,30.480000>0.500000}
cylinder{<60.960000,0.038000,30.480000><60.960000,-1.538000,30.480000>0.500000}
cylinder{<63.500000,0.038000,33.020000><63.500000,-1.538000,33.020000>0.500000}
cylinder{<60.960000,0.038000,33.020000><60.960000,-1.538000,33.020000>0.500000}
cylinder{<63.500000,0.038000,35.560000><63.500000,-1.538000,35.560000>0.500000}
cylinder{<60.960000,0.038000,35.560000><60.960000,-1.538000,35.560000>0.500000}
cylinder{<63.500000,0.038000,38.100000><63.500000,-1.538000,38.100000>0.500000}
cylinder{<60.960000,0.038000,38.100000><60.960000,-1.538000,38.100000>0.500000}
cylinder{<63.500000,0.038000,40.640000><63.500000,-1.538000,40.640000>0.500000}
cylinder{<60.960000,0.038000,40.640000><60.960000,-1.538000,40.640000>0.500000}
cylinder{<63.500000,0.038000,43.180000><63.500000,-1.538000,43.180000>0.500000}
cylinder{<60.960000,0.038000,43.180000><60.960000,-1.538000,43.180000>0.500000}
cylinder{<75.565000,0.038000,12.700000><75.565000,-1.538000,12.700000>0.500000}
cylinder{<73.025000,0.038000,12.700000><73.025000,-1.538000,12.700000>0.500000}
cylinder{<75.565000,0.038000,15.240000><75.565000,-1.538000,15.240000>0.500000}
cylinder{<73.025000,0.038000,15.240000><73.025000,-1.538000,15.240000>0.500000}
cylinder{<75.565000,0.038000,17.780000><75.565000,-1.538000,17.780000>0.500000}
cylinder{<73.025000,0.038000,17.780000><73.025000,-1.538000,17.780000>0.500000}
cylinder{<75.565000,0.038000,20.320000><75.565000,-1.538000,20.320000>0.500000}
cylinder{<73.025000,0.038000,20.320000><73.025000,-1.538000,20.320000>0.500000}
cylinder{<75.565000,0.038000,22.860000><75.565000,-1.538000,22.860000>0.500000}
cylinder{<73.025000,0.038000,22.860000><73.025000,-1.538000,22.860000>0.500000}
cylinder{<75.565000,0.038000,25.400000><75.565000,-1.538000,25.400000>0.500000}
cylinder{<73.025000,0.038000,25.400000><73.025000,-1.538000,25.400000>0.500000}
cylinder{<75.565000,0.038000,27.940000><75.565000,-1.538000,27.940000>0.500000}
cylinder{<73.025000,0.038000,27.940000><73.025000,-1.538000,27.940000>0.500000}
cylinder{<75.565000,0.038000,30.480000><75.565000,-1.538000,30.480000>0.500000}
cylinder{<73.025000,0.038000,30.480000><73.025000,-1.538000,30.480000>0.500000}
cylinder{<75.565000,0.038000,33.020000><75.565000,-1.538000,33.020000>0.500000}
cylinder{<73.025000,0.038000,33.020000><73.025000,-1.538000,33.020000>0.500000}
cylinder{<75.565000,0.038000,35.560000><75.565000,-1.538000,35.560000>0.500000}
cylinder{<73.025000,0.038000,35.560000><73.025000,-1.538000,35.560000>0.500000}
cylinder{<75.565000,0.038000,38.100000><75.565000,-1.538000,38.100000>0.500000}
cylinder{<73.025000,0.038000,38.100000><73.025000,-1.538000,38.100000>0.500000}
cylinder{<75.565000,0.038000,40.640000><75.565000,-1.538000,40.640000>0.500000}
cylinder{<73.025000,0.038000,40.640000><73.025000,-1.538000,40.640000>0.500000}
cylinder{<75.565000,0.038000,43.180000><75.565000,-1.538000,43.180000>0.500000}
cylinder{<73.025000,0.038000,43.180000><73.025000,-1.538000,43.180000>0.500000}
cylinder{<27.305000,0.038000,12.700000><27.305000,-1.538000,12.700000>0.500000}
cylinder{<24.765000,0.038000,12.700000><24.765000,-1.538000,12.700000>0.500000}
cylinder{<27.305000,0.038000,15.240000><27.305000,-1.538000,15.240000>0.500000}
cylinder{<24.765000,0.038000,15.240000><24.765000,-1.538000,15.240000>0.500000}
cylinder{<27.305000,0.038000,17.780000><27.305000,-1.538000,17.780000>0.500000}
cylinder{<24.765000,0.038000,17.780000><24.765000,-1.538000,17.780000>0.500000}
cylinder{<27.305000,0.038000,20.320000><27.305000,-1.538000,20.320000>0.500000}
cylinder{<24.765000,0.038000,20.320000><24.765000,-1.538000,20.320000>0.500000}
cylinder{<27.305000,0.038000,22.860000><27.305000,-1.538000,22.860000>0.500000}
cylinder{<24.765000,0.038000,22.860000><24.765000,-1.538000,22.860000>0.500000}
cylinder{<27.305000,0.038000,25.400000><27.305000,-1.538000,25.400000>0.500000}
cylinder{<24.765000,0.038000,25.400000><24.765000,-1.538000,25.400000>0.500000}
cylinder{<27.305000,0.038000,27.940000><27.305000,-1.538000,27.940000>0.500000}
cylinder{<24.765000,0.038000,27.940000><24.765000,-1.538000,27.940000>0.500000}
cylinder{<27.305000,0.038000,30.480000><27.305000,-1.538000,30.480000>0.500000}
cylinder{<24.765000,0.038000,30.480000><24.765000,-1.538000,30.480000>0.500000}
cylinder{<27.305000,0.038000,33.020000><27.305000,-1.538000,33.020000>0.500000}
cylinder{<24.765000,0.038000,33.020000><24.765000,-1.538000,33.020000>0.500000}
cylinder{<27.305000,0.038000,35.560000><27.305000,-1.538000,35.560000>0.500000}
cylinder{<24.765000,0.038000,35.560000><24.765000,-1.538000,35.560000>0.500000}
cylinder{<27.305000,0.038000,38.100000><27.305000,-1.538000,38.100000>0.500000}
cylinder{<24.765000,0.038000,38.100000><24.765000,-1.538000,38.100000>0.500000}
cylinder{<27.305000,0.038000,40.640000><27.305000,-1.538000,40.640000>0.500000}
cylinder{<24.765000,0.038000,40.640000><24.765000,-1.538000,40.640000>0.500000}
cylinder{<27.305000,0.038000,43.180000><27.305000,-1.538000,43.180000>0.500000}
cylinder{<24.765000,0.038000,43.180000><24.765000,-1.538000,43.180000>0.500000}
//Bohrungen(schnell)/Durchkontaktierungen
cylinder{<149.860000,0.038000,83.185000><149.860000,-1.538000,83.185000>0.350000 }
cylinder{<149.860000,0.038000,76.835000><149.860000,-1.538000,76.835000>0.350000 }
cylinder{<137.795000,0.038000,17.780000><137.795000,-1.538000,17.780000>0.350000 }
cylinder{<137.795000,0.038000,35.560000><137.795000,-1.538000,35.560000>0.350000 }
cylinder{<113.665000,0.038000,62.865000><113.665000,-1.538000,62.865000>0.350000 }
cylinder{<113.665000,0.038000,38.735000><113.665000,-1.538000,38.735000>0.350000 }
cylinder{<86.995000,0.038000,73.660000><86.995000,-1.538000,73.660000>0.350000 }
cylinder{<86.995000,0.038000,59.055000><86.995000,-1.538000,59.055000>0.350000 }
cylinder{<83.185000,0.038000,56.515000><83.185000,-1.538000,56.515000>0.350000 }
cylinder{<83.185000,0.038000,72.390000><83.185000,-1.538000,72.390000>0.350000 }
cylinder{<81.915000,0.038000,6.985000><81.915000,-1.538000,6.985000>0.350000 }
cylinder{<113.030000,0.038000,6.985000><113.030000,-1.538000,6.985000>0.350000 }
cylinder{<86.995000,0.038000,33.655000><86.995000,-1.538000,33.655000>0.350000 }
cylinder{<86.995000,0.038000,13.970000><86.995000,-1.538000,13.970000>0.350000 }
cylinder{<85.090000,0.038000,36.195000><85.090000,-1.538000,36.195000>0.350000 }
cylinder{<85.090000,0.038000,15.875000><85.090000,-1.538000,15.875000>0.350000 }
cylinder{<89.535000,0.038000,31.750000><89.535000,-1.538000,31.750000>0.350000 }
cylinder{<89.535000,0.038000,17.145000><89.535000,-1.538000,17.145000>0.350000 }
cylinder{<145.415000,0.038000,64.770000><145.415000,-1.538000,64.770000>0.350000 }
cylinder{<156.210000,0.038000,64.770000><156.210000,-1.538000,64.770000>0.350000 }
cylinder{<130.810000,0.038000,10.795000><130.810000,-1.538000,10.795000>0.350000 }
cylinder{<130.810000,0.038000,37.465000><130.810000,-1.538000,37.465000>0.350000 }
cylinder{<110.490000,0.038000,60.960000><110.490000,-1.538000,60.960000>0.350000 }
cylinder{<110.490000,0.038000,17.145000><110.490000,-1.538000,17.145000>0.350000 }
cylinder{<92.075000,0.038000,67.945000><92.075000,-1.538000,67.945000>0.350000 }
cylinder{<92.075000,0.038000,61.595000><92.075000,-1.538000,61.595000>0.350000 }
cylinder{<135.890000,0.038000,25.400000><135.890000,-1.538000,25.400000>0.350000 }
cylinder{<135.890000,0.038000,14.605000><135.890000,-1.538000,14.605000>0.350000 }
cylinder{<95.250000,0.038000,53.975000><95.250000,-1.538000,53.975000>0.350000 }
cylinder{<73.025000,0.038000,53.975000><73.025000,-1.538000,53.975000>0.350000 }
cylinder{<133.985000,0.038000,25.400000><133.985000,-1.538000,25.400000>0.350000 }
cylinder{<133.985000,0.038000,50.800000><133.985000,-1.538000,50.800000>0.350000 }
cylinder{<90.805000,0.038000,80.010000><90.805000,-1.538000,80.010000>0.350000 }
cylinder{<90.805000,0.038000,55.880000><90.805000,-1.538000,55.880000>0.350000 }
//Bohrungen(schnell)/Platine
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Bestückungsdruck
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<75.895200,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<75.895200,0.000000,57.150000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<75.895200,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<75.895200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<75.895200,0.000000,56.515000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<75.895200,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.895200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.676000,0.000000,57.150000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<74.676000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<76.530200,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<76.530200,0.000000,57.150000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<76.530200,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<76.530200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<76.530200,0.000000,56.515000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<76.530200,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.530200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,57.150000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<76.530200,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.517000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.517000,0.000000,55.880000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.517000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,55.626000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.771000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,58.420000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.883000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,58.674000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.771000,0.000000,58.674000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<79.629000,0.000000,58.420000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<79.629000,0.000000,55.880000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<72.771000,0.000000,55.880000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<72.771000,0.000000,58.420000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.120200,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.120200,0.000000,57.150000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<98.120200,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.120200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.120200,0.000000,56.515000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<98.120200,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.120200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.901000,0.000000,57.150000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<96.901000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.755200,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.755200,0.000000,57.150000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<98.755200,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.755200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<98.755200,0.000000,56.515000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<98.755200,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.755200,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<99.949000,0.000000,57.150000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<98.755200,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.742000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.742000,0.000000,55.880000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<94.742000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.854000,0.000000,55.626000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.996000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.108000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.108000,0.000000,58.420000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<102.108000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.854000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<94.996000,0.000000,58.674000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<94.996000,0.000000,58.674000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<101.854000,0.000000,58.420000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<101.854000,0.000000,55.880000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<94.996000,0.000000,55.880000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<94.996000,0.000000,58.420000>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,60.960000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.205200,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.205200,0.000000,60.325000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.205200,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.205200,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.986000,0.000000,60.960000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<141.986000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,60.960000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.840200,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.840200,0.000000,60.325000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<143.840200,0.000000,60.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.840200,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.034000,0.000000,60.960000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<143.840200,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,59.690000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.827000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.081000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,59.436000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.081000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.193000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<147.193000,0.000000,62.230000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<147.193000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.939000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.081000,0.000000,62.484000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.081000,0.000000,62.484000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<146.939000,0.000000,62.230000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<146.939000,0.000000,59.690000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<140.081000,0.000000,59.690000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<140.081000,0.000000,62.230000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<97.459800,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<97.459800,0.000000,10.160000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<97.459800,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<97.459800,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<97.459800,0.000000,10.795000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<97.459800,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<97.459800,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.679000,0.000000,10.160000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<97.459800,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.824800,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.824800,0.000000,10.160000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<96.824800,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.824800,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<96.824800,0.000000,10.795000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<96.824800,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.824800,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.631000,0.000000,10.160000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<95.631000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.838000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.838000,0.000000,11.430000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<100.838000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.584000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.726000,0.000000,11.684000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.726000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.472000,0.000000,8.890000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<93.472000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.726000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.584000,0.000000,8.636000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.726000,0.000000,8.636000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<93.726000,0.000000,8.890000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<93.726000,0.000000,11.430000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<100.584000,0.000000,11.430000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<100.584000,0.000000,8.890000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<123.190000,0.000000,12.369800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<122.555000,0.000000,12.369800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<122.555000,0.000000,12.369800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<122.555000,0.000000,12.369800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<121.920000,0.000000,12.369800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<121.920000,0.000000,12.369800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,12.369800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,13.589000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<122.555000,0.000000,13.589000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<123.190000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<122.555000,0.000000,11.734800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<122.555000,0.000000,11.734800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<122.555000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<121.920000,0.000000,11.734800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<121.920000,0.000000,11.734800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,11.734800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,10.541000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<122.555000,0.000000,10.541000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.825000,0.000000,15.748000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.285000,0.000000,15.748000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.285000,0.000000,15.748000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.031000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.031000,0.000000,8.636000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<121.031000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.285000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.825000,0.000000,8.382000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.285000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.079000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.079000,0.000000,15.494000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<124.079000,0.000000,15.494000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<123.825000,0.000000,8.636000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<121.285000,0.000000,8.636000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<121.285000,0.000000,15.494000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<123.825000,0.000000,15.494000>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.396000,0.000000,44.958000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.158000,0.000000,44.958000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<120.396000,0.000000,44.958000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.777000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.777000,0.000000,45.339000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<120.777000,0.000000,45.339000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.174000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.063000,0.000000,43.815000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<122.174000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.063000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.063000,0.000000,42.545000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<123.063000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.063000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.571000,0.000000,42.545000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<123.063000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.571000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.571000,0.000000,45.085000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<123.571000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.571000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.063000,0.000000,45.085000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<123.063000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.063000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.063000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<123.063000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.460000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.476000,0.000000,43.815000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.460000,0.000000,43.815000> }
difference{
cylinder{<123.825000,0,43.815000><123.825000,0.036000,43.815000>5.156200 translate<0,0.000000,0>}
cylinder{<123.825000,-0.1,43.815000><123.825000,0.135000,43.815000>5.003800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<124.333000,0.000000,43.815000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<56.515000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<56.515000,0.000000,73.025000>}
box{<0,0,-0.406400><1.270000,0.036000,0.406400> rotate<0,-90.000000,0> translate<56.515000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<56.515000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<56.515000,0.000000,65.405000>}
box{<0,0,-0.406400><1.270000,0.036000,0.406400> rotate<0,90.000000,0> translate<56.515000,0.000000,65.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,68.072000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,68.707000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.515000,0.000000,68.707000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,69.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,69.723000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.880000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,69.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,68.707000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<56.515000,0.000000,68.707000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,68.707000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,70.231000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.515000,0.000000,70.231000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,68.707000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,69.723000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<55.880000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,68.707000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,68.707000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.515000,0.000000,68.707000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,66.929000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.499000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,71.501000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.499000,0.000000,71.501000> }
object{ARC(1.534500,0.152400,114.443955,245.556045,0.036000) translate<56.134000,0.000000,69.215000>}
object{ARC(1.534500,0.152400,294.443955,425.556045,0.036000) translate<56.896000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,67.818000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.499000,0.000000,67.818000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,70.612000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.499000,0.000000,70.612000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,67.818000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.531000,0.000000,67.818000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,70.612000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.531000,0.000000,71.501000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.531000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,68.707000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,68.707000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.880000,0.000000,68.707000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-90.000000,0> translate<56.515000,0.000000,67.564000>}
box{<-0.774700,0,-0.406400><0.774700,0.036000,0.406400> rotate<0,-90.000000,0> translate<56.515000,0.000000,66.154300>}
box{<-0.774700,0,-0.406400><0.774700,0.036000,0.406400> rotate<0,-90.000000,0> translate<56.515000,0.000000,72.275700>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.139000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.139000,0.000000,60.960000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<96.139000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.981000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.981000,0.000000,78.740000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<101.981000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.139000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.981000,0.000000,78.740000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.139000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<96.139000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<98.044000,0.000000,60.960000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<96.139000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<101.981000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.076000,0.000000,60.960000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<100.076000,0.000000,60.960000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<99.060000,0.000000,60.960000>}
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,60.960000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.914000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,78.740000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.756000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,78.740000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.914000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.819000,0.000000,60.960000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.914000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.851000,0.000000,60.960000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.851000,0.000000,60.960000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<76.835000,0.000000,60.960000>}
//IC3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.444000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.444000,0.000000,62.230000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,-90.000000,0> translate<123.444000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.286000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.286000,0.000000,82.550000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,90.000000,0> translate<129.286000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.444000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.286000,0.000000,82.550000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<123.444000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.444000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<125.349000,0.000000,62.230000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<123.444000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<129.286000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.381000,0.000000,62.230000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<127.381000,0.000000,62.230000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<126.365000,0.000000,62.230000>}
//IC4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.904000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.904000,0.000000,18.415000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<120.904000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,36.195000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<126.746000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.904000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,36.195000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<120.904000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.904000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.809000,0.000000,18.415000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<120.904000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<126.746000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.841000,0.000000,18.415000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.841000,0.000000,18.415000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<123.825000,0.000000,18.415000>}
//IC10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.584000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.584000,0.000000,13.335000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,-90.000000,0> translate<100.584000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,38.735000>}
box{<0,0,-0.076200><25.400000,0.036000,0.076200> rotate<0,90.000000,0> translate<106.426000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.584000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,38.735000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<100.584000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<100.584000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.489000,0.000000,13.335000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<100.584000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.426000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<104.521000,0.000000,13.335000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<104.521000,0.000000,13.335000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<103.505000,0.000000,13.335000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.260000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<44.450000,0.000000,78.105000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<44.450000,0.000000,78.105000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<46.355000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<46.355000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<46.355000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<46.355000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<46.355000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<46.355000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<46.355000,0.000000,75.565000>}
difference{
cylinder{<46.355000,0,75.565000><46.355000,0.036000,75.565000>2.616200 translate<0,0.000000,0>}
cylinder{<46.355000,-0.1,75.565000><46.355000,0.135000,75.565000>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<39.370000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.560000,0.000000,78.105000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<35.560000,0.000000,78.105000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<37.465000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<37.465000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<37.465000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<37.465000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<37.465000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<37.465000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<37.465000,0.000000,75.565000>}
difference{
cylinder{<37.465000,0,75.565000><37.465000,0.036000,75.565000>2.616200 translate<0,0.000000,0>}
cylinder{<37.465000,-0.1,75.565000><37.465000,0.135000,75.565000>2.463800 translate<0,0.000000,0>}}
//LED3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.480000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.670000,0.000000,78.105000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<26.670000,0.000000,78.105000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<28.575000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<28.575000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<28.575000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<28.575000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<28.575000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<28.575000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<28.575000,0.000000,75.565000>}
difference{
cylinder{<28.575000,0,75.565000><28.575000,0.036000,75.565000>2.616200 translate<0,0.000000,0>}
cylinder{<28.575000,-0.1,75.565000><28.575000,0.135000,75.565000>2.463800 translate<0,0.000000,0>}}
//LED4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.590000,0.000000,78.105000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.780000,0.000000,78.105000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<17.780000,0.000000,78.105000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<19.685000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<19.685000,0.000000,75.565000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<19.685000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<19.685000,0.000000,75.565000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<19.685000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<19.685000,0.000000,75.565000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<19.685000,0.000000,75.565000>}
difference{
cylinder{<19.685000,0,75.565000><19.685000,0.036000,75.565000>2.616200 translate<0,0.000000,0>}
cylinder{<19.685000,-0.1,75.565000><19.685000,0.135000,75.565000>2.463800 translate<0,0.000000,0>}}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.770000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.786000,0.000000,81.280000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<64.770000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<73.914000,0.000000,81.280000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<73.914000,0.000000,81.280000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<72.771000,0.000000,80.391000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<72.771000,0.000000,82.169000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<66.929000,0.000000,82.169000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<66.929000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,80.391000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.025000,0.000000,80.391000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,80.137000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,80.137000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,80.137000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,80.264000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,80.137000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<72.263000,0.000000,80.264000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,82.423000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,82.423000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,82.423000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,82.296000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,82.423000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.263000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,80.264000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,80.137000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.310000,0.000000,80.137000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,80.264000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,80.264000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,80.264000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,82.296000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,82.423000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<67.310000,0.000000,82.423000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,82.296000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,82.296000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,82.296000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,80.137000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,80.137000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,80.137000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,82.423000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,82.423000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,82.423000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,80.391000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.675000,0.000000,80.391000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<66.243200,0.000000,81.280000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<73.456800,0.000000,81.280000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.770000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.786000,0.000000,84.455000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<64.770000,0.000000,84.455000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,84.455000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<73.914000,0.000000,84.455000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<73.914000,0.000000,84.455000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<72.771000,0.000000,83.566000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<72.771000,0.000000,85.344000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<66.929000,0.000000,85.344000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<66.929000,0.000000,83.566000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,83.566000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.025000,0.000000,83.566000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,83.312000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,83.312000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,83.312000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,83.312000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<72.263000,0.000000,83.439000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,85.598000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,85.598000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,85.598000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,85.471000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,85.598000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.263000,0.000000,85.471000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,83.312000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.310000,0.000000,83.312000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,83.439000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,83.439000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,85.471000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,85.598000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<67.310000,0.000000,85.598000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,85.471000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,85.471000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,85.471000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,83.312000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,83.312000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,83.312000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,85.598000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,85.598000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,85.598000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,85.344000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,83.566000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.675000,0.000000,83.566000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<66.243200,0.000000,84.455000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<73.456800,0.000000,84.455000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.770000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.786000,0.000000,87.630000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<64.770000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<73.914000,0.000000,87.630000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<73.914000,0.000000,87.630000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<72.771000,0.000000,86.741000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<72.771000,0.000000,88.519000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<66.929000,0.000000,88.519000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<66.929000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,86.741000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.025000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,86.487000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,86.487000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,86.487000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,86.487000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<72.263000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,88.773000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,88.773000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,88.773000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.263000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,86.487000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.310000,0.000000,86.487000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,86.614000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,86.614000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,86.614000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,88.773000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<67.310000,0.000000,88.773000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,88.646000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,88.646000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,88.646000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,86.487000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,86.487000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,86.487000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,88.773000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,88.773000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,88.773000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,86.741000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.675000,0.000000,86.741000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<66.243200,0.000000,87.630000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<73.456800,0.000000,87.630000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.770000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.786000,0.000000,90.805000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<64.770000,0.000000,90.805000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,90.805000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<73.914000,0.000000,90.805000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<73.914000,0.000000,90.805000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<72.771000,0.000000,89.916000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<72.771000,0.000000,91.694000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<66.929000,0.000000,91.694000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<66.929000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,89.916000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.025000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,89.662000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,89.662000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,89.662000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,89.662000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<72.263000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.771000,0.000000,91.948000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,91.948000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.390000,0.000000,91.948000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,91.948000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.263000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,89.662000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.310000,0.000000,89.662000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,89.789000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,91.948000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<67.310000,0.000000,91.948000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.263000,0.000000,91.821000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.437000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,89.662000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,89.662000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,89.662000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.929000,0.000000,91.948000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,91.948000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.929000,0.000000,91.948000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,91.694000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,89.916000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.675000,0.000000,89.916000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<66.243200,0.000000,90.805000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<73.456800,0.000000,90.805000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,12.700000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,12.700000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,12.700000> }
difference{
cylinder{<13.335000,0,12.700000><13.335000,0.036000,12.700000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,12.700000><13.335000,0.135000,12.700000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,12.700000><13.335000,0.036000,12.700000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,12.700000><13.335000,0.135000,12.700000>0.609600 translate<0,0.000000,0>}}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,12.700000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,12.700000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,12.700000> }
difference{
cylinder{<8.255000,0,12.700000><8.255000,0.036000,12.700000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,12.700000><8.255000,0.135000,12.700000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,12.700000><8.255000,0.036000,12.700000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,12.700000><8.255000,0.135000,12.700000>0.609600 translate<0,0.000000,0>}}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,15.240000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,15.240000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,15.240000> }
difference{
cylinder{<13.335000,0,15.240000><13.335000,0.036000,15.240000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,15.240000><13.335000,0.135000,15.240000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,15.240000><13.335000,0.036000,15.240000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,15.240000><13.335000,0.135000,15.240000>0.609600 translate<0,0.000000,0>}}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,15.240000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,15.240000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,15.240000> }
difference{
cylinder{<8.255000,0,15.240000><8.255000,0.036000,15.240000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,15.240000><8.255000,0.135000,15.240000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,15.240000><8.255000,0.036000,15.240000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,15.240000><8.255000,0.135000,15.240000>0.609600 translate<0,0.000000,0>}}
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,17.780000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,17.780000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,17.780000> }
difference{
cylinder{<13.335000,0,17.780000><13.335000,0.036000,17.780000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,17.780000><13.335000,0.135000,17.780000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,17.780000><13.335000,0.036000,17.780000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,17.780000><13.335000,0.135000,17.780000>0.609600 translate<0,0.000000,0>}}
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,17.780000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,17.780000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,17.780000> }
difference{
cylinder{<8.255000,0,17.780000><8.255000,0.036000,17.780000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,17.780000><8.255000,0.135000,17.780000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,17.780000><8.255000,0.036000,17.780000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,17.780000><8.255000,0.135000,17.780000>0.609600 translate<0,0.000000,0>}}
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,20.320000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,20.320000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,20.320000> }
difference{
cylinder{<13.335000,0,20.320000><13.335000,0.036000,20.320000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,20.320000><13.335000,0.135000,20.320000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,20.320000><13.335000,0.036000,20.320000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,20.320000><13.335000,0.135000,20.320000>0.609600 translate<0,0.000000,0>}}
//R12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,20.320000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,20.320000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,20.320000> }
difference{
cylinder{<8.255000,0,20.320000><8.255000,0.036000,20.320000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,20.320000><8.255000,0.135000,20.320000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,20.320000><8.255000,0.036000,20.320000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,20.320000><8.255000,0.135000,20.320000>0.609600 translate<0,0.000000,0>}}
//R13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,25.400000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,25.400000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,25.400000> }
difference{
cylinder{<13.335000,0,25.400000><13.335000,0.036000,25.400000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,25.400000><13.335000,0.135000,25.400000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,25.400000><13.335000,0.036000,25.400000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,25.400000><13.335000,0.135000,25.400000>0.609600 translate<0,0.000000,0>}}
//R14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,25.400000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,25.400000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,25.400000> }
difference{
cylinder{<8.255000,0,25.400000><8.255000,0.036000,25.400000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,25.400000><8.255000,0.135000,25.400000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,25.400000><8.255000,0.036000,25.400000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,25.400000><8.255000,0.135000,25.400000>0.609600 translate<0,0.000000,0>}}
//R15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,27.940000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,27.940000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,27.940000> }
difference{
cylinder{<13.335000,0,27.940000><13.335000,0.036000,27.940000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,27.940000><13.335000,0.135000,27.940000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,27.940000><13.335000,0.036000,27.940000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,27.940000><13.335000,0.135000,27.940000>0.609600 translate<0,0.000000,0>}}
//R16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,27.940000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,27.940000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,27.940000> }
difference{
cylinder{<8.255000,0,27.940000><8.255000,0.036000,27.940000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,27.940000><8.255000,0.135000,27.940000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,27.940000><8.255000,0.036000,27.940000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,27.940000><8.255000,0.135000,27.940000>0.609600 translate<0,0.000000,0>}}
//R17 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,30.480000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,30.480000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,30.480000> }
difference{
cylinder{<13.335000,0,30.480000><13.335000,0.036000,30.480000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,30.480000><13.335000,0.135000,30.480000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,30.480000><13.335000,0.036000,30.480000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,30.480000><13.335000,0.135000,30.480000>0.609600 translate<0,0.000000,0>}}
//R18 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,30.480000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,30.480000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,30.480000> }
difference{
cylinder{<8.255000,0,30.480000><8.255000,0.036000,30.480000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,30.480000><8.255000,0.135000,30.480000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,30.480000><8.255000,0.036000,30.480000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,30.480000><8.255000,0.135000,30.480000>0.609600 translate<0,0.000000,0>}}
//R19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,33.020000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,33.020000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,33.020000> }
difference{
cylinder{<13.335000,0,33.020000><13.335000,0.036000,33.020000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,33.020000><13.335000,0.135000,33.020000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,33.020000><13.335000,0.036000,33.020000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,33.020000><13.335000,0.135000,33.020000>0.609600 translate<0,0.000000,0>}}
//R20 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,33.020000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,33.020000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,33.020000> }
difference{
cylinder{<8.255000,0,33.020000><8.255000,0.036000,33.020000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,33.020000><8.255000,0.135000,33.020000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,33.020000><8.255000,0.036000,33.020000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,33.020000><8.255000,0.135000,33.020000>0.609600 translate<0,0.000000,0>}}
//R21 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,35.560000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,35.560000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,35.560000> }
difference{
cylinder{<13.335000,0,35.560000><13.335000,0.036000,35.560000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,35.560000><13.335000,0.135000,35.560000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,35.560000><13.335000,0.036000,35.560000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,35.560000><13.335000,0.135000,35.560000>0.609600 translate<0,0.000000,0>}}
//R22 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,35.560000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,35.560000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,35.560000> }
difference{
cylinder{<8.255000,0,35.560000><8.255000,0.036000,35.560000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,35.560000><8.255000,0.135000,35.560000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,35.560000><8.255000,0.036000,35.560000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,35.560000><8.255000,0.135000,35.560000>0.609600 translate<0,0.000000,0>}}
//R23 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,38.100000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,38.100000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,38.100000> }
difference{
cylinder{<13.335000,0,38.100000><13.335000,0.036000,38.100000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,38.100000><13.335000,0.135000,38.100000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,38.100000><13.335000,0.036000,38.100000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,38.100000><13.335000,0.135000,38.100000>0.609600 translate<0,0.000000,0>}}
//R24 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,38.100000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,38.100000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,38.100000> }
difference{
cylinder{<8.255000,0,38.100000><8.255000,0.036000,38.100000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,38.100000><8.255000,0.135000,38.100000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,38.100000><8.255000,0.036000,38.100000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,38.100000><8.255000,0.135000,38.100000>0.609600 translate<0,0.000000,0>}}
//R25 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,40.640000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,40.640000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,40.640000> }
difference{
cylinder{<13.335000,0,40.640000><13.335000,0.036000,40.640000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,40.640000><13.335000,0.135000,40.640000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,40.640000><13.335000,0.036000,40.640000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,40.640000><13.335000,0.135000,40.640000>0.609600 translate<0,0.000000,0>}}
//R26 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,40.640000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,40.640000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,40.640000> }
difference{
cylinder{<8.255000,0,40.640000><8.255000,0.036000,40.640000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,40.640000><8.255000,0.135000,40.640000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,40.640000><8.255000,0.036000,40.640000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,40.640000><8.255000,0.135000,40.640000>0.609600 translate<0,0.000000,0>}}
//R27 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<13.335000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.875000,0.000000,43.180000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<13.335000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.478000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<14.732000,0.000000,43.180000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<14.478000,0.000000,43.180000> }
difference{
cylinder{<13.335000,0,43.180000><13.335000,0.036000,43.180000>0.965200 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,43.180000><13.335000,0.135000,43.180000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<13.335000,0,43.180000><13.335000,0.036000,43.180000>0.660400 translate<0,0.000000,0>}
cylinder{<13.335000,-0.1,43.180000><13.335000,0.135000,43.180000>0.609600 translate<0,0.000000,0>}}
//R28 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.255000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<10.795000,0.000000,43.180000>}
box{<0,0,-0.254000><2.540000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.255000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.398000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.652000,0.000000,43.180000>}
box{<0,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,0.000000,0> translate<9.398000,0.000000,43.180000> }
difference{
cylinder{<8.255000,0,43.180000><8.255000,0.036000,43.180000>0.965200 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,43.180000><8.255000,0.135000,43.180000>0.812800 translate<0,0.000000,0>}}
difference{
cylinder{<8.255000,0,43.180000><8.255000,0.036000,43.180000>0.660400 translate<0,0.000000,0>}
cylinder{<8.255000,-0.1,43.180000><8.255000,0.135000,43.180000>0.609600 translate<0,0.000000,0>}}
//R30 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.595000,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.595000,0.000000,65.151000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<61.595000,0.000000,65.151000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.595000,0.000000,74.295000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.595000,0.000000,73.279000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<61.595000,0.000000,73.279000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<62.484000,0.000000,72.136000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<60.706000,0.000000,72.136000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<60.706000,0.000000,66.294000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<62.484000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.484000,0.000000,72.390000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.706000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,71.755000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.738000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.611000,0.000000,71.628000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,71.755000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.611000,0.000000,71.628000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,72.136000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,71.755000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.452000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.579000,0.000000,71.628000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,71.755000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<60.452000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.611000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,66.675000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<62.611000,0.000000,66.802000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.611000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.611000,0.000000,71.628000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.611000,0.000000,71.628000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.579000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,66.675000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<60.452000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.579000,0.000000,66.802000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.579000,0.000000,71.628000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.579000,0.000000,71.628000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,66.675000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.738000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,66.675000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.452000,0.000000,66.675000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.706000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.484000,0.000000,66.040000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.706000,0.000000,66.040000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<61.595000,0.000000,65.608200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<61.595000,0.000000,72.821800>}
//SL1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,68.834000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,68.961000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.367000,0.000000,68.834000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,69.215000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.494000,0.000000,68.961000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,69.469000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<142.494000,0.000000,69.469000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,69.596000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<142.367000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,68.961000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,68.961000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,66.929000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,68.961000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,68.961000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,69.469000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,69.469000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,66.929000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,66.929000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,66.929000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.923000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,67.310000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,67.310000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,68.580000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,68.580000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,68.580000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,67.310000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,67.310000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,68.580000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,68.580000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,68.580000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,68.580000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,68.580000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,69.850000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,69.850000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,68.580000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,68.961000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,68.961000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,69.469000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,69.469000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,69.850000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,66.929000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,67.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,67.310000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,67.310000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,66.929000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,66.929000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,67.691000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,67.691000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,67.691000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,67.691000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,67.691000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,68.199000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,68.199000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,67.691000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,67.691000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,70.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,70.231000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,70.231000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,70.739000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,69.469000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,69.469000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,68.961000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,68.961000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,71.501000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,72.009000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,74.041000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,72.009000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,74.041000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.041000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,73.660000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,73.660000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.120000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,71.120000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,72.390000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,72.390000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,72.390000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.501000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,72.009000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,72.390000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.041000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,73.660000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,72.771000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,72.771000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,72.771000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,73.279000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,74.041000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,73.279000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,73.279000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,73.279000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,73.279000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,72.771000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,72.771000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,72.009000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,72.771000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,72.771000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,71.501000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,71.501000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,71.501000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,70.739000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,70.231000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,70.231000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,70.231000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,70.231000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,69.469000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,69.469000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,68.199000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,68.199000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,68.834000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,66.929000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,66.929000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,71.501000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,72.009000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,69.469000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,69.469000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,68.961000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,68.961000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,71.501000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,72.009000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,72.009000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,71.120000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,69.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,68.580000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,68.580000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,71.501000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<146.431000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,72.390000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,72.390000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,71.501000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,71.501000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,71.501000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,76.581000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,74.549000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,76.581000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,77.089000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.549000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,76.200000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.930000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,76.200000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,76.200000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,77.470000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,77.470000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,76.581000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,77.089000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,77.470000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,77.470000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.549000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,74.930000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,75.311000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,75.311000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,75.311000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,75.311000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,75.311000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,75.819000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,75.819000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,75.819000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,75.819000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,75.311000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,75.311000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,77.851000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,77.851000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,77.851000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,78.359000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,78.359000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,77.089000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,76.581000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,89.535000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,89.789000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<142.494000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,89.916000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<142.367000,0.000000,89.916000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,89.281000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,89.789000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,89.789000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,89.916000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,91.821000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,91.821000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,91.821000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.923000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,91.440000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,91.821000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,91.440000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,91.440000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,88.900000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,88.900000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,90.170000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,90.170000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,90.170000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,89.281000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,89.789000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,90.170000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,91.821000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,91.440000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,91.440000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,91.440000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,91.821000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,91.821000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,90.551000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,90.551000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,90.551000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,91.059000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,91.821000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,91.821000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,91.059000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,91.059000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,91.059000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,91.059000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,90.551000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,90.551000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,89.789000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,90.551000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,90.551000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,89.281000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,89.281000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,89.154000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,89.281000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.367000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,89.535000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.494000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,78.359000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,77.851000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,77.851000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,77.851000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,77.851000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,77.089000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,75.819000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,75.819000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,76.581000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,77.089000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,76.581000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,76.581000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,89.281000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,89.789000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,89.789000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,89.789000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,76.200000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,76.200000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,88.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,90.170000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,90.170000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,89.281000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,72.009000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,74.041000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,76.581000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,77.089000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,74.041000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,74.041000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,74.549000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,74.041000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,74.930000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,73.660000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,74.041000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,74.041000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,74.041000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,74.041000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,74.041000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,74.041000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,74.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,74.549000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,74.549000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,79.121000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,79.121000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,77.089000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,77.089000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,79.629000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,79.121000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,79.121000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,79.629000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,79.629000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,79.629000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,78.740000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,77.470000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,78.740000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,78.740000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,80.010000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,80.010000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,78.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,79.121000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,79.121000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,79.629000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,79.629000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,79.629000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,80.010000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,80.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,80.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,80.391000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,80.391000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,80.899000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,80.899000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,80.899000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,79.629000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,79.629000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,79.629000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,79.121000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,79.121000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,80.899000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,80.391000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,80.391000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,79.629000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,80.391000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,80.391000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,79.629000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,79.629000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,78.359000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,78.359000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,77.089000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,79.121000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,79.121000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,79.629000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,79.629000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,79.629000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,79.121000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,79.121000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,78.740000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,78.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,79.121000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,79.629000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,79.629000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,81.661000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,81.661000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,79.629000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,79.629000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,81.661000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,81.661000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,82.169000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,81.280000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,80.010000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,81.280000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,81.280000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,82.550000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,82.550000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,81.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,81.661000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,81.661000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,82.169000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,82.550000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,82.550000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,82.931000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,82.931000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,82.931000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,83.439000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,83.439000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,82.169000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,81.661000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,81.661000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,83.439000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,82.931000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,82.931000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,82.931000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,82.931000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,82.169000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,80.899000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,80.899000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,79.629000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,81.661000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,81.661000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,82.169000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,81.661000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,81.661000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,81.280000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,81.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,81.661000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,82.169000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,84.201000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,82.169000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,82.169000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,84.201000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,84.709000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,83.820000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,82.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,83.820000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,83.820000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,85.090000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,85.090000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,83.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,84.201000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,84.709000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,85.090000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,85.090000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,85.471000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,85.471000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,85.471000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,85.979000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,85.979000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,85.979000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,84.709000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,84.201000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,85.979000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,85.471000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,85.471000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,85.471000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,85.471000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,84.709000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,83.439000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,83.439000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,82.169000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,84.201000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,84.709000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,84.201000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,84.201000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,83.820000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,83.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,84.201000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,84.709000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,86.741000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,84.709000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,84.709000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,86.741000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,87.249000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,86.360000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,85.090000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,86.360000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,86.360000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,87.630000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,87.630000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,86.360000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,86.741000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,87.249000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,87.630000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,87.630000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,88.011000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,88.011000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,88.011000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,88.519000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,88.519000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,87.249000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,86.741000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,88.011000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,88.011000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,88.011000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,88.011000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,87.249000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,85.979000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,85.979000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,84.709000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,86.741000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,87.249000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,86.741000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,86.741000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,86.360000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,86.360000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,86.741000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,87.249000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,87.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,88.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,89.281000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,89.281000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,87.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,89.154000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,89.154000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,87.630000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,88.900000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,88.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,89.281000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,87.249000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,87.249000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,67.945000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,70.485000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,73.025000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,75.565000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,78.105000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,83.185000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,80.645000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,90.805000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,85.725000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,88.265000>}
//SL2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,7.366000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.367000,0.000000,7.239000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,7.620000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.494000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,7.874000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<142.494000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,8.001000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<142.367000,0.000000,8.001000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,7.366000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,5.334000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,7.366000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,7.874000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,5.334000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,5.334000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,5.334000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.923000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,5.715000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,6.985000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,5.715000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,6.985000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,6.985000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,8.255000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,8.255000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,7.366000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,7.874000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,8.255000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,5.334000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,5.715000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,5.334000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,6.096000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,6.096000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,6.604000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,6.096000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,8.636000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,9.144000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,7.874000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,7.366000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,9.906000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,10.414000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,10.414000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.446000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,10.795000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,9.906000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,10.414000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,10.795000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.446000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,12.065000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,11.176000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,11.176000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,12.446000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,11.684000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,11.176000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,10.414000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,11.176000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,9.906000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,9.906000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,8.636000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,8.636000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,7.874000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,6.604000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,6.604000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,5.334000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,8.001000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,9.906000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,10.414000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,7.874000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,7.874000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,7.366000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,9.906000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,10.414000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,6.985000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,9.906000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<146.431000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,12.954000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.954000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,15.875000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,15.875000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.954000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,13.335000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,13.716000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,13.716000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,14.224000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,13.716000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,16.764000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,15.494000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,23.114000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<142.494000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,23.241000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<142.367000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,22.606000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,23.114000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,25.146000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,25.146000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,25.146000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.923000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,24.765000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,25.146000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,22.225000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,23.495000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,22.606000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,23.114000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,23.495000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,25.146000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,24.765000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,25.146000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,23.876000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,25.146000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,24.384000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,23.114000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,23.876000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,22.606000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,22.606000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.367000,0.000000,22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,22.860000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.494000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,16.256000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,16.256000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,14.224000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,14.986000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,15.494000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,14.986000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,22.606000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,23.114000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,23.495000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,22.606000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,12.446000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,15.494000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,12.446000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,12.446000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,12.954000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,15.494000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,17.526000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,17.145000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,18.415000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,17.526000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,18.415000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,18.796000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,19.304000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,18.034000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,17.526000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,18.796000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,18.796000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,16.764000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,17.526000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,18.034000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,17.526000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,18.034000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,18.034000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,20.066000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,19.685000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,20.955000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.066000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.955000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,21.336000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,21.844000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,20.574000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,20.066000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,21.336000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,21.336000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,19.304000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,20.066000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.574000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,20.066000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,20.574000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,22.606000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,22.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,22.479000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,20.574000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,20.574000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,6.350000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,8.890000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,11.430000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,13.970000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,16.510000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,21.590000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,19.050000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,24.130000>}
//SL3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,36.576000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.367000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,36.830000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.494000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,37.084000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<142.494000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,37.211000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<142.367000,0.000000,37.211000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,36.576000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,34.544000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,36.576000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,37.084000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,34.544000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,34.544000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,34.544000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.923000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,34.925000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,36.195000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,36.195000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,36.195000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,37.465000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,36.576000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,37.084000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,37.465000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,34.544000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,34.925000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,34.544000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,34.544000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,35.306000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,35.306000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,35.306000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,35.814000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,35.306000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,35.306000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,37.846000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,38.354000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,37.084000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,36.576000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,39.116000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,39.624000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,39.624000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,41.656000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,38.735000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,39.116000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,40.005000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,41.656000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,41.275000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,40.386000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,41.656000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,40.894000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,40.386000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,39.624000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,40.386000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,39.116000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,39.116000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,39.116000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,37.846000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,37.846000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,37.084000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,35.814000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,34.544000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,34.544000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,37.211000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,39.116000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,39.624000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,37.084000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,36.576000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,39.116000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,39.624000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,38.735000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,36.195000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,39.116000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<146.431000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,39.116000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,39.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,42.164000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,44.196000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,42.164000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,43.815000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,45.085000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,44.196000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,44.704000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,45.085000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,42.164000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,42.545000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,42.926000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,42.926000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,43.434000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,42.926000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,45.466000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,45.974000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,44.704000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,44.196000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,52.324000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<142.494000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,52.451000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<142.367000,0.000000,52.451000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,51.816000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,52.324000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,54.356000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,54.356000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,54.356000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.923000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,53.975000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,54.356000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,51.435000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,52.705000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,51.816000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,52.324000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,52.705000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,54.356000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,53.975000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,54.356000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,54.356000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,53.086000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,54.356000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,53.594000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,53.594000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,53.086000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,52.324000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,53.086000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,51.816000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,51.689000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,51.816000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.367000,0.000000,51.689000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.748000,0.000000,52.070000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<142.494000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,45.466000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,45.466000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,44.704000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,43.434000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,44.196000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,44.704000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,44.196000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,44.196000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,51.816000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.494000,0.000000,52.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,52.324000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.494000,0.000000,52.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,43.815000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,52.705000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.923000,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,51.816000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,41.656000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,44.196000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,44.704000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.669000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.367000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,41.656000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.732000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,41.656000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,42.164000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,42.164000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,44.704000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,44.704000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,46.736000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,46.355000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,46.355000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,47.625000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,46.736000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,47.244000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,47.625000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,48.006000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,48.514000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,47.244000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,46.736000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,48.514000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,48.006000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,48.006000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,47.244000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,45.974000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,44.704000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,46.736000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,47.244000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,46.736000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,46.736000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,46.355000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,47.244000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,47.244000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,49.276000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.304000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.304000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<146.304000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,48.895000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,48.895000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.669000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,50.165000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<145.415000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,48.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,49.276000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,50.165000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.669000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,50.546000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,50.546000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,51.054000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.478000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,49.784000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,49.276000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.605000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.478000,0.000000,50.546000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.478000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,50.546000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,50.546000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.732000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.732000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,48.514000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.605000,0.000000,48.514000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,49.276000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,49.784000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.669000,0.000000,49.276000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<142.367000,0.000000,49.276000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.923000,0.000000,48.895000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.923000,0.000000,48.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,49.276000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,49.784000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,49.784000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.605000,0.000000,51.816000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<141.605000,0.000000,51.816000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.367000,0.000000,51.689000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<142.367000,0.000000,51.689000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,51.435000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,51.816000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<146.431000,0.000000,49.784000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<146.431000,0.000000,49.784000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,35.560000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,38.100000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,40.640000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,43.180000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,45.720000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,50.800000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,48.260000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<144.145000,0.000000,53.340000>}
//SL4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,58.801000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.827000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,59.055000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.954000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,59.309000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<12.954000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,59.436000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<12.827000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,56.769000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.891000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,58.801000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,56.769000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,56.769000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.827000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,56.769000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.383000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.383000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.875000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,58.801000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.129000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.129000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,59.690000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.129000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,56.769000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.129000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,56.769000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,57.531000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,57.531000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.938000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,58.039000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.938000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,57.531000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.938000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,60.071000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.938000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,60.579000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.938000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,61.849000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<12.954000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,61.976000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<12.827000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,61.849000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.891000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,63.881000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.827000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,63.881000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.383000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,63.500000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.383000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,63.881000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.827000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,63.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.875000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,61.341000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.129000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,61.849000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.129000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.129000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,63.881000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.129000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,63.881000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.129000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,62.611000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.938000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,63.119000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.938000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,62.611000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.938000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,62.611000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.192000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.065000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,61.341000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.827000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,61.595000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.954000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,61.341000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.938000,0.000000,60.071000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.938000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,60.071000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.065000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.192000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.192000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,58.039000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.065000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,56.769000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.827000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.827000,0.000000,61.214000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.827000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,59.309000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.954000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,58.801000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.954000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,61.341000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.954000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.954000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.129000,0.000000,61.849000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.954000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,60.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.875000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.383000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,61.341000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.891000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.383000,0.000000,62.230000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.383000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.891000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.764000,0.000000,61.341000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<14.605000,0.000000,57.785000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<14.605000,0.000000,60.325000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<14.605000,0.000000,62.865000>}
//SL5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,58.801000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,59.055000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.479000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,59.309000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<22.479000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,59.436000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.289000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,56.769000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,58.801000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.289000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.289000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,56.769000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,56.769000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.352000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,56.769000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.908000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.908000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,58.801000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,59.690000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,56.769000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.654000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,56.769000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,57.531000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.590000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,57.531000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.463000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,58.039000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.463000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,57.531000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.463000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,60.071000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.463000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,60.579000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.463000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,61.849000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<22.479000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,61.976000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.289000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.289000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,61.849000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,63.881000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.352000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,63.881000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.908000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,63.500000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.908000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,63.881000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.352000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,63.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,61.341000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,61.849000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,63.881000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.654000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.400000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,63.881000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.654000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,62.611000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.463000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.590000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,63.119000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.463000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,62.611000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.463000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,62.611000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.590000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.717000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,61.341000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,61.595000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.479000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,61.341000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.590000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.463000,0.000000,60.071000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.463000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,60.071000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.590000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.717000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.717000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,58.039000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.590000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,56.769000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.352000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,61.214000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.352000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,59.309000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,58.801000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,61.341000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,61.849000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,60.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.908000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,61.341000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.416000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,62.230000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.908000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.289000,0.000000,61.341000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<24.130000,0.000000,57.785000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<24.130000,0.000000,60.325000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<24.130000,0.000000,62.865000>}
//SL6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,58.801000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.877000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.258000,0.000000,59.055000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.004000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.258000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,59.309000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<32.004000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,59.436000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<31.877000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,56.769000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.941000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,58.801000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.814000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,56.769000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,56.769000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.877000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,56.769000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.433000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.433000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.925000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,58.801000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.179000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.179000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,59.690000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.179000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,56.769000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.179000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,56.769000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,57.531000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,57.531000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.988000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,58.039000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.988000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,57.531000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.988000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,60.071000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.988000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,60.579000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.988000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.258000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,61.849000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<32.004000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,61.976000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<31.877000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.814000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,61.849000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.941000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,63.881000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.877000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,63.881000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.433000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,63.500000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.433000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,63.881000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.877000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,63.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.925000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,61.341000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.179000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,61.849000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.179000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.179000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,63.881000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.179000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,63.881000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.179000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,62.611000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.988000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,63.119000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.988000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,62.611000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.988000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,62.611000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.242000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,61.341000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.877000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.258000,0.000000,61.595000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.004000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,61.341000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,60.071000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.988000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,60.071000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.242000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.242000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,58.039000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.115000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,56.769000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.877000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,61.214000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.877000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,59.309000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.004000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,58.801000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.004000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,61.341000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.004000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.179000,0.000000,61.849000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.004000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,60.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.925000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.433000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,61.341000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.941000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.433000,0.000000,62.230000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.433000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.814000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.814000,0.000000,61.341000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<33.655000,0.000000,57.785000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<33.655000,0.000000,60.325000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<33.655000,0.000000,62.865000>}
//SL7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,58.801000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.402000,0.000000,58.674000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,59.055000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.529000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,59.055000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,59.309000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<41.529000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,59.436000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<41.402000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,56.769000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.466000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,58.801000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.339000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,56.769000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,56.769000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.402000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,56.769000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.958000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.450000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,58.420000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,59.690000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,58.801000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,59.690000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,56.769000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.704000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,57.150000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,56.769000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,57.531000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,57.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,57.531000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.513000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,58.039000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.513000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,57.531000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.513000,0.000000,57.531000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,60.071000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,60.071000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.513000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,60.579000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.513000,0.000000,60.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,59.309000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,58.801000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,61.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,61.849000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<41.529000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,61.976000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<41.402000,0.000000,61.976000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.339000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,61.849000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.466000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,63.881000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.402000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,63.881000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,63.500000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.958000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,63.881000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.402000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,63.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.450000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,60.960000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,62.230000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,61.341000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,61.849000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,63.881000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,63.500000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,63.881000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,63.881000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.704000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,62.611000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.513000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,63.881000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,63.881000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,63.119000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.513000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,62.611000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.513000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,61.849000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,62.611000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,62.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,61.341000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.767000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,61.341000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.402000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.783000,0.000000,61.595000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.529000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,61.341000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,60.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.513000,0.000000,60.071000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.513000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,60.071000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,60.071000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,59.309000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.767000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,58.039000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.640000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,58.674000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,56.769000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.402000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,61.214000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.402000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,59.309000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.529000,0.000000,59.309000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,58.801000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,58.801000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.529000,0.000000,58.801000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,61.341000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.529000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.529000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,61.849000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.529000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,60.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.450000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,58.420000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.958000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,59.309000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,61.341000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.466000,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,62.230000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.958000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.466000,0.000000,61.341000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,61.341000> }
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<43.180000,0.000000,57.785000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<43.180000,0.000000,60.325000>}
box{<-0.330200,0,-0.330200><0.330200,0.036000,0.330200> rotate<0,-90.000000,0> translate<43.180000,0.000000,62.865000>}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,13.357000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.900000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.900000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,38.757000>}
box{<0,0,-0.101600><21.634000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.900000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.900000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,48.100000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.900000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,48.100000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<33.900000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,42.768000>}
box{<0,0,-0.101600><5.332000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.300000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,42.768000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.000000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,41.289000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.000000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,41.289000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.000000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,29.823000>}
box{<0,0,-0.101600><11.466000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.300000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.750000,0.000000,29.823000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.750000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.750000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.750000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<40.750000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.750000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,26.057000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<40.750000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.300000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,14.828000>}
box{<0,0,-0.101600><11.229000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.300000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,7.780000>}
box{<0,0,-0.101600><5.569000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.300000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,7.780000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<33.900000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,13.350000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.825000,0.000000,13.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,17.125000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,38.755000>}
box{<0,0,-0.101600><21.630000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.825000,0.000000,38.755000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,42.530000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,46.975000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.825000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.375000,0.000000,46.975000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.825000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.375000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.375000,0.000000,29.823000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<41.375000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.375000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.375000,0.000000,8.905000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<41.375000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.375000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.825000,0.000000,8.905000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.825000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,14.828000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.000000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,13.349000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.000000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.000000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.300000,0.000000,13.349000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.000000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,13.357000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<33.900000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.450000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,17.123000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<33.900000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,38.757000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<33.900000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.450000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.450000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.900000,0.000000,42.523000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<33.900000,0.000000,42.523000> }
//X2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,13.357000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<45.965000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<45.965000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,38.757000>}
box{<0,0,-0.101600><21.634000,0.036000,0.101600> rotate<0,90.000000,0> translate<45.965000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<45.965000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,48.100000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<45.965000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,48.100000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.965000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,42.768000>}
box{<0,0,-0.101600><5.332000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.365000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,42.768000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<54.065000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,41.289000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.065000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,41.289000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<54.065000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,29.823000>}
box{<0,0,-0.101600><11.466000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.365000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.815000,0.000000,29.823000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<52.815000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.815000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.815000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<52.815000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.815000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,26.057000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<52.815000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.365000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,14.828000>}
box{<0,0,-0.101600><11.229000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.365000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,7.780000>}
box{<0,0,-0.101600><5.569000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.365000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,7.780000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.965000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,13.350000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<46.890000,0.000000,13.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,17.125000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,38.755000>}
box{<0,0,-0.101600><21.630000,0.036000,0.101600> rotate<0,90.000000,0> translate<46.890000,0.000000,38.755000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,42.530000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,46.975000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<46.890000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.440000,0.000000,46.975000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.890000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.440000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.440000,0.000000,29.823000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<53.440000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.440000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.440000,0.000000,8.905000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<53.440000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.440000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.890000,0.000000,8.905000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.890000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,14.828000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<54.065000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,13.349000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<54.065000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.065000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.365000,0.000000,13.349000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<54.065000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,13.357000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.965000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<47.515000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,17.123000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.965000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,38.757000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.965000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<47.515000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.515000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.965000,0.000000,42.523000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.965000,0.000000,42.523000> }
//X3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,13.357000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.030000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.030000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,38.757000>}
box{<0,0,-0.101600><21.634000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.030000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.030000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,48.100000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.030000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,48.100000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.030000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,42.768000>}
box{<0,0,-0.101600><5.332000,0.036000,0.101600> rotate<0,-90.000000,0> translate<66.430000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,42.768000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<66.130000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,41.289000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<66.130000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,41.289000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<66.130000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,29.823000>}
box{<0,0,-0.101600><11.466000,0.036000,0.101600> rotate<0,-90.000000,0> translate<66.430000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<64.880000,0.000000,29.823000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<64.880000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<64.880000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<64.880000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<64.880000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<64.880000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,26.057000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<64.880000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<66.430000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,14.828000>}
box{<0,0,-0.101600><11.229000,0.036000,0.101600> rotate<0,-90.000000,0> translate<66.430000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,7.780000>}
box{<0,0,-0.101600><5.569000,0.036000,0.101600> rotate<0,-90.000000,0> translate<66.430000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,7.780000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.030000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,13.350000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.955000,0.000000,13.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,17.125000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,38.755000>}
box{<0,0,-0.101600><21.630000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.955000,0.000000,38.755000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,42.530000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,46.975000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.955000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<65.505000,0.000000,46.975000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.955000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<65.505000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<65.505000,0.000000,29.823000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<65.505000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<65.505000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<65.505000,0.000000,8.905000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<65.505000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<65.505000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.955000,0.000000,8.905000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.955000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,14.828000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<66.130000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,13.349000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<66.130000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.130000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<66.430000,0.000000,13.349000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<66.130000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,13.357000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.030000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<59.580000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,17.123000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.030000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,38.757000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.030000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<59.580000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<59.580000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.030000,0.000000,42.523000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.030000,0.000000,42.523000> }
//X4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,13.357000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<70.095000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<70.095000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,38.757000>}
box{<0,0,-0.101600><21.634000,0.036000,0.101600> rotate<0,90.000000,0> translate<70.095000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<70.095000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,48.100000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<70.095000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,48.100000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<70.095000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,42.768000>}
box{<0,0,-0.101600><5.332000,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.495000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,42.768000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<78.195000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,41.289000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.195000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,41.289000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<78.195000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,29.823000>}
box{<0,0,-0.101600><11.466000,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.495000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<76.945000,0.000000,29.823000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<76.945000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<76.945000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<76.945000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<76.945000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<76.945000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,26.057000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<76.945000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.495000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,14.828000>}
box{<0,0,-0.101600><11.229000,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.495000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,7.780000>}
box{<0,0,-0.101600><5.569000,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.495000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,7.780000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<70.095000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,13.350000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<71.020000,0.000000,13.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,17.125000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,38.755000>}
box{<0,0,-0.101600><21.630000,0.036000,0.101600> rotate<0,90.000000,0> translate<71.020000,0.000000,38.755000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,42.530000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,46.975000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<71.020000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<77.570000,0.000000,46.975000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<71.020000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<77.570000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<77.570000,0.000000,29.823000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<77.570000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<77.570000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<77.570000,0.000000,8.905000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<77.570000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<77.570000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.020000,0.000000,8.905000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<71.020000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,14.828000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<78.195000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,13.349000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.195000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.195000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.495000,0.000000,13.349000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<78.195000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,13.357000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<70.095000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<71.645000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,17.123000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<70.095000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,38.757000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<70.095000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<71.645000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.645000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<70.095000,0.000000,42.523000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<70.095000,0.000000,42.523000> }
//X5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,13.357000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<21.835000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<21.835000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,38.757000>}
box{<0,0,-0.101600><21.634000,0.036000,0.101600> rotate<0,90.000000,0> translate<21.835000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<21.835000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,48.100000>}
box{<0,0,-0.101600><5.577000,0.036000,0.101600> rotate<0,90.000000,0> translate<21.835000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,48.100000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.835000,0.000000,48.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,48.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,42.768000>}
box{<0,0,-0.101600><5.332000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.235000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,42.768000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.935000,0.000000,42.768000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,42.768000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,41.289000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<29.935000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,41.289000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.935000,0.000000,41.289000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,41.289000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,29.823000>}
box{<0,0,-0.101600><11.466000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.235000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.685000,0.000000,29.823000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<28.685000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.685000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.685000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<28.685000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.685000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,26.057000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<28.685000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,29.823000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,26.057000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.235000,0.000000,26.057000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,14.828000>}
box{<0,0,-0.101600><11.229000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.235000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,7.780000>}
box{<0,0,-0.101600><5.569000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.235000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,7.780000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,7.780000>}
box{<0,0,-0.101600><8.400000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.835000,0.000000,7.780000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,13.350000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<22.760000,0.000000,13.350000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,17.125000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,38.755000>}
box{<0,0,-0.101600><21.630000,0.036000,0.101600> rotate<0,90.000000,0> translate<22.760000,0.000000,38.755000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,42.530000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,46.975000>}
box{<0,0,-0.101600><4.445000,0.036000,0.101600> rotate<0,90.000000,0> translate<22.760000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.310000,0.000000,46.975000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<22.760000,0.000000,46.975000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.310000,0.000000,46.975000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.310000,0.000000,29.823000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<29.310000,0.000000,29.823000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.310000,0.000000,26.057000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.310000,0.000000,8.905000>}
box{<0,0,-0.101600><17.152000,0.036000,0.101600> rotate<0,-90.000000,0> translate<29.310000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.310000,0.000000,8.905000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.760000,0.000000,8.905000>}
box{<0,0,-0.101600><6.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<22.760000,0.000000,8.905000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,14.828000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.935000,0.000000,14.828000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,14.828000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,13.349000>}
box{<0,0,-0.101600><1.479000,0.036000,0.101600> rotate<0,-90.000000,0> translate<29.935000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.935000,0.000000,13.349000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.235000,0.000000,13.349000>}
box{<0,0,-0.101600><0.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.935000,0.000000,13.349000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,13.357000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.835000,0.000000,13.357000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,13.357000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,17.123000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<23.385000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,17.123000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,17.123000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.835000,0.000000,17.123000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,38.757000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.835000,0.000000,38.757000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,38.757000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,42.523000>}
box{<0,0,-0.101600><3.766000,0.036000,0.101600> rotate<0,90.000000,0> translate<23.385000,0.000000,42.523000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.385000,0.000000,42.523000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.835000,0.000000,42.523000>}
box{<0,0,-0.101600><1.550000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.835000,0.000000,42.523000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  Z80_BUSSES(-80.000000,0,-50.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//D1	1N5061	SOD57-10
