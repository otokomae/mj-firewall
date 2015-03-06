
#-----------------------------------------------------------------------------
# SSH接続設定
#
# SSHポート番号
default['mj-firewall']['ssh_port'] = 22

# SSH許可IPアドレス設定
default['mj-firewall']['sources']['ssh'] = [
]


#-----------------------------------------------------------------------------
# mysql接続設定
#
# mysqlポート番号
default['mj-firewall']['mysql_port'] = 3306

# mysql許可IPアドレス設定
default['mj-firewall']['sources']['mysql'] = [
]
