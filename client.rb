require 'socket'

s = TCPSocket.new 'localhost', 1337

while true
	puts s.recv(4096)
	print("Input: ")
	response = gets.chomp
	s.send response, 0
	s.close

end
s.close

