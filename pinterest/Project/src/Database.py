'''
Created on Jun 9, 2012

Database module abstract the implementation for connecting to database

@author: vivianxu
'''
import sqlite3
import json

class Database(object):
    '''
    Database class wraps sqlite3 module and provides interfaces for executing 
    some common SQLite queries  
    '''

    def __init__(self, db_name):
        '''
        Constructor
   
            db_name -- database name
        '''
        self.conn = sqlite3.connect(db_name)
        self.conn.row_factory = sqlite3.Row
        self.c = self.conn.cursor()

    
    def __execute__(self, query, parameters = ()):
        '''
        Execute query with parameters
        '''
        if __debug__:
            print "execute :" + query
            print "with parameters: " + str(parameters)
            
        self.c.execute(query, parameters)


    def drop_table(self, table_name):
        '''
        Drop table
        '''
        self.__execute__("DROP TABLE " + table_name)

   
    def create_table(self, table_name, table_def):
        '''
        Create table
                
            table_def -- a dictionary containing table schema
        '''
        query = "CREATE TABLE IF NOT EXISTS " + table_name + " ("
        for key in table_def.keys():
            query += key + " " + table_def[key] + ','
        query = query[:-1] + ");"
        self.__execute__(query)
        
        self.conn.commit()
        
    
    def update_table(self, table_name, file_name):
        '''
        Update table
   
            file_name -- a txt file containing data in json format
        '''
        with open(file_name, "r") as f:
            for line in f :
                line.replace("\"", "\'")
                ob = json.loads(line)
                   
                query = "INSERT INTO " + table_name + " ("
                
                # append column names
                for key in ob.keys():
                    query += key + ","      
                query = query[:-1] + ") VALUES ("
                query += "?," * len(ob.keys())
                query = query[:-1] + ")"
             
                try:
                    self.__execute__(query, tuple(ob.values()))
                except:
                    print "Fail to insert (possible duplicate):"
                    print line
                
        self.conn.commit()


    def get_rows(self, table_name, column, value):
        '''
        Fetch rows, i.e. SELECT * from table_name WHERE column = value
        '''
        query = "SELECT * FROM " + table_name + " WHERE " + column + " = " + str(value)
        self.__execute__(query)
        
        return self.c.fetchall()


    def fetchall(self, query, parameters):
        '''
        Execute queries with parameters and fetch all returned rows
        '''
        self.__execute__(query, parameters)      
        
        return self.c.fetchall()
