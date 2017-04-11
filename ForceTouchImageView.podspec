Pod::Spec.new do |s|
  s.name = "ForceTouchImageView"
  s.version = "0.2"
  s.summary = "Why pinch to zoom when you have 3D Touch 🤔"
  s.description = "A tiny open source library to supoort zooming in UIScrollView using Force Touch"
  s.homepage = "https://github.com/omaralbeik/ForceTouchImageView"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { "Omar Albeik" => 'omaralbeik@gmail.com' }
  s.social_media_url = "http://twitter.com/omaralbeik"
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.source = { git: "https://github.com/omaralbeik/ForceTouchImageView.git", tag: "#{s.version}" }
  s.source_files = "Source/**/*.swift"
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0',
  }
end
