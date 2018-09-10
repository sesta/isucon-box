.DEFAULT_GOAL := help

restart: ## copy configs from repository to conf
	sudo cp /home/isucon/myetc/config/nginx/nginx.conf /etc/nginx/
	sudo cp /home/isucon/myetc/config/nginx/sites-available/nginx.conf /etc/nginx/sites-available/nginx.conf
	sudo cp /home/isucon/myetc/config/my.cnf /etc/mysql/my.cnf
	sudo cp /home/isucon/myetc/config/sysctl.conf /etc/
	make -s nginx-restart
	make -s ruby-restart
	make -s alp-clear

ruby-log: ## log Server
	sudo journalctl -u isubata.ruby.service

ruby-restart: ## Restart Server
	sudo systemctl daemon-reload
	cd /home/isucon/isubata/webapp/ruby; /home/isucon/local/ruby/bin/bundle 1> /dev/null
	sudo systemctl restart isubata.ruby.service
	@echo 'Restart isu-ruby'

nginx-restart: ## Restart nginx
	sudo systemctl restart nginx
	@echo 'Restart nginx'

nginx-log: ## tail nginx access.log
	sudo tail -f /var/log/nginx/access.log

nginx-error-log: ## tail nginx error.log
	sudo tail -f /var/log/nginx/error.log

db-restart: ## Restart mysql
	sudo systemctl restart mysql
	@echo 'ruby-restart after this'

db-log: ## tail mysql.log
	sudo tail -f /var/log/mysql/mysql.log

myprofiler: ## Run myprofiler
	myprofiler -user=isucon -password=isucon

.PHONY: help
help:
	@grep -E '^[a-z0-9A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

slow-query-setting-set: ## スロークエリを吐き出す設定にする
	sudo echo '' > /tmp/mysql-slow.log
	mysql -u isucon -pisucon < slow_query_setting.sql

slow-query-log-copy: ## 吐き出したスロークエリをisuconホームに持ってくる
	sudo cp /tmp/mysql-slow.log ./
	sudo chown -R isucon mysql-slow.log

ubuntu: ## switch ubuntu user
	@echo 'change to ubuntu user'
	sudo su - ubuntu

netdata-enable: ## enable netdata
	@echo 'enable netdata'
	sudo systemctl enable netdata

netdata-status: ## show netdata status
	sudo systemctl status netdata

netdata-disable: ## disable netdata
	@echo 'disable netdata'
	sudo systemctl disable netdata

ruby-start: ## start ruby
	@echo 'start ruby'
	sudo systemctl start isubata.ruby.service

ruby-stop: ## stop ruby
	@echo 'stop ruby'
	sudo systemctl stop isubata.ruby.service

ruby-status: ## show ruby status
	@echo 'show ruby status'
	sudo systemctl status isubata.ruby.service

bundle-install: ## bundle install
	cd /home/isucon/webapp/ruby; /home/isucon/.local/ruby/bin/bundle install

alp: ## Run alp
	sudo alp -f /var/log/nginx/access_for_alp.log --sum -r --aggregates '/icons/\w+, /history/\w+, /fetch/\w+, /channel/\w+, /fonts/\w+, /add_channel' --excludes='fetch'

alp-clear: ## clear nginx access.log
	@echo 'clear nginx access.log'
	sudo sh -c "cat /dev/null > /var/log/nginx/access.log"
	sudo sh -c "cat /dev/null > /var/log/nginx/access_for_alp.log"

applog-tail: ## journalctl tail application logs
	@echo 'tail application log'
	sudo journalctl -f -u isubata.ruby.service

git-reload: # git fetch & git merge origin/master
	@echo 'git fetch & git merge origin/master'
	cd /home/isucon
	git fetch origin
	git merge origin/master
