SELECT
    CONCAT(
	    RIGHT(u.mobile_no, 2),
        LEFT(od.oid, 2),
        LEFT(p.pid, 2),
        RIGHT(u.username, 2)
    ) as invoice_no,
    od.created_at
FROM
    user u
    JOIN order_details od on u.uid = od.user_id
    JOIN payment p on od.oid = p.order_id
ORDER BY od.created_at; 