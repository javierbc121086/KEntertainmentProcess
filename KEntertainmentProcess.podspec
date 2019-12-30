
Pod::Spec.new do |spec|

  spec.name         = "KEntertainmentProcess"
  spec.version      = "0.0.1"
  spec.summary      = "Dependencia encargada de procesar la información de KEntretainment"

  spec.description  = <<-DESC
  Modulo encargado de procesar los flujos Movies y Tvs, sobre peticiones a servicios o persistencia de datos 
                   DESC

  spec.homepage     = "https://github.com/javierbc121086/KEntertainmentProcess"
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "Javier Bolaños Carapia" => "javier.bc121086@gmail.com" }
  spec.social_media_url   = "https://www.linkedin.com/in/javier-bola%C3%B1os-carapia-47b079152/"


  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"


  spec.source       = { :git => "git@github.com:javierbc121086/KEntertainmentProcess.git", :tag => "#{spec.version}" }


  spec.source_files  = "KEntertainmentProcess", "KEntertainmentProcess/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"

  
  spec.swift_versions = "5.1.3"
  spec.requires_arc = true

  spec.dependency "KEntertainmentService"

end

## Note: Chage tag number version to #{spec.version} value ##
# git tag -a 0.0.1 -m "Pod V0.0.1"
# git push --tags

## Release New Pod ##
# pod repo push KEntertainmentProcessSpec KEntertainmentProcess.podspec --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,git@gitlab.com:GonetGrupo/iOS/Dependencies/Spects/GNNetworkServicesSpec.git,git@gitlab.com:GonetGrupo/iOS/Dependencies/Spects/GNSwissRazorSpec.git,git@github.com:javierbc121086/KEntertainmentDomainSpec.git,git@github.com:javierbc121086/KEntertainmentServiceSpec.git' --private --verbose
