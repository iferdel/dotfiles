- \h is your friend all the way
- having in your local psql activated and a database called the same as your username it makes you able to use psql right away without any argument to connect locally to the user's database. This allows you to test things or get \h for a quick overview of commands, even \? or trying other stuff.
- The psql prompt is great for quickly writing short queries. Once the query starts to grow and your SQL command starts wrapping in the prompt, it’s time for an upgrade. This is where \e comes in handy. \e will open the last query in your editor where you’ll get all the benefits of your favorite editor, like syntax highlighting and more. Once you save and close the file, it gets evaluated. Thus, \e is perfect for iteratively building a query.
- \e for interactive query building
- \i filename-
- Personally, I like to have two tmux splits side-by-side, one with Vim for editing the file containing the query and one with psql where I simply run \i query.sql. I then just jump between the two splits. 

Let’s assume I want to compare the query plan of two queries in my editor or diff tool. Here’s how I would do this:

db=# \o a.txt
db=# EXPLAIN SELECT * FROM users WHERE id IN (SELECT user_id FROM groups WHERE name = 'admins');
db=# \o b.txt
db=# EXPLAIN SELECT users.* FROM users LEFT JOIN groups WHERE groups.name = 'admins';
db=# \! vimdiff a.txt b.txt
I can now see both query plans side by side. This is also a great way to find out whether the results of two similar queries are the same or not.


https://phili.pe/posts/postgresql-on-the-command-line/
