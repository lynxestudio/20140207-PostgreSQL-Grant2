

create table Books
(
        bookid serial not null primary key,
        isbn varchar(13) not null,
        title varchar(512) not null,
        numpages integer null,
        year smallint not null
);