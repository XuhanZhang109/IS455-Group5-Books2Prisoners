# Data Deletion: If a facility decides not to partner with us, remove the facility_name from the Facility relation. However, because facility_name serves as a foreign key in the Receivers relation, update the deleted value to Null to maintain data integrity.
ALTER TABLE 
    receiver
ADD CONSTRAINT 
    facility_name 
    FOREIGN KEY (facility_name) REFERENCES facility(facility_name) ON DELETE SET NULL;
DELETE FROM facility 
WHERE
    facility_name = 'Logan Correctional Center';

# Data Modification: Update expected parole date and facility transfer information
UPDATE receiver 
SET 
    projected_parole_date = '2026-05-20',
    facility_name = 'Decatur Correctional Center'
WHERE
    inmate_id = 'A123456';