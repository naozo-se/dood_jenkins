## 概要
ホストのDockerが操作できるJenkins

## 構築
```shell
cd [current_dir]
mkdir jenkins_home
chown -R [uid]:[gid]
docker-compose up -d --build
```

## 初回パスワード
```shell
docker exec -ti [container_name] bash
cat /var/jenkins_home/secrets/initialAdminPassword
```
