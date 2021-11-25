## How to Install Yo
```
flutter pub global activate yo
flutter pub global run yo
```

Restart Command Prompt
Run this command to test:
```
yo
``` 

## Create ro Project
```
ro init
```


## Create Module
```
ro module create [module_name]
```

example:
```
ro module create product
```

```
ro module create product/product_list
ro module create product/product_form
```

## Generate Icon
1. Update icon file in assets/icon/icon.png
2. Run this command:
```
ro generate_icon
```

## Remove Unused Import
```
ro clean
```


## Generate core.dart File
```
ro core
```