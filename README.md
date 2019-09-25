# Instant Manager (Metin2 Server Manager)

![alt text](https://imgur.com/8epUklb.png "Instant Manager Menu")

**Instant Manager** is a definitive server manager for metin2 aiming to simplify, optimize and create flexibility on server management on most OS's possible.

# Requirements
 ## On Windows: [MSYS2 MinGW](https://www.msys2.org/), MySQL Server
 - MSYS2 Pacman Packages: 
   * [Python2](https://packages.msys2.org/package/mingw-w64-x86_64-python2?repo=mingw64) - mingw-w64-x86_64-python2
   * [Python2-MySQL](https://packages.msys2.org/package/mingw-w64-x86_64-python2-mysql?repo=mingw64) - mingw-w64-x86_64-python2-mysql
   * [mpg123](https://packages.msys2.org/package/mingw-w64-x86_64-mpg123?repo=mingw64)(optional) - mingw-w64-x86_64-mpg123
 ## On Linux: Yare yare daze...
 
 # Installation
 Open the folder called shared and copy the following folders and files:
 - data
 - locale
 - package
 - CMD
 - item_names.txt
 - item_proto.txt
 - mob_names.txt
 - mob_proto.txt
 
 Open the folder called envs, and create a folder with the operative system wanted(ex: windows), and copy the binary files/libs inside.
 > After, create another folder inside called settings, with a txt file called binaries.txt with the following example structure:

```sh
game=game.exe
db=db.exe
qc=qc.exe
```
