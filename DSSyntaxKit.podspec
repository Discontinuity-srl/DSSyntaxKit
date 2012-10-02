Pod::Spec.new do |s|
  s.name         = "DSSyntaxKit"
  s.version      = "0.0.1"
  s.summary      = "Syntax highlighted NSTextView."
  s.homepage     = "https://github.com/Discontinuity-srl/DSSyntaxKit"
  s.license      = 'MIT'
  s.author       = { "Fabio A. Pelosin" => "fabiopelosin@gmail.com" }
  s.source       = { :git => "https://github.com/Discontinuity-srl/DSSyntaxKit.git" }
  s.source_files = 'Classes/**/*.{h,m}'
  s.requires_arc = true;
  s.dependency 'BlocksKit'
  s.dependency 'NoodleKit/NoodleLineNumberView'
end
