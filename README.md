# AnsibleTools

Ansible Tools e.g. Create directory by BestPractice

[![Gem Version](https://badge.fury.io/rb/ansible_tools.png)](http://badge.fury.io/rb/ansible_tools)
[![Code Climate](https://codeclimate.com/github/volanja/ansible_tools.png)](https://codeclimate.com/github/volanja/ansible_tools)
[![Build Status](https://travis-ci.org/volanja/ansible_tools.svg?branch=master)](https://travis-ci.org/volanja/ansible_tools)

## Installation

Install it yourself as:
```
$ gem install ansible_tools
```

## Usage

```
$ ansible-tools
Commands:
  ansible-tools help [COMMAND]      # Describe available commands or one specific command
  ansible-tools init [-s][-r][-y]  # create ansible files by BestPractice
  ansible-tools show                # show ansible valiables in vars/main.yml
  ansible-tools version             # show version
```

### BestPractice
[Best Practices - ANSIBLEWORKS](http://www.ansibleworks.com/docs/playbooks_best_practices.html)

```
$ ansbile-tools init [-y]
		create	roles/common/tasks
		create	roles/common/handlers
		create	roles/common/templates
		create	roles/common/vars
		create	roles/common/files
		create	group_vars
		create	host_vars
		create	site.yml
		create	roles/common/tasks/main.yml
		create	roles/common/handlers/main.yml
		create	roles/common/templates/foo.conf.j2  #(*1)
		create	roles/common/vars/main.yml
		create	roles/common/files/bar.txt  #(*1)
		create	production  #(*1)
		create	stage       #(*1)
		create	group_vars/group1  #(*1)
		create	group_vars/group2  #(*1)
		create	host_vars/hostname1  #(*1)
		create	host_vars/hostname2  #(*1)

(*1)...if set [-y], this file is not create.
```

### Simple

```
$ ansbile-tools init -s [-y]
		create	roles/common/tasks
		create	roles/common/handlers
		create	roles/common/templates
		create	roles/common/vars
		create	roles/common/files
		create	site.yml
		create	roles/common/tasks/main.yml
		create	roles/common/handlers/main.yml
		create	roles/common/templates/foo.conf.j2  #(*1)
		create	roles/common/vars/main.yml
		create	roles/common/files/bar.txt  #(*1)

(*1)...if set [-y], this file is not create.
```

### Add Role

```
$ ansbile-tools init -r <roles name> [-y]

$ ansible-tools init -r gitlab
		create	roles/gitlab/tasks
		create	roles/gitlab/handlers
		create	roles/gitlab/templates
		create	roles/gitlab/vars
		create	roles/gitlab/files
		create	site.yml
		create	roles/gitlab/tasks/main.yml
		create	roles/gitlab/handlers/main.yml
		create	roles/gitlab/templates/foo.conf.j2  #(*1)
		create	roles/gitlab/vars/main.yml
		create	roles/gitlab/files/bar.txt  #(*1)

(*1)...if set [-y], this file is not create.
```

### Show Variables
Search file and write list
file =>  `roles/*/vars/main.yml`, `group_vars/*.yml`, `host_vars/*.yml`, `*.yml`

```
$ ansbile-tools show
+----------------------------------------------------------------------------+
|             File             |          Key          |        Value        |
+----------------------------------------------------------------------------+
| host_vars/main.yml           | var1                  | num1                |
| group_vars/main.yml          | var2                  | num2                |
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
0.0.4
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## History
0.0.4  Add Option init [-y]

## TODO
+ Make Test
