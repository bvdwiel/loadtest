# Website loadtesting scripts

This repository contains a bunch of scripts you may use to conduct website load/stress testing. The scripts depend on a number of underlying tools so make sure you have them installed.

- Siege
- GnuPlot
- Awk

Using these scripts comes down to a simple workflow.

- Run spider.sh on a base URL to gain a collection of URL's you can use to stress test the site.
- Run dotest.sh on the urls.txt file to perform the actual testing
- Run plottest.sh to process the results into pretty graphs you can include into your shiny reports.

