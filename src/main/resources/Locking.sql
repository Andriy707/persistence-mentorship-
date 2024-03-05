CREATE OR REPLACE FUNCTION prevent_created_at_change()
    RETURNS TRIGGER AS
$$
BEGIN
    IF OLD.createdAt IS DISTINCT FROM NEW.createdAt THEN
        RAISE EXCEPTION 'The created_at column cannot be modified.';
END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updatedAt := CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;



-- triggers
CREATE TRIGGER prevent_created_at_update
    BEFORE UPDATE ON Course
    FOR EACH ROW EXECUTE FUNCTION prevent_created_at_change();


CREATE TRIGGER update_course_updated_at_before_update
    BEFORE UPDATE ON Course
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();