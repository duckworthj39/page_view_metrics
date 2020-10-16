# page_view_metrics

An app that displays metrics such as visits or unique visits for a set of web page logs

# Prerequisites
* Install ruby 2.7.2
* Install bundler
* Install Make - if you can't please use the Makefile targets as a reference
* Run `make build` - this will make the run.rb executable and run bundle install
* Run `make run-parser` - This will run the parser with the default log file location
* If you would like to run it manually with another file path you can also use the command `./bin/parser.rb "[file path here]"`

# Permitted Arguments
1. `file_path` - A valid file path e.g. `'webserver.log'`
2. `format` - A presenter e.g. 'basic' or `'colourized_table'`
3. `filter` - A list of metric attributes to filter with e.g. `'visits'` or `'unique_visits visits'`

# Initial Approach 

Initially I want to provide an MVP (minimal viable product) as to not overcomplicated a very simple problem. 
The intention is to provide something that can be built extended and display prettier metrics for a user.

The presentation will be separate from the parsing code.

My original idea was to split the unique and most views processing into different classes, however my current approach
means the list of metrics objects will have to be accessed and updated separately based on which process is carried out first.
It's become clear that collecting the metrics at the same time and preparing the data together will solve this issue, 
and it means when it comes to displaying the data all of it will be within one array of page objects

# Mid Development
As the processing of this data is so trivial it looks like the **Metric** class can handle processing the metrics itself. 
That means I can provide a mechanism for supplying both the to total views and unique views very simply. Also instead of 
using an array of objects I have found it much more readable for the **MetricLogParser** class to build a hash of objects.

Something I hadn't taken into account was the performance of using an array instead of a hash. Finding a value in an array
means iterating from the first element until the value is found. To improve this the **MetricLogParser** class now uses a hash
to store the Metric object so they can be looked up in a more performant way. It is then converted to an array.

# First Iteration
This initial iteration includes two sections, one to create a data set for the page metrics and one for displaying the data set.
The string manipulation to display this data set is all done within the **MetricsPresenter**, this will take any attribute a
page has and append the value to a presentable string. 

# Final outcome
It became clear that in order to provide the functionality I initially wanted, which was to make the presentation
extendable I needed to use inheritence for the presenter. Adding a new way of presenting the results just requires
adding a child class to the **BasePresenter**. The **Parser** can now take a new format in the parse_file arguments.
This meant removing the **MetricPresenter**.

# Potential future usage
If this were to be used in a real life application, my idea would be to drive out a logging standard inside this app
and use it as a rails engine. One Engine can then handle the generating of logs and parsing, it can then also be ported to
multiple rails projects. The engine would contain parent controllers that can be inherited from to generate the view logs file,
once the file is saved the parser can handle outputting a string to a terminal or a web page. A quick google search shows
gems such as this: 
* https://github.com/tj/terminal-table

Which can be used for displaying the data in a table inside the terminal. This could be a potential third presenter.

# Tests
The app was built using TDD, I always make sure to drive development this way.
You can run the tests by running the command `make test-documentation`
```...........................
   
   Finished in 0.01144 seconds (files took 0.31095 seconds to load)
   27 examples, 0 failures
   
   Coverage report generated for RSpec to /Users/jasonduckworth/Gitlab/page_view_metrics/coverage. 114 / 114 LOC (100.0%) covered.
```

# Rubocop output
```Inspecting 14 files
 ..............
 
 14 files inspected, no offenses detected
```

# References
https://launchschool.com/blog/how-the-hash-works-in-ruby

https://github.com/simplecov-ruby/simplecov

