SELECT DISTINCT u.uid, u.mobile_no
FROM ecommerce.user u
JOIN ecommerce.order_details od ON u.uid = od.user_id
JOIN ecommerce.order_items oi ON od.oid = oi.order_id
JOIN ecommerce.product p ON oi.product_id = p.proid
WHERE p.name = 'Minoxydyl'
ORDER BY u.uid ASC;