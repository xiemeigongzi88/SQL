# -*- coding: utf-8 -*-
"""
Created on Mon Sep  2 23:29:35 2019

@author: sxw17
"""

# Python and MYSQL


# Creating database and table 

import pymysql
import mysql.connector

mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')


mycursor = mydb.cursor()

mycursor.execute("CREATE DATABASE testdb")

mycursor.execute('SHOW DATABASES')

for db in mycursor:
    print(db)
    
###################################
mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor = mydb.cursor()

mycursor.execute("CREATE TABLE students (name VARCHAR(255), age INTEGER(10))")

mycursor.execute("SHOW TABLES")

for table in mycursor:
    print(table)
  

######################################
    # populating data base and table
mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

sqlformula ="INSERT INTO students(name, age) VALUES (%s, %s)".format()

student_1= ("Eirc", 18)

mycursor.execute(sqlformula, student_1)

mydb.commit()


#############################################


mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

sqlformula ="INSERT INTO students(name, age) VALUES (%s, %s)".format()

student_2= [("Eirc", 20),
            ("Eirc_1", 16),
            ("Eirc2", 14),
            ("Eirc3", 13),
            ("Eirc4", 19)]

mycursor.executemany(sqlformula, student_2)

mydb.commit()

###########################################
# selecting and Getting data 

mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

mycursor.execute("SELECT * FROM students ")

myresult= mycursor.fetchall()

for row in myresult:
    print(row)

###----------------------------
mycursor.execute("SELECT age FROM students ")

myresult= mycursor.fetchall()

for row in myresult:
    print(row)


###-----------------------------
mydb = mysql.connector.connect(
host='localhost',
user='root',
passwd='WS@abel1989',
database='testdb')
    
mycursor=mydb.cursor()
mycursor.execute("SELECT age FROM students")

myresult= mycursor.fetchone()


for row in myresult:
    print(row)
    
   
#######################################################
#5. Query Condition with WHERE and Wildcards
    
mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

sql="SELECT * FROM students WHERE age =14"

mycursor.execute(sql)

myresult=mycursor.fetchall()

for i in myresult:
    print(i)
 
##----------------------------
mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

#sql="select name from students where name like '%ic%'"
sql="SELECT name FROM students WHERE name LIKE 'Ei%'"

mycursor.execute(sql)

result = mycursor.fetchall()

for i in result:
    print(i)
    
    
sql_all="SELECT * FROM students"
mycursor.execute(sql_all)
result = mycursor.fetchall()

for i in result:
    print(i)


##################################################
# 6. Update and Limit Query 

mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

sql="UPDATE students SET age =100 WHERE name='Eirc'"

mycursor.execute(sql)

mydb.commit()

    
##--------------------------------------------------
mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

mycursor.execute("SELECT * FROM students LIMIT 5")

result = mycursor.fetchall()

for i in result:
    print(i)
    
##-------------------------------------------------
    
mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

mycursor=mydb.cursor()

mycursor.execute("SELECT * FROM students LIMIT 5 OFFSET 2")

result = mycursor.fetchall()

for i in result:
    print(i)
    
    
##################################################
# 8. Deleting entries and dropping tables 
    
mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='WS@abel1989',
        database='testdb')

sql="DELETE FROM students WHERE name = 'Eirc'"

mycursor=mydb.cursor()
mycursor.execute(sql)

mydb.commit()

# delete complete table 

sql="DROP TABLE students"

mycursor.execute(sql)
mydb.commit()
