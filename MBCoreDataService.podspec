Pod::Spec.new do |s|

  s.name         = "MBCoreDataService"
  s.version      = "1.0.0"
  s.summary      = "Core data wrapper made by Mobilette."

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Romain Asnar" => "romain.asnar@gmail.com" }

  s.homepage     = "https://github.com/Mobilette/CoreDataService"

  s.platform     = :ios
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/Mobilette/CoreDataService.git", :tag => s.version }


  s.source_files = "Source/*.swift"

  s.framework    = "CoreData"

  s.requires_arc = true

end