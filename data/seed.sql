--PERSON INSERTS
/*INSERT INTO person (name, gender, birth_year, death_year, birth_precision, death_precision, description)
VALUES ('Julius Caesar', 'Male', -100, -44, 'Exact', 'Exact', 'Roman general, politician, and writer. He won major military campaigns in Gaul and won a civil war, making himself the supreme ruler of Rome. His actions ended the Roman Republic and led to the rise of the Roman Empire.');

INSERT INTO person (name, gender, birth_year, death_year, birth_precision, death_precision, description)
VALUES ('Cleopatra', 'Female', -69, -30, 'Exact', 'Exact', 'The last active ruler of Egypt''s Ptolemaic Kingdom. Known for her high intelligence and political skill, she famously aligned herself with Roman leaders Julius Caesar and Mark Antony to protect her throne. After her forces lost to Octavian at the Battle of Actium, she died by suicide in 30 BCE, ending her dynasty.');

INSERT INTO person (name, gender, birth_year, death_year, birth_precision, death_precision, description)
VALUES ('Mark Antony', 'Male', -83, -30, 'Exact', 'Exact', 'Roman general and politician who was a close ally of Julius Caesar. After Caesar died, Antony formed the Second Triumvirate to rule Rome. He is best known for his romantic and political alliance with Queen Cleopatra of Egypt, and his defeat by Octavian, aka Augustus, which led to the end of the Roman Republic.');*/


--PLACE INSERTS
/*INSERT INTO place (name, historical_names, latitude, longitude, description)
VALUES ('Rome', 'Roma, Urbs, Caput Mundi, The City of Seven Hills, Eternal City', 41.9028, 12.4964, 'The capital city of Italy. It sits on the Tiber River. Famous for its long history, old ruins, and art. It also surrounds Vatican City, a tiny independent state.');

INSERT INTO place (name, historical_names, latitude, longitude, description)
VALUES ('Alexandria', 'Rhacotis, Alexandria ad Aegyptum, Al-Iskandariyah', 31.1975, 29.8925, 'Founded by Alexander the Great in 332 BCE, it was a legendary ancient hub for Hellenistic scholarship, home to the Great Library and the Pharos Lighthouse. Today, it functions as a vital industrial and cultural center');

INSERT INTO place (name, historical_names, latitude, longitude, description)
VALUES ('Egypt', 'Kemet, Deshret, Tawy', 26.82, 30.80, 'A transcontinental country in North Africa and Southwest Asia. Famous for its ancient civilization, it features the Nile River, the Giza pyramids, and a desert landscape. The capital is Cairo, and the official language is Arabic.');

INSERT INTO place (name, historical_names, latitude, longitude, description)
VALUES ('Rubicon River', 'Fiumicino, Rubico', 44.1681, 12.4431, 'A shallow stream in northeastern Italy that flows into the Adriatic Sea. In 49 BC, Julius Caesar crossed it with his army in defiance of Roman law, sparking a civil war and giving rise to the famous idiom "crossing the rubicon" for passing a point of no return.');*/

-- EVENT INSERTS
/*INSERT INTO event (name, start_date, end_date, start_precision, end_precision, description, causes, consequences)
VALUES ('First Triumvirate formed', -59, -52, 'Circa', 'Exact',
'An informal, secret political alliance among Julius Caesar, Pompey the Great, and Marcus Licinius Crassus that came to dominate Roman politics in the late Republic. It was not a formal office and had no legal standing.',
'Caesar, Pompey, and Crassus each faced separate obstruction from the Senate to their individual political goals and formed the alliance to bypass it by combining their influence.',
'Enabled Caesar''s consulship legislation, Pompey''s eastern settlements, and Crassus''s business interests in Asia. The alliance frayed after Crassus''s death at Carrhae in 53 BC, setting the stage for civil war between Caesar and Pompey.');

INSERT INTO event (name, start_date, end_date, start_precision, end_precision, description, causes, consequences)
VALUES ('Crossing of the Rubicon', -48, NULL, 'Exact', NULL,
'Julius Caesar led a single legion across the Rubicon River, the boundary of Cisalpine Gaul, in defiance of Roman law forbidding a general from bringing his army into Italy proper.',
'The Senate, backed by Pompey, ordered Caesar to disband his army and return to Rome as a private citizen, which Caesar refused, viewing it as a politically motivated attempt to strip him of power.',
'Made war between Caesar and the Senate/Pompey inevitable, triggering the Great Roman Civil War. Gave rise to the idiom "crossing the Rubicon" for passing a point of no return.');

INSERT INTO event (name, start_date, end_date, start_precision, end_precision, description, causes, consequences)
VALUES ('Battle of Actium', -30, NULL, 'Exact', NULL,
'A decisive naval battle fought in the Ionian Sea near Actium, Greece, between the fleet of Octavian, commanded by Marcus Agrippa, and the combined fleet of Mark Antony and Cleopatra.',
'The culmination of over a decade of rivalry between Octavian and Antony, intensified by Antony''s alliance with Cleopatra and the political fallout from his redistribution of Roman territories to her and their children.',
'Decisively defeated Antony and Cleopatra''s forces. Both fled to Alexandria and died by suicide the following year, ending the Ptolemaic Kingdom and leaving Octavian as sole ruler of Rome, who would become Augustus.');

INSERT INTO event (name, start_date, end_date, start_precision, end_precision, description, causes, consequences)
VALUES ('Assassination of Julius Caesar', -43, NULL, 'Exact', NULL,
'Julius Caesar was stabbed to death by a group of Roman senators, led by Marcus Brutus and Gaius Cassius, at a Senate meeting held at the Theatre of Pompey.',
'Fear among a faction of senators that Caesar''s accumulation of power as dictator perpetuo threatened to permanently end the Republic.',
'Plunged Rome into a new round of civil war between Caesar''s supporters (led by Antony and Octavian) and his assassins. Directly led to the formation of the Second Triumvirate.');*/

-- OBJECT INSERTS
/*INSERT INTO object (name, type, create_date, create_precision, description)
VALUES ('Cleopatra''s Needles', 'Obelisk', -1449, 'Circa',
'A pair of ancient Egyptian obelisks originally carved and inscribed under Pharaoh Thutmose III at Heliopolis, later inscribed further by Ramesses II. Moved to Alexandria in 13/12 BC under Roman rule; one now stands in London, the other in New York City.');

INSERT INTO object (name, type, create_date, create_precision, description)
VALUES ('Elephant Denarius', 'Coin', -48, 'Circa',
'A silver denarius minted by Julius Caesar during his civil war campaign, depicting an elephant trampling a serpent. One of the first Roman coins to bear a living individual''s name, used to fund and communicate with Caesar''s legions.');

INSERT INTO object (name, type, create_date, create_precision, discovery_date, description)
VALUES ('Rosetta Stone', 'Stele', -195, 'Exact', 1799,
'A granodiorite stele inscribed with a priestly decree in hieroglyphic, Demotic, and Greek script, honoring Ptolemy V. Its parallel text in three scripts was the key to deciphering Egyptian hieroglyphs in the 19th century.');

INSERT INTO object (name, type, create_date, create_precision, discovery_date, description)
VALUES ('Tusculum Portrait', 'Sculpture', -45, 'Decade', 1825,
'A marble bust of Julius Caesar, widely regarded as the only surviving portrait plausibly made during his lifetime. Discovered at Tusculum by Lucien Bonaparte in 1825, though not identified as Caesar until 1940.');

INSERT INTO object (name, type, create_date, create_precision, discovery_date, description)
VALUES ('Actium Victory Monument', 'Monument', -26, 'Circa', 1805,
'A victory monument built by Octavian near Nikopolis, Greece, to commemorate his defeat of Antony and Cleopatra at Actium. Its façade displayed 36 bronze rams seized from their captured warships.');*/

-- CULTURE_TOPIC INSERTS
/*INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Ancient Rome', 'The broad civilization centered on the city of Rome, spanning its legendary founding through the Kingdom, Republic, and Empire periods.', -752, 476, 'Circa', 'Circa');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Ancient Egypt', 'The civilization of the Nile Valley from its unification under a single ruler through the end of independent Egyptian and Ptolemaic rule.', -3099, -29, 'Circa', 'Exact');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Hellenistic World', 'The Greek-influenced culture, politics, and scholarship that spread across the Eastern Mediterranean and Near East following Alexander the Great''s conquests.', -322, -30, 'Exact', 'Exact');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Roman Republic', 'The system of Roman government between the overthrow of the monarchy and the rise of the Roman Empire under Augustus.', -508, -26, 'Exact', 'Exact');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Ptolemaic Kingdom', 'The Hellenistic Greek kingdom of Egypt established by Alexander the Great''s general Ptolemy I, ruled by his descendants until Roman annexation.', -304, -29, 'Exact', 'Exact');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Roman Senate', 'The governing and advisory council of the Roman state, one of the most enduring political institutions of the ancient world.', -508, NULL, 'Exact', NULL);

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Rule of Julius Caesar', 'The period of Julius Caesar''s dominance over Roman politics, from his victory in the civil war to his assassination.', -48, -43, 'Circa', 'Exact');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Roman Politics', 'The political and governmental history of Rome across its Kingdom, Republic, and Empire eras.', -752, 476, 'Circa', 'Circa');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Roman Kingdom', 'The earliest, semi-legendary period of Roman governance under a series of kings, prior to the establishment of the Republic.', -752, -508, 'Circa', 'Exact');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Roman Empire', 'The autocratic system of Roman government established under Augustus after the fall of the Republic, lasting until the fall of the Western Roman Empire.', -26, 476, 'Exact', 'Circa');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Egyptian Politics', 'The political and governmental history of Egypt, from the pre-unification kingdoms through the end of Ptolemaic rule.', -3499, -29, 'Century', 'Exact');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Upper Egypt', 'The southern predynastic kingdom of the Nile Valley prior to unification with Lower Egypt under a single ruler.', -3499, -3099, 'Century', 'Circa');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Lower Egypt', 'The northern predynastic kingdom of the Nile Delta prior to unification with Upper Egypt under a single ruler.', -3499, -3099, 'Century', 'Circa');

INSERT INTO culture_topic (name, description, start_year, end_year, start_precision, end_precision)
VALUES ('Reign of Cleopatra', 'The period of Cleopatra VII''s rule as Pharaoh of the Ptolemaic Kingdom, from her accession to her death.', -50, -29, 'Circa', 'Exact');*/

-- CULTURE_TOPIC_CULTURE_TOPIC_RELATIONSHIP INSERTS (sub_topic_of)
/*INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (8, 1, 'sub_topic_of');   -- Roman Politics -> Ancient Rome

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (9, 8, 'sub_topic_of');   -- Roman Kingdom -> Roman Politics

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (4, 8, 'sub_topic_of');   -- Roman Republic -> Roman Politics

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (10, 8, 'sub_topic_of');  -- Roman Empire -> Roman Politics

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (6, 8, 'sub_topic_of');   -- Roman Senate -> Roman Politics

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (7, 4, 'sub_topic_of');   -- Rule of Julius Caesar -> Roman Republic

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (11, 2, 'sub_topic_of');  -- Egyptian Politics -> Ancient Egypt

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (12, 11, 'sub_topic_of'); -- Upper Egypt -> Egyptian Politics

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (13, 11, 'sub_topic_of'); -- Lower Egypt -> Egyptian Politics

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (5, 11, 'sub_topic_of');  -- Ptolemaic Kingdom -> Egyptian Politics

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (5, 3, 'sub_topic_of');   -- Ptolemaic Kingdom -> Hellenistic World

INSERT INTO culture_topic_culture_topic_relationships (culture_topic_a_id, culture_topic_b_id, relation_type)
VALUES (14, 5, 'sub_topic_of');  -- Reign of Cleopatra -> Ptolemaic Kingdom */

-- ADDITIONAL PLACE INSERTS
/*INSERT INTO place (name, historical_names, latitude, longitude, description)
VALUES ('Actium', 'Aktion (Ἄκτιον)', 38.9236, 20.7498,
'A promontory in northwestern Greece at the mouth of the Ambracian Gulf, site of the decisive naval battle between Octavian and the combined forces of Antony and Cleopatra in 31 BC.');

INSERT INTO place (name, historical_names, latitude, longitude, description)
VALUES ('Tusculum', 'Tuscolo', 41.7983, 12.7108,
'An ancient hill town in the Alban Hills southeast of Rome, a favored retreat for wealthy Romans in the late Republic, including Cicero. Site of the 1825 discovery of the Tusculum Portrait bust of Julius Caesar.');*/

-- PERSON_PLACE INSERTS
/*INSERT INTO person_place_relationships (person_id, place_id, relation_type) VALUES (1, 1, 'lived_in');
INSERT INTO person_place_relationships (person_id, place_id, relation_type) VALUES (1, 4, 'crossed');
INSERT INTO person_place_relationships (person_id, place_id, relation_type) VALUES (2, 2, 'lived_in');
INSERT INTO person_place_relationships (person_id, place_id, relation_type) VALUES (2, 3, 'governed_over');
INSERT INTO person_place_relationships (person_id, place_id, relation_type) VALUES (3, 1, 'lived_in');
INSERT INTO person_place_relationships (person_id, place_id, relation_type) VALUES (3, 2, 'associated_with');*/

-- PERSON_EVENT INSERTS
/*INSERT INTO person_event_relationships (person_id, event_id, relation_type) VALUES (1, 1, 'participated_in');
INSERT INTO person_event_relationships (person_id, event_id, relation_type) VALUES (1, 2, 'participated_in');
INSERT INTO person_event_relationships (person_id, event_id, relation_type) VALUES (1, 4, 'associated_with');
INSERT INTO person_event_relationships (person_id, event_id, relation_type) VALUES (2, 3, 'participated_in');
INSERT INTO person_event_relationships (person_id, event_id, relation_type) VALUES (3, 3, 'participated_in');*/

-- PERSON_OBJECT INSERTS
/*INSERT INTO person_object_relationships (person_id, object_id, relation_type) VALUES (1, 2, 'created_by');
INSERT INTO person_object_relationships (person_id, object_id, relation_type) VALUES (1, 4, 'depicted_in');
INSERT INTO person_object_relationships (person_id, object_id, relation_type) VALUES (2, 1, 'associated_with');*/

-- PERSON_CULTURE_TOPIC INSERTS
/*INSERT INTO person_culture_topic_relationships (person_id, culture_topic_id, relation_type) VALUES (1, 6, 'member_of');
INSERT INTO person_culture_topic_relationships (person_id, culture_topic_id, relation_type) VALUES (1, 7, 'associated_with');
INSERT INTO person_culture_topic_relationships (person_id, culture_topic_id, relation_type) VALUES (2, 5, 'governed_over');
INSERT INTO person_culture_topic_relationships (person_id, culture_topic_id, relation_type) VALUES (2, 14, 'associated_with');
INSERT INTO person_culture_topic_relationships (person_id, culture_topic_id, relation_type) VALUES (3, 6, 'member_of');*/

-- PERSON_PERSON INSERTS
/*INSERT INTO person_person_relationships (person_a_id, person_b_id, relation_type) VALUES (1, 3, 'associated_with');
INSERT INTO person_person_relationships (person_a_id, person_b_id, relation_type) VALUES (2, 1, 'partnered_with');
INSERT INTO person_person_relationships (person_a_id, person_b_id, relation_type) VALUES (2, 3, 'partnered_with');*/

-- PLACE_EVENT INSERTS
/*INSERT INTO place_event_relationships (place_id, event_id, relation_type) VALUES (1, 1, 'took_place_in');
INSERT INTO place_event_relationships (place_id, event_id, relation_type) VALUES (1, 4, 'took_place_in');
INSERT INTO place_event_relationships (place_id, event_id, relation_type) VALUES (4, 2, 'took_place_in');*/
-- ADDITIONAL PLACE_EVENT INSERT
/*INSERT INTO place_event_relationships (place_id, event_id, relation_type) VALUES (5, 3, 'took_place_in');*/

-- PLACE_OBJECT INSERTS
/*INSERT INTO place_object_relationships (place_id, object_id, relation_type) VALUES (3, 3, 'discovered_at');*/
-- ADDITIONAL PLACE_OBJECT INSERTS
/*INSERT INTO place_object_relationships (place_id, object_id, relation_type) VALUES (5, 5, 'currently_located_at');
INSERT INTO place_object_relationships (place_id, object_id, relation_type) VALUES (6, 4, 'discovered_at');*/

-- PLACE_CULTURE_TOPIC INSERTS
/*INSERT INTO place_culture_topic_relationships (place_id, culture_topic_id, relation_type) VALUES (1, 1, 'part_of');
INSERT INTO place_culture_topic_relationships (place_id, culture_topic_id, relation_type) VALUES (2, 5, 'part_of');
INSERT INTO place_culture_topic_relationships (place_id, culture_topic_id, relation_type) VALUES (3, 2, 'part_of');
INSERT INTO place_culture_topic_relationships (place_id, culture_topic_id, relation_type) VALUES (3, 5, 'part_of');*/

-- EVENT_CULTURE_TOPIC INSERTS
/*INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (1, 4, 'occurred_during');
INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (2, 4, 'occurred_during');
INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (2, 7, 'occurred_during');
INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (3, 4, 'occurred_during');
INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (3, 5, 'occurred_during');
INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (3, 14, 'occurred_during');
INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (4, 4, 'occurred_during');
INSERT INTO event_culture_topic_relationships (event_id, culture_topic_id, relation_type) VALUES (4, 7, 'occurred_during');*/

-- EVENT_EVENT INSERTS
/*INSERT INTO event_event_relationships (event_a_id, event_b_id, relation_type) VALUES (1, 2, 'precedes');
INSERT INTO event_event_relationships (event_a_id, event_b_id, relation_type) VALUES (2, 4, 'precedes');
INSERT INTO event_event_relationships (event_a_id, event_b_id, relation_type) VALUES (4, 3, 'precedes');*/

-- OBJECT_CULTURE_TOPIC INSERTS
/*INSERT INTO object_culture_topic_relationships (object_id, culture_topic_id, relation_type) VALUES (1, 2, 'created_during');
INSERT INTO object_culture_topic_relationships (object_id, culture_topic_id, relation_type) VALUES (2, 4, 'created_during');
INSERT INTO object_culture_topic_relationships (object_id, culture_topic_id, relation_type) VALUES (2, 7, 'created_during');
INSERT INTO object_culture_topic_relationships (object_id, culture_topic_id, relation_type) VALUES (3, 5, 'created_during');
INSERT INTO object_culture_topic_relationships (object_id, culture_topic_id, relation_type) VALUES (4, 7, 'created_during');
INSERT INTO object_culture_topic_relationships (object_id, culture_topic_id, relation_type) VALUES (5, 10, 'created_during');*/

-- PERSON_TITLE_HISTORY INSERTS
/*INSERT INTO person_title_history (person_id, culture_topic_id, title, start_year, end_year, start_precision, end_precision)
VALUES (1, 4, 'Consul', -58, -58, 'Exact', 'Exact');
INSERT INTO person_title_history (person_id, culture_topic_id, title, start_year, end_year, start_precision, end_precision)
VALUES (1, 4, 'Dictator perpetuo', -44, -43, 'Circa', 'Exact');
INSERT INTO person_title_history (person_id, culture_topic_id, title, start_year, end_year, start_precision, end_precision)
VALUES (2, 5, 'Pharaoh', -50, -29, 'Exact', 'Exact');
INSERT INTO person_title_history (person_id, culture_topic_id, title, start_year, end_year, start_precision, end_precision)
VALUES (3, 4, 'Triumvir', -42, -30, 'Circa', 'Circa');*/

