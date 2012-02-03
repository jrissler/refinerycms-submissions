Gem::Specification.new do |s|
  s.name              = "refinerycms-submissions"
  s.version           = "1.1"
  s.date              = "2012-02-01"
  s.summary           = "Contact submissions gem for Refinery with akismet spam filter and extra contact fields."
  s.description       = "Contact submission handling functionality extracted from Refinery CMS to allow you to have a contact form and manage submissions in the Refinery backend. Also includes akismet spam filtering"
  s.homepage          = "http://github.com/jrissler/refinerycms-submissions"
  s.email             = "james@railsbits.com"
  s.authors           = ["James Rissler"]
  s.require_paths = ["lib"]

  #s.rubyforge_project = "refinerycms-submissions"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end

