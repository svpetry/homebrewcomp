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

struct vector vertices[MAX_VERT];
byte edges[MAX_EDGE][2];

int vert_count, edge_count;
char line_buf[LINE_BUF_SIZE];

/******************************************************************************/
byte file_read_line()
{
	byte i;
	char *p;
	char c;

	if (param1l == 0) return 0;

	do
	{
		// read blanks
		do
		{
			c = io_read(163);
			param1l--;
		}
		while (param1l > 0 && (c == 0x0a || c == 0x0d || c == 0x20));

		// read next line
		i = 0;
		p = line_buf;
		while (param1l > 0 && c != 0x0a && c != 0x0d)
		{
			if (i < LINE_BUF_SIZE - 1)
			{
				*p = c;
				i++;
				p++;
			}
			c = io_read(163);
			param1l--;
		}
		*p = 0;
	}
	while (param1l > 0 && line_buf[0] == 0);

	return 1;
}
/******************************************************************************/
byte load_model(char *file_name)
{
	int i;
	char *p1, *p2;
	
	vert_count = 0;
	edge_count = 0;

	strcpy(sparam, file_name);

	io_write(160, 20); // open file for reading
	while (busy);

	if (!out_paramb) {
		puts("File not found!");
		return 0;
	}

	// read vertices
	if (file_read_line())
	{
		if (line_buf[0] != 'V' || line_buf[1] != ':')
		{
			puts("Error: vertex count not found!");
			puts(line_buf);
			return 0;
		}
		vert_count = atoi(line_buf + 2);
	}

	for (i = 0; i < vert_count; i++)
	{
		if (!file_read_line())
		{
			puts("Too few vertex lines!");
			return 0;
		}
			
		p1 = p2 = line_buf;

		while (IS_NUM_CHAR(*p2))
			p2++;
		*p2 = 0;
		vertices[i].x = atoi(p1);
		while (!IS_NUM_CHAR(*p2))
			p2++;
		p1 = p2;

		while (IS_NUM_CHAR(*p2))
			p2++;
		*p2 = 0;
		vertices[i].y = atoi(p1);
		while (!IS_NUM_CHAR(*p2))
			p2++;
		p1 = p2;

		while (IS_NUM_CHAR(*p2))
			p2++;
		*p2 = 0;
		vertices[i].z = atoi(p1);
	}

	// read edges
	if (file_read_line())
	{
		if (line_buf[0] != 'E' || line_buf[1] != ':')
		{
			puts("Error: edge count not found!");
			puts(line_buf);
			return 0;
		}
		edge_count = atoi(line_buf + 2);
	}

	for (i = 0; i < edge_count; i++)
	{
		if (!file_read_line())
		{
			puts("Too few edge lines!");
			return 0;
		}

		p1 = p2 = line_buf;

		while (IS_NUM_CHAR(*p2))
			p2++;
		*p2 = 0;
		edges[i][0] = atoi(p1);
		while (!IS_NUM_CHAR(*p2))
			p2++;
		p1 = p2;

		while (IS_NUM_CHAR(*p2))
			p2++;
		*p2 = 0;
		edges[i][1] = atoi(p1);
	}

	if (vert_count == 0 || edge_count == 0)
	{
		puts("Failed to load 3D-model!");
		return 0;
	}

	return 1;
} // load_model
/******************************************************************************/
void start3d(void)
{
	int i;
	struct point points[MAX_VERT];
	struct point *p1, *p2;

	int alpha = 0, beta = 0, gamma = 0;

	while (io_read(128) == 255) {
		clrbuf();

		init_rotation(alpha, beta, gamma);

		for (i = 0; i < vert_count; i++)
			vec2point(&vertices[i], &points[i]);

		for (i = 0; i < edge_count; i++) {
			p1 = &points[edges[i][0]];
			p2 = &points[edges[i][1]];
			line(p1->x, p1->y, p2->x, p2->y);
		}

		buf2screen();

		alpha += 10;
		if (alpha >= 1024)
			alpha = 0;
		beta += 7;
		if (beta >= 1024)
			beta = 0;
		gamma += 12;
		if (gamma >= 1024)
			gamma = 0;
	}

} // start3d
/******************************************************************************/

