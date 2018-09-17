.DEFAULT_GOAL := help

cp-slow-log: ## ログを持ってくる
	sudo cat /var/log/mariadb/slow.log > ./slow.log

update-mycnf: ## my.confを更新してリスタート
	sudo cp config/my.cnf /etc/my.cnf
	make restart-mariadb

restart-mariadb: ## dbをrestart
	# sudo rm /var/log/mariadb/slow.log
	sudo systemctl restart mariadb.service

.PHONY: help
help:
	@grep -E '^[a-z0-9A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
