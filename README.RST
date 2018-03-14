=======
写给自己
=======

Dear vici, 如果你又换电脑了：
~~~~~~~~~~~~~~~~~~~~~~~~~

1. ``git clone``


n. ``make init``

Done.

如果你又双叒叕折腾了一个centos7服务器
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
想办法root.

请依次进行一下操作:

1. 全平台通用用户名
::

   adduser vici
   passwd vici
   usermod -aG wheel vici
   visudo   # and add a new line '%wheel  ALL=(ALL)       ALL' to the  end of the file



License
-------
Copyright © 2017 woailuoli993. It is free software,
released under the WTFPL License, and may be redistributed
under the terms specified in file LICENSE.
