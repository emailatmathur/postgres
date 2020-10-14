To generate the dynamic script in postgres to export the BLOBS. I have exported the blobs OID <any column that matches OID as key> from table

psql> select '\lo_export '||OID or Key column|| ' ' ||filename or OID as filename || '' from <table_name> ;

<output>

\lo_export 78660 78660
\lo_export 78661 78661
\lo_export 78662 78662

<...>

To import the BLOBS data, generate the dynamic script and update the table with new OID <new oids will be generated during import>.

psql> SELECT FORMAT('\lo_import '||<file_name>|| E'\n'|| ' update <table_name> set <column_name> = :LASTOID where <column_name> = ''' ||<column_name>|| ''';') from <table_name>;

or 

psql> select '\lo_import ' || <file_name> || E'\n'|| ' update <table_name> set <colun_name> = :LASTOID where <column_name>= ''' ||<column_name>|| ''';' from <table_name>;

<...>
\lo_import 78660 
update ngc_exchange set payload = :LASTOID where payload= '78660';

\lo_import 78661 
update ngc_exchange set payload = :LASTOID where payload= '78661';

\lo_import 78662 
update ngc_exchange set payload = :LASTOID where payload= '78662';

<...>

You can simply copy the exported BLOB files to new server or even upload from same server to new database using above queries. :LASTLOIS will be new OID returns from import command. This can also be put into pgpsql to automate the process.
whereas E'\n'|| is used to move the output onto second line.

You can also build the insert statement as well by using the same method.

