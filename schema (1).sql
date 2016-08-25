-- Table containing all the data for a given data node.
-- Maintaining everything since the aim is to keep the data node 
-- as dumb as possible, as far as infrastructure is concerned.
-- Also name node need to have db details of data node, to connect to it, for picking and processing data
-- This will help in following:
	-- Plugging in and out the data node will be easy
	-- Changing configurations of data node will be easy. Don't have to change the software running on data node.
	-- The case where db is running on different port# on different nodes will be handled seamlessly.
	-- By each data node having its own db, will possess less load on name node/server, when multiple crawling requests will be posted in parallel.
CREATE TABLE data_node (
	node_id			int,
	node_ip			varchar(20),
	node_port		decimal(6), -- port on which to connect to
	node_active		decimal(1),
	node_db_port		decimal(6),
	node_db_driver		varchar(100), -- driver class to connect to for this node.
	node_db_conn_string	varchar(100), -- db connection string for this node.
	node_db_user		varchar(50),
	node_password		varchar(50),
	node_vendor		varchar(50), -- could be aws/solarvps etc.
	node_crawl_category	varchar(50), -- for future use, in case it's required to keep separate nodes for separate category like phone/laptop etc.
	PRIMARY KEY (node_id)
);

-- contains the record for each execution request for each data node.
CREATE TABLE execution_summary (
	execution_id		int,
	node_id			int,
	requested_time		timestamp,
	completion_time		timestamp,
	execution_result	decimal(1), -- 0=RUNNING, 1=FAIL, 2=PASS. IF 1, THEN SEARCH execution_error FOR ERROR
	result_processed	decimal(1), -- status to be updated when name node finishes with the collection/aggregation of the crawled content.
	execution_category	varchar(50), -- category for which it has been executed.
	PRIMARY KEY (execution_id)
);

-- contains all the errors produced by this client for the failure of given execution request
CREATE TABLE execution_errors (
	execution_id		int,
	error_id		int,
	url			varchar(500), -- non-empty if url specific error, else empty
	error_message		varchar(1000),
	PRIMARY KEY (execution_id, error_id)
);

-- contains all the urls processed by this client for a given execution request
CREATE TABLE execution_url (
	execution_id		int,
-- 	url					text,
	url			varchar(100), -- 500
	status			decimal(1), -- 0=RUNNING, 1=FAIL, 2=PASS. IF 1, THEN SEARCH execution_error FOR ERROR
	requested_time		timestamp,
	completion_time		timestamp,
	PRIMARY KEY (execution_id, url)
);

-- contains all the urls to be processed for a given category
CREATE TABLE category_url (
	category		int,
	url			varchar(100), -- 500
-- 	url				text,
	depth_level		int,
	PRIMARY KEY (category, url)
);

CREATE TABLE category_domains (
	category   int,
	domain     varchar(100),
	PRIMARY KEY (category, domain)
);

-- Name node data aggregator table, containing all the collected data
CREATE TABLE collected_webpage (
  id		int,
  node_id	int,
  execution_id  int,
  data_id varchar(767) NOT NULL, -- 767
  headers blob,
  text blob,
  status int(11) DEFAULT NULL,
  markers blob,
  parseStatus blob,
  modifiedTime decimal(20) DEFAULT NULL,
  score float DEFAULT NULL,
  typ varchar(32) DEFAULT NULL,
  baseUrl varchar(767) DEFAULT NULL,
  content TEXT,
  title varchar(2048) DEFAULT NULL,
  reprUrl varchar(767) DEFAULT NULL,
  fetchInterval int(11) DEFAULT NULL,
  prevFetchTime decimal(20) DEFAULT NULL,
  inlinks TEXT,
  prevSignature blob,
  outlinks TEXT,
  fetchTime decimal(20) DEFAULT NULL,
  retriesSinceFetch int(11) DEFAULT NULL,
  protocolStatus blob,
  signature blob,
  metadata blob,
  PRIMARY KEY (id)
);

-- TODO CREATE INDEX FOR collected_webpage ON node_id, execution_id & data_id

CREATE TABLE parsed_webpage (
	execution_id int NOT NULL,
	url varchar(100) DEFAULT NULL,
	product_name varchar(767) DEFAULT NULL,
	price int DEFAULT NULL,
	breadcrumb varchar(2048) DEFAULT NULL,
	status int DEFAULT NULL,
	data_fetch_time timestamp,
	PRIMARY KEY (execution_id, url)
);


-- CREATE TABLE parsed_webpage (
--	id int NOT NULL,
--	headers blob DEFAULT NULL,
--	text blob DEFAULT NULL,
--	status int(11) DEFAULT NULL,
--	markers blob DEFAULT NULL,
--	parseStatus blob DEFAULT NULL,
--	modifiedTime bigint(20) DEFAULT NULL,
--	score float DEFAULT NULL,
--	typ varchar(32) DEFAULT NULL,
--	baseUrl varchar(767) DEFAULT NULL,
--	content longblob DEFAULT NULL,
--	title varchar(2048) DEFAULT NULL,
--	reprUrl varchar(767) DEFAULT NULL,
--	fetchInterval int(11) DEFAULT NULL,
--	prevFetchTime bigint(20) DEFAULT NULL,
--	inlinks mediumblob DEFAULT NULL,
--	prevSignature blob DEFAULT NULL,
--	outlinks mediumblob DEFAULT NULL,
--	fetchTime bigint(20) DEFAULT NULL,
--	retriesSinceFetch int(11) DEFAULT NULL,
--	protocolStatus blob DEFAULT NULL,
--	signature blob DEFAULT NULL,
--	metadata blob DEFAULT NULL,
--	PRIMARY KEY (id)
-- );
