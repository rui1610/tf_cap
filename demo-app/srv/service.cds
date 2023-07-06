using { storeApp } from '../db/schema.cds';

service storeAppSrv {
  entity Product as projection on storeApp.Product;
  entity Employee as projection on storeApp.Employee;
  entity Audience as projection on storeApp.Audience;
  entity Customer as projection on storeApp.Customer;
}