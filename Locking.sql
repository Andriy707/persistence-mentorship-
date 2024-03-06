ALTER TABLE Course ADD COLUMN updatedAt TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;


-- optimistic case
BEGIN;

UPDATE Course
SET name = 'optimistic NAME',
    updatedAt = CURRENT_TIMESTAMP
WHERE id = 1 AND updatedAt = '2023-02-20 12:00:00';

IF NOT FOUND THEN
    RAISE 'Failed as record was modified by another transaction.';
END IF;

COMMIT;


--pessimistic case

BEGIN;

-- Lock the row for update to prevent other transactions from modifying it
SELECT updatedAt FROM Course WHERE id = 1 FOR UPDATE;

UPDATE Course
SET name = 'pessimistic NAME',
    updatedAt = CURRENT_TIMESTAMP
WHERE id = 1;

COMMIT;