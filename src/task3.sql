SELECT 
    CONCAT(
        LOWER(SUBSTRING(u.username, 1, 2)),
        RIGHT(u.mobile_no, 2),
        LEFT(od.oid, 2),
        RIGHT(p.pid, 1)
    ) as invoice_no,
    u.Name as name,
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