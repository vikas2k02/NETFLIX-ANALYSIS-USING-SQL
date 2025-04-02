-- Netflix Data Analysis using SQL
-- Solutions of 10 business problems


-- SQL QUESTIONS ALONG WITH ITS QUERY

-- 1. Count the number of Movies vs TV Shows

SELECT 
	type,
	COUNT(*)
FROM netflix  
GROUP BY 1;

	
-- 2. Find the most common rating for movies and TV shows

SELECT type, rating AS most_frequent_rating
FROM (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count,
        ROW_NUMBER() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS row_num
    FROM netflix
    GROUP BY type, rating
) AS RankedRatings
WHERE row_num = 1;


-- 3. List all movies released in a specific year (e.g., 2020)

SELECT * 
FROM netflix
WHERE release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix


SELECT country ,COUNT(*) as No_of_Content
FROM netflix 
WHERE country IS NOT NULL
GROUP by country
ORDER BY COUNT(country) DESC
LIMIT 5;



-- 5. Identify the longest movie

SELECT 
	*
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1) DESC ;


-- 6. Find content added in the last 6 years

SELECT *
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 6 YEAR)
ORDER BY date_added ASC;


-- 7. Find all the movies/TV shows by director 'Abhishek Varman'!

    
SELECT * 
FROM netflix
WHERE  director = 'Abhishek Varman';



-- 8. List all TV shows with more than 5 seasons

SELECT * 
FROM netflix
WHERE 
    type = 'TV Show'
    AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5
    AND duration LIKE '%Season%';


-- 9. List all movies that are documentaries

SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries';



-- 10. Find all content without a director.
	
SELECT * FROM netflix
WHERE director IS NULL;

-- END
