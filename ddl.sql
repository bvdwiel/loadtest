CREATE TABLE IF NOT EXISTS main.results (
	RT		REAL	NOT NULL,	-- Response time in seconds
	STATUS		INT	NOT NULL,	-- HTTP Response status
	C		INT	NOT NULL,	-- Concurrency as set by run of Siege command
	URL		TEXT	NOT NULL,	-- URL of the specific request
	DATETIME	TEXT	NOT NULL	-- DateTime the request was made
);
