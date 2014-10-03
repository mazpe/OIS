package OIS::Schema::Result::EstimateProduct;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("estimate_product");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "estimate_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "product_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "list",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "qty",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "list_total",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "disc",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "disc_per_item",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "disc_subtotal",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "price_per_item",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "subtotal",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "profit",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "profit_per_item",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
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
  "product_id",
  "OIS::Schema::Result::Product",
  { id => "product_id" },
);
__PACKAGE__->belongs_to(
  "estimate_id",
  "OIS::Schema::Result::Estimate",
  { id => "estimate_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2011-04-21 09:35:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:19ClxEYEl73xNne42j5iAA

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
