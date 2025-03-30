CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "first_name" varchar(100),
  "last_name" varchar(100),
  "email" varchar(100) NOT NULL,
  "password" hash NOT NULL,
  "phone" varchar(20),
  "role" varchar(20),
  "created_at" timestamp
);

CREATE TABLE "user_address" (
  "address_id" key,
  "user_id" key,
  "is_default" boolean
);

CREATE TABLE "addresses" (
  "id" integer PRIMARY KEY,
  "city" varchar(100),
  "postal_code" varchar(100),
  "country" varchar(100),
  "address_line1" varchar(100),
  "address_line2" varchar(100)
);

CREATE TABLE "products" (
  "id" integer PRIMARY KEY,
  "name" varchar(100),
  "description" text,
  "product_variants_id" key,
  "category_id" key,
  "brand_id" key,
  "created_at" timestamp
);

CREATE TABLE "product_variants" (
  "id" integer PRIMARY KEY,
  "product_id" key,
  "size" varchar,
  "price" decimal NOT NULL
);

CREATE TABLE "categories" (
  "id" integer PRIMARY KEY,
  "name" varchar(50) NOT NULL
);

CREATE TABLE "brands" (
  "id" integer PRIMARY KEY,
  "name" varchar(50) NOT NULL
);

CREATE TABLE "orders" (
  "id" integer PRIMARY KEY,
  "adress_id" key,
  "user_id" key,
  "total_price" decimal,
  "deliver_price" integer,
  "delivery_method" varchar(100),
  "status" varchar(20),
  "created_at" timestamp,
  "first_name" varchar(100),
  "last_name" varchar(100)
);

CREATE TABLE "order_items" (
  "id" integer PRIMARY KEY,
  "order_id" key,
  "product_variant_id" key,
  "quantity" integer
);

CREATE TABLE "payments" (
  "id" integer PRIMARY KEY,
  "order_id" key,
  "amount" decimal,
  "method" varchar,
  "status" varchar
);

COMMENT ON COLUMN "users"."role" IS 'custommer or admin';

COMMENT ON COLUMN "users"."created_at" IS 'date of registration';

COMMENT ON COLUMN "order_items"."order_id" IS 'reference to order';

COMMENT ON COLUMN "order_items"."product_variant_id" IS 'reference to product';

COMMENT ON COLUMN "order_items"."quantity" IS 'number of items';

COMMENT ON COLUMN "payments"."order_id" IS 'reference to order';

COMMENT ON COLUMN "payments"."amount" IS 'price';

COMMENT ON COLUMN "payments"."method" IS 'applepay/googlepay/card';

ALTER TABLE "orders" ADD FOREIGN KEY ("id") REFERENCES "payments" ("order_id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "product_variants" ADD FOREIGN KEY ("id") REFERENCES "order_items" ("product_variant_id");

ALTER TABLE "product_variants" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "brands" ADD FOREIGN KEY ("id") REFERENCES "products" ("brand_id");

ALTER TABLE "categories" ADD FOREIGN KEY ("id") REFERENCES "products" ("category_id");

ALTER TABLE "addresses" ADD FOREIGN KEY ("id") REFERENCES "orders" ("adress_id");

ALTER TABLE "users" ADD FOREIGN KEY ("id") REFERENCES "user_address" ("user_id");

ALTER TABLE "addresses" ADD FOREIGN KEY ("id") REFERENCES "user_address" ("address_id");
