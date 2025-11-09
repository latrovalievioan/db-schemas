create table author (
    id integer primary key,
    name text unique not null
);

create table style (
    id integer primary key,
    name text unique not null
);

create table songkey (
    id integer primary key,
    name text unique not null
);

create table song (
    id integer primary key,

    title text not null,
    author_id integer not null,
    foreign key (author_id) references author(id)
        on delete cascade
        on update cascade,

    tempo integer not null,
    key_id integer,
    foreign key (key_id) references songkey(id)
        on delete set null
        on update cascade,
    style_id integer,
    foreign key (style_id) references style(id)
        on delete set null
        on update cascade
);

create table user (
    id integer primary key
);

create table playlist (
    id integer primary key,
    name text not null,
    origin text not null, -- ['user', 'system']
    
    user_id integer not null,
    foreign key (user_id) references user(id)
        on delete cascade
        on update cascade,

    unique (user_id, name)
);

create table playlistsongs (
    playlist_id integer not null,
    foreign key (playlist_id) references playlist(id)
        on delete cascade
        on update cascade,
    song_id integer not null,
    foreign key (song_id) references song(id)
        on delete cascade
        on update cascade,
    position integer not null,

    unique(playlist_id, position),
    primary key (playlist_id, song_id)
);
