build:
	bundle install
	chmod +x bin/parser.rb

run-parser:
	./bin/parser.rb

run-parser-table:
	./bin/parser.rb "webserver.log" "colourised_table"