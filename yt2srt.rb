#!/usr/bin/env ruby

#1 (index)
#00:02:07,000 --> 00:02:11,440 (startTime --> endTime)
#Lorem Ipsum (the text for this timeframe)
#2d line

def yt2srt_line(index, line)
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


def yt2srt(input_file, output_file)
	puts "Starting conversion: #{input_file} --> #{output_file}"
	text=File.open(input_file).read
	ofx = File.open(output_file, 'w')
	text.gsub!(/\r\n?/, "\n")
	text.each_line.with_index(1) do |line, index|	
		newLine = yt2srt_line(index, line);
		ofx << newLine
	end
	ofx.close
	puts "Conversion completed successfully!"
end

input = ''
output = ''

if(ARGV.length > 0)
	input = ARGV[0]
	if(ARGV.length > 1)
		output = ARGV[1]
	else
		output = input + '.srt'
	end
else
	puts 'Specify input file:'
	input = STDIN.gets.chomp

	puts "Specify output file (leave blank for #{input}.en.srt):"
	output = STDIN.gets.chomp
	if output == ''
		output = input + 'en.srt'
	end
end

yt2srt(input, output)
