build:
	bundle install
	chmod +x bin/parser.rb

run-parser:
	./bin/run.rb

run-parser-table:
	./bin/run.rb "webserver.log" "colourised_table"