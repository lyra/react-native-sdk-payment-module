# Guard against reloading: the podspec and the Podfile can reach this file through different paths (e.g. symlinked node_modules), which Ruby does not dedupe.
return if defined?(LyraPaymentSDKSPM)

module LyraPaymentSDKSPM
  URL = 'https://github.com/lyra/ios-sdk.git'.freeze
  VERSION = '4.2.2'.freeze
  PRODUCT = 'LyraPaymentSDK'.freeze
  REQUIREMENT = { 'kind' => 'exactVersion', 'version' => VERSION }.freeze

  def self.add_to_target(target)
    project = target.project
    package = project.root_object.package_references.find do |reference|
      reference.is_a?(Xcodeproj::Project::Object::XCRemoteSwiftPackageReference) &&
        reference.repositoryURL.delete_suffix('.git') == URL.delete_suffix('.git')
    end

    unless package
      package = project.new(Xcodeproj::Project::Object::XCRemoteSwiftPackageReference)
      package.repositoryURL = URL
      package.requirement = REQUIREMENT.dup
      project.root_object.package_references << package
    end

    product = target.package_product_dependencies.find do |dependency|
      dependency.package == package && dependency.product_name == PRODUCT
    end
    unless product
      product = project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
      product.package = package
      product.product_name = PRODUCT
      target.package_product_dependencies << product
    end

    unless target.frameworks_build_phase.files.any? { |build_file| build_file.product_ref == product }
      build_file = project.new(Xcodeproj::Project::Object::PBXBuildFile)
      build_file.product_ref = product
      target.frameworks_build_phase.files << build_file
    end
  end
end

def lyra_payment_post_install(installer)
  projects = []
  installer.aggregate_targets.each do |aggregate|
    next unless aggregate.pod_targets.any? { |target| target.pod_name == 'ReactNativeSdkPaymentModule' }

    aggregate.user_targets.each do |target|
      next unless [
        'com.apple.product-type.application',
        'com.apple.product-type.application.on-demand-install-capable'
      ].include?(target.product_type)

      LyraPaymentSDKSPM.add_to_target(target)
      projects << target.project
    end
  end
  projects.uniq.each(&:save)
end