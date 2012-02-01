#!/usr/bin/env ruby
version = '1.0'
raise "Could not get version so gemspec can not be built" if version.nil?
files = Dir.glob("**/*").flatten.reject do |file|
  file =~ /\.gem$/
end

gemspec = <<EOF
Gem::Specification.new do |s|
s.name = %q{refinerycms-submissions}
s.version = %q{#{version}}
s.date = %q{#{Time.now.strftime('%Y-%m-%d')}}
s.summary = %q{Contact submissions gem for Refinery with akismet spam filter and extra contact fields.}
s.description = %q{Contact submission handling functionality extracted from Refinery CMS to allow you to have a contact form and manage submissions in the Refinery backend. Also includes akismet spam filtering}
s.homepage = %q{http://github.com/jrissler/refinerycms-submissions}
s.email = %q{james@railsbits.com}
s.authors = ["James Rissler"]
s.require_paths = %w(lib)

s.files = [
'#{files.join("',\n '")}'
]
s.require_path = 'lib'

s.add_dependency('filters_spam', '~> 0.2')
end
EOF

File.open(File.expand_path("../../refinerycms-submissions.gemspec", __FILE__), 'w').puts(gemspec)