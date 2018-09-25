# Website loadtesting scripts

This repository contains a bunch of scripts you may use to conduct website load/stress testing. The scripts depend on a number of underlying tools so make sure you have them installed.

- Bash 4.x shell
- Curl
- Siege 4.x
- GnuPlot
- Awk
- SQLite 3
- Wget

Using these scripts comes down to a simple workflow which is automated by having loadtest.sh calling the other scripts in sequence.

Before you begin testing, make sure you install the included _siegerc_ file into your homedir's _.siege/siege.conf_ file. The included _install.sh_ script takes care of this step for you.

The installer also builds a parseresults binary if it isn't present yet. In order to dramatically speed up the interpretation of data, the parser was rewritten in extremely messy C++. If anyone here who actually *DOES* know what they're doing would refactor this montrosity, please feel free to do so!

For now, however, it does what I need it to do: import a bazillion lines of text into SQLite at good speed.

Make sure you have the following installed on your system before trying to build:

- G++ in a somewhat recent version
- GNU Make
- Boost
- Boost-Filesystem
- SQLite3 development headers

You might be able to use a precompiled binary from the binaries directory. Proceed at your own risk, though.

## Platform compatibility

## Fedora 28

You need to install a number of packages before parseresults will compile:

    dnf group install "C Development Tools and Libraries"

    dnf install boost-devel boost-filesystem libstdc++-static sqlite-devel gnuplot siege wget

## Usage

In order to loadtest a website, run the loadtest.sh script followed by the hostname of the site or use the component scripts separately if you want more control over the process.

- Check the config file in the root of the project to set the proper values for concurrency and the desired ramp-up.
- Run _spider.sh_ on a hostname to gain a collection of URL's you can use to stress test the site.
- Run _dotest.sh_ to perform the actual testing
- Run _parseresults.sh_ to interpret the results from Siege and store them in a database.
- Run _plottest.sh_ to process the results into pretty graphs you can include into your shiny reports.

The spidering, running the test and parsing steps take a significant amount of time so make sure to plan accordingly.

### About urls.txt

The _spider.sh_ script generates two files: _urls.txt_ and _urls\_raw.txt_. By default, the test runs against a clean set of URL's which are all verified to return HTTP status 200 at the time of spidering. This gives the most reliable test of the actual application working under the heaviest possible load. However, this isn't the most realistic simulation of the actual internet. When live, your website is likely to also receive requests which end up hitting redirects and error pages. Such URL's are included in the _urls\_raw.txt_ file. If you want to test this instead, you should run the test steps manually and replace _urls.txt_ with _urls\_raw.txt_ right before you start the _dotest.sh_ script.

## Warning

Running stress tests on a website causes the server and its underlying infrastructure to be heavily used. Only run stress tests on systems you are explicitly authorized to test.

## Contributing

- Check if you can live with the conditions from the LICENSE file in the root of the project.
- Either pick an existing issue from GitHub or create a new one, describing what you'd like to see changed.
- Work your magic
- Submit a PR
