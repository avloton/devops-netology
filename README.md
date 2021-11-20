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

## Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"

5. Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?

Выделены следующие ресурсы по умолчанию:

```
Оперативная память: 1024 Мб
Процессоры: 2
Диск SATA: 64 Гб
```

6. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?

Для добавления памяти или ресурсов процессора в файл Vagrantfile необходимо добавить строки с memory и cpus, пример:

```
Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-20.04"
	config.vm.provider "virtualbox" do |vb|
		vb.memory = 2048
		vb.cpus = 4
	end
end
```

Затем перезапустить ВМ командой:

```
vagrant reload
```

8. Ознакомиться с разделами `man bash`, почитать о настройках самого bash:
- какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?

Длину журнала history можно задать при помощи переменной HISTSIZE, что описывается в man на строке 696.

- что делает директива ignoreboth в bash?

ignoreboth применяется в системной переменной HISTCONTROL для указания, 
что необходимо использовать ignorespace (не сохранять в истории строки, которые начинаются с пробела) 
и ignoredups (не сохранять в истории дубликаты команд).

9. В каких сценариях использования применимы скобки `{}` и на какой строчке `man bash` это описано?

Скобки {} применяются в механизме Brace Expansion, что описано в man на строке 876.

Brace Expansion используется для генерации произвольных строк.

Сценарии использования:

```a{d,c,b}e расширяется в 'ade ace abe'```

```echo 1 to 10 is {1..10} расширяется в '1 to 10 is 1 2 3 4 5 6 7 8 9 10'```

10. С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?

Команда для создания 100000 файлов при помощи touch будет выглядеть так:

`touch {1..100000}`

Создать 300000 файлов аналогичным способом не получится из-за ограничения системной константы ARG_MAX. В таком случае лучше использовать цикл for.

11. В man bash поищите по `/\[\[`. Что делает конструкция `[[ -d /tmp ]]`

Конструкция проверяет существует ли данный файл и является ли он каталогом. Если это так, то вернуть 0, иначе 1.

12. Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе `type -a bash` в виртуальной машине наличия первым пунктом в списке:

```
bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /bin/bash
```

(прочие строки могут отличаться содержимым и порядком) В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.

Перечень команд, которые позволяют добиться указанного вывода:

```
mkdir -p /tmp/new_path_directory/
ln -s /bin/bash /tmp/new_path_directory/
sudo ln -s /bin/bash /usr/local/bin/
PATH=/tmp/new_path_directory:/usr/local/bin:/bin
type -a bash
```

13. Чем отличается планирование команд с помощью batch и at?

`at` - исполняет команды в указанное время. 

`batch` - исполняет команды когда это позволяет загрузка системы (когда загрузка падает ниже 1.5).


14. Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.

`vagrant halt`

## Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"

1. Какого типа команда `cd`? Попробуйте объяснить, почему она именно такого типа; 
опишите ход своих мыслей, если считаете что она могла бы быть другого типа.

```shell
vagrant@vagrant:~$ type cd
cd is a shell builtin
```

По умолчанию команда `cd` является встроенной командой оболочки (т.е тип builtin). 
Она используется для смены текущей рабочей директории процесса.
Если бы она являлась внешним приложением, то при ее запуске создавался новый процесс 
и затем происходила бы смена рабочей директории только внутри этого процесса.
То есть это бы не привело к смене рабочей директории для текущего процесса.

Однако можно изменить тип `cd` на `alias`:

```shell
vagrant@vagrant:~$ alias cd='cd -L'
vagrant@vagrant:~$ type -t cd
alias
```

2. Какая альтернатива без pipe команде `grep <some_string> <some_file> | wc -l`?

Для подсчета строк, в которых совпал шаблон можно использовать флаг `-c` команды `grep`, например:

`vagrant@vagrant:~$ grep <some_string> <some_file> -c`

3. Какой процесс с PID `1` является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?

Процесс `/sbin/init` имеет PID 1:

```shell
vagrant@vagrant:~$ ps -p 1 -o args
COMMAND
/sbin/init
```

В свою очередь `init` является символьной ссылкой на систему инициализации `systemd`. Получается `systemd` является родителем всех процессов в данной виртуальной машине.

4. Как будет выглядеть команда, которая перенаправит вывод stderr `ls` на другую сессию терминала?

Ответ: `vagrant@vagrant:~$ ls some_file 2>/dev/pts/1`
                
5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.

Да. Здесь передаем содержимое файла команде grep через stdin и выводим stdout в другой файл:
```shell
vagrant@vagrant:~$ grep "2" < file > tmp
```

6. Получится ли находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?

Да, если в графическом режиме запустить эмулятор терминала и ввести команду `echo "hello" > /dev/tty1`, то сообщение появится в
первом терминале tty, который доступен через сочетание клавиш `ctrl+alt+f1`.

7. Выполните команду `bash 5>&1`. К чему она приведет? Что будет, если вы выполните `echo netology > /proc/$$/fd/5`? Почему так происходит?

Команда `bash 5>&1` создаст новый процесс с оболочкой bash, при этом создается дескриптор с номером 5, который связываем с stdout новой оболочки.
Таким образом, все сообщения, которые будут отправлены на дескриптор 5 внутри новой оболочки будут перенаправлены на stdout.

Команда `echo netology > /proc/$$/fd/5` отправляет сообщение "netology" в дескриптор 5 текущего процесса. 
Так как мы ранее связали дескриптор 5 с stdout, то сообщение "netology" будет выведено в stdout консоли. 

8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от `|` на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.

Да, пример команды:

```shell
vagrant@vagrant:~$ ls /non-existent /etc/passwd 3>&1 1>&2 2>&3 | wc -l
/etc/passwd
1
```

9. Что выведет команда `cat /proc/$$/environ`? Как еще можно получить аналогичный по содержанию вывод?

Этот файл отражает начальную среду окружения в тот момент когда текущий процесс оболочки был запущен.
При этом все изменения, которые могли произойти в среде с переменными окружения там отражены не будут.

Можно получить примерно такой же вывод при помощи `printenv`, но она выведет все изменения среды. 

10. Используя `man`, опишите что доступно по адресам `/proc/<PID>/cmdline`, `/proc/<PID>/exe`.

`/proc/<PID>/cmdline` - это файл для чтения, который содержит полную командную строку процесса
пока он не станет зомби. В последнем случае в этом файле ничего нет, то есть чтение из
этого файла будет возвращать 0 символов.

`/proc/<PID>/exe` - в Linux 2.2 и более поздних этот файл является символьной ссылкой, которая
содержит путь к исполняемой команде.

11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью `/proc/cpuinfo`.

```shell
vagrant@vagrant:~$ cat /proc/cpuinfo | grep -i sse
```

Ответ: sse4_2

12. При открытии нового окна терминала и `vagrant ssh` создается новая сессия и выделяется pty. Это можно подтвердить командой `tty`, которая упоминалась в лекции 3.2. Однако:

```shell
vagrant@netology1:~$ ssh localhost 'tty'
not a tty
```
Почитайте, почему так происходит, и как изменить поведение.

Причина в том, что когда мы запускаем удаленную команду при помощи ssh, то не происходит выделения псевдо-терминала tty.
Чтобы изменить поведение можно передать флаг `-t`, это приведет к принудительному выделению псевдо-терминала: `ssh -t localhost 'tty'`

13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись `reptyr`. Например, так можно перенести в `screen` процесс, который вы запустили по ошибке в обычной SSH-сессии.

Запускаем программу top и переводим ее в фон при помощи `CTRL-z`. Затем получаем ее PID при помощи команды `jobs -l` и удаляем из списка задач командой `disown top`: 
```shell
[1]+  Stopped                 top
vagrant@vagrant:~$ bg
[1]+ top &
vagrant@vagrant:~$ jobs -l
[1]+  1404 Stopped (signal)        top
vagrant@vagrant:~$ disown top
-bash: warning: deleting stopped job 1 with process group 1404
```

В результате, в другой сессии SSH (или в tmux), мы можем получить запущенное приложение top при помощи reptyr:
```shell
vagrant@vagrant:~$ reptyr 1404
```
PS: чтобы заработало на виртуалке пришлось править параметр ядра `echo 0 > /proc/sys/kernel/yama/ptrace_scope`.

14. `sudo echo string > /root/new_file` не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без `sudo` под вашим пользователем. Для решения данной проблемы можно использовать конструкцию `echo string | sudo tee /root/new_file`. Узнайте что делает команда `tee` и почему в отличие от `sudo echo` команда с `sudo tee` будет работать.

Команда tee читает из стандартного ввода и пишет в стандартный вывод и файлы. В данном примере, так как программа tee будет запущена от root, 
то она успешно создаст файл по пути `/root/new_file` с содержимым `string` (при этом выведет `string` в stdout).