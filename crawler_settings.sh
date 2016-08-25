sudo su
wget http://downloads.typesafe.com/releases/play-2.0.zip;
wget http://apache.petsads.us/nutch/2.2.1/apache-nutch-2.2.1-src.zip;
wget http://apache.spinellicreations.com/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz;
unzip play-2.0.zip;
unzip apache-nutch-2.2.1-src.zip;
tar -zxvf hadoop-1.2.1.tar.gz;
echo "Please Enter Git Clone URL of the 'crawlerpb' project";
read url
$url
dir=$(pwd);
chmod -R 777 $dir/;
chmod -R 777 $dir/play-2.0;
chmod -R 777 $dir/hadoop-1.2.1;
chmod -R 777 $dir/apache-nutch-2.2.1;
chmod -R 777 $dir/crawlerpb;
chmod -R 777 $dir/crawlerpb/crawlProject;
export PATH=$dir/play-2.0/:$PATH;
cd $dir/crawlerpb/crawlProject;
/etc/init.d/mysql start
mysql -u root -p -h localhost nutch1 < $dir/crawlerpb/crawlProject/schema.sql;
play eclipsify;
play clean compile run;
curl  --header "Content-type:text/plain"  --request POST  --data '{"node_id": "", "node_ip": "localhost", "node_port":"9000", "node_active": "1", "node_db_port": "3306", "node_db_driver":"com.mysql.jdbc.Driver", "node_db_conn_string": "jdbc:mysql://localhost/nutch1", "node_db_user": "root", "node_password":"root", "node_vendor": "aws", "node_crawl_category":"Mobile"}' http://localhost:9000/createNode;
