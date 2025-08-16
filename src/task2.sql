SELECT 
    p.name,
    p.category,
    CASE 
        WHEN p.category = 'Fashion' THEN p.price * 0.20
        WHEN p.category = 'Electronics' THEN p.price * 0.15
        WHEN p.category = 'Mobiles' THEN p.price * 0.10
        ELSE p.price * 0.05
    END AS Profit
FROM 
    ecommerce.product p
JOIN 
    ecommerce.order_items oi ON p.proid = oi.product_id
JOIN 
    ecommerce.order_details od ON oi.order_id = od.oid
GROUP BY 
    p.proid, p.name, p.category, p.price
ORDER BY 
    Profit DESC;