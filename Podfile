platform :ios, '16.0'
use_frameworks!
inhibit_all_warnings!

target 'ExpenseProiOS' do
  # Backend: Supabase SPM orqali qo'shiladi (project.yml -> packages)

  # Local storage (secure)
  pod 'KeychainAccess', '~> 4.2'

  # Networking helper (optional, Supabase uses URLSession)
  pod 'Alamofire', '~> 5.9'

  # Dependency Injection
  pod 'Swinject', '~> 2.8'

  # Image loading
  pod 'Kingfisher', '~> 7.0'

  # Logging
  pod 'SwiftyBeaver', '~> 2.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
    end
  end
end
