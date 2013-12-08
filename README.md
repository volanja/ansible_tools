# AnsibleTools

Ansible Tools e.g. Create directory by BestPractice

## Installation

Add this line to your application's Gemfile:

    gem 'ansible_tools'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ansible_tools

## Usage

```
$ ansible-tools
Commands:
  ansible-tools help [COMMAND]  # Describe available commands or one specific command
  ansible-tools init [-s][-r]   # create ansible files by BestPractice
  ansible-tools show            # show ansible valiables in vars/main.yml
  ansible-tools version         # show version
```

### BestPractice
[Best Practices - ANSIBLEWORKS](http://www.ansibleworks.com/docs/playbooks_best_practices.html)

```
$ ansbile-tools init
		create	roles/common/tasks
		create	roles/common/handlers
		create	roles/common/templates
		create	roles/common/vars
		create	roles/common/file
		create	group_var
		create	host_var
		create	site.yml
		create	roles/common/tasks/main.yml
		create	roles/common/handlers/main.yml
		create	roles/common/templates/foo.conf.j2
		create	roles/common/vars/main.yml
		create	roles/common/file/bar.txt
		create	production
		create	stage
		create	group_var/group1
		create	group_var/group2
		create	host_var/hostname1
		create	host_var/hostname2
```

### Simple

```
$ ansbile-tools init -s
		create	roles/common/tasks
		create	roles/common/handlers
		create	roles/common/templates
		create	roles/common/vars
		create	roles/common/file
		create	site.yml
		create	roles/common/tasks/main.yml
		create	roles/common/handlers/main.yml
		create	roles/common/templates/foo.conf.j2
		create	roles/common/vars/main.yml
		create	roles/common/file/bar.txt
```

### Add Role

```
$ ansbile-tools init -r <roles name>

$ ansible-tools init -r gitlab
		create	roles/gitlab/tasks
		create	roles/gitlab/handlers
		create	roles/gitlab/templates
		create	roles/gitlab/vars
		create	roles/gitlab/file
		create	site.yml
		create	roles/gitlab/tasks/main.yml
		create	roles/gitlab/handlers/main.yml
		create	roles/gitlab/templates/foo.conf.j2
		create	roles/gitlab/vars/main.yml
		create	roles/gitlab/file/bar.txt
```

### Show Variables
Search vars/main.yml and write list

```
$ ansbile-tools show
+----------------------------------------------------------------------------+
|             File             |          Key          |        Value        |
+----------------------------------------------------------------------------+
| roles/gitlab/vars/main.yml   | mysql_gitlab_password | password            |
| roles/gitlab/vars/main.yml   | mysql_gitlab_database | gitlabhq_production |
| roles/mariadb/vars/main.yml  | mysql_root_password   | password            |
| roles/Packages/vars/main.yml | www_port              |                  80 |
| roles/ruby/vars/main.yml     | ruby_ver              | 2.0.0-p247          |
+----------------------------------------------------------------------------+
```

### Show Variables
show version

```
$ ansbile-tools version
0.0.1
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO
+ Make Test
