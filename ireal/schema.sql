CREATE TABLE Author (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE Song (
    id INTEGER PRIMARY KEY,

    title TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Author(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    tempo INTEGER NOT NULL,
    song_key TEXT,
    style TEXT
);

CREATE TABLE User (
    id INTEGER PRIMARY KEY
);

CREATE TABLE UserSettings (
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY (user_id),

    font_type TEXT,
    app_theme TEXT,
    song_theme TEXT,
    minor_symbol_type TEXT, -- ['m', '-']
    playback_position TEXT,
    rehearsal_symbol_display TEXT, -- ['highlight']
    transposing_instrumnt TEXT,
    chord_diagrams_type TEXT
);

CREATE TABLE UserSong (
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    song_id INTEGER NOT NULL,
    FOREIGN KEY (song_id) REFERENCES Song(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    PRIMARY KEY (user_id, song_id)
)

CREATE TABLE UserSongPlaybackSettings (
    user_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    FOREIGN KEY (user_id, song_id) REFERENCES UserSong(user_id, song_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    tempo INTEGER,
    playback_key TEXT,
    style TEXT,
    repeats INTEGER,

    piano_sound TEXT,
    piano_volume INTEGER,
    bass_sound TEXT,
    bass_volume INTEGER,
    drums_sound TEXT,
    drums_volume INTEGER,

    reverb_amount INTEGER,

    chords_type TEXT, -- ['embelished']
    
    count_in_volume INTEGER,
    count_in_duration INTEGER,

    primary_click_sound TEXT,
    secondary_click_sound TEXT,

    PRIMARY KEY (user_id, song_id)
)

CREATE TABLE Playlist (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    origin TEXT NOT NULL, -- ['user', 'system']
    
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE (user_id, name)
);

CREATE TABLE PlaylistSong (
    playlist_id INTEGER NOT NULL,
    FOREIGN KEY (playlist_id) REFERENCES Playlist(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    user_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    FOREIGN KEY (user_id, song_id) REFERENCES UserSong(user_id, song_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    order INTEGER NOT NULL,

    PRIMARY KEY (playlist_id, user_id, song_id)
)
