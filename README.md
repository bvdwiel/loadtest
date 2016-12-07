# Website loadtesting scripts

This repository contains a bunch of scripts you may use to conduct website load/stress testing. The scripts depend on a number of underlying tools so make sure you have them installed.

- Bash 4.x shell
- Siege 4.x
- GnuPlot
- Awk
- SQLite 3

Using these scripts comes down to a simple workflow which is automated by having loadtest.sh calling the other scripts in sequence.

Before you begin testing, make sure you install the included _siegerc_ file into your homedir's _.siege/siege.conf_ file. The included _install.sh_ script takes care of this step for you.

In order to loadtest a website, run the loadtest.sh script followed by the URL of the site or use the component scripts separately if you want more control over the process.

- Run _spider.sh_ on a base URL to gain a collection of URL's you can use to stress test the site.
- Run _dotest.sh_ on the urls.txt file to perform the actual testing
- Run _parseresults.sh_ to interpret the results from Siege and store them in a database.
- Run _plottest.sh_ to process the results into pretty graphs you can include into your shiny reports.

