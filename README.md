## How to Install Yo
```
flutter pub global activate yo
```

- Add this to Your PATH
```
[YOUR_FLUTTER_PARENT_DIRECTORY]\flutter\.pub-cache\bin
[YOUR_FLUTTER_PARENT_DIRECTORY]\flutter\bin\cache\dart-sdk\bin
[YOUR_FLUTTER_PARENT_DIRECTORY]\flutter\bin
```

- Another option is to use YoInstaller.exe
```
Download YoInstaller.exe and click the Install button.
```
[Download Yo-Installer](https://github.com/codekaze/yo_installer/raw/master/YoInstaller/bin/Debug/YoInstaller.exe)

## Create Yo Project
```
yo init
```


## Create Module
```
yo module create [module_name]
```

example:
```
yo module create product
```

```
yo module create product/product_list
yo module create product/product_form
```

## Generate Icon
1. Update icon file in assets/icon/icon.png
2. Run this command:
```
yo generate_icon
```

## Remove Unused Import
```
yo clean
```


## Generate core.dart File
```
yo core
```

## Simple Command to Push to Github
```
yo push
```

its equal to:
```
git add .
git commit -m "."
git push
```