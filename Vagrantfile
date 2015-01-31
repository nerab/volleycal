# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# start with
#
#   $ vagrant up
#

Vagrant.configure('2') do |config|
  config.vm.provider 'docker' do |d|
    d.build_dir = '.' # local docker file
    d.ports = ['5000:5000']
  end
end
