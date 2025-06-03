-- Cleanup script to clear residual data
USE practice;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM Scores WHERE archer_ID = 1 AND competition_ID = 1;
DELETE FROM Ends WHERE range_instance_ID IN (
    SELECT range_instance_ID FROM RangeInstance WHERE round_definition_association_ID IN (1, 2, 3, 4)
);
DELETE FROM RangeInstance WHERE round_definition_association_ID IN (1, 2, 3, 4);

SELECT 'Data cleared' AS cleanup_status;

SET SQL_SAFE_UPDATES = 1;