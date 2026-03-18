const { withPodfile } = require('@expo/config-plugins');

function withLyraPaymentSDK(config) {
  return withPodfile(config, (config) => {
    let contents = config.modResults.contents;

    const block = `
  dynamic_frameworks = ['LyraPaymentSDK', 'LyraMotion', 'LyraMaterial', 'SnapKit']

  pre_install do |installer|
    installer.pod_targets.each do |pod|
      if dynamic_frameworks.include?(pod.name)
        def pod.dynamic_framework?;
          true
        end
        def pod.build_type;
          Pod::BuildType.dynamic_framework
        end
      end
    end
  end
    `;

    if (!contents.includes('pre_install do')) {
      if (contents.includes('post_install do')) {
        contents = contents.replace(
          /post_install do/m,
          `${block}\n\tpost_install do`
        );
      } else {
        contents += `\n${block}`;
      }
    }

    config.modResults.contents = contents;
    return config;
  });
}

module.exports = withLyraPaymentSDK;
