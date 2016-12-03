# Website loadtesting scripts

This repository contains a bunch of scripts you may use to conduct website load/stress testing. The scripts depend on a number of underlying tools so make sure you have them installed.

- Siege
- GnuPlot
- Awk

Using these scripts comes down to a simple workflow which is automated by having loadtest.sh calling the other scripts in sequence.

Befor you begin testing, make sure you install the included siegerc file into your homedir's .siege/siege.conf file. The included install.sh script takes care of this step for you.

In order to loadtest a website, run the loadtest.sh script followed by the URL of the site or use the component scripts separately if you want more control over the process.

- Run spider.sh on a base URL to gain a collection of URL's you can use to stress test the site.
- Run dotest.sh on the urls.txt file to perform the actual testing
- Run plottest.sh to process the results into pretty graphs you can include into your shiny reports.

