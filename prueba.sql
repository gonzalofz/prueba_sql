CREATE DATABASE prueba_sql_gonzalo_fuentes_123;

-- EJERCICIO 1
CREATE TABLE pelicula(
  id SERIAL PRIMARY key,
  nombre VARCHAR(255) NOT NULL,
  anno INTEGER NOT NULL
);

CREATE TABLE tag(
  id SERIAL primary key,
  tag VARCHAR(32) NOT NULL
);


CREATE TABLE pelicula_tag (
  pelicula_id INT,
  tag_id INT,
  PRIMARY KEY (pelicula_id, tag_id),
  CONSTRAINT fk_pelicula FOREIGN KEY(pelicula_id) REFERENCES pelicula(id),
  CONSTRAINT fk_tag FOREIGN KEY(tag_id) REFERENCES tag(id)
);


INSERT INTO pelicula(nombre, anno) VALUES 
('wakanda', 2022),
('batman', 2022),
('one piece', 2022),
('black adam',2022),
('click', 2006);


INSERT INTO tag(tag) VALUES 
('accion'),
('drama'),
('comedia'),
('suspenso'),
('ciencia ficcion');


INSERT INTO pelicula_tag(pelicula_id, tag_id) VALUES 
(1, 1),
(1, 3),
(1, 5),
(2, 4),
(2, 5);

-- ejercicio 1 
-- Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.
SELECT
    T.ID,
    T.TAG,
    COUNT(PT.pelicula_id)
FROM TAG T
    LEFT JOIN PELICULA_TAG PT
    ON T.ID = NULLIF(PT.TAG_ID, 0)
GROUP BY T.ID
ORDER BY T.ID;


-- EJERCICIO 2

CREATE TABLE preguntas(
  id SERIAL PRIMARY key,
  pregunta VARCHAR(255) NOT NULL,
  respuesta_correcta varchar
);


CREATE TABLE usuarios(
  id SERIAL PRIMARY key,
  nombre VARCHAR(255) NOT NULL,
  edad integer
);

CREATE TABLE respuestas(
  id SERIAL PRIMARY key,
  respuesta VARCHAR(255),
  pregunta_id integer,
  usuario_id integer,
  CONSTRAINT fk_pregunta FOREIGN KEY(pregunta_id) REFERENCES preguntas(id),
  CONSTRAINT fk_usuario FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);


INSERT INTO usuarios(nombre, edad) VALUES 
('Camila', 23),
('Gonzalo', 33),
('Richard', 30),
('Seba', 23),
('Matias', 25);

INSERT INTO preguntas(pregunta, respuesta_correcta) VALUES 
('¿Quien es hisenberg?', 'Walter Wide'),
('¿Que es la vida?', 'todo'),
('¿Que es la muerte?', 'el siguiente paso'),
('¿Que es el universo?', 'lo que no podemos entendemos '),
('¿Que es?', 'quien soy');


INSERT INTO respuestas(respuesta, usuario_id, pregunta_id) VALUES 
('Walter Wide', 1, 1),
('Walter Wide', 3, 1),
('Lo que sentimos', 2, 2),
('lo que vemos', 5, 2),
('todo', 4, 2);

--RESPUESTA 6
--Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la
--pregunta)

SELECT
    u.nombre,
    COUNT(p.respuesta_correcta) as cantidad_respuesta
FROM respuestas R
LEFT JOIN usuarios U 
    ON R.usuario_id = U.id
LEFT JOIN preguntas P 
    ON P.respuesta_correcta = R.respuesta
GROUP BY 
    R.usuario_id,
    U.nombre;

-- RESPUESTA 7
-- Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la
-- respuesta correcta

SELECT
    p.pregunta as Pregunta,
    COUNT(P.pregunta) as CANTIDAD_USUARIO_RESPUESTA_CORRECTA
FROM respuestas R
JOIN preguntas P 
    ON P.respuesta_correcta = R.respuesta
GROUP BY 
    P.pregunta;

-- RESPUESTA 8
ALTER TABLE respuestas 
DROP CONSTRAINT respuestas_usuario_id_fkey, 
ADD FOREIGN KEY (usuario_id) 
REFERENCES usuarios(id) 
ON DELETE CASCADE;

DELETE FROM usuarios WHERE id = 1;

-- RESPUESTA 9
ALTER TABLE usuarios ADD CHECK (edad > 18); 

-- RESPUESTA 10
ALTER TABLE usuarios ADD email VARCHAR(50) UNIQUE;


--https://youtu.be/GQgQ_G9dZJA video de la prueba