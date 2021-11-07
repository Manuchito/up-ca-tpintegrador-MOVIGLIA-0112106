#!/bin/bash

timestamp=$(date -Is)

if [ ! -d "./logs" ]; then
    mkdir logs
fi

touch ./logs/backup_home_cliente-03.sh_$timestamp.log
logfile = "./logs/backup_home_cliente-03.sh_$timestamp.log"

echo "Archivo log creado!"

if ping -c 1 -W 1 192.168.20.3; then
	echo "Cliente-03 ONLINE!"
	echo "Copiando archivos del home remoto al disco de backups"

        rsync -avzrh -stats -e ssh --delete --no-perms --exclude '.cache' cliente-03@192.168.20.3:/home /media/disco_backups/ --log-file=$logfile

	echo "..."
	echo "LISTO!"

	ls -la /media/disco_backups/home/cliente-03/

else
    echo "Cliente-03 OFFLINE!"
fi
