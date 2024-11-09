// Get the player input for horizontal movement
var _x_direction = keyboard_check(ord("D")) - keyboard_check(ord("A"));

// Set the horizontal speed
if (_x_direction != 0)
{
	x_speed += x_acceleration * _x_direction;
}
// If we aren't giving an input, slow down to a stop
// (I feel like there must be a better way to handle this)
else if (x_speed > 0)
{
	if(x_speed <= x_stop_speed)
	{
		x_speed -= x_stop_speed;
	}
	else
	{
		x_speed = 0;
	}	
}
else if (x_speed < 0)
{
	if (x_speed >= x_stop_speed)
	{
		x_speed += x_stop_speed;
	}
	else
	{
		x_speed = 0;
	}	
}

// Limit the horizontal speed
if (x_speed > x_max_speed)
{
	x_speed = x_max_speed;
}
else if (x_speed < -x_max_speed)
{
	x_speed = -x_max_speed;
}

// Check whether we're in the air
if (place_meeting(x, y+2, obj_collider))
{
	// We're on the ground
	y_speed = 0;
	// Refresh our double-jumps
	jumps = max_jumps;
}
else
{
	// We're in the air, apply gravity
	y_speed += gravity_amount;
}

// If we have jumups available, allow us to jump
if (jumps > 0)
{
	if (keyboard_check_pressed(ord("W")))
	{
		y_speed = -jump_acceleration;
		jumps -= 1;
	}
}

// Move the player object
move_and_collide(x_speed, y_speed, obj_collider);

// Flip the sprite if we're moving left
if (x_speed != 0)
{
	image_xscale = sign(x_speed);
}