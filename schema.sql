/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals ADD species varchar(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name TEXT,
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
    PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners (id);