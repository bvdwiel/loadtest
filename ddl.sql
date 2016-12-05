CREATE TABLE IF NOT EXISTS main.results (
	PROTO		TEXT	NOT NULL,	-- HTTP Protocol used
	STATUS		INT	NOT NULL,	-- HTTP Response status
	RT		REAL	NOT NULL,	-- Response time in seconds
	VOLUME		INT	NOT NULL,	-- Transaction volume in bytes
	URL		TEXT	NOT NULL,	-- URL of the specific request
	DATETIME	TEXT	NOT NULL,	-- DateTime the request was made
	C		INT	NOT NULL	-- Concurrency value of Siege test
);
