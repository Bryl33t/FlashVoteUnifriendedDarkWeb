require 'colorize'
require 'socket'

class Design

	@@questions = nil

	def initialize(question)
		@@questions = question
	end

	def Title
		puts "\tFLASH VOTE//////".white
	end

	def QuestionPut
		puts "\t#{@@questions.upcase}".yellow
		puts "\t#{"-".blue*@@questions.size}"
	end

end

class FlashVote

	@@questions = nil

	@@ok = 0

	@@no = 0

	def initialize(question)
		@@questions = question
	end

	def SocketListen
		s = TCPServer.new 1337

		count = 0

		while count != 3
			sleep(1)
			
			client = s.accept
			client.send "#{@@questions}", 0
			rec = client.recv(1024)

			if rec != nil
				if rec == "Y"
					@@ok += 1
				elsif rec == "N"
					@@no += 1
				end
			else

			end
			count += 1
			self.Finish


		end

	end

	def Finish
		puts "Number Vote:"
		puts "\t Positive: #{@@ok}".green
		puts "\t Negative: #{@@no}".red
	end

	

end

if ARGV.length != 0
	design = Design.new(ARGV[0])
	design.Title
	design.QuestionPut
	flash = FlashVote.new(ARGV[0])
	flash.SocketListen
else
	puts "Usage: #{__FILE__} \"Questions\""
end
