-- Test script for Range 1 (90m)
USE practice;

-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Test variables
SET @archer_id = 1; -- Jane Doe, Open Female
SET @archer_devision_id = 1; -- Recurve
SET @competition_id = 1; -- The Royal Bow Invitational

-- === RANGE 1: 90m ===
SELECT '=== STARTING RANGE 1 (90m) ===' AS status;

CALL initialise_round(1);
SELECT range_instance_ID INTO @range1 FROM RangeInstance WHERE round_definition_association_ID = 1 ORDER BY created_at DESC LIMIT 1;
-- Check if @range1 is valid
SELECT IF(@range1 IS NULL, 'ERROR: Range 1 ID is NULL', CONCAT('Range 1 ID: ', @range1)) AS range1_debug;
SELECT * FROM RangeInstance WHERE range_instance_ID = @range1;

-- Check existing ends
SELECT COUNT(*) AS existing_ends FROM Ends WHERE range_instance_ID = @range1;
SELECT end_ID INTO @end1 FROM Ends WHERE range_instance_ID = @range1 LIMIT 1;
SELECT IF(@end1 IS NULL, 'ERROR: End 1 ID is NULL', CONCAT('End 1 ID: ', @end1)) AS end1_debug;

-- Check existing scores for @end1
SELECT COUNT(*) AS existing_scores_for_end1 FROM Scores WHERE end_ID = @end1;

-- Record all 6 ends for Range 1
CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range1, 1, FALSE, @end1, 10, 10, 9, 9, 10, 10);
SELECT 'End 1 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end1 FROM Scores WHERE range_instance_ID = @range1;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range1, 1, TRUE, NULL, 10, 9, 9, 8, 10, 9);
SELECT 'End 2 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end2 FROM Scores WHERE range_instance_ID = @range1;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range1, 1, TRUE, NULL, 9, 9, 8, 8, 9, 9);
SELECT 'End 3 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end3 FROM Scores WHERE range_instance_ID = @range1;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range1, 1, TRUE, NULL, 8, 8, 7, 7, 8, 8);
SELECT 'End 4 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end4 FROM Scores WHERE range_instance_ID = @range1;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range1, 1, TRUE, NULL, 7, 7, 6, 6, 7, 7);
SELECT 'End 5 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end5 FROM Scores WHERE range_instance_ID = @range1;

CALL record_end_scores(@archer_id, @archer_devision_id, @competition_id, @range1, 1, TRUE, NULL, 6, 6, 5, 5, 6, 6);
SELECT 'End 6 recorded' AS end_status;
SELECT COUNT(*) AS scores_after_end6 FROM Scores WHERE range_instance_ID = @range1;

-- Check Range 1 results
SELECT COUNT(*) AS range1_scores FROM Scores WHERE range_instance_ID = @range1;
SELECT SUM(end_total_score) AS range1_total FROM Ends WHERE range_instance_ID = @range1;
SELECT COUNT(DISTINCT end_ID) AS range1_ends FROM Ends WHERE range_instance_ID = @range1;

SET SQL_SAFE_UPDATES = 1;