# Calculator Testing
This project contains Selenium tests for calculator, written in [Robot Framework](http://robotframework.org/)

## Testing environment

### 1. Python
You will need Python 3.6 (or higher) and pip to be installed on your machine/docker:
- Python: download and install latest python 3.6 version: https://www.python.org/downloads/
- pip - follow instructions on https://pip.pypa.io/en/stable/installing/

### 2. Virtual env
Set up virtualenvwrapper (or virtualenv), according to https://virtualenvwrapper.readthedocs.io/en/latest/install.html#basic-installation. 
Create a virtualenv to use with Robot Tests, example command:

``` mkvirtualenv -p python3 robotenv```

### 3. Repository
Clone https://github.com/automation-monkey/CalculatorRobotTests.git into your machine/docker.

### 4. Install requirements
Change your working environment to the one created in step 3. If you have just created it with mkvirtualenv - it is already your active environment - you don't have to change it. Install requirements from your cloned repository:

```$ pip3 install -r requirements.txt```

### 5. Webdriver to run tests locally
Downloda and place webdrivers inside your bin folder under the virualenv folder you created, eg. /robotenv/bin

Download latest webdriver:

[Chromedriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)

[Geckodrive Firefox](https://github.com/mozilla/geckodriver/releases)

[Safari](https://developer.apple.com/documentation/webkit/testing_with_webdriver_in_safari)

Put the webdrivers in the webdrivers directory.

### 6. Run a test!
To run a test, you need to use the **robot** command. It's a binary that allows you to run tests written in Robot Framework (http://robotframework.org/).

Most simple way to run a test would be: 

``` $ robot /TestSuite/TestCalculator.robot ```

You can specify a directory where you would like to store result files with **-d**, otherwise they will be stored in your current directory:

``` $  robot -d ../Results/ TestSuite/TestCalculator.robot ```

To pass browser variable with or override the default ones. It could be for any of the webdrivers that are downloaded. Use **-v**. Example:

``` $  robot -v BROWSER:Chrome ../TestSuite/HomePageTests.robot ```

Ideally you would like to run tests using command:

``` $ robot -d ../Results/ -v BROWSER:Chrome TestSuite/TestCalculator.robot```
