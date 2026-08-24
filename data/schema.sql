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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS place (
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

CREATE TABLE IF NOT EXISTS person_title_history (
    id INTEGER PRIMARY KEY, 
    person_id INTEGER NOT NULL, 
    culture_topic_id INTEGER,
    title TEXT NOT NULL, 
    start_year INTEGER NOT NULL, 
    end_year INTEGER,
    start_precision TEXT CHECK (start_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    end_precision TEXT CHECK (end_precision IN ('Exact', 'Circa', 'Decade', 'Century')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (culture_topic_id) REFERENCES culture_topic(id)
);

CREATE TABLE IF NOT EXISTS person_place_relationships (
    person_id INTEGER,
    place_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (place_id) REFERENCES place(id),
    PRIMARY KEY (person_id, place_id, relation_type)
);

CREATE TABLE IF NOT EXISTS person_person_relationships (
    person_a_id INTEGER,
    person_b_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_a_id) REFERENCES person(id),
    FOREIGN KEY (person_b_id) REFERENCES person(id),
    PRIMARY KEY (person_a_id, person_b_id, relation_type)
);

CREATE TABLE IF NOT EXISTS person_event_relationships (
    person_id INTEGER,
    event_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (event_id) REFERENCES event(id),
    PRIMARY KEY (person_id, event_id, relation_type)
);

CREATE TABLE IF NOT EXISTS event_event_relationships (
    event_a_id INTEGER,
    event_b_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_a_id) REFERENCES event(id),
    FOREIGN KEY (event_b_id) REFERENCES event(id),
    PRIMARY KEY (event_a_id, event_b_id, relation_type)
);

CREATE TABLE IF NOT EXISTS person_object_relationships (
    person_id INTEGER,
    object_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (object_id) REFERENCES object(id),
    PRIMARY KEY (person_id, object_id, relation_type)
);

CREATE TABLE IF NOT EXISTS person_culture_topic_relationships (
    person_id INTEGER,
    culture_topic_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (culture_topic_id) REFERENCES culture_topic(id),
    PRIMARY KEY (person_id, culture_topic_id, relation_type)
);

CREATE TABLE IF NOT EXISTS place_event_relationships (
    place_id INTEGER,
    event_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (place_id) REFERENCES place(id),
    FOREIGN KEY (event_id) REFERENCES event(id),
    PRIMARY KEY (place_id, event_id, relation_type)
);

CREATE TABLE IF NOT EXISTS place_object_relationships (
    place_id INTEGER,
    object_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (place_id) REFERENCES place(id),
    FOREIGN KEY (object_id) REFERENCES object(id),
    PRIMARY KEY (place_id, object_id, relation_type)
);

CREATE TABLE IF NOT EXISTS place_culture_topic_relationships (
    place_id INTEGER,
    culture_topic_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (place_id) REFERENCES place(id),
    FOREIGN KEY (culture_topic_id) REFERENCES culture_topic(id),
    PRIMARY KEY (place_id, culture_topic_id, relation_type)
);

CREATE TABLE IF NOT EXISTS event_culture_topic_relationships (
    event_id INTEGER,
    culture_topic_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES event(id),
    FOREIGN KEY (culture_topic_id) REFERENCES culture_topic(id),
    PRIMARY KEY (event_id, culture_topic_id, relation_type)
);

CREATE TABLE IF NOT EXISTS object_culture_topic_relationships (
    object_id INTEGER,
    culture_topic_id INTEGER,
    relation_type TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (object_id) REFERENCES object(id),
    FOREIGN KEY (culture_topic_id) REFERENCES culture_topic(id),
    PRIMARY KEY (object_id, culture_topic_id, relation_type)
);

CREATE TABLE IF NOT EXISTS person_source_relationships (
	person_id INTEGER,
    source_id INTEGER,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (source_id) REFERENCES source(id),
    PRIMARY KEY (person_id, source_id)
);

CREATE TABLE IF NOT EXISTS place_source_relationships (
	place_id INTEGER,
    source_id INTEGER,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (place_id) REFERENCES place(id),
    FOREIGN KEY (source_id) REFERENCES source(id),
    PRIMARY KEY (place_id, source_id)
);

CREATE TABLE IF NOT EXISTS object_source_relationships (
	object_id INTEGER,
    source_id INTEGER,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (object_id) REFERENCES object(id),
    FOREIGN KEY (source_id) REFERENCES source(id),
    PRIMARY KEY (object_id, source_id)
);

CREATE TABLE IF NOT EXISTS event_source_relationships (
	event_id INTEGER,
    source_id INTEGER,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (event_id) REFERENCES event(id),
    FOREIGN KEY (source_id) REFERENCES source(id),
    PRIMARY KEY (event_id, source_id)
);

CREATE TABLE IF NOT EXISTS culture_topic_source_relationships (
	culture_topic_id INTEGER,
    source_id INTEGER,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (culture_topic_id) REFERENCES culture_topic(id),
    FOREIGN KEY (source_id) REFERENCES source(id),
    PRIMARY KEY (culture_topic_id, source_id)
);