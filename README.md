# Nutrition Analysis 
-----------------------------------------

This Task has been created by Ammar Yasser iOS Software Engineer, you need to follow these steps to be able to build it.


## Install Cocoapods
-----------------------------------------
```
sudo gem install cocoapods
```

## Install Pods
-----------------------------------------
```
cd "Project directory"
pod install
```

If you're using M1 Macbook, you maybe will face an error while executing the previous command, so try the following command:

```
sudo arch -x86_64 gem install ffi
arch -x86_64 pod install 
```

## Build Application
-----------------------------------------

After installing pods, open Nutrition Analysis.xcworkspace file, then hit "Command+B"


## M1 Macbook note
-----------------------------------------
you may face an issue if you're using M1, that the project will only run on real device not the simulator, for a temporary fix:

- navigate to build target
- build settings
- enter arm64 in 'Excluded Archituchers' field 

this will make it build normally on simulator, but remember to remove it when running on real device or before submitting to app store.



