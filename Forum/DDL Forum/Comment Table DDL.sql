/*
	Script that serves the purpose of creating table for 'Comment' entities.
	Requires Post Table DDL.sql and React Table DDL.sql to be executed first.
*/

USE FORUM

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'COMMENTS')
BEGIN
	CREATE TABLE COMMENTS(
	comment_id uniqueIdentifier DEFAULT (NEWID()) PRIMARY KEY,
	comment_content NVARCHAR(255) NOT NULL,
	comment_post_id uniqueIdentifier NOT NULL, 
	comment_react_id uniqueIdentifier NOT NULL UNIQUE,
	comment_account_id uniqueIdentifier NOT NULL);

	ALTER TABLE COMMENTS ADD CONSTRAINT FK_COMMENT_ACCOUNT_ID
	FOREIGN KEY(comment_account_id) REFERENCES ACCOUNTS(account_id);

	ALTER TABLE COMMENTS ADD CONSTRAINT FK_COMMENT_POST_ID 
	FOREIGN KEY(comment_post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE;
END