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

## Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. Какой системный вызов делает команда `cd`? В прошлом ДЗ мы выяснили, что `cd` не является самостоятельной  программой, это `shell builtin`, поэтому запустить `strace` непосредственно на `cd` не получится. Тем не менее, вы можете запустить `strace` на `/bin/bash -c 'cd /tmp'`. В этом случае вы увидите полный список системных вызовов, которые делает сам `bash` при старте. Вам нужно найти тот единственный, который относится именно к `cd`. Обратите внимание, что `strace` выдаёт результат своей работы в поток stderr, а не в stdout.

**Ответ:**

Можно перенаправить поток stderr в файл или использовать опцию `-o`:
```bash
vagrant@vagrant:~$ strace /bin/bash -c 'cd /tmp' 2>tmp
```

Поиск по результату работы strace показал, что происходит системный вызов `chdir`:
```shell
stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")                           = 0
```

2. Попробуйте использовать команду `file` на объекты разных типов на файловой системе. Например:
    ```bash
    vagrant@netology1:~$ file /dev/tty
    /dev/tty: character special (5/0)
    vagrant@netology1:~$ file /dev/sda
    /dev/sda: block special (8/0)
    vagrant@netology1:~$ file /bin/bash
    /bin/bash: ELF 64-bit LSB shared object, x86-64
    ```
    Используя `strace` выясните, где находится база данных `file` на основании которой она делает свои догадки.

**Ответ:**

Часть вывода команды `strace`:
```shell
stat("/home/vagrant/.magic.mgc", 0x7ffe35a99f80) = -1 ENOENT (No such file or directory)
stat("/home/vagrant/.magic", 0x7ffe35a99f80) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
read(3, "# Magic local data for file(1) c"..., 4096) = 111
read(3, "", 4096)                       = 0
close(3)                                = 0
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
```
Судя по всему, `file` ищет в разных местах специальный файл `magic` и находит его по пути `/usr/share/misc/magic.mgc`.
Таким образом, в этом файле содержится база данных для команды `file`.

3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

**Ответ:**

При удалении файла можно отыскать открытый дескриптор этого файла через файловую систему `/proc`:
```shell
vagrant@vagrant:~$ ls -lh /proc/2588/fd/
total 0
lrwx------ 1 vagrant vagrant 64 Nov 22 19:36 0 -> /dev/pts/0
lrwx------ 1 vagrant vagrant 64 Nov 22 19:36 1 -> /dev/pts/0
lrwx------ 1 vagrant vagrant 64 Nov 22 19:36 2 -> /dev/pts/0
lr-x------ 1 vagrant vagrant 64 Nov 22 19:36 3 -> /dev/tty
lr-x------ 1 vagrant vagrant 64 Nov 22 19:36 4 -> '/home/vagrant/tmp (deleted)'
```

Далее можно обнулить этот файл при помощи `truncate`:
```shell
vagrant@vagrant:~$ truncate -s0 /proc/2588/fd/4
```

4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

**Ответ:**

Нет, зомби-процессы уже завершили свое выполнение, но присутствуют в системе в качестве списка процессов.
Они будут оставаться в системе пока родительский процесс не считает их код завершения и не сделает системный вызов wait().

5. В iovisor BCC есть утилита `opensnoop`:
    ```bash
    root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
    /usr/sbin/opensnoop-bpfcc
    ```
    На какие файлы вы увидели вызовы группы `open` за первую секунду работы утилиты? Воспользуйтесь пакетом `bpfcc-tools` для Ubuntu 20.04. Дополнительные [сведения по установке](https://github.com/iovisor/bcc/blob/master/INSTALL.md).

**Ответ:**
```shell
vagrant@vagrant:~$ sudo opensnoop-bpfcc
PID    COMM               FD ERR PATH
621    irqbalance          6   0 /proc/interrupts
621    irqbalance          6   0 /proc/stat
621    irqbalance          6   0 /proc/irq/20/smp_affinity
621    irqbalance          6   0 /proc/irq/0/smp_affinity
621    irqbalance          6   0 /proc/irq/1/smp_affinity
621    irqbalance          6   0 /proc/irq/8/smp_affinity
621    irqbalance          6   0 /proc/irq/12/smp_affinity
621    irqbalance          6   0 /proc/irq/14/smp_affinity
621    irqbalance          6   0 /proc/irq/15/smp_affinity
955    vminfo              4   0 /var/run/utmp
```

6. Какой системный вызов использует `uname -a`? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в `/proc`, где можно узнать версию ядра и релиз ОС.

**Ответ:**

Используется системный вызов `uname`:
```shell
vagrant@vagrant:~$ strace uname -a
...
uname({sysname="Linux", nodename="vagrant", ...}) = 0
...
```

Цитата из `man 2 uname`:
> Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.

Таким образом, часть информации может быть получена из `/proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}`.


7. Чем отличается последовательность команд через `;` и через `&&` в bash? Например:
    ```bash
    root@netology1:~# test -d /tmp/some_dir; echo Hi
    Hi
    root@netology1:~# test -d /tmp/some_dir && echo Hi
    root@netology1:~#
    ```
    Есть ли смысл использовать в bash `&&`, если применить `set -e`?

**Ответ:**

При использовании символа `;` между командами, они выполнятся последовательно друг за другом независимо от кода завершения
предыдущей команды.

Использование `&&` означает выполнить логическую операцию "И". В этом случае вторая команда выполнится только после
успешного выполнения первой команды.

Если в оболочке `bash` применить `set -e`, то в этом случае, при неудачном завершении команды произойдет выход
из оболочки. Однако, при использовании `&&` и `set -e`, может не произойти выход из оболочки. Поэтому нет смысла
одновременно использовать `&&` и `set -e`.

8. Из каких опций состоит режим bash `set -euxo pipefail` и почему его хорошо было бы использовать в сценариях?

**Ответ:**

Режим bash `set -euxo pipefail` состоит из следующих опций:

**-e** завершить команду, если она выдала ненулевой код завершения.

**-u** интерпретировать при подстановках неустановленные переменные как ошибки.

**-x** отображать команды вместе с их аргументами когда они выполняются (полезно для трассировки).

**-o pipefail** заменить код завершения конвейера на код завершения последней неудачно завершившейся команды
или нулевой код завершения, если все команды в конвейере завершились удачно.

Данный режим обеспечивает более безопасное выполнение скрипта путем раннего обнаружения некоторых типов проблем,
например: обращение к несуществующей переменной, появление ошибки по умолчанию не останавливает выполнение.

Таким образом, если включить данный режим, то поведение скрипта будет более приближено к некоторым высокоуровневым языкам
программирования, в которых такое поведение работает по умолчанию.

9. Используя `-o stat` для `ps`, определите, какой наиболее часто встречающийся статус у процессов в системе. В `man ps` ознакомьтесь (`/PROCESS STATE CODES`) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

**Ответ:**

```shell
vagrant@vagrant:~$ ps -eo stat | cut -c1 | sort | uniq -c
     55 I
      1 R
     67 S
```
Получается, что в системе больше всего процессов в статусе `I` (Idle kernel thread - ожидающие потоки ядра) 
и `S` (interruptible sleep - процессы в прерываемом сне, в ожидании событий).

## Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

1. На лекции мы познакомились с [node_exporter](https://github.com/prometheus/node_exporter/releases). В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой [unit-файл](https://www.freedesktop.org/software/systemd/man/systemd.service.html) для node_exporter:

    * поместите его в автозагрузку,
    * предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на `systemctl cat cron`),
    * удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

**Ответ:**

Написал следующий unit-файл для node_exporter и разместил его по пути `/lib/systemd/system`:
```shell
[Unit]
Description=Node Exporter
After=network.target

[Service]
EnvironmentFile=-/home/vagrant/node_exporter/options
ExecStart=/home/vagrant/node_exporter/node_exporter $OPTS
Restart=on-failure
Type=simple

[Install]
WantedBy=multi-user.target
```
Создаем файл, в котором можно будет указывать опции при запуске node_exporter:
```shell
vagrant@vagrant:~$ cat node_exporter/options
OPTS="--collector.cpu.info"
```
Включаем службу в автозапуск:
```shell
root@vagrant:/lib/systemd/system# systemctl enable node_exporter.service
```
Перечитаем настройки systemd:
```shell
root@vagrant:/lib/systemd/system# systemctl daemon-reload
```
Запускаем службу и проверяем статус:
```shell
root@vagrant:/lib/systemd/system# service node_exporter start
root@vagrant:/lib/systemd/system# service node_exporter status
● node_exporter.service - Node Exporter
     Loaded: loaded (/lib/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-11-24 15:28:13 UTC; 19s ago
   Main PID: 18859 (node_exporter)
      Tasks: 6 (limit: 2278)
     Memory: 2.7M
     CGroup: /system.slice/node_exporter.service
             └─18859 /home/vagrant/node_exporter/node_exporter --collector.cpu.info

Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=thermal_zone
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=time
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=timex
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=udp_queues
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=uname
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=vmstat
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=xfs
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.726Z caller=node_exporter.go:115 level=info collector=zfs
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.727Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9>
Nov 24 15:28:13 vagrant node_exporter[18859]: ts=2021-11-24T15:28:13.729Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=fal>
```
Проверяем, что служба работает:
```shell
vagrant@vagrant:~$ curl -s http://localhost:9100/metrics 2>/dev/null | grep node_filesystem_avail_bytes | grep mapper
node_filesystem_avail_bytes{device="/dev/mapper/vgvagrant-root",fstype="ext4",mountpoint="/"} 6.055673856e+10
```
Сервис корректно стартовал. Дальнейшие проверки показали, что сервис может быть успешно остановлен и запускается при перезагрузке. 

2. Ознакомьтесь с опциями node_exporter и выводом `/metrics` по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

**Ответ:**

Я бы выбрал следующие опции.

Для мониторинга CPU:
```
--collector.cpu.guest
--collector.cpu
--collector.cpufreq
```
Для мониторинга памяти:
```
--collector.meminfo
```
Для мониторинга дисков:
```  
--collector.diskstats
--collector.mdadm
--collector.mountstats
--collector.filesystem
--collector.filefd
```   
Для мониторинга сети:
```   
--collector.netstat
--collector.netdev
--collector.udp_queues
--collector.tcpstat
--collector.ethtool
```

3. Установите в свою виртуальную машину [Netdata](https://github.com/netdata/netdata). Воспользуйтесь [готовыми пакетами](https://packagecloud.io/netdata/netdata/install) для установки (`sudo apt install -y netdata`). После успешной установки:
    * в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`,
    * добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`:

    ```bash
    config.vm.network "forwarded_port", guest: 19999, host: 19999
    ```
    После успешной перезагрузки в браузере *на своем ПК* (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

**Ответ:**

Netdata успешно запущена в Vagrant, с метриками ознакомился:

![alt text](https://github.com/avloton/devops-netology/raw/main/img/netdata.png)

4. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

**Ответ:**

```shell
vagrant@vagrant:~$ dmesg | grep -i virt
[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.015495] CPU MTRRs all blank - virtualized system.
[    0.150097] Booting paravirtualized kernel on KVM
[  247.365533] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  249.139613] systemd[1]: Detected virtualization oracle.
```

Судя по строке, система успешно определила, что она запущена в виртуальной среде: 

```[  249.139613] systemd[1]: Detected virtualization oracle.```

5. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?

**Ответ:**

Значение в системе по умолчанию:
```shell
vagrant@vagrant:~$ cat /proc/sys/fs/nr_open
1048576
```
Из man:

```shell
/proc/sys/fs/nr_open (since Linux 2.6.25)
              This file imposes ceiling on the value to which the RLIMIT_NOFILE resource limit can  be  raised  (see  getrlimit(2)).
```

`/proc/sys/fs/nr_open`- этот файл накладывает ограничение на значение, до которого может быть увеличен лимит ресурсов RLIMIT_NOFILE.

Таким образом, `nr_open` задает верхнюю планку, до которой может быть увеличено число открытых файловых дескрипторов пользователем.
В свою очередь, максимальное число открытых файловых дескрипторов задается в файле `/etc/security/limits.conf`. 
Текущее значение можно посмотреть командой:

```shell
vagrant@vagrant:~$ ulimit -n
1024
```

6. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.

**Ответ:**

При помощи команды `unshare` запускаем процесс в новом namespace. Параметры `--pid` и `--fork` указывают на то, что нужно сделать fork
процесса и выделить новое пространство имен типа PID, `--mount-proc` создает новое пространство имен типа mount для procfs:
```shell
vagrant@vagrant:~$ sudo -i
root@vagrant:~# unshare --pid --fork --mount-proc sleep 1h &
[1] 1508
```

Отобразим пространства имен и находим, что PID процесса равен 1509:
```shell
root@vagrant:~# lsns
        NS TYPE   NPROCS   PID USER            COMMAND
4026531835 cgroup    123     1 root            /sbin/init
4026531836 pid       122     1 root            /sbin/init
4026531837 user      123     1 root            /sbin/init
4026531838 uts       121     1 root            /sbin/init
4026531839 ipc       123     1 root            /sbin/init
4026531840 mnt       111     1 root            /sbin/init
4026531860 mnt         1    33 root            kdevtmpfs
4026531992 net       123     1 root            /sbin/init
4026532162 mnt         1   397 root            /lib/systemd/systemd-udevd
4026532163 uts         1   397 root            /lib/systemd/systemd-udevd
4026532164 mnt         1   404 systemd-network /lib/systemd/systemd-networkd
4026532183 mnt         1   568 systemd-resolve /lib/systemd/systemd-resolved
4026532184 mnt         4   642 netdata         /usr/sbin/netdata -D
4026532185 mnt         2  1508 root            unshare --pid --fork --mount-proc sleep 1h
4026532186 pid         1  1509 root            sleep 1h
4026532248 mnt         1   599 root            /usr/sbin/irqbalance --foreground
4026532250 mnt         1   605 root            /lib/systemd/systemd-logind
4026532251 uts         1   605 root            /lib/systemd/systemd-logind
```
Подключаемся ко всем пространствам имен процесса, у которого PID равен 1509:
```shell
root@vagrant:~# nsenter -a -t 1509
```
Отображаем список процессов и видим, что у процесса sleep PID равен 1:
```shell
root@vagrant:/# ps
    PID TTY          TIME CMD
      1 pts/0    00:00:00 sleep
      2 pts/0    00:00:00 bash
     11 pts/0    00:00:00 ps
```

7. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

**Ответ:**

Команда `:(){ :|:& };:` - это форк бомба, в результате которой запускается функция, которая запускает два своих экземпляра, которые
в свою очередь запускают еще по два и т.д. Таким образом, будут создаваться новые процессы до исчерпания лимитов.

Вывод dmesg показал, что сработали лимиты системы `cgroups` на уровне user.slice.
Видимо сработали ограничения на максимальное число запущенных процессов в оболочке пользователя:
```shell
[ 3904.462086] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope
[ 3980.003059] watchdog: BUG: soft lockup - CPU#3 stuck for 45s! [bash:7286]
[ 3980.003230] watchdog: BUG: soft lockup - CPU#0 stuck for 45s! [bash:6465]
[ 3980.003400] watchdog: BUG: soft lockup - CPU#1 stuck for 45s! [bash:5013]
```

Текущий лимит на максимальное число запущенных процессов для пользователя, который вошел в систему, можно посмотреть командой (стоит limit: 5012):
```shell
vagrant@vagrant:~$ systemctl status user-1000.slice
● user-1000.slice - User Slice of UID 1000
     Loaded: loaded
    Drop-In: /usr/lib/systemd/system/user-.slice.d
             └─10-defaults.conf
     Active: active since Sun 2021-11-28 07:54:01 UTC; 5h 43min ago
       Docs: man:user@.service(5)
      Tasks: 15 (limit: 5012)
     Memory: 74.9M
     CGroup: /user.slice/user-1000.slice
```
Настройки этого лимита по умолчанию можно посмотреть командой (стоит 33% от системного ограничения):
```shell
vagrant@vagrant:~$ systemctl cat user-1000.slice

[Unit]
Description=User Slice of UID %j
Documentation=man:user@.service(5)
After=systemd-user-sessions.service
StopWhenUnneeded=yes

[Slice]
TasksMax=33%
```

Можно переопределить лимит на количество процессов вошедшего пользователя, создав файл по пути:
```shell
vagrant@vagrant:~$ sudo cat /usr/lib/systemd/system/user-1000.slice.d/10-tasksmax.conf
[Slice]
TasksMax=100
```
Перезагрузим systemd для применения настроек:
```shell
vagrant@vagrant:~$ sudo systemctl daemon-reload
```

Лимит для пользователя изменился (limit: 100):
```shell
vagrant@vagrant:~$ systemctl status user-1000.slice
● user-1000.slice - User Slice of UID 1000
     Loaded: loaded
    Drop-In: /usr/lib/systemd/system/user-.slice.d
             └─10-defaults.conf
             /usr/lib/systemd/system/user-1000.slice.d
             └─10-tasksmax.conf
     Active: active since Sun 2021-11-28 07:54:01 UTC; 5h 39min ago
       Docs: man:user@.service(5)
      Tasks: 15 (limit: 100)
     Memory: 74.9M
     CGroup: /user.slice/user-1000.slice
             ├─session-3.scope
```

## Домашнее задание к занятию "3.5. Файловые системы"

1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.

   
**Ответ:** Сделано.

2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?


   **Ответ:** Нет, файлы, которые являются жесткой ссылкой на один объект не могут иметь разные права доступа и владельца.
Причина в том, что информация о правах доступа и владельце хранится в специальной структуре объекта файловой системы, а жесткие ссылки - это всего лишь указатели на этот объект.

3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```bash
    Vagrant.configure("2") do |config|
      config.vm.box = "bento/ubuntu-20.04"
      config.vm.provider :virtualbox do |vb|
        lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
        lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
        vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
        vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
      end
    end
    ```

    Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

**Ответ:** Сделано.

4. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

**Ответ:**

Смотрим, появились диски /dev/sdb и /dev/sdc:
```shell
root@vagrant:~# fdisk -l
Disk /dev/sda: 64 GiB, 68719476736 bytes, 134217728 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x3f94c461

Device     Boot   Start       End   Sectors  Size Id Type
/dev/sda1  *       2048   1050623   1048576  512M  b W95 FAT32
/dev/sda2       1052670 134215679 133163010 63.5G  5 Extended
/dev/sda5       1052672 134215679 133163008 63.5G 8e Linux LVM


Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

Создаем разделы на диске /dev/sdb:

```shell


root@vagrant:~# fdisk /dev/sdb

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xf27a41f5.

Command (m for help):

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p):

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048): 2048
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help):

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): p
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x359b3e1c

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux

Command (m for help):


Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.

```

5. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.

**Ответ:**

```shell
root@vagrant:~# sfdisk --dump /dev/sdb > sdb.dump
root@vagrant:~# sfdisk /dev/sdc < sdb.dump
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0x359b3e1c.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0x359b3e1c

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

**Ответ:**
```shell
root@vagrant:~# mdadm --create /dev/md0 --level=raid1 --raid-devices=2 /dev/sd[bc]1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
```

7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

**Ответ:**
```shell
root@vagrant:~# mdadm --create /dev/md1 --level=raid0 --raid-devices=2 /dev/sd[bc]2
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
```

8. Создайте 2 независимых PV на получившихся md-устройствах.

**Ответ:**
```shell
root@vagrant:~# pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
root@vagrant:~# pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
```

9. Создайте общую volume-group на этих двух PV.

**Ответ:**
```shell
root@vagrant:~# vgcreate myvg /dev/md0 /dev/md1
  Volume group "myvg" successfully created
```

10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

**Ответ:**
```shell
root@vagrant:~# lvcreate --size 100M myvg /dev/md1
  Logical volume "lvol0" created.
```

11. Создайте `mkfs.ext4` ФС на получившемся LV.

**Ответ:**
```shell
root@vagrant:~# mkfs.ext4 /dev/myvg/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```

12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

**Ответ:**
```shell
root@vagrant:~# mkdir /tmp/new
root@vagrant:~# mount /dev/myvg/lvol0 /tmp/new/
```

13. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

**Ответ:**
```shell
root@vagrant:~# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2021-12-03 17:50:01--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22580844 (22M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz                    100%[==================================================================>]  21.53M   652KB/s    in 43s

2021-12-03 17:50:45 (513 KB/s) - ‘/tmp/new/test.gz’ saved [22580844/22580844]
```

14. Прикрепите вывод `lsblk`.

**Ответ:**
```shell
root@vagrant:~# lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─myvg-lvol0     253:2    0  100M  0 lvm   /tmp/new
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─myvg-lvol0     253:2    0  100M  0 lvm   /tmp/new
	
```

15. Протестируйте целостность файла:

**Ответ:**
```shell
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```

16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

**Ответ:**
```shell
root@vagrant:~# pvmove /dev/md1 /dev/md0
  /dev/md1: Moved: 20.00%
  /dev/md1: Moved: 100.00%
```

17. Сделайте `--fail` на устройство в вашем RAID1 md.

**Ответ:**
```shell
root@vagrant:~# mdadm /dev/md0 --fail /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0
```

18. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.

**Ответ:**
```shell
root@vagrant:~# dmesg | tail
[44537.872312] md0: detected capacity change from 0 to 2144337920
[44537.873666] md: resync of RAID array md0
[44548.532797] md: md0: resync done.
[44605.455954] md1: detected capacity change from 0 to 1067450368
[44746.127169] md: data-check of RAID array md0
[44756.722166] md: md0: data-check done.
[45337.404417] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[45337.404425] ext4 filesystem being mounted at /tmp/new supports timestamps until 2038 (0x7fffffff)
[46760.941886] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
			   
```

19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

**Ответ:**
```shell
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```

20. Погасите тестовый хост, `vagrant destroy`.

## Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

1. Работа c HTTP через телнет.
- Подключитесь утилитой телнет к сайту stackoverflow.com
`telnet stackoverflow.com 80`
- отправьте HTTP запрос
```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
- В ответе укажите полученный HTTP код, что он означает?

**Ответ:**
```shell
vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.193.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
x-request-guid: 721eb2dc-5ea4-4569-8a7e-360a1d2e95a0
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Sat, 04 Dec 2021 16:21:08 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-fra19147-FRA
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1638634868.341439,VS0,VE92
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=49c01730-2416-7790-d1b7-4e59a9ec6a8d; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Connection closed by foreign host.
```

Вернулся код `301 Moved Permanently` - это означает, что запрошенный ресурс был перемещен в новое месторасположение,
на которое указывает `location: https://stackoverflow.com/questions`.


2. Повторите задание 1 в браузере, используя консоль разработчика F12.
- откройте вкладку `Network`
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку `Headers`
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

**Ответ:**

Вернулся HTTP код ответа `307 Internal Redirect`.

Самый долгий запрос это `HTTP GET https://stackoverflow.com/`, который составил 548 мс.

Снимок экрана с консолью браузера:
![alt text](https://github.com/avloton/devops-netology/blob/main/img/hw_3.6_browser_console.png?raw=true)

3. Какой IP адрес у вас в интернете?

**Ответ:**

85.208.222.242 

4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`

**Ответ:**

```shell
vagrant@vagrant:~$ whois 85.208.222.242
% This is the RIPE Database query service.
% The objects are in RPSL format.
%
% The RIPE Database is subject to Terms and Conditions.
% See http://www.ripe.net/db/support/db-terms-conditions.pdf

% Note: this output has been filtered.
%       To receive output for a database update, use the "-B" flag.

% Information related to '85.208.222.0 - 85.208.223.255'

% Abuse contact for '85.208.222.0 - 85.208.223.255' is 'sunegina@mail.ru'

inetnum:        85.208.222.0 - 85.208.223.255
netname:        Infrastructure-UPS
country:        RU
admin-c:        VL5107-RIPE
tech-c:         VL5107-RIPE
status:         ASSIGNED PA
mnt-by:         mnt-ru-llcuralpromservice-1
created:        2019-03-13T06:02:49Z
last-modified:  2019-03-13T06:02:49Z
source:         RIPE

person:         Viktor V. Logunov
address:        LLC "Uralpromservice"
address:        Kushva, Sverdlovsk region
address:        Krasnoarmeiskaya, 16a
address:        Russian Federation
phone:          +7 904 1613535
nic-hdl:        VL5107-RIPE
mnt-by:         TAGNET-MNT
created:        2011-01-22T07:08:15Z
last-modified:  2011-01-22T17:40:52Z
source:         RIPE # Filtered

% Information related to '85.208.220.0/22AS51012'

route:          85.208.220.0/22
origin:         AS51012
mnt-by:         mnt-ru-llcuralpromservice-1
created:        2019-02-27T11:22:48Z
last-modified:  2019-02-27T11:22:48Z
source:         RIPE

% This query was served by the RIPE Database Query Service version 1.101 (WAGYU)
```
Из вывода команды можно понять, что ip адрес принадлежит провайдеру `LLC "Uralpromservice"`, у которого автономная система AS51012.

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`

**Ответ:**

```shell
vagrant@vagrant:~$ traceroute -An 8.8.8.8 -I
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.0.2.2 [*]  0.448 ms  0.258 ms  0.208 ms
 2  192.168.0.1 [*]  0.663 ms  0.585 ms  0.733 ms
 3  85.208.220.1 [AS51012]  1.204 ms  0.952 ms  0.993 ms
 4  10.10.11.3 [*]  3.549 ms  3.274 ms  3.369 ms
 5  85.208.223.246 [AS51012]  3.497 ms  3.508 ms  3.585 ms
 6  85.208.223.254 [AS51012]  3.348 ms  5.918 ms  4.776 ms
 7  95.167.75.141 [AS12389]  11.744 ms  10.596 ms  9.196 ms
 8  87.226.181.89 [AS12389]  33.574 ms  34.706 ms  33.558 ms
 9  * * *
10  108.170.250.113 [AS15169]  49.653 ms * *
11  * * *
12  74.125.253.94 [AS15169]  49.452 ms  46.018 ms  45.478 ms
13  209.85.251.63 [AS15169]  47.395 ms  48.366 ms  47.288 ms
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  8.8.8.8 [AS15169]  52.446 ms  51.243 ms *
```

6. Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка - delay?

**Ответ:**

```shell
vagrant@vagrant:~$ mtr -zn 8.8.8.8
```

```shell
                                        My traceroute  [v0.93]
vagrant (10.0.2.15)                                                          2021-12-04T17:28:59+0000
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                             Packets               Pings
 Host                                                      Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. AS???    10.0.2.2                                       0.0%    10    4.2   4.1   1.2  14.6   3.9
 2. AS???    192.168.0.1                                    0.0%    10    3.7   2.8   1.3   4.8   1.1
 3. AS51012  85.208.220.1                                   0.0%    10    4.3   4.0   2.4   6.4   1.1
 4. AS???    10.10.11.3                                     0.0%    10    7.3   4.9   2.5   7.6   1.8
 5. AS51012  85.208.223.246                                 0.0%    10    7.9   6.0   3.4   8.6   1.5
 6. AS51012  85.208.223.254                                10.0%    10    5.3   6.1   4.6   7.7   1.2
 7. AS12389  95.167.75.141                                 10.0%    10   11.6  10.8   7.8  13.1   1.9
 8. AS12389  87.226.181.89                                 10.0%    10   34.8  34.9  31.9  37.4   1.7
 9. AS12389  5.143.253.105                                 10.0%    10   35.8  35.2  33.5  36.8   1.1
10. AS15169  108.170.250.113                               10.0%    10   40.5  36.6  33.4  40.5   2.3
11. AS15169  142.251.49.158                                66.7%    10   46.5  47.8  46.5  50.1   2.0
12. AS15169  74.125.253.94                                  0.0%    10   68.0  52.0  44.3  68.0   8.5
13. AS15169  209.85.251.63                                  0.0%    10   51.8  50.5  48.9  53.1   1.5
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. (waiting for reply)
18. (waiting for reply)
19. (waiting for reply)
20. (waiting for reply)
21. (waiting for reply)
22. (waiting for reply)
23. AS15169  8.8.8.8                                        0.0%     9   50.1  52.5  50.1  54.7   1.4
```

Наибольшая задержка на участке `12. AS15169  74.125.253.94` - в этом месте ping составляет 68 мс.

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой `dig`

**Ответ:**

Получаем список A записей:
```shell
vagrant@vagrant:~$ dig dns.google A +noall +answer
dns.google.             38      IN      A       8.8.4.4
dns.google.             38      IN      A       8.8.8.8
```

Получаем список DNS серверов:
```shell
vagrant@vagrant:~$ dig dns.google NS +noall +answer
dns.google.             21097   IN      NS      ns1.zdns.google.
dns.google.             21097   IN      NS      ns3.zdns.google.
dns.google.             21097   IN      NS      ns2.zdns.google.
dns.google.             21097   IN      NS      ns4.zdns.google.
```

8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой `dig`

**Ответ:**
```shell
vagrant@vagrant:~$ dig -x 8.8.4.4 +noall +answer
4.4.8.8.in-addr.arpa.   20037   IN      PTR     dns.google.
vagrant@vagrant:~$ dig -x 8.8.8.8 +noall +answer
8.8.8.8.in-addr.arpa.   14157   IN      PTR     dns.google.
```

К обоим IP адресам привязано доменное имя `dns.google`.

## Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"

1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

**Ответ:**

В Linux:
```shell
vagrant@vagrant:~$ ip -br link show
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
eth0             UP             08:00:27:73:60:cf <BROADCAST,MULTICAST,UP,LOWER_UP>
```
В Windows:
```commandline
PS C:\Users\Anatol> netsh interface show interface

Состояние адм.  Состояние     Тип              Имя интерфейса
---------------------------------------------------------------------
Запрещен       Отключен       Выделенный       Ethernet 4
Разрешен       Отключен       Выделенный       Ethernet 2
Разрешен       Подключен      Выделенный       VirtualBox Host-Only Network
Разрешен       Подключен      Выделенный       Ethernet 5
Разрешен       Подключен      Выделенный       Ethernet
```

2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

**Ответ:**

Для распознавания соседа по сетевому интерфейсу используется протокол LLDP.

В Linux пакет устанавливается командой `apt install lldpd`.

Для управления и просмотром информации о работе LLDP в Linux применяются команды `lldpcli` и `lldpctl`.

3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

**Ответ:**

Для разделения коммутатора на несколько виртуальных сетей используется технология VLAN.

В Linux может быть использован следующий пакет `apt install vlan`.
Для настройки VLAN через командную строку можно использовать предустановленный пакет `iproute2`.
Пример настройки через `iproute2`:
```shell
root@vagrant:~# ip -br l
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
eth0             UP             08:00:27:73:60:cf <BROADCAST,MULTICAST,UP,LOWER_UP>

root@vagrant:~# ip link add link eth0 name eth0.100 type vlan id 100

root@vagrant:~# ip -br l
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
eth0             UP             08:00:27:73:60:cf <BROADCAST,MULTICAST,UP,LOWER_UP>
eth0.100@eth0    DOWN           08:00:27:73:60:cf <BROADCAST,MULTICAST>

root@vagrant:~# ip link set dev eth0.100 up

root@vagrant:~# ip -br l
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
eth0             UP             08:00:27:73:60:cf <BROADCAST,MULTICAST,UP,LOWER_UP>
eth0.100@eth0    UP             08:00:27:73:60:cf <BROADCAST,MULTICAST,UP,LOWER_UP>
```

Настройка VLAN может быть задана через файл `/etc/network/interfaces`:
```shell
auto vlan1400
iface vlan1400 inet static
        address 192.168.1.1
        netmask 255.255.255.0
        vlan_raw_device eth0
```

4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.

**Ответ:**

В Linux для агрегации нескольких сетевых интерфейсов в единый логический интерфейс используется драйвер bonding.
Типы агрегации в зависимости от опций подразделяются на горячее резервирование и балансировку.

Рассмотрим какие опции/режимы агрегации бывают (по умолчанию используется balance-rr):

- Active-backup – режим резервирования. В этом режиме один сетевой интерфейс активный, а второй в режиме ожидания. 
Когда основной выходит из строя, второй принимает работу на себя. Таким образом обеспечивается стабильный доступ.

- Balance-rr – пакеты отправляются последовательно. 
Этот режим применяется для балансировки нагрузки и отказоустойчивости.

- 802.3ad – при таком режиме задействуются сразу все сетевые карты. 
(этот режим должен поддерживаться и на коммутаторе)

- Balance-xor – режим применяется для отказоустойчивости и балансировки. 
Одна и та же сетевая карта передает пакеты одним и тем же получателям.

- Broadcast – этот режим передает все пакеты на все сетевые карты.

- Balance-tlb – режим адаптивной балансировки передачи. 
Исходящий трафик распределяется в зависимости от загруженности каждой сетевой карты (определяется скоростью загрузки). 
Не требует дополнительной настройки на коммутаторе. 
Входящий трафик приходит на текущую сетевую карту. 
Если она выходит из строя, то другая сетевая карта берёт себе MAC адрес вышедшей из строя карты.

- Balance-alb - режим адаптивной балансировки нагрузки. 
Включает в себя политику balance-tlb плюс осуществляет балансировку входящего трафика. 
Не требует дополнительной настройки на коммутаторе. 
Балансировка входящего трафика достигается путём ARP переговоров. 
Драйвер bonding перехватывает ARP ответы, отправляемые с локальных сетевых карт наружу, и переписывает MAC адрес источника на один из уникальных MAC адресов сетевой карты, участвующей в объединении. 
Таким образом различные пиры используют различные MAC адреса сервера. 
Балансировка входящего трафика распределяется последовательно (round-robin) между интерфейсами.

Пример конфига в файле /etc/network/interfaces:
```shell
# Define slaves   
auto eth0
iface eth0 inet manual
    bond-master bond0
    bond-primary eth0
    bond-mode active-backup
   
auto wlan0
iface wlan0 inet manual
    wpa-conf /etc/network/wpa.conf
    bond-master bond0
    bond-primary eth0
    bond-mode active-backup

# Define master
auto bond0
iface bond0 inet dhcp
    bond-slaves none
    bond-primary eth0
    bond-mode active-backup
    bond-miimon 100
```

5. Сколько IP адресов в сети с маской /29? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

**Ответ:**

- Сколько IP адресов в сети с маской /29?

Максимум можно использовать 6 адресов (плюс адрес сети и широковещательный).

- Сколько /29 подсетей можно получить из сети с маской /24

Можно получить 32 подсети.

- Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

10.10.10.0/29, 10.10.10.8/29, 10.10.10.16/29.

6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

**Ответ:**

Можно задействовать подсеть из диапазона 100.64.0.0/10, так как данная подсеть 
рекомендована согласно RFC 6598 для использования в качестве адресов для CGN.

Из расчета того, что достаточно максимум 40-50 хостов внутри сети, 
то можно выбрать подсеть 100.64.0.0/26 (диапазон адресов 100.64.0.1 - 100.64.0.62).

7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

**Ответ:**

Примеры команд в Windows.

- отображение таблицы ARP для всех интерфейсов:
```commandline
PS C:\Users\Anatol> arp -a

Интерфейс: 192.168.56.1 --- 0x3
  адрес в Интернете      Физический адрес      Тип
  192.168.56.255        ff-ff-ff-ff-ff-ff     статический
  224.0.0.2             01-00-5e-00-00-02     статический
  224.0.0.22            01-00-5e-00-00-16     статический
  224.0.0.251           01-00-5e-00-00-fb     статический
  224.0.0.252           01-00-5e-00-00-fc     статический
  239.255.255.250       01-00-5e-7f-ff-fa     статический
```
- полная очистка ARP кэша:
```commandline
C:\Windows\system32>netsh interface ip delete arpcache
```
- удаление конкретного ip адреса:
```commandline
C:\Windows\system32>arp -d 192.168.0.100
```

Примеры команд в Linux.

- отображение таблицы ARP:
```shell
vagrant@vagrant:~$ ip neigh
10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 DELAY
10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 STALE
```
- полная очистка ARP для интерфейса eth0:
```shell
vagrant@vagrant:~$ sudo ip neigh flush dev eth0
```
- удаление конкретного ip адреса:
```shell
vagrant@vagrant:~$ sudo ip neigh del 10.0.2.3 dev eth0
```

## Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
**Ответ:**
```
route-views>show ip route 85.208.222.242
Routing entry for 85.208.220.0/22
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 1w2d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 1w2d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 6939
      MPLS label: none
```
```
route-views>show bgp 85.208.222.242
BGP routing table entry for 85.208.220.0/22, version 1388583848
Paths: (24 available, best #24, table default)
  Not advertised to any peer
  Refresh Epoch 1
  2497 12389 51012
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin IGP, localpref 100, valid, external
      path 7FE1502ACBB8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 1299 12389 51012
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE127D30428 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 3356 12389 51012
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE165B8CBF8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 3
  3303 12389 51012
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3303:1004 3303:1006 3303:1030 3303:3056
      path 7FE122533BB0 RPKI State not found
      rx pathid: 0, tx pathid: 0
```


2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

**Ответ:**
Создаем несколько dummy интерфейсов:
```shell
vagrant@vagrant:~$ sudo modprobe -v dummy numdummies=2
insmod /lib/modules/5.4.0-80-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=2
```
Проверяем, что модуль ядра успешно подгрузился:
```shell
vagrant@vagrant:~$ lsmod | grep dummy
dummy                  16384  0
```
Проверяем наличие dummy интерфейсов:
```shell
vagrant@vagrant:~$ ip -br a
lo               UNKNOWN        127.0.0.1/8 ::1/128
eth0             UP             10.0.2.15/24 fe80::a00:27ff:fe73:60cf/64
dummy0           DOWN
dummy1           DOWN
```
Поднимаем интерфейс dummy0:
```shell
vagrant@vagrant:~$ sudo ip link set dev dummy0 up
```
Прописываем несколько статических маршрутов:
```shell
vagrant@vagrant:~$ sudo ip route add 172.17.0.0/16 via 172.16.0.1
vagrant@vagrant:~$ sudo ip route add 172.18.0.0/16 via 172.16.0.1
```
Проверяем таблицу маршрутизации:
```shell
vagrant@vagrant:~$ ip r
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100
172.16.0.0/24 dev dummy0 proto kernel scope link src 172.16.0.1
172.17.0.0/16 via 172.16.0.1 dev dummy0
172.18.0.0/16 via 172.16.0.1 dev dummy0
```

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

**Ответ:**
```shell
root@vagrant:~# ss -atnp4
State             Recv-Q            Send-Q                        Local Address:Port                          Peer Address:Port             Process
LISTEN            0                 4096                                0.0.0.0:111                                0.0.0.0:*                 users:(("rpcbind",pid=574,fd=4),("systemd",pid=1,fd=35))
LISTEN            0                 4096                          127.0.0.53%lo:53                                 0.0.0.0:*                 users:(("systemd-resolve",pid=575,fd=13))
LISTEN            0                 128                                 0.0.0.0:22                                 0.0.0.0:*                 users:(("sshd",pid=694,fd=3))
LISTEN            0                 4096                              127.0.0.1:8125                               0.0.0.0:*                 users:(("netdata",pid=659,fd=56))
LISTEN            0                 4096                                0.0.0.0:19999                              0.0.0.0:*                 users:(("netdata",pid=659,fd=4))
ESTAB             0                 0                                 10.0.2.15:22                                10.0.2.2:56624             users:(("sshd",pid=1472,fd=4),("sshd",pid=1423,fd=4))
```
Из вывода видно, что системное приложение `systemd-resolve` слушает порт 53/tcp на адресе 127.0.0.53, который предназначен для протокола DNS.
Приложение `sshd` слушает порт 22/tcp на всех интерфейсах.
Установлено соединение TCP между `10.0.2.15:22` и `10.0.2.2:56624`.

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

**Ответ:**
```shell
root@vagrant:~# ss -aunp4
State             Recv-Q            Send-Q                          Local Address:Port                         Peer Address:Port            Process
UNCONN            0                 0                               127.0.0.53%lo:53                                0.0.0.0:*                users:(("systemd-resolve",pid=575,fd=12))
UNCONN            0                 0                              10.0.2.15%eth0:68                                0.0.0.0:*                users:(("systemd-network",pid=407,fd=19))
UNCONN            0                 0                                     0.0.0.0:111                               0.0.0.0:*                users:(("rpcbind",pid=574,fd=5),("systemd",pid=1,fd=36))
UNCONN            0                 0                                   127.0.0.1:8125                              0.0.0.0:*                users:(("netdata",pid=659,fd=54))
```
Из вывода видно, что системное приложение `systemd-network` слушает порт 68/udp на адресе 10.0.2.15, которое предназначено для протокола `dhcp`.
Приложение `netdata` слушает порт 8125/udp на localhost.
Системное приложение `systemd-resolve` слушает порт 53/udp на адресе 127.0.0.53.

5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали. 

**Ответ:**

![alt_text](https://github.com/avloton/devops-netology/raw/main/img/network.png)

## Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

1. Установите Bitwarden плагин для браузера. Зарегистрируйтесь и сохраните несколько паролей.

**Ответ:**

Сделано:

![alt_text](https://github.com/avloton/devops-netology/raw/main/img/bitwarden.png)

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

**Ответ:**

Сделано.

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

**Ответ:**

Устанавливаем apache:
```shell
root@vagrant:/etc/apache2# apt install apache2
```

Генерируем закрытый ключ и самоподписанный сертификат:
```shell
root@vagrant:/etc/apache2# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=Company
 Name/OU=Org/CN=www.example.com"
Generating a RSA private key
.............................................................................................................+++++
.........................................+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----
```
Подключаем необходимые модули в apache:
```shell
root@vagrant:/etc/apache2# a2enmod rewrite
root@vagrant:/etc/apache2# a2enmod ssl
root@vagrant:/etc/apache2# a2enmod headers
root@vagrant:/etc/apache2# systemctl restart apache2
```
Прописываем конфигурацию для SSL (основа взята с ресурса https://ssl-config.mozilla.org/):
```shell
root@vagrant:/etc/apache2# vim /etc/apache2/sites-available/self-signed-ssl.conf

<VirtualHost *:80>
    RewriteEngine On
    RewriteCond %{REQUEST_URI} !^/\.well\-known/acme\-challenge/
    RewriteRule ^(.*)$ https://%{HTTP_HOST}$1 [R=301,L]
</VirtualHost>

<VirtualHost *:443>
    SSLEngine on
    ServerName localhost
    DocumentRoot /var/www/html
    # curl https://ssl-config.mozilla.org/ffdhe2048.txt >> /path/to/signed_cert_and_intermediate_certs_and_dhparams
    SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile   /etc/ssl/private/apache-selfsigned.key

    # enable HTTP/2, if available
    Protocols h2 http/1.1

    # HTTP Strict Transport Security (mod_headers is required) (63072000 seconds)
    Header always set Strict-Transport-Security "max-age=63072000"
</VirtualHost>

# intermediate configuration
SSLProtocol             all -SSLv3 -TLSv1 -TLSv1.1
SSLCipherSuite          ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
SSLHonorCipherOrder     off
SSLSessionTickets       off
```
Включаем новую конфигурацию, отключаем старую, проверяем конфиг:
```shell
root@vagrant:/etc/apache2# a2ensite self-signed-ssl.conf 
root@vagrant:/etc/apache2# a2dissite 000-default.conf
root@vagrant:/etc/apache2# apache2ctl configtest
root@vagrant:/etc/apache2# systemctl reload apache2
```

 В результате тестовый сайт доступен через HTTPS:

![alt_text](https://github.com/avloton/devops-netology/raw/main/img/ssl_apache2.png)

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

**Ответ:**

Проверка на TLS уязвимости сайта https://testssl.sh:

```shell
vagrant@vagrant:~/testssl.sh$ ./testssl.sh -U --sneaky https://testssl.sh/

###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/
    (6da72bc 2021-12-10 20:16:28 -- )

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
 on vagrant:./bin/openssl.Linux.x86_64
 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


 Start 2021-12-11 13:10:28        -->> 81.169.166.184:443 (testssl.sh) <<--

 Further IP addresses:   2a01:238:4308:a920:1000:0:e571:51
 rDNS (81.169.166.184):  testssl.sh.
 Service detected:       HTTP


 Testing vulnerabilities

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK), no session ticket extension
 ROBOT                                     not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    no gzip/deflate/compress/br HTTP compression (OK)  - only supplied "/" tested
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services
                                           https://censys.io/ipv4?q=317383D12511E625564E8C850DD7494CAC6903ECAD7394055A5D3FB5E6EFB402 could help you to find out
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no common prime detected
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES256-SHA ECDHE-RSA-AES128-SHA DHE-RSA-CAMELLIA256-SHA DHE-RSA-CAMELLIA128-SHA DHE-RSA-AES256-SHA DHE-RSA-AES128-SHA AES256-SHA
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2021-12-11 13:11:38 [  75s] -->> 81.169.166.184:443 (testssl.sh) <<--
```

Найдена уязвимость BEAST (CVE-2011-3389).

5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
 
**Ответ:**

6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

**Ответ:**

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

**Ответ:**

