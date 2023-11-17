CREATE TABLE universities (
    university_id NUMBER PRIMARY KEY,
    university_name VARCHAR2(255),
    founded_date DATE,
    location VARCHAR2(255),
    website VARCHAR2(255),
    ranking_2023 NUMBER,
    type VARCHAR2(20),
    QSWorldRanking_2023 VARCHAR2(20)
);

CREATE TABLE subjects (
    sub_id NUMBER PRIMARY KEY,
    sub_name VARCHAR2(255),
    subject_type VARCHAR2(255)
);
CREATE TABLE alumni (
    alumni_id NUMBER PRIMARY KEY,
    sub_id NUMBER,
    full_name VARCHAR2(255),
    degree_earned VARCHAR2(255),
    Current_Employer VARCHAR2(255),
    Current_Designation VARCHAR2(255),
    location VARCHAR2(255),
    batch VARCHAR2(255),
    university_id NUMBER,
    FOREIGN KEY (university_id) REFERENCES universities(university_id),
    FOREIGN KEY (sub_id) REFERENCES subjects(sub_id)
);
CREATE TABLE subject_rankings (
    sub_ranking_id NUMBER PRIMARY KEY,
    ranking VARCHAR2(20),
    year NUMBER,  -- Assuming "year" is a numeric value, adjust accordingly if it's a date
    university_id NUMBER,
    sub_id NUMBER,
    FOREIGN KEY (university_id) REFERENCES universities(university_id),
    FOREIGN KEY (sub_id) REFERENCES subjects(sub_id)
);
CREATE TABLE professors (
    professor_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(255),
    sub_id NUMBER,
    university_id NUMBER,
    Designation VARCHAR2(255),
    email VARCHAR2(255),
    FOREIGN KEY (sub_id) REFERENCES subjects(sub_id),
    FOREIGN KEY (university_id) REFERENCES universities(university_id)
);


-- Create Facilities Table
CREATE TABLE facilities (
    facility_id NUMBER PRIMARY KEY,
    facility_name VARCHAR2(255),
    facility_weight NUMBER,  -- Assuming it's a numeric value
    university_id NUMBER,
    FOREIGN KEY (university_id) REFERENCES universities(university_id)
);

-- Create Awards Table
CREATE TABLE awards (
    award_id NUMBER PRIMARY KEY,
    award_name VARCHAR2(255),
    year NUMBER,  -- Assuming it's a numeric value
    recipient_id NUMBER,
    FOREIGN KEY (recipient_id) REFERENCES professors(professor_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES alumni(alumni_id) ON DELETE CASCADE
);

-- Create Financial Data Table
CREATE TABLE university_metrics (
    metric_id NUMBER PRIMARY KEY,
    university_id NUMBER,
    metric_name VARCHAR2(100),
    value NUMBER,  -- Assuming it's a numeric value
    year NUMBER,  -- Assuming it's a numeric value
    FOREIGN KEY (university_id) REFERENCES universities(university_id)
);

create or replace TRIGGER trg_before_UniversityData_change
BEFORE INSERT OR DELETE OR UPDATE ON universities
FOR EACH ROW
DECLARE
    v_user VARCHAR2(20); 
BEGIN
    SELECT user INTO v_user From dual;
    IF INSERTING THEN

       DBMS_OUTPUT.PUT_LINE('New data is inserted in the UNIVERSITIES table by '||v_user);

    ELSIF DELETING THEN

        DBMS_OUTPUT.PUT_LINE('New data is deleteded from the UNIVERSITIES table by '||v_user );

    ELSIF UPDATING THEN

        DBMS_OUTPUT.PUT_LINE('New data is updated in the UNIVERSITIES table by '||v_user);

    END IF;

END;

SET SERVEROUTPUT ON;


                              ----data inserted from csv file--
INSERT INTO subject_rankings (sub_ranking_id, ranking, year, university_id, sub_id)
VALUES
    (3, '651-680', 2023, 16, 5);

INSERT INTO subjects (sub_id, sub_name, subject_type)
SELECT 92, 'Soil, Water, and Environment Science', 'Social Science'
FROM dual--require a FROM clause, but the operation isn't related to any actual table data.
    --DUAL is a special table in Oracle that has a single row and single column and is commonly used as a dummy table
WHERE NOT EXISTS (
    SELECT 1
    FROM subjects
    WHERE sub_name = 'Soil, Water, and Environment Science'
);

