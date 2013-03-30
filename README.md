=================================
 goinstall -- Install Go Simply
=================================

1. What's this
==============

``goinstall`` is command line tool to install Go.


2. How to install and use
==========

・ If git is installed
---------------------------
    $ git clone https://github.com/kwmt/goinstall
    $ cd goinstall/
    $ sudo ./goinstall.sh <login user>
    $ source ~/.bashrc ( if you use bash )
    $ go version
    go version gox.x.x ( where x is number )

・ If git is NOT installed
---------------------------
    $ wget https://raw.github.com/kwmt/goinstall/master/goinstall.sh
    $ wget https://raw.github.com/kwmt/goinstall/master/gosetting.sh
    $ chmod +x goinstall.sh gosetting.sh 
    $ sudo ./goinstall.sh 
    $ source ~/.bashrc ( if you use bash )
    $ go version
    go version gox.x.x ( where x is number )

3. Support OS
==========
* Linux(Ubuntu,Cent OS)
* Mac ( but you need to install gcc and Mercurial. )


4. Contribution
==========
Contributions to the project are welcome.

