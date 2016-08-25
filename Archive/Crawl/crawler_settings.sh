wget http://downloads.typesafe.com/releases/play-2.0.zip;
wget http://apache.petsads.us/nutch/2.2.1/apache-nutch-2.2.1-src.zip;
wget http://apache.spinellicreations.com/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz;
unzip play-2.0.zip;
unzip apache-nutch-2.2.1-src.zip;
tar -zxvf hadoop-1.2.1.tar.gz;
dir=$(pwd);
chmod -R 777 $dir/;
chmod -R 777 $dir/play-2.0;
chmod -R 777 $dir/hadoop-1.2.1;
chmod -R 777 $dir/apache-nutch-2.2.1;
chmod -R 777 $dir/crawlerpb;
chmod -R 777 $dir/crawlProject;
export PATH=$dir/play-2.0/:$PATH;
cd $dir/crawlerpb/crawlProject;
play eclipsify;
play clean compile run;

