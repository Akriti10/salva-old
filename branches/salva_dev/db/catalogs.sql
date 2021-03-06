--------------------------------------
-- System catalogs                  --
--------------------------------------
CREATE TABLE countries ( 
    	id INTEGER NOT NULL,
    	name text NOT NULL,
	citizen text NOT NULL,
	code char(3) NOT NULL, 
	PRIMARY KEY(id),
	UNIQUE(name),
	UNIQUE(code)
);
COMMENT ON TABLE countries IS
	'Listado de pa�ses';
COMMENT ON COLUMN countries.name IS
	'Nombre del pa�s';
COMMENT ON COLUMN countries.citizen IS
	'Gentilicio de los ciudadanos del pa�s';
COMMENT ON COLUMN countries.code IS
	'Abreviaci�n (3 letras) del pa�s';

CREATE TABLE states (
	id SERIAL,
	country_id int4 NOT NULL
		REFERENCES countries(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	name text NOT NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY(id),
	UNIQUE(name)
);
COMMENT ON TABLE states IS
	'Lista de estados';

CREATE TABLE userrole ( 
    	id SERIAL NOT NULL,
   	name text NOT NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
    	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE userrole IS
	'Rol que juega un usuario en diferentes tablas gen�ricas 
	(usergenericworks, usertechproducts, userotheractivities)';
-- Autor, coautor, traductor, entrevistador, entrevistado, ...

-- Used both in articles and in newspaperarticles
-- Published, in press, sent, accepted for publication, in process
CREATE TABLE articlestatuses (  
	id SERIAL, 
	name varchar(50) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE articlestatuses IS
	'Estado de un art�culo (utilizado en articles y newspaperarticles)';
-- Publicado, en prensa, enviado, aceptado, en proceso, ...

CREATE TABLE mediatypes ( 
    id SERIAL, 
    name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE mediatypes IS
	'Medio f�sico en el que un trabajo est� publicado';
-- Impreso, electr�nico, p�gina Web, ...

CREATE TABLE publishers ( 
	id SERIAL,
	name text NOT NULL,
	descr text NULL,
	url text NULL,
        moduser_id int4 NULL    	     -- Use it only to know who has
            REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE publishers IS
	'Editoriales';

CREATE TABLE modalities (
    id SERIAL,  
    name text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);
COMMENT ON TABLE modalities IS 
	'Modalidad en que es impartido un curso o de una ponencia';
-- Presencial, Distancia, ambas o ninguna de las anteriores :)

CREATE TABLE menus (
	id SERIAL,
	label text NOT NULL,
	parent_menu_id int4 NULL
		REFERENCES menus(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	group_id int4 NOT NULL
		REFERENCES groups(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	ordering int4 NOT NULL,
	iconopen text NULL,
	iconclosed text NULL,
	iconpath text NULL,
	style text NULL,
	action text NULL,
	target text NULL,
	expanded bool DEFAULT 'f' NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (label, parent_menu_id)
);
COMMENT ON TABLE menus IS
	'Cada uno de los elementsentos del men� que se muestra al usuario';
COMMENT ON COLUMN menus.parent_menu_id IS
	'ID del elemento padre - NULL siginfica que est� sobre la raiz';
COMMENT ON COLUMN menus.group_id IS
	'Nivel m�nimo de usuario que tiene derecho de ver este elemento';
COMMENT ON COLUMN menus.expanded IS
	'Si tiene sub-elementos, expanded indica si por default los mostramos o no';
COMMENT ON COLUMN menus.ordering IS
	'Dentro de su �rbol, el �rden relativo en que aparece este elemento. Si hay m�s
	de un elemento con el mismo nivel de ordenamiento, se muestran por �rden de ID';
COMMENT ON COLUMN menus.style IS
	'';
COMMENT ON COLUMN menus.action IS
	'';
COMMENT ON COLUMN menus.target IS
	'';
