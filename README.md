<h1 align="center">Meta Secret Mobile Application</h1>

#### vault-server api
  http://api.meta-secret.org


### STEPS TO BUILD

You'll need installed Android Studio & XCode

1. Download Meta-Secret-Core project from [here](https://github.com/meta-secret/meta-secret-core)
2. Download Meta-Secret-KMM project from [here](https://github.com/meta-secret/meta-secret-kmm)
3. Move to the folder where you downloaded Meta-Secret-Core project

#### FOR IOS
1. Run `sh iosBuild.sh`
2. Go to the folder where you downloaded Meta-Secret-KMM project
3. In terminal do `pod install` command
4. Open `MetaSecret.xcworkspace` in XCode
5. Copy `MetaSecretCore.xcframework` from `Meta-Secret-Core/target` to the RustLib folder (just drag-n-drop it)
6. Select MetaSecret project file in xcode
7. In oppened window select `TARGETS: MetaSecret`
8. Switch to `BuildPhases`
9. In `Link Binary With Libraries` press `+` sign and select added `MetaSecretCore` if it wasn't added automaticaly
10. Build a project (Cmd+B)

#### FOR ANDROID

1. Open Android Studio. From the toolbar, go to `Android Studio > Preferences > Appearance & Behaviour > Android SDK > SDK Tools`. Check the following options for installation and click OK.
- `Android SDK Tools`
- `NDK`
- `CMake`
- `LLDB`
2. `export ANDROID_HOME=/Users/$USER/Library/Android/sdk`
    `export NDK_HOME=$ANDROID_HOME/ndk-bundle`
3. Install Docker [instruction](https://docs.docker.com/desktop/install/mac-install/)
4. Install Cross (in terminal)`cargo install cross --git https://github.com/cross-rs/cross`
5. Add targets:
 - `rustup target add aarch64-linux-android`
 - `rustup target add x86_64-linux-android`
6. Run docker `docker ps`
7. Build lib:
- `cross build --target aarch64-linux-android`
- `cross build --target x86_64-linux-android`


***IMPORTANT!!!***
DO NOT COMMIT THIS LIB!
