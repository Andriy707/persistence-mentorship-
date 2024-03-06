CREATE TABLE IF NOT EXISTS CourseAudit
(
    audit_id        SERIAL PRIMARY KEY,
    course_id       BIGINT,
    operation       VARCHAR(10),
    name_old        VARCHAR(255) NULL,
    name_new        VARCHAR(255) NULL,
    assignedTeacher_old BIGINT NULL,
    assignedTeacher_new BIGINT NULL,
    change_timestamp TIMESTAMP NOT NULL DEFAULT now(),
    changed_by      VARCHAR(255) --?????? how to check user if
);


---Function
CREATE OR REPLACE FUNCTION course_audit_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO CourseAudit(course_id, operation, name_old, assignedTeacher_old, change_timestamp, changed_by)
        VALUES (OLD.id, TG_OP, OLD.name, OLD.assignedTeacher, now(), current_user);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO CourseAudit(course_id, operation, name_old, name_new, assignedTeacher_old, assignedTeacher_new, change_timestamp, changed_by)
        VALUES (NEW.id, TG_OP, OLD.name, NEW.name, OLD.assignedTeacher, NEW.assignedTeacher, now(), current_user);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO CourseAudit(course_id, operation, name_new, assignedTeacher_new, change_timestamp, changed_by)
        VALUES (NEW.id, TG_OP, NEW.name, NEW.assignedTeacher, now(), current_user);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Triggers
CREATE TRIGGER course_audit_delete
    AFTER DELETE ON Course
    FOR EACH ROW EXECUTE FUNCTION course_audit_trigger_function();

CREATE TRIGGER course_audit_update
    AFTER UPDATE ON Course
    FOR EACH ROW EXECUTE FUNCTION course_audit_trigger_function();

CREATE TRIGGER course_audit_insert
    AFTER INSERT ON Course
    FOR EACH ROW EXECUTE FUNCTION course_audit_trigger_function();