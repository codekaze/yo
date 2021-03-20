## Install Yo Package
```
flutter pub global activate yo
```

- Add this to Your PATH
```
[YOUR_FLUTTER_PARENT_DIRECTORY]\flutter\.pub-cache\bin
[YOUR_FLUTTER_PARENT_DIRECTORY]\flutter\bin\cache\dart-sdk\bin
[YOUR_FLUTTER_PARENT_DIRECTORY]\flutter\bin
```

```
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