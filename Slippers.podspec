#
# Be sure to run `pod lib lint Slippers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Slippers'
  s.version          = '0.1.1'
  s.summary          = 'Slippers provides some simple types that make working with network calls easier.'
  s.swift_versions   = ['4.0', '4.1', '4.2', '5.0', '5.1', '5.2', '5.3']
  s.description      = <<-DESC
  Slippers adds some structure around common networking tasks like refreshing, paging, and json parsing.
  
  Specifically, it provides:
  - A protocol called Refreshable which requires a `refresh` function
  - A functional implementation of Refreshable
  - A 'meta' refresher class which will accept bunch of refreshables and refresh all of them on command
  - A protocol called Pageable which requires `nextPage` and `fetchPage` functions
  - A functional implementation of Pageable + Refreshable that manages the page number for you
  - An extension to Pageable that can be used with `UITableViewDelegate`s to simplify infinite lists
  - An array extension that allows you to use a simple array to simulate paginated batches of elements
  - A class that makes a single JSONEncoder and JSONDecoder available throughout your project with smart defaults set on them
  - A ID class that you can use transparently for integer server ids which helps enforce type consistency when passed around
                       DESC

  s.homepage         = 'https://github.com/ThryvInc/slippers'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Elliot Schrock' => '' }
  s.source           = { :git => 'https://github.com/ThryvInc/slippers.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/elliot_schrock'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Slippers/Classes/Core/*', 'Slippers/Classes/Id/*'
  
  s.subspec "StringId" do |sp|
    sp.source_files = 'Slippers/Classes/Core/*', 'Slippers/Classes/StringId/*'
  end
end
