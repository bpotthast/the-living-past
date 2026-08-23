CREATE TABLE IF NOT EXISTS source (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    institution TEXT, 
    url TEXT, 
    source_type TEXT CHECK (source_type IN ('Primary', 'Secondary', 'Tertiary')),
    source_subtype TEXT,
    publication_info TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS person (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    gender TEXT CHECK (gender IN ('Male', 'Female', 'Other', 'Unknown')),
    birth_year INTEGER, 
    death_year INTEGER,
    birth_precision TEXT CHECK (birth_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    death_precision TEXT CHECK (death_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    description TEXT,
    occupation_title TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE  IF NOT EXISTS place (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    historical_names TEXT,
    latitude REAL,
    longitude REAL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS event (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    start_date INTEGER NOT NULL, 
    end_date INTEGER,
    start_precision TEXT CHECK (start_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    end_precision TEXT CHECK (end_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    description TEXT,
    causes TEXT,
    consequences TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS object (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    type TEXT,
    create_date INTEGER NOT NULL, 
    create_precision TEXT CHECK (create_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    discovery_date INTEGER,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS culture_topic (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    description TEXT,    
    start_year INTEGER NOT NULL, 
    end_year INTEGER,
    start_precision TEXT CHECK (start_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    end_precision TEXT CHECK (end_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);