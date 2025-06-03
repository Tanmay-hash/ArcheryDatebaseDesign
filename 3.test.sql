-- -- Test script for Range 3 (50m)
-- USE practice;

-- -- Disable safe update mode
-- SET SQL_SAFE_UPDATES = 0;

-- -- Test variables
-- SET @archer_id = 1; -- Jane Doe, Open Female
-- SET @archer_devision_id = 1; -- Recurve
-- SET @competition_id = 1; -- The Royal Bow Invitational

-- -- === RANGE 3: 50m ===
-- SELECT '=== STARTING RANGE 3 (50m) ===' AS status;

-- CALL advance_round_range(3, @archer_id, @competition_id);
-- SELECT range_instance_ID INTO @range3 FROM RangeInstance WHERE round_definition_association_ID = 3 ORDER BY created_at DESC LIMIT 1;
-- -- Check if @range3 is valid
-- SELECT IF(@range3 IS NULL, 'ERROR: Range 3 ID is NULL', CONCAT('Range 3 ID: ', @range3)) AS range3_debug;
-- SELECT * FROM RangeInstance WHERE range_instance_ID = @range3;

-- -- Check existing ends
-- SELECT COUNT(*) AS existing_ends FROM Ends WHERE range_instance_ID = @range3;
-- SELECT end_ID INTO @end3 FROM Ends WHERE range_instance_ID = @range3 LIMIT 1;
-- SELECT IF(@end3 IS NULL, 'ERROR: End 3 ID is NULL', CONCAT('End 3 ID: ', @end3)) AS end3_debug;

-- -- Check existing scores for @end3
-- SELECT COUNT(*) AS existing_scores_for_end3 FROM Scores WHERE end_ID = @end3;

-- -- Record all 6 ends for Range 3
-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, FALSE, @end3, 10, 10, 9, 9, 10, 10);
-- SELECT 'End 1 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end1 FROM Scores WHERE range_instance_ID = @range3;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 10, 9, 9, 8, 10, 9);
-- SELECT 'End 2 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end2 FROM Scores WHERE range_instance_ID = @range3;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 9, 9, 8, 8, 9, 9);
-- SELECT 'End 3 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end3 FROM Scores WHERE range_instance_ID = @range3;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 8, 8, 7, 7, 8, 8);
-- SELECT 'End 4 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end4 FROM Scores WHERE range_instance_ID = @range3;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 7, 7, 6, 6, 7, 7);
-- SELECT 'End 5 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end5 FROM Scores WHERE range_instance_ID = @range3;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 6, 6, 5, 5, 6, 6);
-- SELECT 'End 6 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end6 FROM Scores WHERE range_instance_ID = @range3;

-- -- Check Range 3 results
-- SELECT COUNT(*) AS range3_scores FROM Scores WHERE range_instance_ID = @range3;
-- SELECT SUM(end_total_score) AS range3_total FROM Ends WHERE range_instance_ID = @range3;
-- SELECT COUNT(DISTINCT end_ID) AS range3_ends FROM Ends WHERE range_instance_ID = @range3;

-- SET SQL_SAFE_UPDATES = 1;


-- Test script for Range 3 (50m)
USE practice;

-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Test variables
SET @archer_id = 1; -- Jane Doe, Open Female
SET @archer_devision_id = 1; -- Recurve
SET @competition_id = 1; -- The Royal Bow Invitational

-- === RANGE 3: 50m ===
SELECT '=== STARTING RANGE 3 (50m) ===' AS status;

CALL advance_round_range(3, @archer_id, @competition_id);
SELECT range_instance_ID INTO @range3 FROM RangeInstance WHERE round_definition_association_ID = 3 ORDER BY created_at DESC LIMIT 1;
-- Check if @range3 is valid
SELECT IF(@range3 IS NULL, 'ERROR: Range 3 ID is NULL', CONCAT('Range 3 ID: ', @range3)) AS range3_debug;
SELECT * FROM RangeInstance WHERE range_instance_ID = @range3;

-- Check existing ends
SELECT COUNT(*) AS existing_ends FROM Ends WHERE range_instance_ID = @range3;
SELECT end_ID INTO @end3 FROM Ends WHERE range_instance_ID = @range3 LIMIT 1;
SELECT IF(@end3 IS NULL, 'ERROR: End 3 ID is NULL', CONCAT('End 3 ID: ', @end3)) AS end3_debug;

-- Clear any existing scores for @end3
DELETE FROM Scores WHERE end_ID = @end3;
SELECT COUNT(*) AS existing_scores_after_cleanup FROM Scores WHERE end_ID = @end3;

-- Record all 6 ends for Range 3
CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, FALSE, @end3, 10, 10, 9, 9, 10, 10);
SELECT 'End 1 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end1 FROM Scores WHERE range_instance_ID = @range3;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 10, 9, 9, 8, 10, 9);
SELECT 'End 2 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end2 FROM Scores WHERE range_instance_ID = @range3;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 9, 9, 8, 8, 9, 9);
SELECT 'End 3 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end3 FROM Scores WHERE range_instance_ID = @range3;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 8, 8, 7, 7, 8, 8);
SELECT 'End 4 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end4 FROM Scores WHERE range_instance_ID = @range3;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 7, 7, 6, 6, 7, 7);
SELECT 'End 5 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end5 FROM Scores WHERE range_instance_ID = @range3;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range3, 1, TRUE, NULL, 6, 6, 5, 5, 6, 6);
SELECT 'End 6 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end6 FROM Scores WHERE range_instance_ID = @range3;

-- Check Range 3 results
SELECT COUNT(*) AS range3_scores FROM Scores WHERE range_instance_ID = @range3;
SELECT SUM(end_total_score) AS range3_total FROM Ends WHERE range_instance_ID = @range3;
SELECT COUNT(DISTINCT end_ID) AS range3_ends FROM Ends WHERE range_instance_ID = @range3;

SET SQL_SAFE_UPDATES = 1;