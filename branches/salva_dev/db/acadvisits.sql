----------------------------------------
-- Estancias y sabaticos              --
----------------------------------------

CREATE TABLE acadvisittype (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE acadvisittype IS
	'Tipos de visita acad�mica';
-- Sab�tico, posdoctoral, de investigaci�n...

CREATE TABLE acadvisits (
	id  SERIAL NOT NULL,
	user_id int4 NOT NULL
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    	institution_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	country_id smallint NOT NULL
            REFERENCES countries(id)
            ON UPDATE CASCADE
            DEFERRABLE,
	acadvisittype_id integer NOT NULL 
	    REFERENCES acadvisittype(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
        name text NOT NULL,
	startyear int4 NOT NULL,
	startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
	endyear int4  NULL,
	endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
	place text NULL,
	goals text NULL,
    	other text  NULL,
	visitor_id integer NULL 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
	PRIMARY KEY(id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE acadvisits IS
	'Cada una de las visitas acad�micas, relacionadas con el usuario en 
	cuesti�n';

COMMENT ON COLUMN acadvisits.visitor_id IS
	'Si esta columna apunta a un usuario externo, significa que el usuario participo
	 en la coordinaci�n de una visita o estancia acad�mica de un invitado';

CREATE TABLE sponsorsacadvisits (
	id  SERIAL NOT NULL,
	acadvisit_id integer NOT NULL 
	    REFERENCES  acadvisits(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
 	sponsorinst_id integer NOT NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
	amount integer NOT NULL,
	PRIMARY KEY(id)
);
COMMENT ON TABLE sponsorsacadvisits IS
	'Instituci�n patrocinadora de cada visita acad�mica';
