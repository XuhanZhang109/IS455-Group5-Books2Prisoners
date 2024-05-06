# How many sci-fi books do we have in stock?
SELECT 
    genre, 
    SUM(quantity) AS total_books
FROM 
    Inventory
WHERE 
    genre = 'Sci-Fi';

# What is the most requested genre?
SELECT 
    requested_genre,
    COUNT(requested_genre) AS genre_count
FROM
    Request_Letter
GROUP BY 
    requested_genre
ORDER BY 
    genre_count DESC;

# What books has inmate Y567890 already received?
SELECT 
    order_id, orders.ISBN, title
FROM
    orders
        JOIN
    bibliographic_metadata
WHERE
    orders.ISBN = bibliographic_metadata.ISBN
        AND order_id = (SELECT 
            order_id
        FROM
            order_status
        WHERE
            inmate_id = 'Y567890');
            
# When is the last order sent to inmate Y567890?
SELECT 
    inmate_id,
	MAX(order_closed_date) AS hold_date
FROM 
    Order_Status
WHERE 
    inmate_id = "Y567890";

# What to consider when sending books to the inmate R772904?
SELECT 
    inmate_id, hardcover, notes, restrictions
FROM
    receiver
        JOIN
    facility ON receiver.facility_name = facility.facility_name
WHERE
    inmate_id = 'R772904';
    
# Show the orders that have been sent to the Logan Correctional Center after April 15.
SELECT 
    order_id
FROM
    dispatched_order
WHERE
    tracking_number 
    IN (
        SELECT 
            tracking_number
        FROM
            dispatch
        WHERE
            facility_name = 'Logan Correctional Center'
                AND dispatch_date >= '2024-04-15'
);

# On average, how long does it take for received letters to be processed?
SELECT 
    AVG(DATEDIFF(order_closed_date, order_opened_date)) AS average_processing_time
FROM 
    order_status;