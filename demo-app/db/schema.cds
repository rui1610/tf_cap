namespace storeApp;

entity Product {
  key ID: UUID;
  productName: String(200);
  productInfo: String(500);
  stockLevel: Integer;
  discount: Decimal(5,2);
  targetAudience: Association to Audience;
  employees: Association to many Employee on employees.product = $self;
  employee: Association to Employee;
}

entity Employee {
  key ID: UUID;
  firstName: String(190);
  lastName: String(190);
  products: Association to many Product on products.employee = $self;
  product: Association to Product;
}

entity Audience {
  key ID: UUID;
  audiencePitch: String(500);
  product: Association to Product;
}

entity Customer {
  key ID: UUID;
  loyaltyInfo: String(500);
  firstName: String(190);
  lastName: String(190);
  product: Association to Product;
}

