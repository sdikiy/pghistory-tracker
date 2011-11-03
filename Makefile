#PG_SHAREDIR := $(shell pg_config --sharedir)

test:	test-init-db test-schema test-functions test-edit

clean:	test-clean-db


test-init-db:
	createdb history_tracker_test
	createlang plpgsql history_tracker_test
	createlang plpythonu history_tracker_test
	
	#psql history_tracker_test -f $(PG_SHAREDIR)/contrib/pgtap.sql >/dev/null
	psql history_tracker_test -f test/pgtap.sql >/dev/null

test-schema:
	psql history_tracker_test -f test/test_schema.sql

test-functions:
	psql history_tracker_test -f test/test_functions.sql

test-edit:
	psql history_tracker_test -f test/test_edit.sql

test-clean-db:
	dropdb history_tracker_test