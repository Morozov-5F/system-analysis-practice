settings.outformat = "pdf";

import graph;

unitsize(1cm);

// Total number of criteria
int NUM_CRITERIA = 6;
// Total number of alternatives
int NUM_ALTERNATIVES = 4;

// Circle radius
real r = 1;
// Horizontal offset between circles
real offset_x = r;
// Vertical offset between circles
real offset_y = 2 * r;
// Horizontal position step between circles
real step_x = 2 * r + offset_x;
// Vertical position step between circles
real step_y = 2 * r + offset_y;

// Length of canvas (assuming that there are always more criteria than alternatives)
real total_length = 2 * r * (NUM_CRITERIA - 1) + offset_x * (NUM_CRITERIA - 1);
real alt_length = 2 * r * (NUM_ALTERNATIVES - 1) + offset_x * (NUM_ALTERNATIVES - 1);

real center_x = total_length / 2;
real alternatives_offset = (total_length - alt_length) / 2;

// First level (global goal)
draw(Circle((center_x, 2 * step_y), r));
label("$C_1$", (center_x, 2 * step_y), NoAlign);

// Second level (criteria)
for (int i = 0; i < NUM_CRITERIA; ++i)
{
  draw(Circle((i * step_x, step_y), r));

  // Add label inside the cirlcle
  string label_str = format("$C_%d$", i + 1, "");
  label(label_str, (i * step_x, step_y), NoAlign);

  // Draw arrows from the first level to second
  draw((center_x, 2 * step_y - r) -- (i * step_x, step_y + r), arrow = Arrow());
}
// Third level (Alternatives)
for (int i = 0; i < NUM_ALTERNATIVES; ++i)
{
  draw(Circle((alternatives_offset + i * step_x, 0), r));

  string label_str = format("$C_%d$", i + 1, "");
  label(label_str, (alternatives_offset + i * step_x, 0), NoAlign);

  // Drwa arrows from the second level to the third
  for (int j = 0; j < NUM_CRITERIA; ++j)
  {
    draw((j * step_x, step_y - r) -- (alternatives_offset + i * step_x, r), arrow = Arrow());
  }
}
