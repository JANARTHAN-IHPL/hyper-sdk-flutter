# Hyper SDK Flutter

A flutter plugin for juspay payment SDK.

## Flutter Setup

1. Add plugin dependency in `pubspec.yaml`

## Android Setup

1. Add to `android/build.gradle`
```gradle
buildscript {
    ....
    repositories {
        ....
        maven {
            url "https://maven.juspay.in/jp-build-packages/hypersdk-asset-download/releases/"
        }
    }

    dependencies {
        ....
        classpath 'in.juspay:hypersdk-asset-plugin:1.0.3'
    }
}
```

2. Add to `android/app/build.gradle`
```gradle
apply plugin: 'hypersdk-asset-plugin'
```

3. Create file `android/app/MerchantConfig.txt` with the following content
```txt
clientId = <your client id>
```

## iOS Setup

1. In `ios/Podfile`
```
post_install do |installer|
  fuse_path = "./Pods/HyperSDK/Fuse.rb"
  clean_assets = true
  if File.exist?(fuse_path)
    if system("ruby", fuse_path.to_s, clean_assets.to_s)
    end
  end
end
```

2. Create file `ios/MerchantConfig.txt` with the following content
```txt
clientId = <your client id>
```