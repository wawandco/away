#
# Be sure to run `pod lib lint away.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Away"
  s.version          = "0.1.0"
  s.summary          = "Builds fakes CLLocations x distance away"
  s.description      = <<-DESC
                        Away helps building fake CLLocations based on a given distance.
                       DESC

  s.homepage         = "https://github.com/wawandco/away"
  s.license          = 'MIT'
  s.author           = { "Antonio Pagano" => "apagano@wawand.co" }
  s.source           = { :git => "https://github.com/wawandco/away.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wawandco'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Away' => ['Pod/Assets/*.png']
  }
  s.frameworks = 'CoreLocation', 'Foundation'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
