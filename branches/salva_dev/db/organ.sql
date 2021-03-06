------------
-- Organs --
------------

CREATE TABLE organtype (
	id serial,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE organtype IS
	'Tipos de �rgano - Colegiado, editorial, otro';
-- �rgano colegiado, �rgano editorial, otro

CREATE TABLE roleinorgan (
	id serial,
	name text NOT NULL,
	moduser_id int4 NULL    	     -- Use it only to know who has
	    REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE roleinorgan IS
	'Roles definidos en un �rgano';
---- Organos Colegiados ----
-- Presidente, propietario, suplente, vocal, representante, miembro, 
-- secretario
---- Organos editoriales ----
-- Director de revista, director de colecci�n, miembro de comit� editorial,
-- secretario de redacci�n

CREATE TABLE organ (
	id serial,
	name text NOT NULL,
	abbrev text NULL,
	organtype_id int4 NOT NULL
	    REFERENCES organtype(id)
            ON UPDATE CASCADE  
            DEFERRABLE,
	institution_id int4 NOT NULL
	    REFERENCES institutions(id)
            ON UPDATE CASCADE  
            DEFERRABLE,
	moduser_id int4 NULL    	     -- Use it only to know who has
	    REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name),
	UNIQUE (abbrev)
);
COMMENT ON TABLE organ IS
	'Cat�logo de �rganos colegiados/editoriales';
---- Organos Colegiados ----
-- Junta de gobierno, Consejo universitario, Consejo t�cnico, Consejo acad�mico
-- de �rea, Consejo interno, Comit� acad�mico, Comit� de becas, Comisiones
-- evaluadoras, Comisiones dictaminadoras, Otro
---- Organos editoriales ----
-- ..

CREATE TABLE userorgan (
	id SERIAL,
	user_id int4 NOT NULL
	    REFERENCES users(id)
            ON UPDATE CASCADE  
            ON DELETE CASCADE  
            DEFERRABLE,
	organ_id int4 NOT NULL
	    REFERENCES organ(id)
            ON UPDATE CASCADE   
            DEFERRABLE,
	roleinorgan_id int4 NOT NULL
	    REFERENCES roleinorgan(id)
            ON UPDATE CASCADE   
            DEFERRABLE,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear int4  NULL,
	endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
	PRIMARY KEY(id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
		(startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))	
);
COMMENT ON TABLE userorgan IS
	'Roles que un usuario ha tenido en un �rgano, con periodo';
