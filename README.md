# GNG-Company-Database

This project showcases a relational database design for "Green-Not-Greed," a fictional non-profit organization. It demonstrates proficiency in SQL, Python, and database infrastructure concepts. <br>

### Index
* [Database](#DB)
* [User Interface](#UI)
* [E/R Diagram](#ER)
* [Query Demonstrations](#Query)

---
### Database
<a name="DB"></a>

The database schema manages information about the organization, its members, campaigns, and other aspects. It can be built and deployed using PostgreSQL and the [construct](https://github.com/NeddTheRedd/GNG-Company-Database/blob/main/gng-construct.sql) SQL files. The script populates the database with sample data. <br>

Install PostgreSQL here: [https://www.postgresql.org/download/](https://www.postgresql.org/download/).

---
### User Interface
<a name="UI"></a>

The project also includes a Python user interface for interacting with the database, demonstrating additional skills in application development. The program for our UI can be found [here](https://github.com/NeddTheRedd/GNG-Company-Database/blob/main/gng.py). <br>

---
### E/R Diagram
<a name="ER"></a>

Here is the E/R Diagram, which is a visual representation of the entities and their relationships in our [database](https://github.com/NeddTheRedd/GNG-Company-Database/blob/main/gng-construct.sql):

<br>

![gng-model-main](https://github.com/NeddTheRedd/GNG-Company-Database/assets/153869055/f05baa56-2ef2-447e-b93c-62d991b7f444)

<br>

---
### Query Demonstrations
<a name="Query"></a>

Below are demonstrations of several queries along with their results:

---

#### Query 1: Campaign Expenses after August 8th, 2024

**Description**: Return all campaign expenses incurred after August 8th, 2024, and indicate the campaign they were used for.

<img width="685" alt="Screen Shot 2024-05-14 at 4 21 29 PM" src="https://github.com/NeddTheRedd/GNG-Company-Database/assets/153869055/8a0067d8-1310-422f-a82c-637b0957e836">

<br>

**Result**: 

<img width="804" alt="Screen Shot 2024-05-14 at 4 21 56 PM" src="https://github.com/NeddTheRedd/GNG-Company-Database/assets/153869055/fd257504-dee9-4abe-8f5d-73444490b93b">

---

#### Query 2: GNG Affiliates who are Both Members and Volunteers

**Description**: Return the member names and company names of GNG affiliates whose staff are both members and volunteers of GNG.

<img width="400" alt="Screen Shot 2024-05-14 at 4 39 06 PM" src="https://github.com/NeddTheRedd/GNG-Company-Database/assets/153869055/5ece979a-b6d3-40cf-aa69-081010072641">

<br>

**Result**:

<img width="265" alt="Screen Shot 2024-05-14 at 4 38 53 PM" src="https://github.com/NeddTheRedd/GNG-Company-Database/assets/153869055/05828fb0-cc76-44c2-9a0b-fbac208cf81f">




