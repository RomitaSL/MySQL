CREATE DATABASE estudiantesYCursos;

Use estudiantesYCursos;

-- Se crean las tablas
CREATE TABLE estudiantes (
	id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    edad INT NOT NULL
);

CREATE TABLE cursos (
	id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL UNIQUE,
    duracion INT NOT NULL
);

CREATE TABLE inscripciones(
	id_estudiante INT,
    id_curso INT,
	FOREIGN KEY(id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY(id_curso) REFERENCES cursos(id_curso)
);

-- Se añaden 6 estudiantes
INSERT INTO estudiantes (nombre, edad) VALUES
('Josefa Garcia', 25),
('Luis Lopez', 30),
('Angela Martinez', 22),
('Javier Salas', 35),
('Gabriela Torres', 28);

-- Se insertan 4 cursos
INSERT INTO cursos (nombre, duracion) VALUES
('Programacion', 40),
('Calculo', 30),
('Proyectos', 35),
('Bases de Datos', 50);

-- Se asocia los estudiantes a cursos
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES 
(1, 1), (1, 2),
(2, 1), (2, 3), (2, 4),
(3, 2), (3, 4),
(4, 3), (4, 1);

-- Se despliegan todos los estudiantes y sus respectivos cursos
SELECT e.nombre AS nombre_estudiante, c.nombre AS nombre_curso
FROM estudiantes e
LEFT JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
LEFT JOIN cursos c ON i.id_curso = c.id_curso
ORDER BY nombre_estudiante, nombre_curso;

-- Se despliegan todos los estudiantes inscritos en el curso: programacion
SELECT e.nombre AS nombre_estudiante
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
WHERE c.nombre = 'Programacion';

-- Se despliegan todos los cursos donde esta inscrito un estudiante
SELECT c.nombre AS nombre_curso
FROM cursos c
JOIN inscripciones i ON c.id_curso = i.id_curso
JOIN estudiantes e ON i.id_estudiante = e.id_estudiante
WHERE e.nombre = 'Luis Lopez';

-- Se despliegan cuantos estudiantes estan inscritos en cada curso
SELECT c.nombre AS nombre_curso,
COUNT(i.id_estudiante) AS total_estudiantes
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.nombre
ORDER BY total_estudiantes DESC, nombre_curso;

-- Se muestran los estudiantes no inscritos en ningún curso
SELECT e.nombre AS estudiante_no_inscrito
FROM estudiantes e
LEFT JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
WHERE i.id_curso IS NULL;
