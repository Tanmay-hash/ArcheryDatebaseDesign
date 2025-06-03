-- -- Test script for Range 4 (30m)
-- USE practice;

-- -- Disable safe update mode
-- SET SQL_SAFE_UPDATES = 0;

-- -- Test variables
-- SET @archer_id = 1; -- Jane Doe, Open Female
-- SET @archer_devision_id = 1; -- Recurve
-- SET @competition_id = 1; -- The Royal Bow Invitational

-- -- === RANGE 4: 30m ===
-- SELECT '=== STARTING RANGE 4 (30m) ===' AS status;

-- CALL advance_round_range(4, @archer_id, @competition_id);
-- SELECT range_instance_ID INTO @range4 FROM RangeInstance WHERE round_definition_association_ID = 4 ORDER BY created_at DESC LIMIT 1;
-- -- Check if @range4 is valid
-- SELECT IF(@range4 IS NULL, 'ERROR: Range 4 ID is NULL', CONCAT('Range 4 ID: ', @range4)) AS range4_debug;
-- SELECT * FROM RangeInstance WHERE range_instance_ID = @range4;

-- -- Check existing ends
-- SELECT COUNT(*) AS existing_ends FROM Ends WHERE range_instance_ID = @range4;
-- SELECT end_ID INTO @end4 FROM Ends WHERE range_instance_ID = @range4 LIMIT 1;
-- SELECT IF(@end4 IS NULL, 'ERROR: End 4 ID is NULL', CONCAT('End 4 ID: ', @end4)) AS end4_debug;

-- -- Check existing scores for @end4
-- SELECT COUNT(*) AS existing_scores_for_end4 FROM Scores WHERE end_ID = @end4;

-- -- Record all 6 ends for Range 4
-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, FALSE, @end4, 10, 10, 10, 10, 10, 10);
-- SELECT 'End 1 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end1 FROM Scores WHERE range_instance_ID = @range4;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 10, 10, 10, 9, 9, 10);
-- SELECT 'End 2 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end2 FROM Scores WHERE range_instance_ID = @range4;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 10, 9, 9, 9, 9, 9);
-- SELECT 'End 3 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end3 FROM Scores WHERE range_instance_ID = @range4;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 9, 9, 8, 8, 9, 9);
-- SELECT 'End 4 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end4 FROM Scores WHERE range_instance_ID = @range4;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 8, 8, 8, 8, 8, 8);
-- SELECT 'End 5 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end5 FROM Scores WHERE range_instance_ID = @range4;

-- CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 7, 7, 7, 7, 7, 7);
-- SELECT 'End 6 recorded' AS end_status;
-- SELECT COUNT(*) AS scores_after_end6 FROM Scores WHERE range_instance_ID = @range4;

-- -- Check Range 4 results
-- SELECT COUNT(*) AS range4_scores FROM Scores WHERE range_instance_ID = @range4;
-- SELECT SUM(end_total_score) AS range4_total FROM Ends WHERE range_instance_ID = @range4;
-- SELECT COUNT(DISTINCT end_ID) AS range4_ends FROM Ends WHERE range_instance_ID = @range4;

-- SET SQL_SAFE_UPDATES = 1;


-- Test script for Range 4 (30m)
USE practice;

-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Test variables
SET @archer_id = 1; -- Jane Doe, Open Female
SET @archer_devision_id = 1; -- Recurve
SET @competition_id = 1; -- The Royal Bow Invitational

-- === RANGE 4: 30m ===
SELECT '=== STARTING RANGE 4 (30m) ===' AS status;

CALL advance_round_range(4, @archer_id, @competition_id);
SELECT range_instance_ID INTO @range4 FROM RangeInstance WHERE round_definition_association_ID = 4 ORDER BY created_at DESC LIMIT 1;
-- Check if @range4 is valid
SELECT IF(@range4 IS NULL, 'ERROR: Range 4 ID is NULL', CONCAT('Range 4 ID: ', @range4)) AS range4_debug;
SELECT * FROM RangeInstance WHERE range_instance_ID = @range4;

-- Check existing ends
SELECT COUNT(*) AS existing_ends FROM Ends WHERE range_instance_ID = @range4;
SELECT end_ID INTO @end4 FROM Ends WHERE range_instance_ID = @range4 LIMIT 1;
SELECT IF(@end4 IS NULL, 'ERROR: End 4 ID is NULL', CONCAT('End 4 ID: ', @end4)) AS end4_debug;

-- Clear any existing scores for @end4
DELETE FROM Scores WHERE end_ID = @end4;
SELECT COUNT(*) AS existing_scores_after_cleanup FROM Scores WHERE end_ID = @end4;

-- Record all 6 ends for Range 4
CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, FALSE, @end4, 10, 10, 10, 10, 10, 10);
SELECT 'End 1 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end1 FROM Scores WHERE range_instance_ID = @range4;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 10, 10, 10, 9, 9, 10);
SELECT 'End 2 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end2 FROM Scores WHERE range_instance_ID = @range4;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 10, 9, 9, 9, 9, 9);
SELECT 'End 3 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end3 FROM Scores WHERE range_instance_ID = @range4;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 9, 9, 8, 8, 9, 9);
SELECT 'End 4 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end4 FROM Scores WHERE range_instance_ID = @range4;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 8, 8, 8, 8, 8, 8);
SELECT 'End 5 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end5 FROM Scores WHERE range_instance_ID = @range4;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range4, 1, TRUE, NULL, 7, 7, 7, 7, 7, 7);
SELECT 'End 6 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end6 FROM Scores WHERE range_instance_ID = @range4;

-- Check Range 4 results
SELECT COUNT(*) AS range4_scores FROM Scores WHERE range_instance_ID = @range4;
SELECT SUM(end_total_score) AS range4_total FROM Ends WHERE range_instance_ID = @range4;
SELECT COUNT(DISTINCT end_ID) AS range4_ends FROM Ends WHERE range_instance_ID = @range4;

SET SQL_SAFE_UPDATES = 1;