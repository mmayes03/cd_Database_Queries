/*produce a list of the start times for 
bookings by members named 'David Farrell'?*/

SELECT starttime::time, firstname ||' '||surname AS Fullname
FROM cd.bookings
INNER JOIN cd.facilities
ON cd.facilities.facid = cd.bookings.facid
JOIN cd.members
ON cd.members.memid = cd.bookings.memid
WHERE cd.members.firstname iLIKE 'david'
AND surname iLIKE 'farrell';

/*produce a list of the start times for 
bookings for tennis courts, for the date 
'2012-09-21'? Return a list of start time 
and facility name pairings, ordered by the time.*/

SELECT name, starttime::time FROM cd.facilities
INNER JOIN cd.bookings 
ON cd.facilities.facid = cd.bookings.facid
WHERE DATE(starttime) = '2012-09-21'
AND name LIKE 'Tennis%'
ORDER BY starttime::time;

/*Produce a list of facilities with more than 
1000 slots booked.*/

SELECT cd.facilities.name, SUM(cd.bookings.slots) AS Total_slots 
FROM cd.facilities
INNER JOIN cd.bookings 
ON cd.facilities.facid = cd.bookings.facid
GROUP BY cd.facilities.name
HAVING SUM(cd.bookings.slots) > 1000;

/*Produce a list of the total number of slots 
booked per facility in the month of September 2012. 
Produce an output table consisting of facility id 
and slots, sorted by the number of slots.*/

SELECT cd.facilities.facid, SUM(slots) AS total
FROM cd.facilities
INNER JOIN cd.bookings 
ON cd.facilities.facid = cd.bookings.facid
WHERE EXTRACT(YEAR FROM starttime) = '2012'
AND EXTRACT(MONTH FROM starttime) = '09'
GROUP BY cd.facilities.facid
ORDER BY total;

/*Produce a count of the number of 
facilities that have a cost to guests of 
10 or more.
*/

SELECT COUNT(DISTINCT name) FROM cd.facilities
WHERE guestcost>=10;

/*get the signup date of your last member*/
SELECT joindate FROM cd.members
WHERE memid = 
(SELECT MAX(memid) FROM cd.members);

/*produce an ordered list of the first 
10 surnames in the members table? The list must 
not contain duplicates.
*/

SELECT DISTINCT surname FROM cd.members
WHERE surname != 'GUEST'
ORDER BY surname ASC
LIMIT 10;

/*produce a list of members who 
joined after the start of September 1st 2012*/

SELECT * FROM cd.members
WHERE DATE(joindate) > '2012-09-01';

/*retrieve the details of facilities
with ID 1 and 5*/

SELECT * FROM cd.facilities
WHERE facid in (1,5);

/*produce a list of all facilities with 
the word 'Tennis' in their name?*/

SELECT name FROM cd.facilities
WHERE name LIKE '%Tennis%';

/*produce a list of facilities that charge 
a fee to members, and that fee is less than 
1/50th of the monthly maintenance cost?*/

SELECT * FROM cd.facilities
WHERE membercost != 0
AND membercost < (monthlymaintenance/50);

/*produce a list of 
facilities that charge a fee to members*/
SELECT * FROM cd.facilities
WHERE membercost != 0;

/*print out a list of all of the 
facilities and their cost to members.*/
SELECT name, membercost, guestcost 
FROM cd.facilities;
