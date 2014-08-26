~~ News Curator ~~
=====================================

##About:

This program was written as an assessment of a Database Basics program for Epicodus Summer 2014

##Author:

* [Christian Danielsen] (https://github.com/cdanielsen)

##Description:
A program to store and categorize news sources in a postgres database.

##Implementation:
This program requires a postgresql database labeled 'news_curator' with the following schema:

sources | categorys (sic) | categorys_sources
------  | --------------  | -----------------
id      | id              | id
name    | slant           | category_id
url     |                 | source_id


##Known Bugs
Calling add_source or add_category method recursively causes the program to exit


Copyright MIT
