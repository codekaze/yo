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