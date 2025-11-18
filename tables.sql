
CREATE TABLE IF NOT EXISTS genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS artists_genres (
    id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (artist_id) REFERENCES artists(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE(artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER CHECK (release_year >= 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    cover_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS album_artists (
    id SERIAL PRIMARY KEY,
    album_id INTEGER NOT NULL,
    artist_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (album_id) REFERENCES albums(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE(album_id, artist_id)
);

CREATE TABLE IF NOT EXISTS tracks (
    id SERIAL PRIMARY KEY,
    album_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration INTEGER CHECK (duration > 0 AND duration <= 3600), -- в секундах, максимум 1 час
    track_order INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (album_id) REFERENCES albums(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS compilations (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER CHECK (release_year >= 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS compilation_tracks (
    id SERIAL PRIMARY KEY,
    compilation_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (compilation_id) REFERENCES compilations(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (track_id) REFERENCES tracks(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE(compilation_id, track_id)
);
