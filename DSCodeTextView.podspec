Pod::Spec.new do |s|
  s.name         = "DSCodeTextView"
  s.version      = "0.0.1"
  s.summary      = "Syntax highlighted NSTextView."
  s.homepage     = "https://github.com/Discontinuity-srl/DSCodeTextView.git"
  s.license      = 'MIT'
  s.author       = { "Fabio A. Pelosin" => "fabiopelosin@gmail.com" }
  s.source       = { :git => "https://github.com/Discontinuity-srl/DSCodeTextView.git" }
  s.platform     = :osx, '10.7'
  s.source_files = 'Classes/**/*.{h,m}'

  s.dependency 'NoodleKit'
  s.dependency 'BlocksKit'
end
