# gpg_encoding_example

Пример хранения в репо зашифрованных файлов с пакетной расшифровкой.

Как это работает?

1. Помещаем НЕ зашифрованные файлы в каталог с репо
2. Добавляем файлы в .gitignore
3. Через git status убеждаемся что git ничего не видит и репо пусто.
4. Добавлям список файлов для зашифровки в secret_files в Makefile
5. Указываем идентифкатор ключа в key_id в Makefile (выдумайте, но ключ с этим
   идентификатором должен быть на сервере)
6. Кодируем: `make encrypt`
7. Добавляем закодированные файлы в репозиторий `git add *.asc; git commit -m 'Add encoded
   secrets'`


# Как перенести ключ на сервер?

Экспортируем ключ

```
make export_key
```

Перееносим ключи на сервер

```
scp private.key SERVER:/каталог_где_развернуто_репо/
```

Импортируем ключ на сервере (загружает файл private.key из каталога в котором
запускается)

```
make import_key
```


# Как расшифровать файлы на сервере?

```
make decrypt
```

# FAQ

## gpg: encryption of 'secret.txt' failed: No public key

У вас нет ключа gpg указанного в RECIPIENT на вашем компе. Его нужно или создать
или импортировать.

```
make create_key
```

## Как экспортировать/импортировать ключи?

https://edoceo.com/sys/gpg


## Какие ключи у меня в gpg?

```
gpg -k
```
