CREATE DATABASE IF NOT EXISTS eventos_db;
USE eventos_db;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    contraseña VARCHAR(20) NOT NULL
);

CREATE TABLE eventos (
    id_eventos INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL,
    ubicacion VARCHAR(30) NOT NULL,
    descripcion VARCHAR(500)
);

CREATE TABLE galerias (
    id_galerias INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(30) NOT NULL,
    id_evento INT NOT NULL,
    CONSTRAINT fk_galeria_evento
        FOREIGN KEY (id_evento)
        REFERENCES eventos(id_eventos)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE imagenes (
    id_imagenes INT AUTO_INCREMENT PRIMARY KEY,
    id_galeria INT NOT NULL,
    titulo VARCHAR(30) NOT NULL,
    imagen VARCHAR(30) NOT NULL,
    CONSTRAINT fk_imagen_galeria
        FOREIGN KEY (id_galeria)
        REFERENCES galerias(id_galerias)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE favoritos (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    CONSTRAINT fk_favorito_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_favorito_evento
        FOREIGN KEY (id_evento)
        REFERENCES eventos(id_eventos)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uq_usuario_evento UNIQUE (id_usuario, id_evento)
);

USE eventos_db;


INSERT INTO usuarios (id_usuario, nombre, email, contraseña) VALUES
(1, 'Adrian Suarez', 'adrian.suarez@email.com', 'pass_adrian_123'),
(2, 'Lucia Fernandez', 'lucia.fernandez@email.com', 'pass_lucia_123'),
(3, 'Pablo Garcia', 'pablo.garcia@email.com', 'pass_pablo_123'),
(4, 'Marta Alonso', 'marta.alonso@email.com', 'pass_marta_123'),
(5, 'Sergio Diaz', 'sergio.diaz@email.com', 'pass_sergio_123');

ALTER TABLE eventos
MODIFY descripcion VARCHAR(250);

INSERT INTO eventos (id_eventos, titulo, fecha, ubicacion, descripcion) VALUES
(1, 'No estoy de frente', '2026-05-10', 'Teatro Alhambra', 'Un monólogo protagonizado por Mari Paz Sayago, con una puesta en escena íntima y cercana. La obra combina humor y emoción para hablar de identidad, memoria y cambios personales.'),
(2, 'XXVI Feria del Salmón', '2026-05-18', 'Cornellana', 'Feria de referencia con actividades de pesca, naturaleza y cultura local. Reúne a visitantes, familias y profesionales en una jornada completa con ambiente festivo.'),
(3, 'Fiesta de la Sidra', '2026-08-30', 'Playa San Lorenzo', 'Evento popular con récord mundial de escanciado simultáneo. Incluye ambiente festivo, tradición asturiana y gran participación del público.'),
(4, 'Concierto Tsunami', '2026-04-22', 'Ayuntamiento de Gijón', 'Evento musical del festival Tsunami con una noche dedicada al rock y hardcore. Reúne artistas y público en una jornada intensa de directo y energía.'),
(5, 'Viaje a la luna', '2026-03-27', 'Centro Federico García Lorca', 'Exposición colectiva con obras inspiradas en la imaginación, el simbolismo y la poesía visual. Una propuesta cultural para todos los públicos.'),
(6, 'XI Festival de Cine LGTBI', '2026-04-09', 'Avilés, Centro Niemeyer', 'Programación de cine con títulos nacionales e internacionales y actividades complementarias. Un evento referente en diversidad cultural y audiovisual.');

ALTER TABLE galerias
MODIFY titulo VARCHAR(50);

INSERT INTO galerias (id_galerias, titulo, id_evento) VALUES
(1, 'Galería Concierto Tsunami', 4),
(2, 'Galería Viaje a la luna', 5),
(3, 'Galería XI Festival de Cine LGTBI', 6);


ALTER TABLE imagenes
MODIFY titulo VARCHAR(50);

INSERT INTO imagenes (id_imagenes, id_galeria, titulo, imagen) VALUES
(1, 1, 'Concierto Tsunami - Imagen 1', 'imagen1'),
(2, 1, 'Concierto Tsunami - Imagen 2', 'imagen2'),
(3, 1, 'Concierto Tsunami - Imagen 3', 'imagen3'),

(4, 2, 'Viaje a la luna - Imagen 1', 'imagen1'),
(5, 2, 'Viaje a la luna - Imagen 2', 'imagen2'),
(6, 2, 'Viaje a la luna - Imagen 3', 'imagen3'),

(7, 3, 'XI Festival de Cine LGTBI - Imagen 1', 'imagen1'),
(8, 3, 'XI Festival de Cine LGTBI - Imagen 2', 'imagen2'),
(9, 3, 'XI Festival de Cine LGTBI - Imagen 3', 'imagen3');


INSERT INTO favoritos (id_favorito, id_usuario, id_evento) VALUES
(1, 1, 1),
(2, 1, 3),
(3, 2, 2),
(4, 2, 4),
(5, 3, 1),
(6, 3, 6),
(7, 4, 5),
(8, 4, 3),
(9, 5, 2),
(10, 5, 4);