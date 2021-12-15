# Gnome Terminal Profiles Tweaker (GTPT)

View and bulk edit the following [Gnome Terminal](https://en.wikipedia.org/wiki/GNOME_Terminal) profile settings using the [gsettings](https://wiki.gnome.org/HowDoI/GSettings) command and a [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) script:

- Font name/size (using default Pango `'filename fontsize'` format)
- Row size (terminal height)
- Column size (terminal width)

![image](https://user-images.githubusercontent.com/10182110/145905455-5f94f57d-992d-4dab-a4e4-006a012ddbbc.png)

## Rationale

Because I like terminal profiles (themes), and I have accumulated many themes over the years, it's difficult to manage so many theme properties in a consistent manner, so I needed a programmatic way to make terminal profile property changes in bulk.

So, the use case for **GTPT** is whenever I discover a new font (or terminal height, or width, etc.) I'd like to use in my terminal sessions, or add a new terminal profile, I run this script and it very quickly updates all terminal profiles at one time.

## [Developed with a Bash Template (BaT)](https://github.com/richbl/a-bash-template)[<img src="https://user-images.githubusercontent.com/10182110/145758715-b127adfc-710b-49d3-9ede-151adc83ae76.png" width="150" />](https://github.com/richbl/a-bash-template)

**GTPT** uses a Bash shell template (BaT) called **[A-Bash-Template](https://github.com/richbl/a-bash-template)** designed to make script development and command line argument management more robust, easier to implement, and easier to maintain. Here are a few of those features:

- Dependencies checker: a routine that checks all external program dependencies (*e.g.*, [jq](https://stedolan.github.io/jq/))
- Arguments and script details--such as script description and syntax--are stored in the [JSON](http://www.json.org/) file format (*i.e.*, `config.json`)
- JSON queries (using [jq](https://stedolan.github.io/jq/)) handled through wrapper functions
- A script banner function automates banner generation, reading directly from `config.json`
- Command line arguments are parsed and tested for completeness using both short and long-format argument syntax (*e.g.*, `-f|--font`)
- Optional command line arguments are permissible and managed through the JSON configuration file
- Template functions organized into libraries (see the [Bash-Lib](https://github.com/richbl/bash-lib) project for details) to minimize code footprint in the main script

For more details about using a bash template, [check out the BaT sources here](https://github.com/richbl/a-bash-template).

## Requirements

- An operational [Bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) environment (Bash 5.1.8 used during development)
- One additional external program:
  - [jq](https://stedolan.github.io/jq/), for parsing the `config.json` file

While this package was initially written and tested under Linux (Ubuntu 21.10), there should be no reason why this won't work under other shells or Unix-like operating systems that support the `gsettings` application.

## Basic Usage

**GTPT** is run through a command line interface, so all of the command options are made available there.

Here's the default response when running `gnome_terminal_profiles_tweaker.sh` with no arguments:

    $ ./gnome_terminal_profiles_tweaker.sh 

     |
     |  Gnome Terminal Profiles Tweaker (GTPT)
     |    1.0.0
     |
     |  Usage:
     |    gnome_terminal_profiles_tweaker.sh [-c new_column_count] [-r new_row_count] [-f new_font]
     |
     |  -c, --columns  The number of columns in a newly created terminal window
     |  -r, --rows     The number of rows in a newly created terminal window
     |  -f, --font     Font name and size using Pango syntax: 'name size', e.g. 'Monospace 12'
     |

    220 profiles found

    Profile #1 'Tomorrow Night Eighties' >> no changes
    Profile #2 'gotham' >> no changes
    Profile #3 'ibm3270' >> no changes
    ...

In this example, the program responds by displaying the results of a `gsettings` query for all terminal profiles, but with no changes made to those profiles.

When the optional arguments are passed, the script provides feedback on the changes made to those terminal profiles:

    $ ./gnome_terminal_profiles_tweaker.sh -f 'IBM 3270 13'

     |
     |  Gnome Terminal Profiles Tweaker (GTPT)
     |    1.0.0
     |
     |  Usage:
     |    gnome_terminal_profiles_tweaker.sh [-c new_column_count] [-r new_row_count] [-f new_font]
     |
     |  -c, --columns  The number of columns in a newly created terminal window
     |  -r, --rows     The number of rows in a newly created terminal window
     |  -f, --font     Font name and size using Pango syntax: 'name size', e.g. 'Monospace 12'
     |

    220 profiles found

    Profile #1 'Tomorrow Night Eighties' >> Font: 'Source Code Pro 11'-->'IBM 3270 13'. 
    Profile #2 'gotham' >> Font: 'Source Code Pro 11'-->'IBM 3270 13'. 
    Profile #3 'ibm3270' >> Font: 'Source Code Pro 11'-->'IBM 3270 13'.
    ...

## Roadmap

- The gsettings profile getter/setter functions in this script could be used for the bulk configuration of any number Gnome Terminal properties. If there's a good use case for adding additional functionality to **GTPT**, let me know.

## IMPORTANT! This Project Uses Git Submodules

> If you're about to clone this project, read this

This project uses a Git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) project, called [Bash-Lib](https://github.com/richbl/bash-lib) (see the `bash-lib` folder for details) to keep library dependencies single-sourced and up-to-date without manual intervention.

=======

Because I like terminal profiles (themes), and I have accumulated many themes over the years, it's difficult to manage so many theme properties in a consistent manner, so I needed a programmatic way to make terminal profile property changes in bulk.

So, the use case for **GTPT** is whenever I discover a new font (or terminal height, or width, etc.) I'd like to use in my terminal sessions, or add a new terminal profile, I run this script and it very quickly updates all terminal profiles at one time.

## [Developed with a Bash Template (BaT)](https://github.com/richbl/a-bash-template)[<img src="https://user-images.githubusercontent.com/10182110/145758715-b127adfc-710b-49d3-9ede-151adc83ae76.png" width="150" />](https://github.com/richbl/a-bash-template)


**GTPT** uses a Bash shell template (BaT) called **[A-Bash-Template](https://github.com/richbl/a-bash-template)** designed to make script development and command line argument management more robust, easier to implement, and easier to maintain. Here are a few of those features:

- Dependencies checker: a routine that checks all external program dependencies (*e.g.*, [jq](https://stedolan.github.io/jq/))
- Arguments and script details--such as script description and syntax--are stored in the [JSON](http://www.json.org/) file format (*i.e.*, `config.json`)
- JSON queries (using [jq](https://stedolan.github.io/jq/)) handled through wrapper functions
- A script banner function automates banner generation, reading directly from `config.json`
- Command line arguments are parsed and tested for completeness using both short and long-format argument syntax (*e.g.*, `-f|--font`)
- Optional command line arguments are permissible and managed through the JSON configuration file
- Template functions organized into libraries (see the [Bash-Lib](https://github.com/richbl/bash-lib) project for details) to minimize code footprint in the main script

For more details about using a bash template, [check out the BaT sources here](https://github.com/richbl/a-bash-template).

## Requirements

 - An operational [Bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) environment (Bash 5.1.8 used during development)
 -  One additional external program:
    + [jq](https://stedolan.github.io/jq/), for parsing the `config.json` file

While this package was initially written and tested under Linux (Ubuntu 21.10), there should be no reason why this won't work under other shells or Unix-like operating systems that support the `gsettings` application.


## Basic Usage
**GTPT** is run through a command line interface, so all of the command options are made available there.

Here's the default response when running `gnome_terminal_profiles_tweaker.sh` with no arguments:

	$ ./gnome_terminal_profiles_tweaker.sh 

     |
     |  Gnome Terminal Profiles Tweaker (GTPT)
     |    1.0.0
     |
     |  Usage:
     |    gnome_terminal_profiles_tweaker.sh [-c new_column_count] [-r new_row_count] [-f new_font]
     |
     |  -c, --columns  The number of columns in a newly created terminal window
     |  -r, --rows     The number of rows in a newly created terminal window
     |  -f, --font     Font name and size using Pango syntax: 'name size', e.g. 'Monospace 12'
     |

    220 profiles found

    Profile #1 'Tomorrow Night Eighties' >> no changes
    Profile #2 'gotham' >> no changes
    Profile #3 'ibm3270' >> no changes
    ...


In this example, the program responds by displaying the results of a `gsettings` query for all terminal profiles, but with no changes made to those profiles.

When the optional arguments are passed, the script provides feedback on the changes made to those terminal profiles:

	$ ./gnome_terminal_profiles_tweaker.sh -f 'IBM 3270 13'

     |
     |  Gnome Terminal Profiles Tweaker (GTPT)
     |    1.0.0
     |
     |  Usage:
     |    gnome_terminal_profiles_tweaker.sh [-c new_column_count] [-r new_row_count] [-f new_font]
     |
     |  -c, --columns  The number of columns in a newly created terminal window
     |  -r, --rows     The number of rows in a newly created terminal window
     |  -f, --font     Font name and size using Pango syntax: 'name size', e.g. 'Monospace 12'
     |

    220 profiles found

    Profile #1 'Tomorrow Night Eighties' >> Font: 'Source Code Pro 11'-->'IBM 3270 13'. 
    Profile #2 'gotham' >> Font: 'Source Code Pro 11'-->'IBM 3270 13'. 
    Profile #3 'ibm3270' >> Font: 'Source Code Pro 11'-->'IBM 3270 13'.
    ...

## Roadmap

- The gsettings profile getter/setter functions in this script could be used for the bulk configuration of any number Gnome Terminal properties. If there's a good use case for adding additional functionality to **GTPT**, let me know.

## IMPORTANT! This Project Uses Git Submodules

> If you're about to clone this project, read this

This project uses a Git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) project, called [Bash-Lib](https://github.com/richbl/bash-lib) (see the `bash-lib` folder for details) to keep library dependencies single-sourced and up-to-date without manual intervention.

So, be sure to clone this project with the `--recursive` switch (`git clone --recursive https://github.com/richbl/terminal-profiles-tweaker`) so any submodule project(s) will be automatically cloned as well. If you clone into this project without this switch, you'll likely see empty submodule project folders (depending on your version of Git).
