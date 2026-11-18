function withLyraPaymentSDK(config) {
  const projectRoot = config._internal?.projectRoot || process.cwd();
  const { withPodfile } = require(require.resolve('expo/config-plugins', {
    paths: [projectRoot],
  }));

  return withPodfile(config, (modConfig) => {
    let contents = modConfig.modResults.contents;
    const helperRequire = `require File.join(File.dirname(Pod::Executable.execute_command('node', ['-p', 'require.resolve("@lyracom/react-native-sdk-payment-module/package.json", { paths: [process.argv[1]] })', __dir__]).strip), 'ios/lyra_payment_sdk')`;

    if (!contents.includes(helperRequire)) {
      contents = `${helperRequire}\n${contents}`;
    }

    if (!/^[ \t]*lyra_payment_post_install[ \t]*(?:\(| )/m.test(contents)) {
      const postInstall =
        /^([ \t]*)react_native_post_install(?=[ \t]*(?:\(\s*)?([a-zA-Z_]\w*))(?:[ \t]*\([^\n]*\)|[ \t]*\([\s\S]*?^\1\)|[ \t]+[^\n]+)[ \t]*(?:#[^\n]*)?$/m;
      if (!postInstall.test(contents)) {
        throw new Error(
          'LyraPaymentSDK: could not find react_native_post_install in the Podfile.'
        );
      }
      contents = contents.replace(
        postInstall,
        '$&\n$1lyra_payment_post_install($2)'
      );
    }

    modConfig.modResults.contents = contents;
    return modConfig;
  });
}

module.exports = withLyraPaymentSDK;
