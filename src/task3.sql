SELECT 
    u.Name as name,
    CONCAT(
        LOWER(SUBSTRING(u.username, 1, 2)), -- first two letters of username
        LEFT(od.oid, 2),                    -- first two digits of oid
        RIGHT(p.pid, 2),                    -- last two digits of pid
        RIGHT(u.mobile_no, 2)               -- last two digits of the mobile_no
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