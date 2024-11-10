// Get the player input for horizontal movement
var _x_direction = keyboard_check(ord("D")) - keyboard_check(ord("A"));

// Set the horizontal speed
if (_x_direction != 0)
{
	x_speed += x_acceleration * _x_direction;
}
else if (x_speed > 0)
{
	// If we aren't giving an input, slow down to a stop
	// (I feel like there must be a better way to handle this)
	if (x_speed <= x_stop_speed)
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
if (place_meeting(x, y+y_speed, obj_collider))
{
	// We're on the ground
	// Make sure we're actually on the ground (not hovering)
	while (!place_meeting(x, y+sign(y_speed), obj_collider))
	{
		y += sign(y_speed);
	}
	y_speed = 0;
	
	// Refresh our double-jumps
	current_jumps = max_jumps;
}
else
{
	// We're in the air, apply gravity
	y_speed += gravity_amount;
	
	// Limit falling speed
	if (y_speed > y_terminal_velocity)
	{
		y_speed = y_terminal_velocity;
	}
	
	y += y_speed;
}

// If we have jumps available, allow us to jump
if (current_jumps > 0)
{
	if (keyboard_check_pressed(ord("W")))
	{
		y_speed = -jump_acceleration;
		current_jumps -= 1;
	}
}

// Move and collide horizontally
if (place_meeting(x+x_speed, y-1, obj_collider))
{
	// We've hit a wall
	x_speed	= 0;
}
else
{
	x += x_speed;
}

// Flip the sprite if we're moving left
if (x_speed != 0)
{
	image_xscale = sign(x_speed);
}