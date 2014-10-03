package OIS::Schema::Result::Estimate;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("estimate");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "name_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "ship_to_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "salesperson_id_1",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "salesperson_id_2",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "tax_code_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "taxable",
  { data_type => "ENUM", default_value => "Y", is_nullable => 0, size => 1 },
  "date",
  { data_type => "DATE", default_value => undef, is_nullable => 0, size => 10 },
  "list",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 1,
    size => 12,
  },
  "subtotal",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 1,
    size => 12,
  },
  "discount",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 1,
    size => 12,
  },
  "tax",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 1,
    size => 12,
  },
  "total",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 1,
    size => 12,
  },
  "profit",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 1,
    size => 12,
  },
  "notes",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "active",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "created",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "updated",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "ship_to_id",
  "OIS::Schema::Result::Name",
  { id => "ship_to_id" },
);
__PACKAGE__->belongs_to(
  "salesperson_id_1",
  "OIS::Schema::Result::Name",
  { id => "salesperson_id_1" },
);
__PACKAGE__->belongs_to(
  "salesperson_id_2",
  "OIS::Schema::Result::Name",
  { id => "salesperson_id_2" },
);
__PACKAGE__->belongs_to(
  "tax_code_id",
  "OIS::Schema::Result::TaxCode",
  { id => "tax_code_id" },
);
__PACKAGE__->belongs_to("name_id", "OIS::Schema::Result::Name", { id => "name_id" });
__PACKAGE__->has_many(
  "estimate_products",
  "OIS::Schema::Result::EstimateProduct",
  { "foreign.estimate_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2011-04-21 09:35:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SyOQYimXGyhqG7uiv83WqA

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
