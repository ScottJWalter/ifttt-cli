[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/ScottJWalter/ifttt-cli) 

# IFTTT CLI
Manage IFTTT from the command line.

# Featrues
IFTTT is a very useful service that links various services, but no API is provided. 
Creating a large number of applets can be difficult to manage and maintain. 
With this tool you can easily manage and maintain IFTTT from the command line. 

The specification starts Chrome in headless mode with Puppeteer and performs web operation in the background. 

## Notes from the Fork
_Ultimately, this fork will PR back to the original repo.  Until then, here are some things to keep in mind:_

* _IFTTT has **NO** "true" API (e.g. REST, SOAP, etc.) they expose. This CLI tool actually wraps the ifttt.com website, using a headless copy of chromium to surf the site behind the scenes. This makes things somewhat brittle, as any design changes to the website may break this tool's functionality._
* _In the latest site redesign, the `trigger` and `action` identifiers are no longer clearly identified on the site, only the collection of services the app interacts with.  For the most part, this is in order (the first being the trigger, the second the action), but I have seen cases where that's not the case (which appears to be a function of the app developer's decisions).  This fork assumes that `works-with #1` is the trigger and `works-with-#2` is the action._
* _In fixing chromium to install correctly on GitPod, there may be some additional tools being loaded in the Docker image that aren't necessary, but there wasn't a single clear example end-to-end on how to do it, so I had to piece together several different threads.  This will be addressed at a later date._

_&mdash; [SJW](https://github.com/ScottJWalter)_

# DEMO

![demo](https://raw.githubusercontent.com/miso-develop/ifttt-cli/master/images/demo.gif)

# Getting Started

## Installation

### On GitPod

Clicking the "Gitpod Ready-to-Code" button (above) launches a GitPod instance with all the appropriate tools loaded.  It then compiles and installs ifttt-cli, leaving it ready for you to log in and play with.

**NOTE:** In order to get all the pieces working on this, it takes some time for the Docker image to load up the first time.

### Via NPM

#### Prerequisites
An environment of Node.js v8.0.0 or higher is required. 

#### Installation

```bash
$ npm install -g ifttt-cli
```

## Login
First, log in to IFTTT. 
Execute the following command to launch Chrome and display the IFTTT login screen. Please login. 

```bash
$ ifttt login
```

You can also login in headless mode by specifying the `-e, --email` option, followed by the e-mail address and password. 

```bash
$ ifttt login -e email@example.com password
```

# Usage

```bash
$ ifttt --help
ifttt [options] <command>

Control IFTTT from the command line.

Commands:
  ifttt [options] <command>                 Control IFTTT from the command line.
                                                                       [default]
  ifttt login [-e, --email <mail address>   Log in to IFTTT.
  <password>]                               If the option is omitted, please log
                                            in from the launched browser.
  ifttt logout                              Log out of IFTTT.
  ifttt connect <service>                   Connect to the specified service.
  ifttt list [-l, --long]                   Display a list of applets.
                                            Use the `-l, --long` option to
                                            display the details.
  ifttt get [id..]                          Get the applet recipe.
                                            The recipe of all applets is
                                            acquired by specifying `-a, --all`
                                            option.
  ifttt create <file>                       Create the applet.
                                            Specify and execute a JSON file
                                            containing a recipe.
  ifttt delete <id..>                       Remove the applet.
                                            Specify the ID of the applet you
                                            want to delete and execute it.
  ifttt update <file>                       Update the applet.
                                            Specify and execute a JSON file
                                            containing a recipe.

Positionals:
  command
     [required] [choices: "login", "logout", "connect", "list", "get", "create",
                                                             "delete", "update"]

Options:
  -b, --browser, --no-headless  Control while displaying chrome.       [boolean]
  -h, --help                    Show help                              [boolean]
  -v, --version                 Show version number                    [boolean]
```

## List
Display a list of applets. 
The applet ID and applet name are displayed. 

```bash
$ ifttt list
┌───────────┬─────────┐
│ ID        │ Name    │
├───────────┼─────────┤
│ 12345678d │ applet1 │
├───────────┼─────────┤
│ 23456789d │ applet2 │
├───────────┼─────────┤
│ 34567890d │ applet3 │
└───────────┴─────────┘

```

Specifying the `-l, --long` option also displays trigger and action information. 

```bash
$ ifttt list -l
┌───────────┬─────────┬──────────────────┬──────────┬────────┐
│ ID        │ Name    │ Trigger          │ Action   │ Status │
├───────────┼─────────┼──────────────────┼──────────┼────────┤
│ 12345678d │ applet1 │ Google Assistant │ Webhooks │ true   │
├───────────┼─────────┼──────────────────┼──────────┼────────┤
│ 23456789d │ applet2 │ Amazon Alexa     │ Webhooks │ false  │
├───────────┼─────────┼──────────────────┼──────────┼────────┤
│ 34567890d │ applet3 │ Webhooks         │ Clova    │ true   │
└───────────┴─────────┴──────────────────┴──────────┴────────┘

```

## Get
Get recipe information of specified applet ID. 
As JSON data is standard output, please reduce it when saving it. 

```bash
$ ifttt get <applet-id> > recipe.json
```

Specify `-a, --all` option instead of applet ID to get recipe information of all applets. 

```bash
$ ifttt get -a > all-recipe.json
```

## Create
Create an applet of recipe contents by specifying a recipe JSON file. 

```bash
$ ifttt create recipe.json
```

## Delete
Removes the applet with the specified applet ID. 

```bash
$ ifttt delete <applet-id>
```

## Update
Update the contents of the recipe by specifying the recipe JSON file. 

```bash
$ ifttt update recipe.json
```

## Connect
Connect to the specified service. 
If the service needs to log in, Chrome will be launched, so please use your browser to log in. 

An example of standard output JSON is [this](#recipe-json-sample).

```bash
$ ifttt connect <service-id>
```

## Logout
Log out of IFTTT. 

```bash
$ ifttt logout
```

## Recipe JSON sample
The following JSON data is a recipe when `Google Assistant` `Say a simple phrase` is specified as a trigger and `Webhooks` `Make a web request` is specified as an action. 

```json
[
  {
    "id": "12345678d",
    "name": "applet name",
    "notification": false,
    "status": true,
    "trigger": {
      "service": "google_assistant",
      "type": "simple_voice_trigger",
      "fields": [
        {
          "name": "voice_input_1",
          "value": "sample",
          "type": "text_field"
        },
        {
          "name": "voice_input_2",
          "value": "",
          "type": "text_field"
        },
        {
          "name": "voice_input_3",
          "value": "",
          "type": "text_field"
        },
        {
          "name": "tts_response",
          "value": "sample",
          "type": "text_field"
        },
        {
          "name": "supported_languages_for_user",
          "value": "en",
          "type": "collection_select"
        }
      ]
    },
    "action": {
      "service": "maker_webhooks",
      "type": "make_web_request",
      "fields": [
        {
          "name": "url",
          "value": "https://example.com/",
          "type": "text_field"
        },
        {
          "name": "method",
          "value": "GET",
          "type": "collection_select"
        },
        {
          "name": "content_type",
          "value": "application/json",
          "type": "collection_select"
        },
        {
          "name": "body",
          "value": "sample",
          "type": "text_field"
        }
      ]
    }
  }
]
```

# Built With
* [Puppeteer](https://github.com/GoogleChrome/puppeteer)
* [Yargs](https://github.com/yargs/yargs)
* [rimraf](https://github.com/isaacs/rimraf)
* [Table](https://github.com/gajus/table)
* [validator.js](https://github.com/chriso/validator.js)

# Contribution
1. Fork it
1. Create your feature branch
1. Commit your changes
1. Push to the branch
1. Create new Pull Request

# License
[MIT](./LICENSE)

# Acknowledgments
This README is translated into English by Google Translate based on README_ja.md.
