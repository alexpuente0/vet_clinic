/*Queries that provide answers to the questions from project.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth < '2020-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

/* Update and Delete Queries */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deleted_entrie;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO deleted_entrie;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*Queries that provide answers to the questions from project P.II*/

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*Queries that provide answers to the questions from project P.III*/

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM animals 
FULL JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(*) FROM species
JOIN animals ON species.id = animals.species_id GROUP BY species.name;

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name FROM animals
JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name
ORDER BY COUNT(owner_id) DESC
LIMIT 1;

/*Queries that provide answers to the questions from project P.IV*/

/*1*/
SELECT animals.name FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher' 
ORDER BY visits.date_of_visit DESC LIMIT 1;

/*2*/
SELECT COUNT(animals.name) FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'Stephanie Mendez';

/*3*/
SELECT vets.name, species.name FROM vets
FULL JOIN specializations ON specializations.vet_id = vets.id
FULL JOIN species ON species.id = specializations.species_id;

/*4*/
SELECT animals.name FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

/*5*/
SELECT animals.name, COUNT(*) FROM animals
JOIN visits ON visits.animals_id = animals.id
GROUP BY animals.name ORDER BY COUNT(*) DESC LIMIT 1;

/*6*/
SELECT animals.name FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit LIMIT 1;

/*7*/
SELECT animals.*, vets.*, visits.date_of_visit FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id ORDER BY visits.date_of_visit DESC LIMIT 1;

/*8*/
SELECT COUNT(*) FROM visits
FULL JOIN animals ON animals.id = visits.animals_id
FULL JOIN vets ON visits.vet_id = vets.id
FULL JOIN specializations ON specializations.vet_id = vets.id
WHERE specializations.species_id IS NULL;

/*9*/
SELECT species.name, COUNT(*) FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC;