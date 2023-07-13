using { guitarStoreSrv } from '../srv/service.cds';

annotate guitarStoreSrv.Pitch with @odata.draft.enabled;
annotate guitarStoreSrv.Warehouse with @odata.draft.enabled;
annotate guitarStoreSrv.Discount with @odata.draft.enabled;
annotate guitarStoreSrv.Warehouse with @cds.odata.valuelist;
annotate guitarStoreSrv.Discount with @cds.odata.valuelist;
annotate guitarStoreSrv.Product with @cds.odata.valuelist;
annotate guitarStoreSrv.Product with @UI.HeaderInfo: { TypeName: 'Product', TypeNamePlural: 'Products', Title: { Value: productName } };
annotate guitarStoreSrv.Product with {
  ID @Common.Text: { $value: productName, ![@UI.TextArrangement]: #TextOnly }
};
annotate guitarStoreSrv.Product with @UI.Identification: [{ Value: productName }];
annotate guitarStoreSrv.Product with {
  productName @title: 'Product Name';
  productDescription @title: 'Product Description'
};

annotate guitarStoreSrv.Product with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: productName },
    { $Type: 'UI.DataField', Value: productDescription },
    { $Type: 'UI.DataField', Label: 'Discount', Value: discount_ID }
];

annotate guitarStoreSrv.Product with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: productName },
    { $Type: 'UI.DataField', Value: productDescription },
    { $Type: 'UI.DataField', Label: 'Discount', Value: discount_ID }
  ]
};

annotate guitarStoreSrv.Product with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate guitarStoreSrv.Pitch with @UI.HeaderInfo: { TypeName: 'Pitch', TypeNamePlural: 'Pitches', Title: { Value: targetAudience } };
annotate guitarStoreSrv.Pitch with {
  ID @Common.Text: { $value: targetAudience, ![@UI.TextArrangement]: #TextOnly }
};
annotate guitarStoreSrv.Pitch with @UI.Identification: [{ Value: targetAudience }];
annotate guitarStoreSrv.Pitch with {
  targetAudience @title: 'Target Audience';
  pitchText @title: 'Pitch Text'
};

annotate guitarStoreSrv.Pitch with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: targetAudience },
    { $Type: 'UI.DataField', Value: pitchText },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
];

annotate guitarStoreSrv.Pitch with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: targetAudience },
    { $Type: 'UI.DataField', Value: pitchText },
    { $Type: 'UI.DataField', Label: 'Product', Value: product_ID }
  ]
};

annotate guitarStoreSrv.Pitch with {
  product @Common.Text: { $value: product.productName, ![@UI.TextArrangement]: #TextOnly }
};

annotate guitarStoreSrv.Pitch with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate guitarStoreSrv.Warehouse with @UI.HeaderInfo: { TypeName: 'Warehouse', TypeNamePlural: 'Warehouses', Title: { Value: stockCount } };
annotate guitarStoreSrv.Warehouse with {
  ID @Common.Text: { $value: stockCount, ![@UI.TextArrangement]: #TextOnly }
};
annotate guitarStoreSrv.Warehouse with @UI.Identification: [{ Value: stockCount }];
annotate guitarStoreSrv.Warehouse with {
  stockCount @title: 'Stock Count'
};

annotate guitarStoreSrv.Warehouse with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: stockCount }
];

annotate guitarStoreSrv.Warehouse with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: stockCount }
  ]
};

annotate guitarStoreSrv.Warehouse with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' },
  { $Type : 'UI.ReferenceFacet', ID : 'Product', Target : 'products/@UI.LineItem' }
];

annotate guitarStoreSrv.Discount with @UI.HeaderInfo: { TypeName: 'Discount', TypeNamePlural: 'Discounts', Title: { Value: discountPercentage } };
annotate guitarStoreSrv.Discount with {
  ID @Common.Text: { $value: discountPercentage, ![@UI.TextArrangement]: #TextOnly }
};
annotate guitarStoreSrv.Discount with @UI.Identification: [{ Value: discountPercentage }];
annotate guitarStoreSrv.Discount with {
  discountPercentage @title: 'Discount Percentage'
};

annotate guitarStoreSrv.Discount with @UI.LineItem: [
    { $Type: 'UI.DataField', Value: discountPercentage }
];

annotate guitarStoreSrv.Discount with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
    { $Type: 'UI.DataField', Value: discountPercentage }
  ]
};

annotate guitarStoreSrv.Discount with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

