#!/bin/bash


[[ $(id -u) != 0 ]] && echo -e " 请使用root用户运行此脚本！" && exit 1

echo ""
echo "This script will install python3.9.6 and virtualenv for CentOS7."
echo "Now checking what versions of python have installed in your system..."
echo "python -V:"
python -V
echo "python3 -V"
python3 -V

read -s -n1 -p "Press any key to continue..." 


echo ""
read -p "Please choose the version of Python3 [1. v3.8.12, 2. v3.9.7]: " version_no

if [ "$version_no" = "1" ]; then
	version_id='3.8.12'
else
	version_id='3.9.7'
fi

echo ""
echo "Python$version_id will be installed."
echo ""
#安装依赖
yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel gcc-c++

#下载安装包。更多版本见https://www.python.org/ftp/python 
wget https://www.python.org/ftp/python/$version_id/Python-$version_id.tgz

#解压并进入目录
tar xzvf Python-$version_id.tgz
cd Python-$version_id

#设置默认安装目录
mkdir /usr/local/python3
./configure -prefix=/usr/local/python3 --with-ssl

#编译安装
make && make install

#建立链接
ln -s /usr/local/python3/bin/python3 /usr/bin/python3   #为python3创建软连接
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3   #为pip3创建软连接

#测试安装是否成功
python3 -V
pip3 -V


echo ""
echo "The script will install virtualenv."
echo ""

read -s -n1 -p "Press any key to continue..." 

#为python3安装virtualenv
pip3 install virtualenv

# echo "PATH=\$PATH:/usr/local/python3/bin" >> /etc/profile

# #让etc/profile生效
# source /etc/profile

# #检查是否添加成功
# echo $PATH

ln -s /usr/local/python3/bin/virtualenv /usr/bin/virtualenv   #为virtualenv创建软连接
# #检查是否安装成功
virtualenv --version

echo ""
echo "The script runs to end."
