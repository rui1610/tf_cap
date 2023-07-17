using { guitarStore } from '../db/schema.cds';

service guitarStoreSrv {
  entity Pitch as projection on guitarStore.Pitch;
  entity Warehouse as projection on guitarStore.Warehouse;
  entity Discount as projection on guitarStore.Discount;
}