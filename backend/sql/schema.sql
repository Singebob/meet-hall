CREATE TABLE organization (
	"uuid" UUID primary key,
	"name" VARCHAR(50),
	"description" VARCHAR(200)
);

CREATE TABLE "user" (
	"uuid" UUID primary key,
	"displayname" VARCHAR(50),
	"firstname" VARCHAR(50),
	"lastname" VARCHAR(50),
	"email" VARCHAR(50)
);

CREATE TABLE "event" (
	"uuid" UUID primary key,
	"name" VARCHAR(50),
	"description" VARCHAR(2000),
	"date" TIMESTAMP,
	"location" VARCHAR(100),
	"arviched" boolean default false
);

CREATE TABLE "role" (
	"uuid" UUID primary key,
	"name" VARCHAR(50)
);

CREATE TABLE tag_category (
	"uuid" UUID primary key,
	"name" VARCHAR(30),
	"color" VARCHAR(10)
);

CREATE TABLE entity_type (
	"uuid" UUID primary key,
	"name" VARCHAR(20)
);

CREATE TABLE user_organization (
	"organization_uuid" UUID,
	"user_uuid" UUID,
	CONSTRAINT PK_user_organization PRIMARY KEY (organization_uuid, user_uuid),
	FOREIGN KEY (organization_uuid) REFERENCES organization (uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (uuid)
);

CREATE TABLE event_request (
	"uuid" UUID primary key,
	"creator" UUID,
	name VARCHAR(50),
	description VARCHAR(2000),
	FOREIGN KEY (creator) REFERENCES "user" (uuid)
);

CREATE TABLE user_event_participation (
	"user_uuid" UUID,
	"event_uuid" UUID,
	"role_uuid" UUID,
	CONSTRAINT PK_user_event_participation PRIMARY KEY (user_uuid, event_uuid, role_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (uuid),
	FOREIGN KEY (event_uuid) REFERENCES "event" (uuid),
	FOREIGN KEY (role_uuid) REFERENCES "role" (uuid)
);

CREATE TABLE tag (
	"uuid" UUID PRIMARY KEY,
	"name" VARCHAR(20),
	"category" UUID,
	FOREIGN KEY (category) REFERENCES tag_category (uuid)
);

CREATE TABLE available_tag_category (
	"tag_category_uuid" UUID,
	"entity_type_uuid" UUID,
	CONSTRAINT PK_available_tag_category PRIMARY KEY (tag_category_uuid, entity_type_uuid),
	FOREIGN KEY (tag_category_uuid) REFERENCES tag_category (uuid),
	FOREIGN KEY (entity_type_uuid) REFERENCES entity_type (uuid)
);

CREATE TABLE event_tag (
	"event_uuid" UUID,
	"tag_uuid" UUID,
	CONSTRAINT PK_event_tag PRIMARY KEY (event_uuid, tag_uuid),
	FOREIGN KEY (event_uuid) REFERENCES "event" (uuid),
	FOREIGN KEY (tag_uuid) REFERENCES tag (uuid)
);

CREATE TABLE organization_tag (
	"organization_uuid" UUID,
	"tag_uuid" UUID,
	CONSTRAINT PK_organization_tag PRIMARY KEY (organization_uuid, tag_uuid),
	FOREIGN KEY (organization_uuid) REFERENCES organization (uuid),
	FOREIGN KEY (tag_uuid) REFERENCES tag (uuid)
);

CREATE TABLE user_tag (
	"user_uuid" UUID,
	"tag_uuid" UUID,
	CONSTRAINT PK_user_tag PRIMARY KEY (user_uuid, tag_uuid),
	FOREIGN KEY (user_uuid) REFERENCES "user" (uuid),
	FOREIGN KEY (tag_uuid) REFERENCES tag (uuid)
);

CREATE USER postgraphile_data_management WITH PASSWORD '${POSTGRAPHILE_DATA_MANAGEMENT_USER_PASSWORD}';
CREATE USER postgraphile_full_access WITH PASSWORD '${POSTGRAPHILE_FULL_ACCESS_USER_PASSWORD}';

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO postgraphile_data_management;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgraphile_full_access;