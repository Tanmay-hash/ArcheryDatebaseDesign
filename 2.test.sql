-- -- Test script for Range 2 (70m)
-- USE practice;

-- -- Disable safe update mode
-- SET SQL_SAFE_UPDATES = 0;

-- -- Test variables
-- SET @archer_id = 1; -- Jane Doe, Open Female
-- SET @archer_devision_id = 1; -- Recurve
-- SET @competition_id = 1; -- The Royal Bow Invitational

-- -- === RANGE 2: 70m ===
-- SELECT '=== STARTING RANGE 2 (70m) ===' AS status;

-- CALL advance_round_range(2, @archer_id, @competition_id);
-- SELECT range_instance_ID INTO @range2 FROM RangeInstance WHERE round_definition_association_ID = 2 ORDER BY created_at DESC LIMIT 1;
-- -- Check if @range2 is valid
-- SELECT IF(@range2 IS NULL, 'ERROR: Range 2 ID is NULL', CONCAT('Range 2 ID: ', @range2)) AS range2_debug;
-- SELECT * FROM RangeInstance WHERE range_instance_ID = @range2;

-- -- Check existing ends
-- SELECT COUNT(*) AS existing_ends FROM Ends WHERE range_instance_ID = @range2;
-- SELECT end_ID INTO @end2 FROM Ends WHERE range_instance_ID = @range2 LIMIT 1;
-- SELECT IF(@end2 IS NULL, 'ERROR: End 2 ID is NULL', CONCAT('End 2 ID: ', @end2)) AS end2_debug;

-- -- Check existing scores for @end2
-- SELECT COUNT(*) AS existing_scores_for_end2 FROM Scores WHERE end_ID = @end2;

-- -- Record all 6 ends for Range 2
-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, FALSE, @end2, 10, 10, 9, 9, 10, 10);
-- SELECT 'End 1 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end1 FROM Scores WHERE range_instance_ID = @range2;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 10, 9, 9, 8, 10, 9);
-- SELECT 'End 2 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end2 FROM Scores WHERE range_instance_ID = @range2;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 9, 9, 8, 8, 9, 9);
-- SELECT 'End 3 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end3 FROM Scores WHERE range_instance_ID = @range2;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 8, 8, 7, 7, 8, 8);
-- SELECT 'End 4 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end4 FROM Scores WHERE range_instance_ID = @range2;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 7, 7, 6, 6, 7, 7);
-- SELECT 'End 5 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end5 FROM Scores WHERE range_instance_ID = @range2;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 6, 6, 5, 5, 6, 6);
-- SELECT 'End 6 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end6 FROM Scores WHERE range_instance_ID = @range2;

-- -- Check Range 2 results
-- SELECT COUNT(*) AS range2_scores FROM Scores WHERE range_instance_ID = @range2;
-- SELECT SUM(end_total_score) AS range2_total FROM Ends WHERE range_instance_ID = @range2;
-- SELECT COUNT(DISTINCT end_ID) AS range2_ends FROM Ends WHERE range_instance_ID = @range2;

-- SET SQL_SAFE_UPDATES = 1;




-- Test script for Range 2 (70m)
USE practice;

-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Test variables
SET @archer_id = 1; -- Jane Doe, Open Female
SET @archer_devision_id = 1; -- Recurve
SET @competition_id = 1; -- The Royal Bow Invitational

-- === RANGE 2: 70m ===
SELECT '=== STARTING RANGE 2 (70m) ===' AS status;

CALL advance_round_range(2, @archer_id, @competition_id);
SELECT range_instance_ID INTO @range2 FROM RangeInstance WHERE round_definition_association_ID = 2 ORDER BY created_at DESC LIMIT 1;
-- Check if @range2 is valid
SELECT IF(@range2 IS NULL, 'ERROR: Range 2 ID is NULL', CONCAT('Range 2 ID: ', @range2)) AS range2_debug;
SELECT * FROM RangeInstance WHERE range_instance_ID = @range2;

-- Check existing ends
SELECT COUNT(*) AS existing_ends FROM Ends WHERE range_instance_ID = @range2;
SELECT end_ID INTO @end2 FROM Ends WHERE range_instance_ID = @range2 LIMIT 1;
SELECT IF(@end2 IS NULL, 'ERROR: END 2 ID is NULL', CONCAT('End 2 ID: ', @end2)) AS end2_debug;

-- Clear any existing scores for @end2 to avoid Error Code: 1644
DELETE FROM Scores WHERE end_ID = @end2;
SELECT COUNT(*) AS existing_scores_after_cleanup FROM Scores WHERE end_ID = @end2;

-- Record all 6 ends for Range 2
CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, FALSE, @end2, 10, 10, 9, 9, 10, 10);
SELECT 'End 1 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end1 FROM Scores WHERE range_instance_ID = @range2;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 10, 9, 9, 8, 10, 9);
SELECT 'End 2 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end2 FROM Scores WHERE range_instance_ID = @range2;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 9, 9, 8, 8, 9, 9);
SELECT 'End 3 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end3 FROM Scores WHERE range_instance_ID = @range2;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 8, 8, 7, 7, 8, 8);
SELECT 'End 4 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end4 FROM Scores WHERE range_instance_ID = @range2;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 7, 7, 6, 6, 7, 7);
SELECT 'End 5 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end5 FROM Scores WHERE range_instance_ID = @range2;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range2, 1, TRUE, NULL, 6, 6, 5, 5, 6, 6);
SELECT 'End 6 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end6 FROM Scores WHERE range_instance_ID = @range2;

-- Check Range 2 results
SELECT COUNT(*) AS range2_scores FROM Scores WHERE range_instance_ID = @range2;
SELECT SUM(end_total_score) AS range2_total FROM Ends WHERE range_instance_ID = @range2;
SELECT COUNT(DISTINCT end_ID) AS range2_ends FROM Ends WHERE range_instance_ID = @range2;

SET SQL_SAFE_UPDATES = 1;