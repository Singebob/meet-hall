CREATE TABLE organization (
	org_uuid UUID primary key,
	org_name VARCHAR(50),
	org_description VARCHAR(200)
);

CREATE TABLE "user" (
	use_uuid UUID primary key,
	use_displayname VARCHAR(50),
	use_firstname VARCHAR(50),
	use_lastname VARCHAR(50),
	use_email VARCHAR(50)
);

CREATE TABLE "event" (
	eve_uuid UUID primary key,
	eve_name VARCHAR(50),
	eve_description VARCHAR(2000),
	eve_date TIMESTAMP,
	eve_location VARCHAR(100),
	eve_arviched boolean default false
);

CREATE TABLE "role" (
	rol_uuid UUID primary key,
	rol_name VARCHAR(50)
);

CREATE TABLE tag_category (
	tca_uuid UUID primary key,
	tca_name VARCHAR(30),
	tca_color VARCHAR(10)
);

CREATE TABLE entity_type (
	ety_uuid UUID primary key,
	ety_name VARCHAR(20)
);

CREATE TABLE user_organization (
	org_uuid UUID,
	use_uuid UUID,
	CONSTRAINT PK_user_organization PRIMARY KEY (org_uuid, use_uuid),
	FOREIGN KEY (org_uuid) REFERENCES organization (org_uuid),
	FOREIGN KEY (use_uuid) REFERENCES "user" (use_uuid)
);

CREATE TABLE event_request (
	ere_uuid UUID primary key,
	use_uuid UUID,
	ere_name VARCHAR(50),
	eve_description VARCHAR(2000),
	FOREIGN KEY (use_uuid) REFERENCES "user" (use_uuid)
);

CREATE TABLE user_event_participation (
	use_uuid UUID,
	eve_uuid UUID,
	rol_uuid UUID,
	CONSTRAINT PK_user_event_participation PRIMARY KEY (use_uuid, eve_uuid, rol_uuid),
	FOREIGN KEY (use_uuid) REFERENCES "user" (use_uuid),
	FOREIGN KEY (eve_uuid) REFERENCES "event" (eve_uuid),
	FOREIGN KEY (rol_uuid) REFERENCES "role" (rol_uuid)
);

CREATE TABLE tag (
	tag_uuid UUID PRIMARY KEY,
	tag_name VARCHAR(20),
	tca_uuid UUID,
	FOREIGN KEY (tca_uuid) REFERENCES tag_category (tca_uuid)
);

CREATE TABLE available_tag_category (
	tca_uuid UUID,
	ety_uuid UUID,
	CONSTRAINT PK_available_tag_category PRIMARY KEY (tca_uuid, ety_uuid),
	FOREIGN KEY (tca_uuid) REFERENCES tag_category (tca_uuid),
	FOREIGN KEY (ety_uuid) REFERENCES entity_type (ety_uuid)
);

CREATE TABLE event_tag (
	eve_uuid UUID,
	tag_uuid UUID,
	CONSTRAINT PK_event_tag PRIMARY KEY (eve_uuid, tag_uuid),
	FOREIGN KEY (eve_uuid) REFERENCES "event" (eve_uuid),
	FOREIGN KEY (tag_uuid) REFERENCES tag (tag_uuid)
);

CREATE TABLE organization_tag (
	org_uuid UUID,
	tag_uuid UUID,
	CONSTRAINT PK_organization_tag PRIMARY KEY (org_uuid, tag_uuid),
	FOREIGN KEY (org_uuid) REFERENCES organization (org_uuid),
	FOREIGN KEY (tag_uuid) REFERENCES tag (tag_uuid)
);

CREATE TABLE user_tag (
	use_uuid UUID,
	tag_uuid UUID,
	CONSTRAINT PK_user_tag PRIMARY KEY (use_uuid, tag_uuid),
	FOREIGN KEY (use_uuid) REFERENCES "user" (use_uuid),
	FOREIGN KEY (tag_uuid) REFERENCES tag (tag_uuid)
);

CREATE USER postgraphile_data_management WITH PASSWORD '${postgraphile_data_management_user_password}';
CREATE USER postgraphile_full_access WITH PASSWORD '${postgraphile_full_access_user_password}';

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO postgraphile_data_management;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgraphile_full_access;