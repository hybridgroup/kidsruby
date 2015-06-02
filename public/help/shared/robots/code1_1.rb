require 'sphero'

Sphero.start '/dev/tty.Sphero-YBW-RN-SPP' do
	roll 60, Sphero::FORWARD
	keep_going 3

	roll 60, Sphero::RIGHT
	keep_going 3

	roll 60, Sphero::BACKWARD
	keep_going 3

	roll 60, Sphero::LEFT
	keep_going 3

	stop
end
