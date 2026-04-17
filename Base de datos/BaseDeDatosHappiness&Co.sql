DROP DATABASE IF EXISTS happiness_co;
CREATE DATABASE happiness_co
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_spanish_ci;

USE happiness_co;


CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    ubicacion VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE galerias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    id_evento INT NOT NULL,
    CONSTRAINT fk_galerias_eventos
        FOREIGN KEY (id_evento)
        REFERENCES eventos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE imagenes_galeria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    id_galeria INT NOT NULL,
    CONSTRAINT fk_imagenes_galerias
        FOREIGN KEY (id_galeria)
        REFERENCES galerias(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE favoritos (
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    PRIMARY KEY (id_usuario, id_evento),
    CONSTRAINT fk_favoritos_usuarios
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_favoritos_eventos
        FOREIGN KEY (id_evento)
        REFERENCES eventos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO usuarios (nombre, email, password) VALUES
('Laura Martínez', 'laura@happinessco.es', 'laura123'),
('Carlos Vega', 'carlos@happinessco.es', 'carlos123'),
('Elena Ruiz', 'elena@happinessco.es', 'elena123');

INSERT INTO eventos (fecha, titulo, ubicacion, descripcion) VALUES
('2026-01-01', 'Concierto Tsunami', 'Ayuntamiento de Gijón', 'Festival de rock y hardcore en un gran arranque cultural de año.'),
('2026-01-12', 'Viaje a la luna', 'Centro Federico García Lorca', 'Exposición colectiva centrada en una mirada artística y contemporánea.'),
('2026-01-24', 'XI Festival de Cine LGTBI', 'Avilés, Centro Niemeyer', 'Ciclo de cine con títulos nacionales e internacionales y actividades complementarias.'),
('2026-06-05', 'No estoy de frente', 'Teatro Alhambra', 'Monólogo protagonizado por Mari Paz Sayago en una cita teatral destacada.'),
('2026-06-15', 'Fiesta de la Sidra', 'Playa San Lorenzo', 'Encuentro popular con récord mundial de escanciado simultáneo y ambiente festivo.'),
('2026-06-25', 'XXVI Feria del Salmón', 'Cornellana', 'Feria de pesca, naturaleza y actividades para aficionados y visitantes.');

INSERT INTO galerias (titulo, id_evento) VALUES
('Galería Concierto Tsunami', 1),
('Galería Viaje a la luna', 2),
('Galería XI Festival de Cine LGTBI', 3);

INSERT INTO imagenes_galeria (titulo, imagen, id_galeria) VALUES
('Escenario principal Tsunami', 'img/tsunami_1.jpg', 1),
('Público en el concierto', 'img/tsunami_2.jpg', 1),
('Artistas invitados Tsunami', 'img/tsunami_3.jpg', 1),

('Entrada a la exposición', 'img/viaje_luna_1.jpg', 2),
('Obra destacada de la muestra', 'img/viaje_luna_2.jpg', 2),
('Sala principal de la exposición', 'img/viaje_luna_3.jpg', 2),

('Cartel del festival', 'img/cine_lgtbi_1.jpg', 3),
('Proyección inaugural', 'img/cine_lgtbi_2.jpg', 3),
('Coloquio con el público', 'img/cine_lgtbi_3.jpg', 3);

INSERT INTO favoritos (id_usuario, id_evento) VALUES
(1, 1),
(1, 2),
(1, 4),

(2, 2),
(2, 3),
(2, 5),

(3, 1),
(3, 3),
(3, 6);

CREATE OR REPLACE VIEW vista_galerias_anteriores_28022026 AS
SELECT
    g.id AS id_galeria,
    g.titulo AS titulo_galeria,
    e.id AS id_evento,
    e.titulo AS titulo_evento,
    e.fecha
FROM galerias g
JOIN eventos e ON g.id_evento = e.id
WHERE e.fecha < '2026-02-28';

CREATE OR REPLACE VIEW vista_favoritos_usuario_1 AS
SELECT
    u.id AS id_usuario,
    u.nombre AS usuario,
    e.id AS id_evento,
    e.fecha,
    e.titulo,
    e.ubicacion,
    e.descripcion
FROM favoritos f
JOIN usuarios u ON f.id_usuario = u.id
JOIN eventos e ON f.id_evento = e.id
WHERE u.id = 1;


CREATE OR REPLACE VIEW vista_imagenes_evento_2 AS
SELECT
    e.id AS id_evento,
    e.titulo AS evento,
    g.id AS id_galeria,
    g.titulo AS galeria,
    ig.id AS id_imagen,
    ig.titulo AS titulo_imagen,
    ig.imagen
FROM eventos e
JOIN galerias g ON g.id_evento = e.id
JOIN imagenes_galeria ig ON ig.id_galeria = g.id
WHERE e.id = 2;

CREATE OR REPLACE VIEW vista_favoritos_usuario_2_posteriores_28022026 AS
SELECT
    u.id AS id_usuario,
    u.nombre AS usuario,
    e.id AS id_evento,
    e.fecha,
    e.titulo,
    e.ubicacion,
    e.descripcion
FROM favoritos f
JOIN usuarios u ON f.id_usuario = u.id
JOIN eventos e ON f.id_evento = e.id
WHERE u.id = 2
  AND e.fecha > '2026-02-28';