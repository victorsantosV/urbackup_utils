## Intalação LXD e LXC

#### Instalando o LXD
```bash
##instalacao lxd
sudo snap install lxd
```
#### Instalando o LXC
```bash
##instalacao lxc
sudo apt-get install lxc
```
## Criação dos discos 

##### TIPO BTRFS

```bash
lxc storage create <nome-do-storage> btrfs
```
## Criando a rede

```bash
lxc network create <nome-da-rede>

## Exemplo com placa local
lxc network create eth0 --type=macvlan parent=enp2s0
```

#### A rede com faixa 3 é a rede que o lxd criou e a outra é a placa que ta parente do computador.
![alt text](./image/ipv4-redes-vm.png)

## Criando maquina

```bash
lxc launch ubuntu:20.04 <nome-que-voce-quer-na-maquina> --storage <nome-do-storage> --network <nome-da-rede>
```

## LXC SNAPSHOT

```bash
## Voce cria um snapshot
lxc snapshot <nome-da-instancia> <nome-do-arquivo>

## Voce list o numero de snapshots presentes na instancia
lxc list <nome-da-instancia>

## voce mostra o nome de cada snap que esta atralado a instancia
lxc info <nome-da-instancia>
```

```bash
## Voce entra na vm
lxc exec <nome-da-instancia> bash
```

### LXC RESTORE SNAPSHOT
```bash
## Voce da um restore em um snapshot em tempo de execução
lxc restore <nome-da-instancia> <nome-do-arquivo>
```
# Urbackup 

## Cliente

```bash
## instalacao do client
apt install build-essential "g++" libwxgtk3.0-gtk3-dev "libcrypto++-dev" libz-dev

apt update

TF=$(mktemp) && wget "https://hndl.urbackup.org/Client/2.4.11/UrBackup%20Client%20Linux%202.4.11.sh" -O $TF && sudo sh $TF; rm -f $TF
```
### Descrição das flags e todas as suas funcionalidades
Flag | Descrição
---|---
-x| Não cruze o limite do sistema de arquivos durante o backup
-f| Não siga links simbólicos fora do caminho de backup
-d| Diretório
-a| Não compartilhe hashes locais com outros clientes virtuais
-g| Grupo para qual ele pertence
-v| sub cliente virtual ao qual ele pertence
-c| server

```bash
#comandos e configuracoes
## adicionar o backup dir no cliente
urbackupclientctl add-backupdir -d /backup

## verifica o estado do server client
systemctl status urbackupclientbackend

## adicionar uma pasta no server filho ou virtual
urbackupclientctl add-backupdir -d /admin -v admin

```

#### Recovery de server na visão do client 
Caso o servidor client precise ser modificado, o unico arquivo que voce tem que se preocupar eh o server_idents.txt, que possui a conexão com os server, nele voce conecta os servidores e ao criar os clients novamente ele faz o recovery automaticamente

#### Client configuration

ativar o modo internet, pegar a key, atribuir ao client

 Você deve fazer backup de “/var/urbackup” ou “C

```bash
## Criar pasta subvolume
sudo btrfs subvolume create /btrf
```
#### urbackupclientctl Browse Params

Flag | Descrição
---|---
-b| Id ao qual voce quer voltar
-d| Diretório
-v| sub cliente virtual ao qual ele pertence
-c| server

#### urbackupclientctl restore-start params

Flag | Descrição
---|----
-b| Id ao qual voce quer voltar
-t| Mapeamento de qual pasta voce quer comecar 
-m| mapeamento de qual pasta voce quer sair diferente do  configurado  
-f| Não siga links simbólicos fora do caminho de backup 
-d| Diretório 
-v| sub cliente virtual ao qual ele pertence 
-c| server 

#### Configurando o cliente para receber os servidores
O caminho a seguir corresponde a todas as chaves que são disponiveis para autenticar o servidor com o client, tanto local, como no modelo internet

![alt text](./image/urbackup_key_server.png)
Essa é a chave ao qual voce deve colocar no servidor 

Devemos colar esta chave no arquivo server_idents e reinciar os servicos para que ambos consigam se conectar

os passos são:

```sh
## Caso o servico esteja rodando
vi /usr/local/var/urbackup/server_idents.txt
```

![alt text](./image/token.png)
cole a chave que pegamos e esta a mostra na imagem acima
Salve

```sh
systemctl restart urbackupclientbackend

## Para acompanhar o resultado
urbackupclientctl status
```

## =======================================

## Server

```bash
## Primeiro, atualize todos os packages
sudo apt update
## Siga os passos para instalar o server
sudo add-apt-repository ppa:uroni/urbackup \
sudo apt update \
sudo apt install urbackup-server 

Depois de instalado, configure o caminho padrao dele, ou para um disco desejado ou para a pasta srv, onde a permissao de escrita existe
```

### Configurações de backups

```bash
## Caminho de salvamento e configuração de snapshot
/usr/local/etc/urbackup/snapshot.cfg

## caminho para configuração de rede
vi /etc/netplan/50-cloud-init.yaml

## manda arquivos para outros server
rsync -avzrhP ./server_ident* root@10.219.176.252:/keys

```
### Criando link simbolico
ln -s /usr/local/var/urbackup /urbackup

### Para encontrar algo relacionado a algum ambiente 

find . -iname '*urbackup*'

### Para que o servidor se torne sincronizado com o client em um ambiente btrfs, mude o caminho padrao para a pasta

```bash
systemctl stop urbackupsrv
mv /media/BACKUP/urbackup ==> /srv/urbackup/backups/
systemctl start urbackupsvc
## mudar no ambiente grafico
```


### Caso o servidor nao apareça o sistem de restore do urbackup

```bash
### Edite esse arquivo e na aba restore coloque RESTORE=server-confirms
vi /etc/default/urbackupclient
service urbackupclientbackend restart
```

adicionar client
adicionar virtual client
modo internet
configuração de client especifico | global
correios
recovery modo grafico
segurança

chmod +x ./install_my_apps.sh


## criar um arquivo chamado prefilebackup   
```bash

## incremental file
post_incr_filebackup

## ful bkp
post_full_filebackup
```

## arrumando o sqlcmd para que o urbackup entenda

```bash
sudo ls /opt/mssql-tools/bin/sqlcmd*
sudo ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd
```

## caminho e o que eles tem

```bash

/usr/local/var/urbackup => server idents
/usr/local/etc/urbackup => scripts pre-backup

```