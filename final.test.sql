-- Test script for final advance (should fail)
USE practice;

-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Test variables
SET @archer_id = 1; -- Jane Doe, Open Female
SET @competition_id = 1; -- The Royal Bow Invitational

-- === Try advancing again (should fail) ===
SELECT '=== ATTEMPTING FINAL ADVANCE ===' AS status;
CALL advance_round_range(4, @archer_id, @competition_id);
-- Expected: Raises 'You have reached the end of the round.'

SET SQL_SAFE_UPDATES = 1;