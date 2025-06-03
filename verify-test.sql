-- Verification queries for archery round test
USE practice;

-- Hardcode archer and division IDs
SET @archer_id = 1; -- Jane Doe, Open Female
SET @archer_devision_id = 1; -- Recurve
SET @competition_id = 1; -- The Royal Bow Invitational
SET @round_definition_id = 1; -- WA90/1440

-- Check archer details
SELECT * FROM Archers WHERE archer_ID = @archer_id;

-- Check archer division
SELECT * FROM ArcherDevision WHERE archer_devision_ID = @archer_devision_id;

-- Check RangeInstance entries
SELECT * FROM RangeInstance WHERE range_instance_ID IN (
    SELECT DISTINCT range_instance_ID FROM Scores WHERE archer_ID = @archer_id AND competition_ID = @competition_id
);

-- Check ends per range
SELECT range_instance_ID, COUNT(DISTINCT end_ID) AS ends_count
FROM Ends
WHERE range_instance_ID IN (
    SELECT DISTINCT range_instance_ID FROM Scores WHERE archer_ID = @archer_id AND competition_ID = @competition_id
)
GROUP BY range_instance_ID;

-- Check scores per end
SELECT range_instance_ID, end_ID, COUNT(*) AS scores_count
FROM Scores
WHERE archer_ID = @archer_id AND competition_ID = @competition_id
GROUP BY range_instance_ID, end_ID
ORDER BY range_instance_ID, end_ID;

-- Check scores for all ranges
SELECT 
    s.score_ID, s.archer_ID, s.range_instance_ID, s.end_ID, 
    s.score_value, s.is_competition, e.end_total_score
FROM Scores s
JOIN Ends e ON s.end_ID = e.end_ID
WHERE s.archer_ID = @archer_id AND s.competition_ID = @competition_id
ORDER BY s.range_instance_ID, s.end_ID;

-- Check number of ranges completed
SELECT COUNT(DISTINCT s.range_instance_ID) AS ranges_completed
FROM Scores s
JOIN RangeInstance ri ON s.range_instance_ID = ri.range_instance_ID
JOIN RoundDefinitionAssociation rda ON ri.round_definition_association_ID = rda.round_definition_association_ID
WHERE s.archer_ID = @archer_id
  AND s.competition_ID = @competition_id
  AND rda.round_definition_ID = @round_definition_id;

-- Final summary
SELECT '=== FINAL RESULTS ===' AS status;

SELECT 
    rdf.distance AS Distance_m,
    rda.face_size AS Face_Size_cm,
    COUNT(DISTINCT e.end_ID) AS Ends_Shot,
    SUM(e.end_total_score) AS Range_Total,
    ri.range_instance_ID
FROM Scores s
JOIN RangeInstance ri ON s.range_instance_ID = ri.range_instance_ID
JOIN RoundDefinitionAssociation rda ON ri.round_definition_association_ID = rda.round_definition_association_ID
JOIN RangeDefinitions rdf ON rda.range_definition_ID = rdf.range_definition_ID
JOIN Ends e ON s.end_ID = e.end_ID
WHERE s.archer_ID = @archer_id AND s.competition_ID = @competition_id
GROUP BY rdf.distance, rda.face_size, ri.range_instance_ID
ORDER BY rdf.distance DESC;

-- Total scores across all ranges
SELECT 
    COUNT(*) AS Total_Arrows,
    SUM(score_value) AS Total_Score,
    AVG(score_value) AS Average_Score
FROM Scores 
WHERE archer_ID = @archer_id AND competition_ID = @competition_id;

-- Calculate total score for the round
SELECT SUM(e.end_total_score) AS total_round_score
FROM Ends e
JOIN RangeInstance ri ON e.range_instance_ID = ri.range_instance_ID
JOIN RoundDefinitionAssociation rda ON ri.round_definition_association_ID = rda.round_definition_association_ID
WHERE rda.round_definition_ID = @round_definition_id
AND e.range_instance_ID IN (
    SELECT range_instance_ID 
    FROM Scores 
    WHERE archer_ID = @archer_id AND competition_ID = @competition_id
);