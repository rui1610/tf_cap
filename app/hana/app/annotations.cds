using { storeAppSrv } from '../srv/service.cds';

annotate storeAppSrv.Product with @odata.draft.enabled;
annotate storeAppSrv.Employee with @odata.draft.enabled;
annotate storeAppSrv.Audience with @odata.draft.enabled;
annotate storeAppSrv.Customer with @odata.draft.enabled;
annotate storeAppSrv.Audience with @cds.odata.valuelist;
annotate storeAppSrv.Employee with @cds.odata.valuelist;
annotate storeAppSrv.Product with @cds.odata.valuelist;
annotate storeAppSrv.Product with @UI.HeaderInfo: { TypeName: 'Product', TypeNamePlural: 'Products', Title: { Value: productName } };
annotate storeAppSrv.Product with {
  ID @Common.Text: { $value: productName, ![@UI.TextArrangement]: #TextOnly }
};
annotate storeAppSrv.Product with @UI.Identification: [{ Value: productName }];
annotate storeAppSrv.Product with {
  productName @title: 'Product Name';
  productInfo @title: 'Product Information';
  stockLevel @title: 'Stock Level';
  discount @title: 'Discount'
};

annotate storeAppSrv.Product with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: productName },
    { $Type: 'UI.DataField', Value: productInfo },
    { $Type: 'UI.DataField', Value: stockLevel },
    { $Type: 'UI.DataField', Value: discount },
    { $Type: 'UI.DataField', Label: 'Employee', Value: employee_ID }
];

annotate storeAppSrv.Product with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: productName },
    { $Type: 'UI.DataField', Value: productInfo },
    { $Type: 'UI.DataField', Value: stockLevel },
    { $Type: 'UI.DataField', Value: discount },
    { $Type: 'UI.DataField', Label: 'Employee', Value: employee_ID }
  ]
};

annotate storeAppSrv.Product with {
  employee @Common.Text: { $value: employee.lastName, ![@UI.TextArrangement]: #TextOnly }
};

annotate storeAppSrv.Product with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate storeAppSrv.Employee with @UI.HeaderInfo: { TypeName: 'Employee', TypeNamePlural: 'Employees', Title: { Value: lastName } };
annotate storeAppSrv.Employee with {
  ID @Common.Text: { $value: lastName, ![@UI.TextArrangement]: #TextOnly }
};
annotate storeAppSrv.Employee with @UI.Identification: [{ Value: lastName }];
annotate storeAppSrv.Employee with {
  firstName @title: 'First Name';
  lastName @title: 'Last Name'
};

annotate storeAppSrv.Employee with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: firstName },
    { $Type: 'UI.DataField', Value: lastName },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
];

annotate storeAppSrv.Employee with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: firstName },
    { $Type: 'UI.DataField', Value: lastName },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
  ]
};

annotate storeAppSrv.Employee with {
  product @Common.Text: { $value: product.productName, ![@UI.TextArrangement]: #TextOnly }
};

annotate storeAppSrv.Employee with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate storeAppSrv.Audience with @UI.HeaderInfo: { TypeName: 'Audience', TypeNamePlural: 'Audiences' };
annotate storeAppSrv.Audience with {
  audiencePitch @title: 'Audience Pitch'
};

annotate storeAppSrv.Audience with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: audiencePitch },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
];

annotate storeAppSrv.Audience with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: audiencePitch },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
  ]
};

annotate storeAppSrv.Audience with {
  product @Common.Text: { $value: product.productName, ![@UI.TextArrangement]: #TextOnly }
};

annotate storeAppSrv.Audience with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate storeAppSrv.Customer with @UI.HeaderInfo: { TypeName: 'Customer', TypeNamePlural: 'Customers', Title: { Value: lastName } };
annotate storeAppSrv.Customer with {
  ID @Common.Text: { $value: lastName, ![@UI.TextArrangement]: #TextOnly }
};
annotate storeAppSrv.Customer with @UI.Identification: [{ Value: lastName }];
annotate storeAppSrv.Customer with {
  loyaltyInfo @title: 'Loyalty Information';
  firstName @title: 'First Name';
  lastName @title: 'Last Name'
};

annotate storeAppSrv.Customer with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: loyaltyInfo },
    { $Type: 'UI.DataField', Value: firstName },
    { $Type: 'UI.DataField', Value: lastName },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
];

annotate storeAppSrv.Customer with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: loyaltyInfo },
    { $Type: 'UI.DataField', Value: firstName },
    { $Type: 'UI.DataField', Value: lastName },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
  ]
};

annotate storeAppSrv.Customer with {
  product @Common.Text: { $value: product.productName, ![@UI.TextArrangement]: #TextOnly }
};

annotate storeAppSrv.Customer with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

