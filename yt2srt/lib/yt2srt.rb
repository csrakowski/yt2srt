# yt2srt
#Copyright (c) 2013, Christiaan Rakowski
#All rights reserved.

#Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
# - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#Main Yt2srt class, contains helper methods to convert Youtube Captions subtitles to SubRip (.srt) format
class Yt2srt

	# Helper method, used to convert a single line
	#
	# Example:
	#   >> convert_line(index, line)
	#
	# Arguments:
	#   index: (Integer)
	#   line: (String)
	
	def self.convert_line(index, line)
		startTime = line[/(\d+:)?\d+:\d+/]
		if startTime.index(':') == 1
			startTime.insert(0, '0')
		end
		line[/(\d+:)?\d+:\d+/] = ''
		endTime = String.new(startTime)
		sec = endTime[/:\d+/]
		sec.sub!(':', '')
		sec = sec.to_i + 5
		if sec > 59
			sec -= 60
			min = endTime[/\d+:/].chop.to_i + 1
			mins = min.to_s + ':'
			if min < 10
				mins.insert(0, '0')
			end
			endTime[/\d+:/] = mins
		end
		v = ':'
		if sec < 10
			v += '0'
		end
		endTime[/:\d+/] = sec.to_s.insert(0, v)
		text = line
		return "#{index}\n00:#{startTime},000 --> 00:#{endTime},000\n#{text}\n"
	end

	private_class_method :convert_line
	
	# Main method, used to convert Youtube Captions subtitles to SubRip (.srt) format
	#
	# Example:
	#   >> Yt2srt.convert(input, output)
	#
	# Arguments:
	#   input_file: (String)
	#   output_file: (String)
	
	def self.convert(input_file, output_file)
		puts "Starting conversion: #{input_file} --> #{output_file}"
		text=File.open(input_file).read
		ofx= File.open(output_file, 'w')
		text.gsub!(/\r\n?/, "\n")
		text.each_line.with_index(1) do |line, index|	
			newLine = convert_line(index, line);
			ofx << newLine
		end
		ofx.close
		puts "Conversion completed successfully!"
	end	
	
end