CREATE SEQUENCE test_sequence_cache CACHE 15;

CREATE SEQUENCE test_sequence_no_cache CACHE 1;


SELECT nextval('test_sequence_cache');

SELECT nextval('test_sequence_no_cache');



SELECT * FROM pg_sequences WHERE sequencename = 'test_sequence_cache';
SELECT * FROM pg_sequences WHERE sequencename = 'test_sequence_no_cache';

