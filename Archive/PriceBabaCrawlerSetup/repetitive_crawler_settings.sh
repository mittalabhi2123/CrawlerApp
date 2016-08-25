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
play eclipsify;
play clean compile run;
