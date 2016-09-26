#
# Database access functions for the web forum.
#

import time
import psycopg2

## Database connection


## Get posts from database.
def GetAllPosts():
    '''Get all the posts from the database, sorted with the newest first.

    Returns:
      A list of dictionaries, where each dictionary has a 'content' key
      pointing to the post content, and 'time' key pointing to the time
      it was posted.
    '''
    #posts = [{'content': str(row[1]), 'time': str(row[0])} for row in DB]
    #posts.sort(key=lambda row: row['time'], reverse=True)
    #return posts
    # Establish the connection inside the method
    db = psycopg2.connect("dbname=forum")
    c = db.cursor()
    query = "select time,content from posts order by time desc;"
    c.execute(query)
    posts = c.fetchall()
    db.close()
    return posts

## Add a post to the database.
def AddPost(name, nickname):
    '''Add a new post to the database.

    Args:
      content: The text content of the new post.
    '''
    t = time.strftime('%c', time.localtime())
    c = db.cursor()
    c.execute("insert into forum values (%s, %s, %s);"
              %(t, name, nickname)
    db.commit()
    db.close()
