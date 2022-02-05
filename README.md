# This project was for learning, as it serves no more purpose it is now archived*

# Instant Manager (Metin2 Server Manager)

![alt text](https://icyber.me/images/E24.png "Instant Manager Menu")

**Instant Manager** is a definitive server manager for metin2 aiming to simplify, optimize and create flexibility on server management on most OS's possible.

# Requirements
 ## On Windows: [MSYS2 MinGW](https://www.msys2.org/), MySQL Server
 **Suggestions**: [MSYS2 Shortcut Menu](https://github.com/njzhangyifei/msys2-mingw-shortcut-menus)
 - MSYS2 Pacman Packages: 
   * [Python2](https://packages.msys2.org/package/mingw-w64-x86_64-python2?repo=mingw64) - mingw-w64-x86_64-python2
   * [Python2-MySQL](https://packages.msys2.org/package/mingw-w64-x86_64-python2-mysql?repo=mingw64) - mingw-w64-x86_64-python2-mysql
   * [mpg123](https://packages.msys2.org/package/mingw-w64-x86_64-mpg123?repo=mingw64)(optional) - mingw-w64-x86_64-mpg123
   * [rsync](https://packages.msys2.org/base/rsync) - rsync
 ## On Linux: MySQL Server
 - FreeBSD pkg Packages: 
   * Bash rsync Python2 Python2-MySQL
   * mpg123(optional)
   
 - Debian apt-get Packages:
   * rsync python2.7 python-pymysql
   * mpg123(optional)
 
 # Installation
 Git clone the repository into wished directory:
 > git clone https://github.com/OriDevTeam/Instant-Manager
 
 Open the folder called shared and copy the following folders and files:
 - data
 - locale
 - package
 - CMD
 - item_names.txt
 - item_proto.txt
 - mob_names.txt
 - mob_proto.txt
 
 Next, create a folder called envs/<operative_system_name> and copy the following the files:
 - game
 - db
 - qc
 
