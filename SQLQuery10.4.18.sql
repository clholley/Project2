/****************************************************************
 *  This script creates the database named disk_inventory
 *  For SWDV 220 Project 2
 ****************************************************************/

/****************************************************************
 * Date			Programmer		Description
 * 10/5/2018	Cindy Holley	Create database and tables
 *  
 ****************************************************************/

USE master
GO

/****** Create Database ****************************************/ 
/****** Object:  Database AP   *********************************/
IF DB_ID('disk_inventory') IS NOT NULL
	DROP DATABASE disk_inventory
GO

CREATE DATABASE disk_inventory
GO 

USE disk_inventory;


/****** Create Database Tables   ******************************/ 
/****** Object:  Table Borrower   *****************************/   
CREATE TABLE Borrower(
	borrower_id		int not null identity primary key,
	borrower_fname	varchar(45),
	borrower_lname	varchar(45),
	borrower_phone	varchar(20)
)
GO

/****** Object:  HasBorrower   *******************************/  
/* gets data from Tables:  Borrower   ************************/ 
CREATE TABLE HasBorrower (
	borrower_id	int not null primary key,
	checkout_date	datetime not null,
	return_date	datetime not null,

	FOREIGN KEY (borrower_id) references Borrower(borrower_id)
)
GO

/****** Object:  Table ArtistType   *************************/ 
CREATE TABLE ArtistType (
	artist_type_id			int not null identity primary key,
	artist_type_description	char(100),
)
GO

/****** Object:  Table Artist   ****************************/ 
/* gets data from Tables:  ArtistType   ********************/ 
CREATE TABLE Artist (
	artist_id		int not null identity primary key,
	artist_type		varchar(45) not null,
	artist_fname	varchar(45) not null,
	artist_lname	varchar(45) not null,
	group_name		varchar(45) not null,
	artist_type_id	int not null,

	FOREIGN KEY (artist_type_id) references ArtistType(artist_type_id)
)
GO


/****** Media and 4 tables   ******************************/ 
/****** Object:  Table	MediaType   ***********************/
CREATE TABLE MediaType(
	media_type			varchar(10) not null primary key,
	media_description	varchar(100) not null,
)
GO

/****** Object:  Table Genre   ****************************/   
CREATE TABLE Genre (
	genre_id			varchar(10) not null primary key,
	genre_description	varchar(100) not null,
)
GO

/****** Object:  Table Status *****************************/   
CREATE TABLE Status (
	status_code			varchar(10) not null primary key,
	status_description	varchar(100) not null,
)
GO

/****** Object:  Table	Media ****************************/
/* gets data from Tables:  MediaType, Genre, and Status **/
CREATE TABLE Media(
	media_id		int NOT NULL PRIMARY KEY,
	media_name		varchar(45) not null,
	release_date		datetime not null,

	media_type		varchar(10) not null,
	genre_id		varchar(10) not null,
	status_code		varchar(10) not null,

	FOREIGN KEY(media_type) references MediaType(media_type),
	FOREIGN KEY(genre_id) references Genre(genre_id),
	FOREIGN KEY(status_code) references Status(status_code)
)
GO

/****** Object:  MediaHasArtist **************************/   
/* gets data from Tables: Artist and Media ***************/
CREATE TABLE MediaHasArtist (
	artist_id		int not null,
	media_type		varchar(10) not null,

	PRIMARY KEY(artist_id, media_type),
	FOREIGN KEY(artist_id) references Artist(artist_id),	
	FOREIGN KEY(media_type) references MediaType(media_type)	
)
GO
