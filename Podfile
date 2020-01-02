platform :ios, '10.0'

source 'https://github.com/CocoaPods/Specs.git' 
source 'git@gitlab.com:GonetGrupo/iOS/Dependencies/Spects/GNNetworkServicesSpec.git'
source 'git@gitlab.com:GonetGrupo/iOS/Dependencies/Spects/GNSwissRazorSpec.git'
source 'git@github.com:javierbc121086/KEntertainmentDomainSpec.git'
source 'git@github.com:javierbc121086/KEntertainmentServiceSpec.git'
source 'git@github.com:javierbc121086/KEntertainmentDataSpec.git'

target 'KEntertainmentProcess' do
  use_frameworks!

  pod 'KEntertainmentService'
  pod 'RPEntertainmentData'

  target 'KEntertainmentProcessTests' do

    pod 'KEntertainmentService'
    pod 'RPEntertainmentData'
  end

end
