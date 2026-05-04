const {
  withAppBuildGradle,
  withGradleProperties,
} = require('@expo/config-plugins');

function withLyraCardRecognizer(config) {
  // Add lyra:cards-camera-recognizer to app/build.gradle
  config = withAppBuildGradle(config, (modConfig) => {
    let lines = modConfig.modResults.contents.split('\n');
    let newLines = [];
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];

      if (line.includes('dependencies {')) {
        newLines.push(
          `dependencies {\n\timplementation('com.lyra:cards-camera-recognizer:1.0.+')\n`
        );
        continue;
      }

      newLines.push(line);
    }

    modConfig.modResults.contents = newLines.join('\n');
    return modConfig;
  });

  // Add Jetifier to gradle.properties
  return withGradleProperties(config, (modConfig) => {
    modConfig.modResults.push({
      type: 'property',
      key: 'android.enableJetifier',
      value: 'true',
    });
    return modConfig;
  });
}

module.exports = withLyraCardRecognizer;
