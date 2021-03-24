-- 2.
use albums_db;

-- 3a. 31 rows
select * 
from albums;

-- 3b. 23 unique artist names
select distinct artist 
from albums;

-- 3c. primary key = id
show create table albums;

-- 3d. oldest release date = 1967, most recent release date = 2011 - used built in sort feature to determine oldest and most recent dates
select release_date
from albums;

-- 4a. The Dark Side of the Moon, The Wall
select *
from albums
where artist = "Pink Floyd";

-- 4b. 1967
select release_date
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";

-- 4c.Grunge, Alternative Rock
select genre
from albums
where name = "Nevermind";

-- 4d. The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural
select name
from albums
where release_date between 1990 and 1999;

-- 4e. Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall
select name
from albums
where sales < 20;

-- 4f. Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A., Supernatural - because those genre names ("Hard rock" or "Progressive rock") do not exactly match the search ("Rock")
select name
from albums
where genre = "Rock";