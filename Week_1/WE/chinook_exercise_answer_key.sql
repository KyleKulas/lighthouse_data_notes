/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
SELECT name, albums.Title
FROM artists
LEFT JOIN albums
ON artists.ArtistId = albums.ArtistId
WHERE albums.Title IS NULL;


/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
SELECT DISTINCT artists.Name, genres.Name
FROM artists
JOIN albums
ON artists.ArtistId= albums.ArtistId
JOIN tracks
on albums.AlbumId = tracks.AlbumId
JOIN genres
ON tracks.GenreId = genres.GenreId
WHERE genres.Name LIKE 'Latin';

/* TASK III
Which video track has the longest length?
*/
SELECT Name, Milliseconds
FROM tracks
GROUP BY Name
ORDER BY Milliseconds DESC LIMIT 1;


/* TASK IV
Find the names of customers who live in 
the same city as the top employee 
(The one not managed by anyone).
*/
SELECT customers.FirstName, customers.LastName, customers.City, employees.City, employees.ReportsTo
FROM customers
JOIN employees
ON customers.City = employees.City
WHERE employees.ReportsTo IS NULL;


/* TASK V
Find the managers of employees supporting 
Brazilian customers.
*/
SELECT employees.FirstName, employees.LastName, 
customers.Country
FROM employees
JOIN customers
ON employees.EmployeeId = customers.SupportRepId
WHERE customers.Country LIKE '%Brazil%';


/* TASK VI
Which playlists have no Latin tracks?
*/
SELECT playlists.Name, playlists.PlaylistId, tracks.name, genres.Name
FROM playlists
LEFT JOIN playlist_track
ON playlists.PlaylistId = playlist_track.PlaylistId
LEFT JOIN tracks
ON playlist_track.TrackId = tracks.TrackId
LEFT JOIN genres
ON tracks.GenreId = genres.GenreId
WHERE genres.Name NOT LIKE "%Latin%";