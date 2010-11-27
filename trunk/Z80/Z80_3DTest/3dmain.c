#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "3dmain.h"
#include "utils3d.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"
#include "io.h"
#include "defs.h"

/******************************************************************************/
void start3d(void) {

	struct vector v1, v2, v3, v4;
	struct point p;

	v1.x = -40;
	v1.y = -40;
	v1.z = 0;

	v2.x = 40;
	v2.y = -40;
	v2.z = 0;

	v3.x = -40;
	v3.y = 40;
	v3.z = 0;

	v4.x = 40;
	v4.y = 40;
	v4.z = 0;

	while (io_read(128) == 255) {
		clrbuf();

		init_rotation(0, 0, 0);

		rotate(&v1);
		rotate(&v2);
		rotate(&v3);
		rotate(&v4);

		vec2point(&v1, &p);
		setpoint(&p);

		vec2point(&v2, &p);
		setpoint(&p);

		vec2point(&v3, &p);
		setpoint(&p);

		vec2point(&v4, &p);
		setpoint(&p);

		buf2screen();
	}
}
/******************************************************************************/

