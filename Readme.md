# page_view_metrics

An app that displays metrics for a page based off a specific log structure

# Initial Approach 

Initially I want to provide an MVP (minimal viable product) as to not overcomplicate a very simple problem. 
The intention is to provide something that can be built up to provide prettier metrics for a user and possible extend the functionality once the main function as been provided.

The presentation will be separate from the processing code.

My original idea was to split the unique and most views processing into different classes, however my current approach
means the list of page objects will have to be accessed and updated seperatly based on which process is carried out first.
It's become clear that collecting the metrics at the same time and preparing the data together will solve this issue, 
and it means when it comes to displaying the data all of it will be within one array of page objects

# Thoughts Mid Development
As the processing of this data is so trivial it looks like the Page class can handle processing the metrics itself. 
That means I can provide a mechanism for supplying both the to total views and unique views very simply. Also instead of 
using an array of objects I have found it much more readable for the PageMetrics class to build a hash of objects.

For the MVP approach it seems providing a PORO is the simplest and most readable approach. All the object handles is building
this hash of objects. I'm going to see if I even need to supply this as a hash, it may be that using an array would prove
just as useful however I do worry that searching through an array over a hash would be the least efficient method if we 
were to be parsing a very large log file. For example if I were to use the array **include** method to look for a log with a 
specific path, it would start from the 0th element and go one by one.m This isn't the case with a hash.


# References
https://launchschool.com/blog/how-the-hash-works-in-ruby
https://github.com/simplecov-ruby/simplecov

