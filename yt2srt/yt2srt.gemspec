Gem::Specification.new do |s|
  s.name				= "yt2srt"
  s.version				= "1.0.0"  
  s.executables			<< "yt2srt"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christiaan Rakowski"]
  s.date = %q{2013-01-04}
  s.description = %q{Quick Ruby script to convert Youtube Captions subtitles to SubRip (.srt) format}
  s.email = %q{cs.rakowski@gmail.com}
  s.files = ["lib/yt2srt.rb", "bin/yt2srt"]
  s.homepage = %q{http://rubygems.org/gems/yt2srt}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Quick Ruby script to convert Youtube Captions subtitles to SubRip (.srt) format}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

