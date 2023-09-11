.PHONY: start

start: list.txt
	/usr/app/ii-node -sys "NeonXP Station" -db /usr/app/db

list.txt:
	wget http://club.hugeping.ru/list.txt
	/usr/app/ii-tool -db /usr/app/db fetch http://club.hugeping.ru
