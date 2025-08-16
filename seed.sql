CREATE DATABASE ecommerce;
CREATE USER 'apt_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'wlQ7cgP1oVf9JgXRR9TW';
GRANT SELECT ON ecommerce. * TO 'apt_user'@'localhost';
CREATE TABLE
    ecommerce.user (
        uid int PRIMARY KEY,
        username VARCHAR(40) NOT NULL,
        password VARCHAR(40) NOT NULL,
        Name VARCHAR(40) NOT NULL,
        Address VARCHAR(40) NOT NULL,
        mobile_no INT NOT NULL
    );
CREATE table
    ecommerce.order_details (
        oid int PRIMARY KEY,
        user_id INT NOT NULL,
        total INT,
        payment_id INT NOT NULL,
        created_at DATE
    );
CREATE TABLE
    ecommerce.payment (
        pid int PRIMARY KEY,
        order_id INT not null,
        amount int,
        payment_type varchar(40) NOT NULL,
        status varchar(40) NOT NULL,
        created_at date
    );
CREATE TABLE
    ecommerce.order_items (
        oiid int PRIMARY KEY,
        order_id INT NOT NULL,
        product_id INT NOT NULL,
        created_at date
    );
CREATE TABLE
    ecommerce.product (
        proid int PRIMARY KEY,
        name VARCHAR(40) NOT NULL,
        description VARCHAR(40),
        category VARCHAR(40) NOT NULL,
        price INT NOT NULL,
        stock INT
    );
INSERT INTO
    ecommerce.user
values
    (
        101,
        'alexsmith3',
        'xyz',
        'Alex Smith',
        'New Jersey',
        80665597
    ),
    (
        102,
        'johndean1',
        'abc',
        'John Dean',
        'New York',
        99113654
    ),
    (
        103,
        'stevehope22',
        'efg',
        'Steve Hopes',
        'San Jose',
        87702087
    );
INSERT INTO
    ecommerce.order_details
values
    (991, 101, 1400, 229, '2022-12-22'),
    (992, 102, 3700, 230, '2023-01-13'),
    (993, 101, 2300, 228, '2023-02-07'),
    (994, 103, 1100, 224, '2023-02-15'),
    (995, 102, 3090, 227, '2023-02-19'),
    (996, 101, 2200, 226, '2023-02-27'),
    (997, 103, 2700, 225, '2023-02-01');
INSERT INTO
    ecommerce.payment
values
    (
        224,
        994,
        1100,
        'NetBanking',
        'Success',
        '2023-02-15'
    ),
    (225, 997, 1500, 'COD', 'Pending', '2023-02-01'),
    (226, 996, 2200, 'UPI', 'Success', '2023-02-27'),
    (227, 995, 3090, 'UPI', 'Success', '2023-02-19'),
    (228, 993, 2300, 'COD', 'Pending ', '2023-02-07'),
    (229, 991, 1400, 'COD', 'Success', '2022-12-22'),
    (230, 992, 3700, 'COD', 'Success', '2023-01-13');
INSERT INTO
    ecommerce.order_items
values
    (11, 991, 811, '2022-12-22'),
    (12, 992, 811, '2023-01-13'),
    (13, 992, 814, '2023-01-13'),
    (14, 993, 812, '2023-02-07'),
    (15, 993, 813, '2023-02-07'),
    (16, 994, 817, '2023-02-15'),
    (17, 995, 812, '2023-02-19'),
    (18, 995, 815, '2023-02-19'),
    (19, 996, 817, '2023-02-27'),
    (20, 996, 817, '2023-02-27'),
    (21, 997, 811, '2023-02-01'),
    (22, 997, 813, '2023-02-01');
INSERT INTO
    ecommerce.product
values
    (
        811,
        'Wedding Kurta',
        'Wedding Kurta',
        'Fashion',
        1400,
        9
    ),
    (
        812,
        'Washing Machine',
        'Washing Machine',
        'Appliances',
        1000,
        6
    ),
    (
        813,
        'Remote Control Car',
        'Remote Control Car',
        'Toys',
        1300,
        11
    ),
    (
        814,
        'Apple IPhone',
        'Apple IPhone',
        'Mobiles',
        2300,
        14
    ),
    (
        815,
        'HP Laptop',
        'HP Laptop',
        'Electronics',
        2090,
        10
    ),
    (816, 'Sofa', 'Sofa', 'Furniture', 1600, 3),
    (
        817,
        'Minoxydyl',
        'Minoxydyl',
        'Hair Care',
        1100,
        7
    );
ALTER TABLE ecommerce.order_details ADD FOREIGN KEY (user_id) REFERENCES ecommerce.user (uid);
ALTER TABLE ecommerce.payment ADD FOREIGN KEY (order_id) REFERENCES ecommerce.order_details (oid);
ALTER TABLE ecommerce.order_details ADD FOREIGN KEY (payment_id) REFERENCES ecommerce.payment (pid);
ALTER TABLE ecommerce.order_items ADD FOREIGN KEY (order_id) REFERENCES ecommerce.order_details (oid);
ALTER TABLE ecommerce.order_items ADD FOREIGN KEY (product_id) REFERENCES ecommerce.product (proid);