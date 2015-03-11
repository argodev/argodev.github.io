<img alt='Metasploit' src='/assets/images/metasploit.png' class='blogimage img-responsive'>

I've been doing some penetration testing and working through a lab full of exercises which has led me to spending some
time with the Metasploit framework. I still consider myself somewhat of a novice when it comes to using this venerable
tool. That being said, while I appreciate the database-backing of the tool, and the fact that NMAP scans (and other
tools) can feed directly into the database (powered by Postgres), I found myself wanting to interact with the database
directly. I wanted to write SQL scripts and other things to update entries on servers. In general, I want to be able to
use this DB as the main repository for artifacts and documentation for my pentest and to serve as the basis for my
report.

To start, I wanted to connect pg admin to the database and poke around a bit, but I had difficulty figuring out what
the connection details were. After digging a bit, i found the connection details stored in
`/opt/metasploit/config/database.yml`. With this file, i was able to connect and tweak the database to my heart's
consent.