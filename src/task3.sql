SELECT 
    u.Name as name,
    CONCAT(
        LOWER(SUBSTRING(u.username, 1, 2)),  -- First 2 chars of username
        '9',                                -- Static '9'
        SUBSTRING(od.oid, 2, 2),            -- Middle 2 digits of order ID
        SUBSTRING(p.pid, 2, 2)              -- Middle 2 digits of payment ID
    ) as invoice_no,
    od.created_at
FROM 
    ecommerce.user u
JOIN 
    ecommerce.order_details od ON u.uid = od.user_id
JOIN 
    ecommerce.payment p ON od.payment_id = p.pid
WHERE 
    YEAR(od.created_at) = 2023
ORDER BY 
    od.created_at DESC; 