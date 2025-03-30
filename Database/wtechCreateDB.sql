-- Creating tables that do not require foreign keys
CREATE TABLE "categories" (
  "id" integer PRIMARY KEY,
  "name" varchar(50) NOT NULL
);

CREATE TABLE "brands" (
  "id" integer PRIMARY KEY,
  "name" varchar(50) NOT NULL
);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "first_name" varchar(100),
  "last_name" varchar(100),
  "email" varchar(100) NOT NULL,
  "password" varchar(150) NOT NULL,
  "phone" varchar(20),
  "role" varchar(20),
  "created_at" timestamp
);

CREATE TABLE "addresses" (
  "id" integer PRIMARY KEY,
  "city" varchar(100),
  "postal_code" varchar(100),
  "country" varchar(100),
  "address_line1" varchar(100),
  "address_line2" varchar(100)
);
-- Creating tables with foreign keys that reference previous tables
CREATE TABLE "user_address" (
  "address_id" integer,
  "user_id" integer,
  "is_default" boolean,
  PRIMARY KEY ("address_id", "user_id"),
  FOREIGN KEY ("address_id") REFERENCES "addresses" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);

CREATE TABLE "products" (
  "id" integer PRIMARY KEY,
  "name" varchar(100),
  "description" text,
  "category_id" integer,
  "brand_id" integer,
  "created_at" timestamp,
  FOREIGN KEY ("category_id") REFERENCES "categories" ("id"),
  FOREIGN KEY ("brand_id") REFERENCES "brands" ("id")
);

CREATE TABLE "product_variants" (
  "id" integer PRIMARY KEY,
  "product_id" integer,
  "size" varchar,
  "price" decimal NOT NULL,
  FOREIGN KEY ("product_id") REFERENCES "products" ("id")
);

CREATE TABLE "orders" (
  "id" integer PRIMARY KEY,
  "address_id" integer,
  "user_id" integer,
  "total_price" decimal,
  "deliver_price" integer,
  "delivery_method" varchar(100),
  "status" varchar(20),
  "created_at" timestamp,
  "first_name" varchar(100),
  "last_name" varchar(100),
  FOREIGN KEY ("user_id") REFERENCES "users" ("id"),
  FOREIGN KEY ("address_id") REFERENCES "addresses" ("id")
);

CREATE TABLE "order_items" (
  "id" integer PRIMARY KEY,
  "order_id" integer,
  "product_variant_id" integer,
  "quantity" integer,
  FOREIGN KEY ("order_id") REFERENCES "orders" ("id"),
  FOREIGN KEY ("product_variant_id") REFERENCES "product_variants" ("id")
);

CREATE TABLE "payments" (
  "id" integer PRIMARY KEY,
  "order_id" integer,
  "amount" decimal,
  "method" varchar(50),
  "status" varchar(50),
  FOREIGN KEY ("order_id") REFERENCES "orders" ("id")
);
-- Comments
COMMENT ON COLUMN "users"."role" IS 'customer or admin';
COMMENT ON COLUMN "users"."created_at" IS 'date of registration';
COMMENT ON COLUMN "order_items"."order_id" IS 'reference to order';
COMMENT ON COLUMN "order_items"."product_variant_id" IS 'reference to product';
COMMENT ON COLUMN "order_items"."quantity" IS 'number of items';
COMMENT ON COLUMN "payments"."order_id" IS 'reference to order';
COMMENT ON COLUMN "payments"."amount" IS 'price';
COMMENT ON COLUMN "payments"."method" IS 'applepay/googlepay/card';