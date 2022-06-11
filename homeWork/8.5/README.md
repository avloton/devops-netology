Команда запуска контейнера, который содержит несколько версий Python и Tox:

```
docker run --privileged=True \
-v /home/anatol/Anatol/netology/vector-role:/opt/vector-role \
-v /var/run/docker.sock:/var/run/docker.sock \
-w /opt/vector-role \
-it tox_multi_python /bin/bash
```