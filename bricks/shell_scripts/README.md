## 📦 Add Execution Permission for Shell Scripts

Before running the shell scripts in this project, make sure they have execution permission.

You can set the permission for all `.sh` files at once using:

```bash
chmod +x ./bricks/shell_scripts/*.sh
```

## Tạo 1 feature mới (khi đã có màn hình)
```bash 
./bricks/shell_scripts/create_feature.sh
```

## 📦 Create only screen
```bash 
cd lib/presentation/features
```

```bash 
../../../bricks/shell_scripts/create_screen.sh
```

## 📦 Create Screen with feature

```bash 
./bricks/shell_scripts/create_screen_with_feature.sh
```





## Cách setup mason và tạo mới brick
1. Activate Mason globally
```bash 
dart pub global activate mason_cli
```

If you're using Flutter:
```bash 
flutter pub global activate mason_cli
```

2. Add Mason to your PATH
```bash 
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

Sau đó reload shell:
```bash 
source ~/.zshrc
```

## ----- Cài xong Mason -----
3. Create a new Mason project
   Navigate to your project folder:
```bash 
mason init
```

4. Add bricks to your project
```bash 
Tạo thư mục bricks -> cd bricks
```

Muốn tạo một brick mới:
```bash 
mason new <brick_name>
```

Thêm mason vừa tạo vào list:
```bash 
cd bricks
mason add <brick_name> --path <brick_name>
mason get
```


