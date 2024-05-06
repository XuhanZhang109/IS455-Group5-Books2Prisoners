# Create database
CREATE DATABASE books2prisoners;

# Use database
USE books2prisoners;

# Create tables
CREATE TABLE Request_Letter (
    inmate_id VARCHAR(10) NOT NULL, 
    date_stamped DATE NOT NULL,
    requested_genre VARCHAR(50), 
    requested_author VARCHAR(50),
    requested_title VARCHAR(50),
    status ENUM ("processed", "unprocessed"),
    PRIMARY KEY (inmate_id, date_stamped)
);

CREATE TABLE Orders (
    order_id INT NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    PRIMARY KEY (order_id, ISBN)
);

CREATE TABLE Order_Status (
    order_id INT PRIMARY KEY NOT NULL, 
    inmate_id  VARCHAR(10),
    order_opened_date DATE,
    order_closed_date DATE,
    date_stamped  DATE
);

CREATE TABLE Facility (
    facility_name VARCHAR(50) PRIMARY KEY NOT NULL, 
    restrictions TEXT,
    address VARCHAR(255),
    zip_code VARCHAR(10),
    city_name VARCHAR(50)
);

CREATE TABLE Dispatch (
	tracking_number CHAR(20) PRIMARY KEY NOT NULL,
    facility_name VARCHAR(50) NOT NULL,
    dispatch_date DATE,
    FOREIGN KEY (facility_name) REFERENCES Facility(facility_name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Dispatched_Order (
    order_id INT PRIMARY KEY NOT NULL, 
    tracking_number CHAR(20) NOT NULL,
    FOREIGN KEY (tracking_number) REFERENCES Dispatch(tracking_number)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Receiver (
    inmate_id  VARCHAR(10) PRIMARY KEY NOT NULL,
    facility_name  VARCHAR(50),
    inmate_name VARCHAR(50) NOT NULL,
    gender ENUM ("Male", "Female", "Non-binary"),
    birthdate DATE,
    projected_parole_date DATE NOT NULL,
	dictionary_eng ENUM ("Yes", "No") NOT NULL,
    dictionary_esp ENUM ("Yes", "No") NOT NULL,
    hardcover ENUM ("Yes", "No") NOT NULL,
    notes  TEXT,
	FOREIGN KEY (facility_name) REFERENCES Facility(facility_name)
        ON UPDATE CASCADE
);


CREATE TABLE Bibliographic_Metadata (
    ISBN VARCHAR(13) PRIMARY KEY NOT NULL, 
    title VARCHAR(50),
    author VARCHAR(50),
    hardcover ENUM ("Yes", "No") NOT NULL,
    genre VARCHAR(50)
);

CREATE TABLE Inventory (
    ISBN VARCHAR(13) PRIMARY KEY NOT NULL, 
    genre VARCHAR(50),
    quantity INT UNSIGNED
);

# Data insertion
INSERT INTO orders (order_id, ISBN)
VALUES 
    (00001, "9780451524935"),
    (00001, "9780316769488"),
    (00001, "9780743273565"),
    (00002, "9780679783268"),
    (00002, "9781503261969"),
    (00003, "9780439023528"),
    (00003, "9780590353427"),
    (00003, "9781524763138"),
    (00003, "9780345816023"),
    (00004, "9780142424179"),
    (00004, "9780743273565"),
    (00005, "9780316769488"),
    (00005, "9780679783268"),
    (00005, "9781503261969"),
    (00005, "9781524763138");
    
INSERT INTO facility (facility_name, restrictions, address, zip_code, city_name)
VALUES 
    ("Stateville Correctional Center", "no hardbound books", "16830 IL-53", "60403","Crest Hill"),
    ("Menard Correctional Center", "no stained books", "711 E Kaskaskia St", "62259", "Menard"),
    ("Pontiac Correctional Center", "no graphic novels", "700 W Lincoln St", "61764", "Pontiac"), 
    ("Logan Correctional Center", "no hardbound books", "1096 1350th St", "62656", "Lincoln"),  
    ("Decatur Correctional Center", null, "2310 East Mound Road, P.O. Box 3066",  "62524", "Decatur");

INSERT INTO bibliographic_metadata (ISBN, title, author, hardcover, genre)
VALUES
	("9780451524935", "1984", "George Orwell", "Yes", "Dystopian"),
    ("9780316769488", "The Catcher in the Rye", "J.D. Salinger", "No", "Literary"),
    ("9780743273565", "The Great Gatsby", "F. Scott Fitzgerald", "Yes", "Classic"),
    ("9780679783268", "Pride and Prejudice", "Jane Austen", "No", "Romance"),
    ("9780439023528", "The Hunger Games", "Suzanne Collins", "No", "Young Adult");

INSERT INTO inventory (ISBN, genre, quantity)
VALUES
    ("9780451524935", "Dystopian", 2),
    ("9780316769488", "Literary", 1),
    ("9780743273565", "Classic", 3),
    ("9780679783268", "Romance", 1),
    ("9780439023528", "Young Adult", 1),
    ("9780575088325", "Sci-Fi", 1),
    ("9780450032999", "Sci-Fi", 4),
    ("9780804134729", "Sci-Fi", 1),
    ("9780316038288", "Sci-Fi", 3),
    ("9780553293350", "Sci-Fi", 2),
    ("9780575074829", "Sci-Fi", 3),
    ("9780553293831", "Sci-Fi", 1);

INSERT INTO request_letter (inmate_id, date_stamped, requested_genre, requested_author, requested_title, status)
VALUES 
    ("A123456", "2024-04-05", "Classic", "James Joyce", "Ulysses", "processed"),
    ("C345678", "2024-04-08", "Dictionary", "Merriam-Webster", "The Merriam-Webster Dictionary, Newest Edition", "unprocessed"),
    ("M901234", "2024-04-11", "Classic", "Jane Austen", "Persuasion", "processed"),
    ("B789012", "2024-04-13", "Classic", "Bram Stoker", "Dracula", "processed"),
    ("R772904", "2024-04-16", "Young Adult", "Rainbow Rowell", "Eleanor & Park", "unprocessed"),
    ("X389048", "2024-04-16", "Dystopian", "Franz Kafka", "The Trial", "unprocessed"),
    ("Y567890", "2024-04-11", "Dystopian", "Ray Bradburt", "Fahrenheit 451", "processed");

INSERT INTO receiver (inmate_id, facility_name, inmate_name, gender, birthdate, projected_parole_date, dictionary_eng, dictionary_esp, hardcover, notes)
VALUES 
    ("A123456", "Stateville Correctional Center", "John Smith", "Male", "2007-01-15", "2028-05-20", "Yes", "No", "No", null),
    ("B789012", "Stateville Correctional Center", "Jane Doe", "Female", "1985-03-28", "2030-11-03", "No", "No", "Yes", null),
    ("C345678", "Decatur Correctional Center", "David Johnson", "Non-Binary", "1979-11-09", "2027-09-15", "No", "Yes", "No", "cannot read english"),
    ("M901234", "Logan Correctional Center", "James Brown", "Male", "2001-04-05", "2031-05-09", "Yes", "No", "No", null), 
    ("Y567890", "Pontiac Correctional Center", "Jenna Gill", "Female", "1990-08-20", "2056-11-29", "No", "No", "Yes", null),
    ("X389048", "Logan Correctional Center", "Jeremy Bolt", "Male", "1973-12-05", "2033-08-27", "No", "Yes", "Yes", null),
    ("R772904", "Pontiac Correctional Center", "Finn Fletcher", "Non-Binary", "2008-05-16", "2040-09-24", "No", "No", "No", "can receive YA only");
    
INSERT INTO Order_Status (order_id, date_stamped, order_opened_date, order_closed_date, inmate_id)
VALUES 
    (00001, "2024-04-01", "2024-03-02", "2024-04-05", "A123456"),
    (00002, "2024-04-02", "2024-03-06", "2024-04-06", "B789012"),
    (00003, "2024-04-03", "2024-02-09", "2024-04-07", "C345678"),
    (00004, "2024-04-04", "2024-03-01", "2024-04-08", "M901234"),
    (00005, "2024-04-05", "2024-02-26", "2024-04-10", "Y567890");

INSERT INTO Dispatch (tracking_number, facility_name, dispatch_date)
VALUES 
	("940551020079345678", "Stateville Correctional Center", "2024-04-15"),
    ("940551020079345679", "Menard Correctional Center", "2024-04-14"),
    ("940551020079345680", "Logan Correctional Center", "2024-04-20"),
    ("940551020079345681", "Pontiac Correctional Center", "2024-04-15"),
    ("940551020079345682", "Decatur Correctional Center", "2024-04-12");

INSERT INTO Dispatched_Order (order_id, tracking_number)
VALUES 
	(00001, "940551020079345678"),
	(00002, "940551020079345678"),
	(00003, "940551020079345678"),
	(00004, "940551020079345678"),
	(00005, "940551020079345678"),
	(00006, "940551020079345679"),
	(00007, "940551020079345679"),
	(00008, "940551020079345679"),
	(00009, "940551020079345679"),
	(00010, "940551020079345679"),
	(00011, "940551020079345679"),
	(00012, "940551020079345680"),
	(00013, "940551020079345680"),
	(00014, "940551020079345680"),
	(00015, "940551020079345680"),
	(00016, "940551020079345680"),
	(00017, "940551020079345680"),
	(00018, "940551020079345680"),
	(00019, "940551020079345681"),
	(00020, "940551020079345681"),
	(00021, "940551020079345681"),
	(00022, "940551020079345681"),
	(00023, "940551020079345681"),
	(00024, "940551020079345681"),
	(00025, "940551020079345681"),
	(00026, "940551020079345681"),
	(00027, "940551020079345682"),
	(00028, "940551020079345682"),
	(00029, "940551020079345682"),
	(00030, "940551020079345682");