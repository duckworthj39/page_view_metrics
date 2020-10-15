build:
	bundle install
	chmod +x bin/parser.rb

run-parser:
	./bin/run.rb

run-parser-visits-filter:
	./bin/run.rb "webserver.log" "basic" "visits"

run-parser-table:
	./bin/run.rb "webserver.log" "colourized_table"