/// @description Insert description here
x_direction = keyboard_check(vk_right) - keyboard_check(vk_left);
y_direction = keyboard_check(vk_down) - keyboard_check(vk_up); 

var _magnitude = sqrt(sqr(x_direction) + sqr(y_direction));

if (_magnitude > 0) 
{
	x += (x_direction * x_speed)/ _magnitude;
	y += (y_direction * y_speed)/ _magnitude;
}

