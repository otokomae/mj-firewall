#
# Cookbook Name:: mj-firewall
# Recipe:: default
#
# Copyright 2014, MJ::Factory
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'firewall'

execute "ufw-reset" do
  command 'yes | sudo ufw reset --force'
  action :run
end

# SSHはIP指定がある場合はそのIPに対して許可
# IP指定が無い場合は、SSH全体を許可
#
if not node['mj-firewall']['sources']['ssh'].empty?
    node['mj-firewall']['sources']['ssh'].each do |ip_address|
        firewall_rule 'ssh' do
            protocol :tcp
            port     node['mj-firewall']['ssh_port']
            action   :allow
            source   ip_address
            notifies :enable, 'firewall[ufw]'
        end
    end
else
    firewall_rule 'ssh' do
        port     node['mj-firewall']['ssh_port']
        action   :allow
        notifies :enable, 'firewall[ufw]'
    end
end


# HTTP/HTTPS を通す
firewall_rule 'http/https' do
    protocol :tcp
    ports    [80, 443]
    action   :allow
    notifies :enable, "firewall[ufw]"
end


# mysql については IP指定がある場合のみその IPについて mysqlポートの接続を許可する
# IP指定が無い場合は mysqlポートへの接続は拒否する
if not node['mj-firewall']['sources']['mysql'].empty?
    node['mj-firewall']['sources']['mysql'].each do |ip_address|
        firewall_rule 'ssh' do
            protocol :tcp
            port     node['mj-firewall']['mysql_port']
            action   :allow
            source   ip_address
            notifies :enable, 'firewall[ufw]'
        end
    end
end

# ufw  before.rules を編集して ICMPを閉じる
cookbook_file "/etc/ufw/before.rules" do
    owner "root"
    group "root"
    mode "0640"
end


firewall 'ufw' do
  action :enable
end
