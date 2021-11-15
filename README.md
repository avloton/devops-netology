# devops-netology

## Домашнее задание к занятию «1.1. Введение в DevOps»

Благодаря добавленному файлу .gitignore будут проигнорированы следующие файлы в каталоге terraform:
- все файлы в директориях и поддиректориях .terraform;
- файлы с расширением .tfstate или содержащие в имени .tfstate;
- файл crash.log;
- файлы с расширением .tfvars;
- файл override.tf;
- файл override.tf.json;
- файлы, которые оканчиваются на _override.tf;
- файлы, которые оканчиваются на _override.tf.json;
- файл .terraformrc;
- файл terraform.rc.


## Домашнее задание к занятию «2.4. Инструменты Git»

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

`git show aefea`

    commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
    Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
    Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md

Хеш и комментарий коммита - это  aefead2207ef7e2aa5dc81a34aedf0cad4c32545 и "Update CHANGELOG.md."

2. Какому тегу соответствует коммит 85024d3?

`git show 85024d3`

    commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)

Коммит 85024d3 соответствует тэгу tag: v0.12.23.

3. Сколько родителей у коммита b8d720? Напишите их хеши.

`git show b8d720^1`

    commit 56cd7859e05c36c06b56d013b55a252d0bb7e158

`git show b8d720^2`

    commit 9ea88f22fc6269854151c571162c5bcf958bee2b

У коммита b8d720 два родителя с хешами 56cd7859e05c36c06b56d013b55a252d0bb7e158 и 9ea88f22fc6269854151c571162c5bcf958bee2b.

4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

`git log --oneline --graph v0.12.23..v0.12.24~1`

    b14b74c49 [Website] vmc provider links
    3f235065b Update CHANGELOG.md
    6ae64e247 registry: Fix panic when server is unreachable
    5c619ca1b website: Remove links to the getting started guide's old location
    06275647e Update CHANGELOG.md
    d5f9411f5 command: Fix bug when using terraform login on Windows
    4b6d06cc5 Update CHANGELOG.md
    dd01a3507 Update CHANGELOG.md
    225466bc3 Cleanup after v0.12.23 release

5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

`git log --pickaxe-regex -S"func providerSource\(" -p --all`

    commit 8c928e83589d90a031f811fae52a81be7153e82f

6. Найдите все коммиты в которых была изменена функция globalPluginDirs.

Находим файлы, в которых определена функция: `git grep "globalPluginDirs"`

Находим коммиты, в которых менялось тело функции: `git log -L :globalPluginDirs:plugins.go`

    commit 78b12205587fe839f10d946ea3fdc06719decb05
    commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46
    commit 41ab0aef7a0fe030e84018973a64135b11abcd70
    commit 66ebff90cdfaa6938f26f908c7ebad8d547fea17
    commit 8364383c359a6b738a436d1b7745ccdce178df47

7. Кто автор функции synchronizedWriters?

`git log --pickaxe-regex -S"func synchronizedWriters\(" -p --all`

    Author: Martin Atkins <mart@degeneration.co.uk>

Или

`git log --pickaxe-regex -S"func synchronizedWriters\(" --reverse --pretty='format:%an' | head -n1`

    Martin Atkins

