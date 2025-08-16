let readFile = require("../src/readFile");
let executeQuery = require("../src/executeQuery");
let path = require("path");

const isDescending = (arr) => {
  return arr.every((x, i) => {
    return i === 0 || x <= arr[i - 1];
  });
};

describe("Task 1", () => {
  let customers;
  let uids;

  beforeAll(async () => {
    try {
      const sql = await readFile(
        path.join(__dirname, "..", "src", "task1.sql")
      );
      if (sql.length > 0) {
        customers = await executeQuery(sql);
      }
      uids = customers.map((result) => {
        return result.uid;
      });
    } catch (e) {
      console.error(e);
    }
  });

  test("should fetch first user and its mobile number of customer who have hair faill issues (i.e. ordered Minoxydyl) ", () => {
    expect(customers[0]?.uid).toBe(101);
    expect(customers[0]?.mobile_no).toBe(80665597);
  });

  test("should fetch two customers who have hair faill issues (i.e. ordered Minoxydyl) ", () => {
    expect(customers?.length).toEqual(2);
  });

  test("should order customer by user id in ascending order", () => {
    const isAscending = (arr) => {
      return arr.every((x, i) => {
        return i === 0 || x >= arr[i - 1];
      });
    };

    expect(isAscending(uids)).toBe(true);
  });
});

describe("Task 2", () => {
  let products;

  beforeAll(async () => {
    try {
      const sql = await readFile(
        path.join(__dirname, "..", "src", "task2.sql")
      );
      if (sql.length > 0) {
        products = await executeQuery(sql);
      }
    } catch (e) {
      console.error(e);
    }
  });

  test("should only have all the products which are sold", () => {
    const productNames = products.map((product) => {
      return product.name;
    });
    const soldProducts = [
      "Wedding Kurta",
      "Remote Control Car",
      "Minoxydyl",
      "Apple IPhone",
      "HP Laptop",
      "Washing Machine",
    ];

    productNames.forEach((productName) => {
      expect(soldProducts.includes(productName)).toBe(true);
    });
  });

  test("should calculate 20% profit for fashion", () => {
    const fashionProduct = products.find(
      (product) => product.category === "Fashion"
    );

    expect(fashionProduct?.Profit).toBe(840);
  });

  test("should sort the records in descending order of profit", () => {
    const productProfits = products.map((product) => {
      return product.Profit;
    });

    expect(isDescending(productProfits)).toBe(true);
  });
});

describe("Task 3", () => {
  let invoices;

  beforeAll(async () => {
    try {
      const sql = await readFile(
        path.join(__dirname, "..", "src", "task3.sql")
      );
      if (sql.length > 0) {
        invoices = await executeQuery(sql);
      }
    } catch (e) {
      console.error(e);
    }
  });

  test("should fetch correct invoice numbers for Steve Hopes", () => {
    const steveInvoices = invoices.filter(
      (invoice) => invoice.name === "Steve Hopes"
    );

    expect(steveInvoices[0]?.invoice_no).toBe("st992487");
    expect(steveInvoices[1]?.invoice_no).toBe("st992587");
  });

  test("should fetch invoices belonging to 2023 only", () => {
    invoices.forEach((invoice) => {
      const date = new Date(invoice.created_at);
      expect(date.getFullYear()).toBe(2023);
    });
  });

  test("should fetch invoices in descending order of created_at", () => {
    const createdAtDates = invoices.map((invoice) => {
      return invoice.created_at;
    });

    expect(isDescending(createdAtDates)).toBe(true);
  });

  test("should fetch John Dean as second and last record", () => {
    expect(invoices[1]?.name).toBe("John Dean");
    expect(invoices[1]?.invoice_no).toBe("jo992754");

    expect(invoices[5]?.name).toBe("John Dean");
    expect(invoices[5]?.invoice_no).toBe("jo993054");
  });
});
