#
# Database access functions for the web forum.
#

import time
import psycopg2
import bleach

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
    query = "SELECT time,content FROM posts ORDER BY time DESC"
    c.execute(query)
    posts = [{'content': str(row[1]),
              'time': str(row[0])}
             for row in c.fetchall()]
    db.close()
    return posts

## Add a post to the database.
def AddPost(content):
    '''Add a new post to the database.

    Args:
      content: The text content of the new post.
    '''
    #t = time.strftime('%c', time.localtime())
    db = psycopg2.connect("dbname=forum")
    c = db.cursor()
    c.execute("INSERT INTO posts (content) values (%s)",  (bleach.clean(content),))
    db.commit()
    db.close()
