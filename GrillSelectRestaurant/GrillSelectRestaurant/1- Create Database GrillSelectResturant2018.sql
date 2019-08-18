/*Create Restaurant database
Sccript Date :September 10,2019
Developed by :Maryam Naji, Zohreh karimzadeh/ Mahtab Abbasigaravand/ Ehsan Bavandsavadkoohi
*/

create database GrillSelectResturant2018

on primary
(

	name = 'GrillSelectResturant2018',
	filename = 'E:\GrillSelect database\GrillSelectResturant2018.mdf',
	size = 12 MB,
	filegrowth = 2 MB,
	maxsize = 100 MB
) 
log on
(
	name = 'GrillSelectResturant2018_log',
	filename = 'E:\GrillSelect database\GrillSelectResturant2018_log.ldf',
	size = 3 MB,
	filegrowth = 10%,
	maxsize = 25 MB
)
;
go


