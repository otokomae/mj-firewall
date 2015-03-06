mj-firewall Cookbook
======================
Ubuntuにて ufw にてファイアウォールの設定を行うクックブック。
ssh, mysql についてのアクセス制限、http/https を通す設定。を行うクックブック。

ssh, mysql は IPアドレスを指定してアクセスの制限を行う。
mysqlは IP指定が無い場合は、外部からの接続は行わせない。

Requirements
------------

- `firewall` - firewallクックブック

Attributes
----------

* ssh_port: 22(default)
* mysql_port: 3306(default)
* sources:
  * ssh: []
  * mysql: []
