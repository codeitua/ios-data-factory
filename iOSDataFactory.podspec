Pod::Spec.new do |s|

  s.name         = "iOSDataFactory"
  s.version      = "0.2.0"
  s.summary      = "iOSDataFactory description."

  s.description  = <<-DESC
iOSDataFactory detailed description
                   DESC

  s.homepage     = "https://github.com/codeitua/ios-data-factory.git"
  s.license      = { :type => "MIT", :text => <<-LICENSE
                   Copyright 2018
                   Permission is granted to CodeIT
                 LICENSE
               }

  s.author = "CodeIT"
  s.homepage = "https://github.com/codeitua/ios-data-factory"

  s.platform = :ios
  s.ios.deployment_target = "10.0"

  s.swift_version = '4.0'
  
  s.source       = { :git => "https://github.com/codeitua/ios-data-factory.git", :tag => "#{s.version}" }

  s.source_files  = "iOSDataFactory", "iOSDataFactory/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"

end
