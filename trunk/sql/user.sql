------------------------------------
-- User status and Groups Tables  --
------------------------------------
CREATE TABLE userstatus ( 
    id serial NOT NULL,
    name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE(name)
);
COMMENT ON TABLE userstatus IS
	'Estado de cada uno de los usuarios';
-- Nuevo, aprobado, bloqueado, etc.

CREATE TABLE userlevels (
    id int2 NOT NULL,
    name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE(name)
);
COMMENT ON TABLE userlevels IS
	'Grupos (tipos) de usuario del sistema';
-- Usuario, operador, administrador, etc.

CREATE TABLE secretquestion ( 
    id int2 NOT NULL,
    name text,
    PRIMARY KEY (id),
    UNIQUE(name)
);
COMMENT ON TABLE secretquestion IS
	'Preguntas secretas que pueden ser usadas (junto la respuesta secreta
	provista por cada usuario) para recuperar una contrase�a';

CREATE TABLE users ( 
    id SERIAL NOT NULL,
    login text NOT NULL,
    passwd text NOT NULL,
    userstatus_id int4 NOT NULL 
            REFERENCES userstatus(id)
            ON UPDATE CASCADE
            DEFERRABLE
	    DEFAULT 1,
    userlevel_id int4 NOT NULL
	    REFERENCES userlevels(id)
	    ON UPDATE CASCADE
	    DEFERRABLE
	    DEFAULT 1,
    secretquestion_id int4 NULL 
           REFERENCES secretquestion(id)
           ON UPDATE CASCADE
           DEFERRABLE,
    secretanswer text NULL,
    email text NULL, 
    pkcs7 text NULL,
    session char(32) NULL,
    session_exp timestamp DEFAULT now()+'3 hr'::interval NULL,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE(login),
    UNIQUE(session)
);
CREATE INDEX users_id_idx ON users(id);
CREATE INDEX users_name_idx ON users(login);
COMMENT ON TABLE users IS
	'Usuarios del sistema';
COMMENT ON COLUMN users.email IS 
	'El correo ser� utilizado para la recuperaci�n de contrase�as o 
	notificaci�n de cambios generados por terceros';
COMMENT ON COLUMN users.pkcs7 IS 
	'A ser utilizado con infraestructura PKI';

-- CREATE TABLE usergroups (
--     uid int4 NOT NULL
-- 	REFERENCES users(id)
--         ON UPDATE CASCADE
--         ON DELETE CASCADE
--         DEFERRABLE,
--     gid int4 NOT NULL 
-- 	REFERENCES groups(id)
--         ON UPDATE CASCADE
--         DEFERRABLE,
--     dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
--     PRIMARY KEY (uid, gid)
-- );
-- COMMENT ON TABLE usergroups IS
-- 	'Grupos a los que pertenece cada usuario';