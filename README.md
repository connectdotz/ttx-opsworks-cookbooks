cookbooks
=========

chef cookbooks for managing ThingTrix storage-services stack on AWS [AWS OpsWorks](http://aws.amazon.com/opsworks).

Features
--------
 * Titan/Rexster
 ** download and install rexster-server, rexster-console and titan-hbase
 ** setup titan with rexster-server
 ** provide start/stop rexster receipts to work with aws OpsWorks stack management
 ** also contains a tomcat cookbook from [AWS OpsWorks example cookbooks](http://https://github.com/amazonwebservices/opsworks-example-cookbooks).
* Hbase/Hadoop
** download and install hbase, hadoop
** setup hbase with hadoop in separate layers
** modify /etc/hosts for hadoop/hbase to function in OpsWorks env


