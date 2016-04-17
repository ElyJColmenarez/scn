--22-abr-2015
-- Johan, Jhonny, Geraldine, Juan

create user usuarioscn with password '1234';

CREATE DATABASE bd_scnfinal
  WITH OWNER = usuarioscn
       ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
  
  
--cambia el formato de la fecha a Dia/mes/año para consulta e insercion
alter database  bd_scnfinal SET DateStyle to 'sql,dmy';

\c bd_scnfinal;


--
-- PostgreSQL database dump
--

-- Started on 2016-03-18 14:29:47 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 8 (class 2615 OID 57791)
-- Name: err; Type: SCHEMA; Schema: -; Owner: usuarioscn
--

CREATE SCHEMA err;


ALTER SCHEMA err OWNER TO usuarioscn;

--
-- TOC entry 7 (class 2615 OID 17080)
-- Name: per; Type: SCHEMA; Schema: -; Owner: usuarioscn
--

CREATE SCHEMA per;


ALTER SCHEMA per OWNER TO usuarioscn;

--
-- TOC entry 6 (class 2615 OID 16761)
-- Name: sis; Type: SCHEMA; Schema: -; Owner: usuarioscn
--

CREATE SCHEMA sis;


ALTER SCHEMA sis OWNER TO usuarioscn;

--
-- TOC entry 10 (class 2615 OID 66067)
-- Name: tmp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tmp;


ALTER SCHEMA tmp OWNER TO postgres;

--
-- TOC entry 601 (class 2612 OID 49601)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: alamoj
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO alamoj;

SET search_path = public, pg_catalog;

--
-- TOC entry 197 (class 1255 OID 49604)
-- Dependencies: 601 9
-- Name: crear_usuario_nodef(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: alamoj
--

CREATE FUNCTION crear_usuario_nodef(character varying, character varying, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
   return 1;
END;
$$;


ALTER FUNCTION public.crear_usuario_nodef(character varying, character varying, character varying) OWNER TO alamoj;

--
-- TOC entry 196 (class 1255 OID 17079)
-- Dependencies: 9
-- Name: reverse(text); Type: FUNCTION; Schema: public; Owner: usuarioscn
--

CREATE FUNCTION reverse(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	Select array_to_string(ARRAY(
		SELECT substring($1,s.i,1) from generate_series(length($1), 1, -1) as s(i)
		), '');
$_$;


ALTER FUNCTION public.reverse(text) OWNER TO usuarioscn;

SET search_path = err, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 176 (class 1259 OID 57792)
-- Dependencies: 8
-- Name: t_error; Type: TABLE; Schema: err; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_error (
    codigo integer NOT NULL,
    cod_error integer,
    cod_usuario integer,
    cod_estatus character(1),
    fec_reporte date,
    fec_respuesta date,
    descripcion character varying(255),
    respuesta character varying(255)
);


ALTER TABLE err.t_error OWNER TO usuarioscn;

--
-- TOC entry 177 (class 1259 OID 57798)
-- Dependencies: 8
-- Name: t_est_error; Type: TABLE; Schema: err; Owner: postgres; Tablespace: 
--

CREATE TABLE t_est_error (
    codigo character varying(1) NOT NULL,
    nombre character varying
);


ALTER TABLE err.t_est_error OWNER TO postgres;

SET search_path = per, pg_catalog;

--
-- TOC entry 172 (class 1259 OID 17127)
-- Dependencies: 7
-- Name: t_menu; Type: TABLE; Schema: per; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_menu (
    codigo integer,
    nombre character varying(30),
    permiso character(1)
);


ALTER TABLE per.t_menu OWNER TO usuarioscn;

--
-- TOC entry 171 (class 1259 OID 17109)
-- Dependencies: 1960 7
-- Name: t_mod_usuario; Type: TABLE; Schema: per; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_mod_usuario (
    codigo integer NOT NULL,
    cod_usuario integer NOT NULL,
    cod_modulo integer NOT NULL,
    permiso character(1) NOT NULL,
    valor smallint,
    CONSTRAINT chk_mod_usuario_01 CHECK ((permiso = ANY (ARRAY['S'::bpchar, 'I'::bpchar, 'D'::bpchar, 'U'::bpchar])))
);


ALTER TABLE per.t_mod_usuario OWNER TO usuarioscn;

--
-- TOC entry 2142 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE t_mod_usuario; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON TABLE t_mod_usuario IS 'Tabla que almacena los permisos por usuarios';


--
-- TOC entry 2143 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN t_mod_usuario.codigo; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_mod_usuario.codigo IS 'Código del permiso usuario-módulo';


--
-- TOC entry 2144 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN t_mod_usuario.cod_usuario; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_mod_usuario.cod_usuario IS 'Código del usuario dueño del permiso';


--
-- TOC entry 2145 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN t_mod_usuario.cod_modulo; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_mod_usuario.cod_modulo IS 'Código del módulo';


--
-- TOC entry 2146 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN t_mod_usuario.permiso; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_mod_usuario.permiso IS 'Permiso otorgado (I=insert, U=update, S=select, D=delete';


--
-- TOC entry 2147 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN t_mod_usuario.valor; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_mod_usuario.valor IS 'Indica si tiene el permiso o no (1=SI, 0=NO)';


--
-- TOC entry 168 (class 1259 OID 17081)
-- Dependencies: 7
-- Name: t_modulo; Type: TABLE; Schema: per; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_modulo (
    codigo integer NOT NULL,
    nombre character varying(30)
);


ALTER TABLE per.t_modulo OWNER TO usuarioscn;

--
-- TOC entry 2149 (class 0 OID 0)
-- Dependencies: 168
-- Name: TABLE t_modulo; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON TABLE t_modulo IS 'Tabla que contiene los módulos de la aplicación';


--
-- TOC entry 2150 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN t_modulo.codigo; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_modulo.codigo IS 'Código del módulo de la aplicación';


--
-- TOC entry 2151 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN t_modulo.nombre; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_modulo.nombre IS 'Nombre del módulo de la aplicación';


--
-- TOC entry 170 (class 1259 OID 17099)
-- Dependencies: 7
-- Name: t_tabla; Type: TABLE; Schema: per; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_tabla (
    nombre character varying(30) NOT NULL,
    cod_modulo integer
);


ALTER TABLE per.t_tabla OWNER TO usuarioscn;

--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 170
-- Name: TABLE t_tabla; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON TABLE t_tabla IS 'Tabla que contiene la lista de tablas de la aplicación, está hecha con la finalidad de asociarlas a un módulo y agilizar el otorgamiento/revocamiento de permisología';


--
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN t_tabla.nombre; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_tabla.nombre IS 'Nombre de la tabla del sistema';


--
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN t_tabla.cod_modulo; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_tabla.cod_modulo IS 'Código del módulo al que pertenece la tabla';


--
-- TOC entry 169 (class 1259 OID 17086)
-- Dependencies: 1959 7
-- Name: t_usuario; Type: TABLE; Schema: per; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_usuario (
    nombre character varying(30) NOT NULL,
    codigo integer,
    tipo character(1),
    CONSTRAINT chk_usuario_01 CHECK ((tipo = ANY (ARRAY['U'::bpchar, 'R'::bpchar])))
);


ALTER TABLE per.t_usuario OWNER TO usuarioscn;

--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE t_usuario; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON TABLE t_usuario IS 'Tabla que contiene los usuarios de base de datos de la aplicación';


--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN t_usuario.nombre; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_usuario.nombre IS 'Indica el nombre del usuario';


--
-- TOC entry 2159 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN t_usuario.codigo; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_usuario.codigo IS 'Código de la persona, hace refercia a sis.t_persona.codigo';


--
-- TOC entry 2160 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN t_usuario.tipo; Type: COMMENT; Schema: per; Owner: usuarioscn
--

COMMENT ON COLUMN t_usuario.tipo IS 'Indica si es un usuario o un rol(U,R)';


SET search_path = sis, pg_catalog;

--
-- TOC entry 164 (class 1259 OID 17035)
-- Dependencies: 1956 1957 1958 6
-- Name: t_cur_estudiante; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_cur_estudiante (
    codigo integer NOT NULL,
    cod_estudiante integer NOT NULL,
    cod_curso integer NOT NULL,
    por_asistencia double precision,
    nota integer,
    cod_estado character(1) NOT NULL,
    observaciones character varying(300),
    CONSTRAINT chk_cur_estudiante_01 CHECK ((por_asistencia >= (0)::double precision)),
    CONSTRAINT chk_cur_estudiante_02 CHECK ((nota >= 0)),
    CONSTRAINT chk_cur_estudiante_03 CHECK ((por_asistencia <= (100)::double precision))
);


ALTER TABLE sis.t_cur_estudiante OWNER TO usuarioscn;

--
-- TOC entry 162 (class 1259 OID 17004)
-- Dependencies: 1953 1954 1955 6
-- Name: t_curso; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_curso (
    codigo integer NOT NULL,
    cod_periodo integer NOT NULL,
    cod_uni_curricular integer NOT NULL,
    cod_docente integer,
    seccion character varying(5) NOT NULL,
    fec_inicio date,
    fec_final date,
    capacidad smallint,
    observaciones character varying(300),
    CONSTRAINT chk_curso_01 CHECK ((fec_inicio < fec_final)),
    CONSTRAINT chk_curso_02 CHECK ((capacidad >= 0)),
    CONSTRAINT chk_curso_03 CHECK ((length(btrim((seccion)::text)) > 0))
);


ALTER TABLE sis.t_curso OWNER TO usuarioscn;

--
-- TOC entry 161 (class 1259 OID 17002)
-- Dependencies: 162 6
-- Name: t_curso_codigo_seq; Type: SEQUENCE; Schema: sis; Owner: usuarioscn
--

CREATE SEQUENCE t_curso_codigo_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sis.t_curso_codigo_seq OWNER TO usuarioscn;

--
-- TOC entry 2164 (class 0 OID 0)
-- Dependencies: 161
-- Name: t_curso_codigo_seq; Type: SEQUENCE OWNED BY; Schema: sis; Owner: usuarioscn
--

ALTER SEQUENCE t_curso_codigo_seq OWNED BY t_curso.codigo;


--
-- TOC entry 2165 (class 0 OID 0)
-- Dependencies: 161
-- Name: t_curso_codigo_seq; Type: SEQUENCE SET; Schema: sis; Owner: usuarioscn
--

SELECT pg_catalog.setval('t_curso_codigo_seq', 177, true);


--
-- TOC entry 154 (class 1259 OID 16896)
-- Dependencies: 6
-- Name: t_docente; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_docente (
    codigo integer NOT NULL,
    cod_instituto integer,
    num_empleado smallint,
    cod_estado character(1) NOT NULL
);


ALTER TABLE sis.t_docente OWNER TO usuarioscn;

--
-- TOC entry 163 (class 1259 OID 17030)
-- Dependencies: 6
-- Name: t_est_cur_estudiante; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_est_cur_estudiante (
    codigo character(1) NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE sis.t_est_cur_estudiante OWNER TO usuarioscn;

--
-- TOC entry 153 (class 1259 OID 16891)
-- Dependencies: 6
-- Name: t_est_docente; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_est_docente (
    codigo character(1) NOT NULL,
    nombre character varying(40) NOT NULL
);


ALTER TABLE sis.t_est_docente OWNER TO usuarioscn;

--
-- TOC entry 155 (class 1259 OID 16916)
-- Dependencies: 6
-- Name: t_est_estudiante; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_est_estudiante (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_estudiante OWNER TO usuarioscn;

--
-- TOC entry 150 (class 1259 OID 16847)
-- Dependencies: 6
-- Name: t_est_periodo; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_est_periodo (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_periodo OWNER TO usuarioscn;

--
-- TOC entry 159 (class 1259 OID 16977)
-- Dependencies: 6
-- Name: t_est_usu_con_estudios; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_est_usu_con_estudios (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_usu_con_estudios OWNER TO usuarioscn;

--
-- TOC entry 157 (class 1259 OID 16952)
-- Dependencies: 6
-- Name: t_est_usu_enc_pensum; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_est_usu_enc_pensum (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_usu_enc_pensum OWNER TO usuarioscn;

--
-- TOC entry 173 (class 1259 OID 33095)
-- Dependencies: 6
-- Name: t_est_usu_ministerio; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_est_usu_ministerio (
    codigo character(1) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE sis.t_est_usu_ministerio OWNER TO usuarioscn;

--
-- TOC entry 156 (class 1259 OID 16921)
-- Dependencies: 6
-- Name: t_estudiante; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_estudiante (
    codigo integer NOT NULL,
    cod_instituto integer,
    cod_pensum integer,
    num_carnet character varying(20),
    num_expediente character varying(30),
    cod_rusnies character varying(30),
    cod_estado character(1) NOT NULL
);


ALTER TABLE sis.t_estudiante OWNER TO usuarioscn;

--
-- TOC entry 179 (class 1259 OID 66035)
-- Dependencies: 6
-- Name: t_estudiante_temp; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_estudiante_temp (
    id integer,
    cedula integer NOT NULL,
    apellidos character varying(50),
    nombres character varying(50),
    sexo character varying(1),
    discapacidad boolean,
    condicion character varying(10),
    anio integer,
    fec_ingreso timestamp without time zone,
    telefono1 character varying(20),
    telefono2 character varying(20),
    email character varying(50),
    apellido1 character varying(30),
    apellido2 character varying(30),
    nombre1 character varying(30),
    nombre2 character varying(30),
    seccion character varying(1)
);


ALTER TABLE sis.t_estudiante_temp OWNER TO usuarioscn;

--
-- TOC entry 165 (class 1259 OID 17060)
-- Dependencies: 6
-- Name: t_fotografia; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_fotografia (
    cod_persona integer NOT NULL,
    tipo character varying(20),
    imagen oid
);


ALTER TABLE sis.t_fotografia OWNER TO usuarioscn;

--
-- TOC entry 149 (class 1259 OID 16830)
-- Dependencies: 6
-- Name: t_instituto; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_instituto (
    codigo smallint NOT NULL,
    nom_corto character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion character varying(200)
);


ALTER TABLE sis.t_instituto OWNER TO usuarioscn;

--
-- TOC entry 144 (class 1259 OID 16762)
-- Dependencies: 6
-- Name: t_pensum; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_pensum (
    codigo integer NOT NULL,
    nombre character varying(100) NOT NULL,
    nom_corto character varying(20) NOT NULL,
    observaciones character varying(200)
);


ALTER TABLE sis.t_pensum OWNER TO usuarioscn;

--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE t_pensum; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON TABLE t_pensum IS 'Tabla padre de un pensum';


--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 144
-- Name: COLUMN t_pensum.codigo; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_pensum.codigo IS 'Código del pensum';


--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 144
-- Name: COLUMN t_pensum.nombre; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_pensum.nombre IS 'Nombre largo del pensum';


--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 144
-- Name: COLUMN t_pensum.nom_corto; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_pensum.nom_corto IS 'Abreviación del nombre del pensum';


--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 144
-- Name: COLUMN t_pensum.observaciones; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_pensum.observaciones IS 'Alguna otra información relevante del pensum';


--
-- TOC entry 151 (class 1259 OID 16852)
-- Dependencies: 1948 1949 6
-- Name: t_periodo; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_periodo (
    codigo integer NOT NULL,
    nombre character varying(30),
    cod_instituto integer NOT NULL,
    cod_pensum integer NOT NULL,
    fec_inicio date NOT NULL,
    fec_final date NOT NULL,
    observaciones character varying(100),
    cod_estado character(1) NOT NULL,
    CONSTRAINT chk_periodo_01 CHECK ((codigo > 0)),
    CONSTRAINT chk_periodo_02 CHECK ((fec_inicio < fec_final))
);


ALTER TABLE sis.t_periodo OWNER TO usuarioscn;

--
-- TOC entry 152 (class 1259 OID 16876)
-- Dependencies: 1950 1951 6
-- Name: t_persona; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_persona (
    codigo integer NOT NULL,
    cedula integer NOT NULL,
    rif character varying(20),
    nombre1 character varying(20) NOT NULL,
    nombre2 character varying(20),
    apellido1 character varying(20) NOT NULL,
    apellido2 character varying(20),
    sexo character varying(1) NOT NULL,
    fec_nacimiento date,
    tip_sangre character varying(8),
    telefono1 character varying(20),
    telefono2 character varying(20),
    cor_personal character varying(50),
    cor_institucional character varying(50),
    direccion character varying(200),
    CONSTRAINT chk_persona_01 CHECK (((fec_nacimiento >= '1940-01-01'::date) AND (fec_nacimiento <= ('now'::text)::date))),
    CONSTRAINT chk_persona_02 CHECK (((sexo)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying])::text[])))
);


ALTER TABLE sis.t_persona OWNER TO usuarioscn;

--
-- TOC entry 180 (class 1259 OID 66046)
-- Dependencies: 6
-- Name: t_persona_temp_2; Type: TABLE; Schema: sis; Owner: alamoj; Tablespace: 
--

CREATE TABLE t_persona_temp_2 (
    cedula integer NOT NULL,
    email character varying(50)
);


ALTER TABLE sis.t_persona_temp_2 OWNER TO alamoj;

--
-- TOC entry 148 (class 1259 OID 16813)
-- Dependencies: 6
-- Name: t_prelacion; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_prelacion (
    codigo integer NOT NULL,
    cod_uni_curricular integer NOT NULL,
    cod_uni_cur_prelada integer NOT NULL
);


ALTER TABLE sis.t_prelacion OWNER TO usuarioscn;

--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE t_prelacion; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON TABLE t_prelacion IS 'Tabla que almacena las prelaciones entre unidades curriculares';


--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN t_prelacion.codigo; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_prelacion.codigo IS 'Código único de la prelación';


--
-- TOC entry 2190 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN t_prelacion.cod_uni_curricular; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_prelacion.cod_uni_curricular IS 'Código de la unidad curricular a establecerle la prelación';


--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN t_prelacion.cod_uni_cur_prelada; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_prelacion.cod_uni_cur_prelada IS 'Código de la unidad que no se puede cursar si no se ha aprobado esta';


--
-- TOC entry 146 (class 1259 OID 16784)
-- Dependencies: 6
-- Name: t_tip_uni_curricular; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_tip_uni_curricular (
    codigo character(1) NOT NULL,
    nombre character varying(40) NOT NULL
);


ALTER TABLE sis.t_tip_uni_curricular OWNER TO usuarioscn;

--
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE t_tip_uni_curricular; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON TABLE t_tip_uni_curricular IS 'Almacena los distintos tipos de unidades curriculares';


--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 146
-- Name: COLUMN t_tip_uni_curricular.codigo; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_tip_uni_curricular.codigo IS 'Código del tipo de unidad curricular';


--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 146
-- Name: COLUMN t_tip_uni_curricular.nombre; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_tip_uni_curricular.nombre IS 'Nombre del tipo de unidad curricular';


--
-- TOC entry 145 (class 1259 OID 16769)
-- Dependencies: 1938 1939 1940 6
-- Name: t_trayecto; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_trayecto (
    codigo integer NOT NULL,
    cod_pensum integer NOT NULL,
    num_trayecto smallint NOT NULL,
    certificado character varying(150),
    min_credito smallint NOT NULL,
    CONSTRAINT chk_trayecto_01 CHECK ((codigo > 0)),
    CONSTRAINT chk_trayecto_02 CHECK ((num_trayecto >= 0)),
    CONSTRAINT chk_trayecto_03 CHECK ((min_credito >= 0))
);


ALTER TABLE sis.t_trayecto OWNER TO usuarioscn;

--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 145
-- Name: TABLE t_trayecto; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON TABLE t_trayecto IS 'Lista de trayectos, semestres o trimestres de un pensum';


--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 145
-- Name: COLUMN t_trayecto.codigo; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_trayecto.codigo IS 'Código único del trayecto';


--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 145
-- Name: COLUMN t_trayecto.cod_pensum; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_trayecto.cod_pensum IS 'Código del pensum al que pertenece';


--
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 145
-- Name: COLUMN t_trayecto.num_trayecto; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_trayecto.num_trayecto IS 'Número de trayecto, año, semestre o trimestre del pensum';


--
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 145
-- Name: COLUMN t_trayecto.certificado; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_trayecto.certificado IS 'Nombre del certificado que se obtiene al finalizar este trayecto';


--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 145
-- Name: COLUMN t_trayecto.min_credito; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_trayecto.min_credito IS 'Mínima cantidad de unidades de créditos a obtener para aprobar el trayecto';


--
-- TOC entry 147 (class 1259 OID 16789)
-- Dependencies: 1941 1942 1943 1944 1945 1946 1947 6
-- Name: t_uni_curricular; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_uni_curricular (
    codigo integer NOT NULL,
    cod_uni_ministerio character varying(20),
    cod_trayecto integer NOT NULL,
    nombre character varying(100) NOT NULL,
    cod_tipo character(1) NOT NULL,
    hta double precision NOT NULL,
    hti double precision,
    uni_credito smallint NOT NULL,
    dur_semanas smallint NOT NULL,
    not_min_aprobatoria smallint NOT NULL,
    not_maxima smallint NOT NULL,
    CONSTRAINT chk_uni_curricular_01 CHECK ((codigo > 0)),
    CONSTRAINT chk_uni_curricular_02 CHECK ((hta >= (0)::double precision)),
    CONSTRAINT chk_uni_curricular_03 CHECK ((hti >= (0)::double precision)),
    CONSTRAINT chk_uni_curricular_04 CHECK ((uni_credito >= 0)),
    CONSTRAINT chk_uni_curricular_05 CHECK ((dur_semanas >= 0)),
    CONSTRAINT chk_uni_curricular_06 CHECK ((not_min_aprobatoria >= 0)),
    CONSTRAINT chk_uni_curricular_07 CHECK ((not_maxima >= not_min_aprobatoria))
);


ALTER TABLE sis.t_uni_curricular OWNER TO usuarioscn;

--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 147
-- Name: TABLE t_uni_curricular; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON TABLE t_uni_curricular IS 'Tabla que almacena las unidades curriculares de un pensum';


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.codigo; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.codigo IS 'Código único de la unidad curricular';


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.cod_uni_ministerio; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.cod_uni_ministerio IS 'Código de la unidad curricular según el ministerio';


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.cod_trayecto; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.cod_trayecto IS 'Código del trayecto al que pertenece la unidad curricular';


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.nombre; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.nombre IS 'Nombre de la unidad curricular';


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.cod_tipo; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.cod_tipo IS 'Tipo de la unidad, hace referencia a sis.t_tip_uni_curricular';


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.hta; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.hta IS 'Horas de Trabajo Acompañado por semana(horas de clase)';


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.hti; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.hti IS 'Horas de Trabajo Independiente por semana';


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.uni_credito; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.uni_credito IS 'Cantidad de unidades de crédito de la unidad curricular';


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.dur_semanas; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.dur_semanas IS 'Cantidad de semanas que dura la unidad curricular';


--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.not_min_aprobatoria; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.not_min_aprobatoria IS 'Nota mínima con la que se aprueba la unidad curricular';


--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 147
-- Name: COLUMN t_uni_curricular.not_maxima; Type: COMMENT; Schema: sis; Owner: usuarioscn
--

COMMENT ON COLUMN t_uni_curricular.not_maxima IS 'Nota máxima o escala de nota de la unidad curricular';


--
-- TOC entry 160 (class 1259 OID 16982)
-- Dependencies: 6
-- Name: t_usu_con_estudios; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_usu_con_estudios (
    codigo integer NOT NULL,
    cod_estado character(1),
    cod_instituto integer
);


ALTER TABLE sis.t_usu_con_estudios OWNER TO usuarioscn;

--
-- TOC entry 158 (class 1259 OID 16957)
-- Dependencies: 6
-- Name: t_usu_enc_pensum; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_usu_enc_pensum (
    codigo integer NOT NULL,
    cod_estado character(1),
    cod_instituto integer,
    cod_pensum integer
);


ALTER TABLE sis.t_usu_enc_pensum OWNER TO usuarioscn;

--
-- TOC entry 174 (class 1259 OID 33100)
-- Dependencies: 6
-- Name: t_usu_ministerio; Type: TABLE; Schema: sis; Owner: usuarioscn; Tablespace: 
--

CREATE TABLE t_usu_ministerio (
    codigo integer NOT NULL,
    cod_estado character(1)
);


ALTER TABLE sis.t_usu_ministerio OWNER TO usuarioscn;

--
-- TOC entry 183 (class 1259 OID 66098)
-- Dependencies: 1746 6
-- Name: v_cur_estudiante; Type: VIEW; Schema: sis; Owner: postgres
--

CREATE VIEW v_cur_estudiante AS
    SELECT inst.codigo AS cod_instituto, inst.nombre AS nom_instituto, peri.codigo AS cod_periodo, peri.nombre AS nom_periodo, pens.codigo AS cod_pensum, pens.nom_corto, tray.num_trayecto, curs.codigo AS cod_curso, curs.seccion, unid.codigo AS cod_uni_curricular, unid.nombre AS nom_uni_curricular, doce.cedula AS ced_docente, (((doce.nombre1)::text || ' '::text) || (doce.apellido1)::text) AS nom_docente, doce.cor_personal AS cor_doc_personal, estu.codigo AS cod_estudiante, estu.cedula AS ced_estudiante, (((estu.apellido1)::text || ', '::text) || (estu.nombre1)::text) AS nom_estudiante, estu.cor_personal AS cor_est_personal, cure.codigo AS cod_cur_estudiante, cure.por_asistencia, cure.nota, cure.cod_estado, est_estu.nombre AS nom_est_estudiante, cure.observaciones FROM (((((((((t_instituto inst JOIN t_periodo peri ON ((inst.codigo = peri.cod_instituto))) JOIN t_pensum pens ON ((peri.cod_pensum = pens.codigo))) JOIN t_curso curs ON ((peri.codigo = curs.cod_periodo))) LEFT JOIN t_persona doce ON ((curs.cod_docente = doce.codigo))) JOIN t_uni_curricular unid ON ((curs.cod_uni_curricular = unid.codigo))) LEFT JOIN t_trayecto tray ON ((unid.cod_trayecto = tray.codigo))) JOIN t_cur_estudiante cure ON ((curs.codigo = cure.cod_curso))) JOIN t_persona estu ON ((cure.cod_estudiante = estu.codigo))) JOIN t_est_cur_estudiante est_estu ON ((cure.cod_estado = est_estu.codigo))) ORDER BY inst.codigo, peri.codigo, tray.num_trayecto, curs.seccion, unid.nombre, (((estu.apellido1)::text || ', '::text) || (estu.nombre1)::text);


ALTER TABLE sis.v_cur_estudiante OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 66030)
-- Dependencies: 1744 6
-- Name: v_cur_estudiante_temp; Type: VIEW; Schema: sis; Owner: alamoj
--

CREATE VIEW v_cur_estudiante_temp AS
    SELECT inst.codigo AS ins_codigo, inst.nombre AS inst_nombre, peri.codigo AS per_codigo, peri.nombre AS per_nombre, curs.codigo AS cur_codigo, curs.seccion AS cur_seccion, tray.codigo AS tray_codigo, tray.num_trayecto AS tra_numero, tray.certificado AS tra_certificado, unid.codigo AS uni_cur_codigo, unid.nombre AS uni_cur_nombre, doce.cedula AS doc_cedula, doce.nombre1 AS doc_nombre1, doce.apellido1 AS doc_apellido1, doce.cor_personal AS doc_cor_personal, estu.codigo AS est_codigo, estu.cedula AS est_cedula, estu.apellido1 AS est_apellido1, estu.apellido2 AS est_apellido2, estu.nombre1 AS est_nombre1, estu.nombre2 AS est_nombre2, estu.cor_personal AS est_cor_personal, cure.codigo AS cur_est_codigo, cure.por_asistencia AS cur_est_por_asistencia, cure.nota AS cur_est_nota, cure.cod_estado AS cur_est_cod_estado, est_estu.nombre AS est_est_nombre, cure.observaciones AS cur_est_observaciones FROM ((((((((t_instituto inst JOIN t_periodo peri ON ((inst.codigo = peri.cod_instituto))) JOIN t_curso curs ON ((peri.codigo = curs.cod_periodo))) LEFT JOIN t_persona doce ON ((curs.cod_docente = doce.codigo))) JOIN t_uni_curricular unid ON ((curs.cod_uni_curricular = unid.codigo))) LEFT JOIN t_trayecto tray ON ((unid.cod_trayecto = tray.codigo))) LEFT JOIN t_cur_estudiante cure ON ((curs.codigo = cure.cod_curso))) JOIN t_persona estu ON ((cure.cod_estudiante = estu.codigo))) JOIN t_est_cur_estudiante est_estu ON ((cure.cod_estado = est_estu.codigo))) ORDER BY peri.cod_instituto, curs.cod_periodo, curs.seccion, unid.nombre, estu.apellido1;


ALTER TABLE sis.v_cur_estudiante_temp OWNER TO alamoj;

--
-- TOC entry 167 (class 1259 OID 17075)
-- Dependencies: 1742 6
-- Name: v_docente; Type: VIEW; Schema: sis; Owner: usuarioscn
--

CREATE VIEW v_docente AS
    SELECT p.codigo, p.cedula, p.rif, p.nombre1, p.nombre2, p.apellido1, p.apellido2, p.sexo, p.fec_nacimiento, p.tip_sangre, p.telefono1, p.telefono2, p.cor_personal, p.cor_institucional, p.direccion, d.cod_instituto AS cod_departamento, d.num_empleado, d.cod_estado FROM (t_persona p JOIN t_docente d ON ((p.codigo = d.codigo)));


ALTER TABLE sis.v_docente OWNER TO usuarioscn;

--
-- TOC entry 166 (class 1259 OID 17070)
-- Dependencies: 1741 6
-- Name: v_estudiante; Type: VIEW; Schema: sis; Owner: usuarioscn
--

CREATE VIEW v_estudiante AS
    SELECT p.cedula, p.codigo, p.rif, p.nombre1, p.nombre2, p.apellido1, p.apellido2, p.sexo, p.fec_nacimiento, p.tip_sangre, p.telefono1, p.telefono2, p.cor_personal, p.cor_institucional, p.direccion, e.cod_instituto AS cod_departamento, e.cod_pensum, e.num_carnet, e.num_expediente, e.cod_rusnies, e.cod_estado FROM (t_persona p JOIN t_estudiante e ON ((p.codigo = e.codigo)));


ALTER TABLE sis.v_estudiante OWNER TO usuarioscn;

--
-- TOC entry 181 (class 1259 OID 66051)
-- Dependencies: 1745 6
-- Name: v_pensum; Type: VIEW; Schema: sis; Owner: postgres
--

CREATE VIEW v_pensum AS
    SELECT p.codigo AS cod_pensum, p.nombre AS nom_pensum, p.nom_corto AS nom_cor_pensum, t.codigo AS cod_trayecto, t.num_trayecto, t.certificado, t.min_credito, u.codigo AS cod_uni_curricular, u.nombre AS nom_uni_curricular, u.cod_tipo, u.hta, u.hti, u.uni_credito, u.dur_semanas, u.not_min_aprobatoria, u.not_maxima FROM ((t_pensum p JOIN t_trayecto t ON ((p.codigo = t.cod_pensum))) JOIN t_uni_curricular u ON ((t.codigo = u.cod_trayecto))) ORDER BY p.codigo, t.num_trayecto, u.nombre;


ALTER TABLE sis.v_pensum OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 41432)
-- Dependencies: 1743 6
-- Name: v_prelacion; Type: VIEW; Schema: sis; Owner: alamoj
--

CREATE VIEW v_prelacion AS
    SELECT ta.num_trayecto AS num_tra_a, a.nombre AS nom_a, '==>' AS sep, tb.num_trayecto AS num_tra_b, b.nombre AS nom_b FROM ((((t_trayecto ta JOIN t_uni_curricular a ON ((ta.codigo = a.cod_trayecto))) JOIN t_prelacion p ON ((a.codigo = p.cod_uni_curricular))) JOIN t_uni_curricular b ON ((p.cod_uni_cur_prelada = b.codigo))) JOIN t_trayecto tb ON ((b.cod_trayecto = tb.codigo)));


ALTER TABLE sis.v_prelacion OWNER TO alamoj;

SET search_path = tmp, pg_catalog;

--
-- TOC entry 182 (class 1259 OID 66068)
-- Dependencies: 10
-- Name: activos_infor_dic_2015; Type: TABLE; Schema: tmp; Owner: postgres; Tablespace: 
--

CREATE TABLE activos_infor_dic_2015 (
    cedula integer NOT NULL,
    nombres character varying(50),
    apellidos character varying(50)
);


ALTER TABLE tmp.activos_infor_dic_2015 OWNER TO postgres;

SET search_path = sis, pg_catalog;

--
-- TOC entry 1952 (class 2604 OID 17007)
-- Dependencies: 162 161 162
-- Name: codigo; Type: DEFAULT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_curso ALTER COLUMN codigo SET DEFAULT nextval('t_curso_codigo_seq'::regclass);


SET search_path = err, pg_catalog;

--
-- TOC entry 2126 (class 0 OID 57792)
-- Dependencies: 176
-- Data for Name: t_error; Type: TABLE DATA; Schema: err; Owner: usuarioscn
--

COPY t_error (codigo, cod_error, cod_usuario, cod_estatus, fec_reporte, fec_respuesta, descripcion, respuesta) FROM stdin;
\.


--
-- TOC entry 2127 (class 0 OID 57798)
-- Dependencies: 177
-- Data for Name: t_est_error; Type: TABLE DATA; Schema: err; Owner: postgres
--

COPY t_est_error (codigo, nombre) FROM stdin;
\.


SET search_path = per, pg_catalog;

--
-- TOC entry 2123 (class 0 OID 17127)
-- Dependencies: 172
-- Data for Name: t_menu; Type: TABLE DATA; Schema: per; Owner: usuarioscn
--

COPY t_menu (codigo, nombre, permiso) FROM stdin;
\.


--
-- TOC entry 2122 (class 0 OID 17109)
-- Dependencies: 171
-- Data for Name: t_mod_usuario; Type: TABLE DATA; Schema: per; Owner: usuarioscn
--

COPY t_mod_usuario (codigo, cod_usuario, cod_modulo, permiso, valor) FROM stdin;
\.


--
-- TOC entry 2119 (class 0 OID 17081)
-- Dependencies: 168
-- Data for Name: t_modulo; Type: TABLE DATA; Schema: per; Owner: usuarioscn
--

COPY t_modulo (codigo, nombre) FROM stdin;
\.


--
-- TOC entry 2121 (class 0 OID 17099)
-- Dependencies: 170
-- Data for Name: t_tabla; Type: TABLE DATA; Schema: per; Owner: usuarioscn
--

COPY t_tabla (nombre, cod_modulo) FROM stdin;
\.


--
-- TOC entry 2120 (class 0 OID 17086)
-- Dependencies: 169
-- Data for Name: t_usuario; Type: TABLE DATA; Schema: per; Owner: usuarioscn
--

COPY t_usuario (nombre, codigo, tipo) FROM stdin;
dulceyr	88	U
carranzac	87	U
alamoj	81	U
balzap	84	U
gutierrezj	2065	U
castanedam	85	U
parelesn	2063	U
landazabalc	2072	U
waracaog	2066	U
caninoa	2123	U
santiagoo	83	U
arcilag	2067	U
gomezr	86	U
mendozal	82	U
morad	2119	U
albarrani	2120	U
romerob	2068	U
castrom	2000	U
\.


SET search_path = sis, pg_catalog;

--
-- TOC entry 2117 (class 0 OID 17035)
-- Dependencies: 164
-- Data for Name: t_cur_estudiante; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_cur_estudiante (codigo, cod_estudiante, cod_curso, por_asistencia, nota, cod_estado, observaciones) FROM stdin;
1346	40	176	0	0	I	
1355	5	176	0	0	I	
83	4	14	0	0	N	
1364	54	176	0	0	I	
1334	104	170	0	0	N	
18	61	11	0	0	I	
109	3	15	0	0	N	
113	8	15	0	14	A	
123	42	15	0	6	R	
129	64	15	0	12	A	
128	58	15	0	6	R	
120	37	15	0	\N	N	
125	47	15	0	7	R	
127	53	15	0	0	N	
130	68	15	0	0	N	
132	73	15	0	0	N	
119	36	15	0	6	R	
133	75	15	0	14	A	
121	38	15	0	6	R	
134	79	15	0	7	R	
117	30	15	0	0	N	
118	31	15	0	6	R	
112	7	15	0	0	N	
131	71	15	0	6	R	
110	4	15	0	6	R	
122	40	15	0	16	A	
126	49	15	0	6	R	
111	6	15	0	6	R	
124	43	15	0	8	R	
114	12	15	0	6	R	
28	70	12	0	0	N	
30	74	12	0	6	R	
31	72	12	0	\N	N	
32	2	12	0	0	A	 Equivalencia
34	76	12	0	12	A	
35	51	12	0	0	N	
33	17	12	0	6	R	
36	67	12	0	17	A	
40	24	12	0	0	N	
37	21	12	0	6	R	
38	20	12	0	6	R	
39	29	12	0	0	N	
41	35	12	0	0	N	
42	56	12	0	12	A	
44	33	12	0	6	R	
43	34	12	0	6	R	
47	23	12	0	0	N	
49	19	12	0	6	R	
46	69	12	0	6	R	
50	14	12	0	12	A	
48	55	12	0	14	A	
53	61	12	0	0	N	
51	22	12	0	12	A	
54	65	12	0	6	R	
52	60	12	0	8	R	
89	27	14	0	17	A	
96	42	14	0	15	A	
86	8	14	0	20	A	
108	80	14	0	18	A	
82	3	14	0	17	A	
101	58	14	0	19	A	
93	37	14	0	17	A	
85	7	14	0	17	A	
98	47	14	0	15	A	
100	53	14	0	0	N	
103	68	14	0	0	N	
106	75	14	0	19	A	
94	38	14	0	19	A	
90	30	14	0	0	N	
92	36	14	0	18	A	
107	79	14	0	17	A	
105	73	14	0	15	A	
88	18	14	0	0	N	
91	31	14	0	17	A	
99	49	14	0	0	N	
97	43	14	0	18	A	
95	40	14	0	19	A	
84	6	14	0	17	A	
87	12	14	0	17	A	
14	51	11	0	11	R	
5	20	11	0	7	R	verificar cedula
25	74	11	0	3	R	
24	72	11	0	0	I	No Aparece en el Listado
21	67	11	0	13	A	
26	76	11	0	12	A	
3	17	11	0	12	A	PER
1	2	11	0	4	R	
13	35	11	0	3	R	
10	29	11	0	0	I	No Aparece en el Listado
16	56	11	0	12	A	
8	23	11	0	3	R	
12	34	11	0	5	R	
22	69	11	0	13	A	
11	33	11	0	13	A	
7	22	11	0	12	A	
57	74	13	0	17	A	
55	70	13	0	12	A	
56	77	13	0	18	A	
61	76	13	0	16	A	
62	51	13	0	13	A	
59	2	13	0	6	R	
64	21	13	0	16	A	
66	29	13	0	14	A	
63	67	13	0	15	A	
65	20	13	0	12	A	
67	24	13	0	7	R	
72	66	13	0	12	A	
68	35	13	0	7	R	
70	34	13	0	12	A	
73	69	13	0	12	A	
69	56	13	0	17	A	
76	19	13	0	17	A	
75	55	13	0	15	A	
71	33	13	0	12	A	
78	22	13	0	13	A	
77	14	13	0	14	A	
80	61	13	0	16	A	
81	65	13	0	12	A	
142	27	16	0	19	A	
138	7	16	0	12	A	
139	8	16	0	20	A	
143	30	16	0	0	N	
141	18	16	0	17	A	
136	4	16	0	19	A	
137	6	16	0	18	A	
140	12	16	0	20	A	
58	72	13	0	0	I	NO APRACE EN LISTA DE RICHAR
79	60	13	0	12	A	
15	55	11	0	13	A	
4	19	11	0	12	A	
17	60	11	0	12	A	PER
1326	2015	167	0	12	A	
248	92	11	0	0	I	
260	95	15	0	0	I	
257	118	15	0	0	N	
259	94	15	0	6	R	
242	90	12	0	12	A	
241	89	12	0	6	R	
244	92	12	0	0	N	
243	91	12	0	12	A	
256	95	14	0	16	A	
253	118	14	0	0	N	
254	93	14	0	0	N	
255	94	14	0	19	A	
280	101	22	0	0	R	
281	102	22	0	1	R	
288	108	22	0	0	N	
289	109	22	0	0	N	
273	99	17	0	0	I	No Cursa
195	15	17	0	12	A	
205	46	17	0	16	A	
272	98	17	0	0	I	No Cursa
190	5	17	0	12	A	
204	45	17	0	20	A	
197	25	17	0	20	A	
191	9	17	0	14	A	
271	97	17	0	0	I	No Cursa
212	62	17	0	12	A	
198	26	17	0	3	R	
201	39	17	0	4	R	
192	10	17	0	12	A	
203	44	17	0	15	A	
274	100	17	0	0	N	
207	50	17	0	14	A	
196	16	17	0	12	A	
210	57	17	0	20	A	
199	28	17	0	12	A	
208	52	17	0	17	A	
213	63	17	0	15	A	
189	1	17	0	12	A	
206	48	17	0	16	A	
202	41	17	0	13	A	
194	13	17	0	12	A	
214	78	17	0	0	N	
193	11	17	0	3	R	
200	32	17	0	12	A	
270	96	17	0	12	A	
245	89	11	0	12	A	
249	89	13	0	12	A	
250	90	13	0	17	A	
252	92	13	0	1	N	
251	91	13	0	16	A	
261	118	16	0	0	N	
264	95	16	0	0	I	NO CURSA IPP
154	58	16	0	20	A	
262	93	16	0	0	N	
149	42	16	0	13	A	
188	3	16	0	19	A	
161	80	16	0	20	A	
155	64	16	0	16	A	
146	37	16	0	14	A	
147	38	16	0	14	A	
156	68	16	0	4	N	
158	73	16	0	14	A	
153	53	16	0	0	N	
159	75	16	0	20	A	
157	71	16	0	15	A	
145	36	16	0	14	A	
160	79	16	0	18	A	
152	49	16	0	18	A	
150	43	16	0	20	A	
263	94	16	0	12	A	
276	97	18	0	13	A	
278	99	18	0	0	N	
277	98	18	0	17	A	
279	100	18	0	0	N	
217	9	18	0	19	A	
231	46	18	0	18	A	
221	15	18	0	20	A	
223	25	18	0	20	A	
216	5	18	0	20	A	
238	62	18	0	20	A	
222	16	18	0	19	A	
224	26	18	0	18	A	
218	10	18	0	14	A	
237	59	18	0	19	A	
225	28	18	0	19	A	
227	39	18	0	15	A	
229	44	18	0	18	A	
233	50	18	0	20	A	
234	52	18	0	20	A	
239	63	18	0	19	A	
228	41	18	0	19	A	
236	57	18	0	20	A	
284	104	22	0	0	N	
235	54	18	0	20	A	
220	13	18	0	20	A	
240	78	18	0	0	N	
226	32	18	0	19	A	
219	11	18	0	10	R	
275	96	18	0	18	A	
162	1	19	0	13	A	
283	100	22	0	0	N	
286	106	22	0	0	N	
282	103	22	0	0	N	
247	91	11	0	13	A	
266	97	19	0	0	I	curso seccion 3 prof richard
268	99	19	0	4	R	
269	100	19	0	6	R	
168	15	19	0	13	A	
178	46	19	0	13	A	
163	5	19	0	14	A	
185	62	19	0	15	A	
169	16	19	0	13	A	
171	26	19	0	14	A	
177	45	19	0	14	A	
172	28	19	0	5	R	
164	9	19	0	12	A	
184	59	19	0	6	R	
180	50	19	0	15	A	
165	10	19	0	13	A	
181	52	19	0	12	A	
170	25	19	0	14	A	
174	39	19	0	13	A	
186	63	19	0	13	A	
182	54	19	0	13	A	
183	57	19	0	14	A	
175	41	19	0	11	R	
179	48	19	0	13	A	
173	32	19	0	7	R	
187	78	19	0	0	I	No aparece en la lista.
166	11	19	0	4	R	
265	96	19	0	13	A	
215	1	18	0	15	A	
300	119	22	0	0	I	
1347	91	176	0	0	I	
1365	16	176	0	0	I	
1381	74	176	0	0	I	
1373	106	177	0	0	I	
1393	2032	177	0	0	I	
1324	102	167	0	12	A	
326	12	77	0	16	A	
348	38	78	93	11	R	
317	40	78	100	16	A	
334	58	78	90	5	R	
330	12	78	45	1	N	
367	19	80	37	1	N	
385	2	82	0	20	A	
374	91	80	81	12	A	
363	70	80	79	15	A	
323	8	78	96	14	A	
258	93	15	0	0	N	
116	27	15	0	6	R	
135	80	15	0	6	R	
115	18	15	0	6	R	
29	77	12	0	6	R	
45	66	12	0	6	R	
344	6	75	0	0	E	
102	64	14	0	17	A	
104	71	14	0	18	A	
301	120	22	0	0	N	
297	116	22	0	12	A	
302	121	22	0	0	N	
299	118	22	0	0	N	
291	111	22	0	0	N	
296	115	22	0	15	A	
285	105	22	0	0	N	
290	110	22	0	0	N	
295	114	22	0	0	R	
298	117	22	0	0	N	
294	113	22	0	1	R	
211	59	17	0	12	A	
209	54	17	0	20	A	
9	24	11	0	0	I	No Aparece en el Listado
60	17	13	0	20	A	
74	23	13	0	8	R	
151	47	16	0	17	A	
144	31	16	0	19	A	
148	40	16	0	20	A	
230	45	18	0	20	A	
232	48	18	0	18	A	
335	58	75	0	0	E	
303	122	22	0	0	N	
293	92	22	0	0	N	
292	112	22	0	0	N	
287	107	22	0	0	N	
23	70	11	0	13	A	Verificar Nombre (Richard)
27	77	11	0	12	A	PER
6	21	11	0	12	A	PER
20	66	11	0	12	A	
347	38	75	0	0	E	
19	65	11	0	13	A	
2	14	11	0	12	A	
267	98	19	0	0	I	curso seccion 3 prof richard
176	44	19	0	13	A	
167	13	19	0	13	A	
310	127	22	0	12	A	
1335	2049	170	0	0	N	
311	40	76	0	17	A	
246	90	11	0	0	R	No Aparece en el Listado
321	8	76	0	15	A	
379	91	76	0	14	A	
395	34	86	0	15	A	
387	90	81	0	2	R	
386	90	86	0	15	A	
383	2	86	0	18	A	
382	2	87	0	0	N	
392	90	87	0	0	N	
397	34	87	0	0	N	
342	6	74	0	17	A	
316	40	75	0	0	I	
327	12	74	0	1	N	
322	8	75	0	0	I	
319	8	74	0	17	A	
355	33	74	0	13	A	
315	40	74	0	17	A	
373	19	74	0	1	N	
350	38	74	0	16	A	
353	33	75	0	0	I	
332	58	74	0	16	A	
377	91	74	0	14	A	
360	70	75	0	0	I	
362	70	74	0	12	A	
389	90	83	0	12	A	
394	34	83	0	12	A	
1327	2019	167	0	1	N	
371	19	75	0	0	I	
375	91	75	0	0	I	
340	6	78	100	12	A	
384	2	85	0	0	I	
388	90	85	0	0	I	
356	33	80	41	1	N	
390	90	82	0	20	A	
398	34	85	0	0	I	
396	34	82	0	20	A	
331	12	75	0	0	E	
339	6	77	0	18	A	
318	8	77	0	17	A	
352	38	77	0	17	A	
312	40	77	0	15	A	
333	58	77	0	16	A	
400	26	79	0	2	N	
358	33	79	0	13	A	
372	19	79	0	16	A	
378	91	79	0	16	A	
365	70	79	0	15	A	
343	6	73	0	17	A	
324	8	73	0	20	A	
368	19	73	0	9	R	
401	26	73	0	1	N	
313	40	73	0	20	A	
349	38	73	0	17	A	
376	91	73	0	17	A	
329	12	73	0	9	R	
336	58	73	0	17	A	
361	70	73	0	18	A	
359	33	73	0	17	A	
402	26	75	0	0	I	
429	21	78	49	1	N	
407	45	75	0	0	I	
420	50	75	0	0	I	
427	25	75	0	0	I	
1339	58	176	0	0	I	
443	67	75	0	0	I	
1382	4	176	0	0	I	
1348	31	177	0	0	I	
455	60	75	0	0	I	
456	55	85	0	0	I	
461	76	85	0	0	I	
1366	42	177	0	0	I	
1374	3	177	0	0	I	
474	18	75	0	0	I	
1394	2041	177	0	0	I	
439	17	78	41	1	N	
482	44	75	0	0	I	
520	39	78	41	1	N	
531	52	78	44	1	N	
490	29	75	0	0	I	
494	62	75	0	0	I	
535	61	78	5	1	N	
499	4	75	0	0	I	
540	77	78	41	1	N	
498	4	80	80	7	R	
506	5	75	0	0	I	
509	5	80	81	7	R	
473	18	80	6	1	N	
515	16	75	0	0	I	
406	26	80	25	1	N	
423	25	80	63	1	N	
525	39	75	0	0	I	
528	52	75	0	0	I	
458	55	82	0	20	A	
484	29	80	5	1	N	
410	45	80	68	1	N	
539	61	75	0	0	I	
415	50	80	66	1	N	
449	60	80	42	1	N	
431	21	75	0	0	E	
440	17	75	0	0	E	
542	77	75	0	0	E	
496	62	80	81	5	R	
442	67	80	81	12	A	
516	16	80	90	12	A	
532	52	76	0	0	N	
1328	113	170	0	2	R	
1338	121	170	0	0	N	
1336	2009	170	0	0	R	
505	5	76	0	15	A	
408	45	76	0	15	A	
418	50	76	0	13	A	
479	44	76	0	0	N	
518	16	76	0	12	A	
424	25	76	0	13	A	
493	62	76	0	14	A	
445	67	76	0	18	A	
460	55	81	0	5	R	
469	76	81	0	6	R	
462	55	86	0	16	A	
465	76	86	0	13	A	
464	55	87	0	0	N	
457	76	87	0	0	N	
511	5	74	0	16	A	
502	4	74	0	17	A	
517	16	74	0	15	A	
436	17	74	0	12	A	
475	18	74	0	1	N	
426	25	74	0	14	A	
430	21	74	0	12	A	
404	26	74	0	1	N	
487	29	74	0	1	N	
522	39	74	0	8	R	
480	44	74	0	1	N	
416	50	74	0	15	A	
527	52	74	0	9	R	
492	62	74	0	16	A	
412	45	74	0	16	A	
536	61	74	0	1	N	
451	60	74	0	7	R	
446	67	74	0	16	A	
545	77	74	0	12	A	
468	55	83	0	15	A	
467	76	83	0	12	A	
463	76	82	0	16	A	
483	44	80	11	1	N	
432	21	77	0	18	A	
435	17	77	0	19	A	
533	61	77	0	3	N	
521	39	77	0	10	N	
526	52	77	0	17	A	
544	77	77	0	8	N	
501	4	79	0	14	A	
512	16	79	0	19	A	
470	18	79	0	1	N	
507	5	79	0	15	A	
421	25	79	0	16	A	
477	44	79	0	2	N	
409	45	79	0	16	A	
489	29	79	0	1	N	
444	67	79	0	18	A	
491	62	79	0	16	A	
452	60	79	0	7	N	
417	50	79	0	12	A	
500	4	73	0	19	A	
508	5	73	0	19	A	
471	18	73	0	1	N	
514	16	73	0	17	A	
438	17	73	0	9	R	
433	21	73	0	9	R	
488	29	73	0	1	N	
422	25	73	0	19	A	
523	39	73	0	9	R	
411	45	73	0	19	A	
419	50	73	0	18	A	
530	52	73	0	9	R	
538	61	73	0	1	N	
497	62	73	0	19	A	
481	44	73	0	1	N	
450	60	73	0	1	N	
541	77	73	0	9	R	
447	67	73	0	17	A	
553	63	75	0	0	I	
1340	38	176	0	0	I	
566	75	75	0	0	I	
1358	2014	176	0	0	I	
1367	15	176	0	0	I	
575	80	75	0	0	I	
1375	67	176	0	0	I	
1383	1	176	0	0	I	
1349	27	177	0	0	I	
585	57	85	0	0	I	
572	43	78	49	1	N	
593	42	85	0	0	I	
550	63	78	33	1	N	
559	71	78	64	1	N	
564	75	78	87	8	R	
602	65	85	0	0	I	
577	80	78	77	2	R	
608	41	85	0	0	I	
611	46	85	0	0	I	
1329	2021	170	0	0	N	
619	64	85	0	0	I	
563	75	76	0	14	A	
625	31	85	0	0	I	
552	63	76	0	0	N	
652	14	81	0	4	R	
649	22	81	0	0	N	
635	54	85	0	0	I	
604	41	81	0	7	R	
643	56	85	0	0	I	
616	46	81	0	5	R	
650	22	85	0	0	I	
688	96	81	0	0	N	
658	14	85	0	0	I	
636	54	81	0	17	A	
639	56	81	0	6	R	
665	47	85	0	0	I	
620	64	81	0	0	N	
671	74	85	0	0	I	
588	57	81	0	7	R	
676	37	85	0	0	I	
657	14	86	0	1	N	
645	22	86	0	1	N	
629	31	86	0	12	A	
685	66	85	0	0	I	
673	37	86	0	6	R	
638	56	86	0	12	A	
555	71	75	0	0	E	
573	43	75	0	0	E	
659	47	86	0	7	R	
680	66	86	0	1	N	
666	74	86	0	14	A	
687	96	88	0	1	N	
609	41	88	0	14	A	
590	42	88	0	14	A	
631	54	88	0	12	A	
610	46	88	0	14	A	
596	65	88	0	12	A	
586	57	88	0	12	A	
621	64	88	0	1	N	
654	14	87	0	0	N	
647	22	87	0	0	N	
675	37	87	0	0	N	
681	66	87	0	0	N	
624	31	87	0	2	R	
669	74	87	0	0	N	
662	47	87	0	0	N	
641	56	87	0	0	N	
603	41	89	0	10	R	
591	42	89	0	19	A	
634	54	89	0	11	R	
615	46	89	0	0	N	
582	57	89	0	4	R	
597	65	89	0	2	R	
617	64	89	0	0	N	
574	43	74	0	1	N	
551	63	74	0	5	R	
580	80	74	0	15	A	
565	75	74	0	17	A	
557	71	74	0	15	A	
655	14	83	0	1	N	
691	96	83	0	10	R	
651	22	83	0	1	N	
630	31	83	0	13	A	
674	37	83	0	9	R	
613	46	83	0	14	A	
589	42	83	0	12	A	
605	41	83	0	13	A	
664	47	83	0	12	A	
637	54	83	0	1	N	
587	57	83	0	13	A	
684	66	83	0	10	R	
644	56	83	0	12	A	
668	74	83	0	14	A	
601	65	83	0	12	A	
618	64	83	0	1	N	
648	22	82	0	1	N	
690	96	82	0	1	N	
653	14	82	0	1	N	
628	31	82	0	6	R	
594	42	82	0	16	A	
606	41	82	0	16	A	
614	46	82	0	16	A	
661	47	82	0	6	R	
679	37	82	0	4	N	
640	56	82	0	16	A	
633	54	82	0	16	A	
584	57	82	0	16	A	
599	65	82	0	16	A	
667	74	82	0	16	A	
683	66	82	0	5	R	
622	64	82	0	1	N	
547	63	77	0	9	N	
560	71	77	0	18	A	
568	43	77	0	19	A	
581	80	77	0	18	A	
562	75	77	0	18	A	
569	43	73	0	9	R	
558	71	73	0	17	A	
576	80	73	0	17	A	
549	63	73	0	1	N	
567	75	73	0	20	A	
693	96	85	0	0	I	
695	36	85	0	0	I	
706	27	85	0	0	I	
1350	8	176	0	0	I	
711	98	85	0	0	I	
1359	2015	176	0	0	I	
1368	34	176	0	0	I	
719	89	85	0	0	I	
1376	70	176	0	0	I	
728	15	85	0	0	I	
731	69	85	0	0	I	
1341	80	177	0	0	I	
1384	122	177	0	0	I	
1205	2117	168	0	0	N	
741	13	85	0	0	I	
749	3	85	0	0	I	
756	1	85	0	0	I	
760	20	85	0	0	I	
766	79	85	0	0	I	
774	48	85	0	0	I	
782	32	85	0	0	I	
789	59	85	0	0	I	
798	10	85	0	0	I	
1195	2097	168	0	13	A	
1198	2103	168	0	15	A	
1199	2105	168	0	16	A	
1200	2107	168	0	15	A	
832	2014	90	0	1	R	
1204	2115	168	0	16	A	
1203	2113	168	0	15	A	
1202	2111	168	0	13	A	
1196	2099	168	0	11	R	
1201	2109	168	0	14	A	
808	100	91	0	2	N	
739	13	81	0	5	R	
794	10	81	0	5	R	
726	15	81	0	0	N	
753	1	81	0	5	R	
712	98	81	0	0	N	
784	32	81	0	0	N	
771	48	81	0	0	N	
790	59	81	0	0	N	
723	15	86	0	13	A	
792	10	86	0	1	N	
708	98	86	0	1	N	
715	89	86	0	1	N	
694	36	86	0	7	R	
750	1	88	0	12	A	
736	13	88	0	1	N	
743	3	88	0	12	A	
757	20	88	0	1	N	
701	27	88	0	12	A	
773	48	88	0	1	N	
778	32	88	0	1	N	
764	79	88	0	14	A	
729	69	88	0	1	N	
787	59	88	0	1	N	
717	89	87	0	0	N	
725	15	87	0	0	N	
796	10	87	0	0	N	
697	36	87	0	0	N	
710	98	87	0	0	N	
752	1	89	0	1	R	
745	3	89	0	0	N	
692	96	89	0	0	N	
761	20	89	0	0	N	
783	32	89	0	0	N	
742	13	89	0	0	N	
776	48	89	0	0	N	
791	59	89	0	0	N	
702	27	89	0	3	R	
732	69	89	0	0	N	
829	117	91	0	2	R	
770	79	89	0	9	R	
827	113	91	0	4	R	
826	109	91	0	8	R	
804	2007	91	0	2	R	
831	2014	91	0	11	R	
813	99	91	0	17	A	
820	110	91	0	1	N	
805	2008	91	0	5	R	
836	2015	91	0	3	R	
802	127	91	0	1	N	
824	108	91	0	1	R	
816	2010	91	0	2	N	
833	106	91	0	1	N	
809	112	91	0	0	N	
822	2013	92	0	8	R	
811	2009	91	0	5	R	
754	1	83	0	14	A	
746	3	83	0	12	A	
720	89	83	0	1	N	
740	13	83	0	1	N	
722	15	83	0	12	A	
758	20	83	0	1	N	
795	10	83	0	12	A	
703	27	83	0	13	A	
781	32	83	0	11	R	
713	98	83	0	1	N	
772	48	83	0	1	N	
785	59	83	0	10	R	
730	69	83	0	1	R	
767	79	83	0	14	A	
699	36	83	0	11	R	
1197	2101	168	0	12	A	
803	2007	90	0	1	N	
806	2008	90	0	1	N	
814	99	90	0	1	N	
815	2010	90	0	1	N	
812	2009	90	0	1	N	
835	2015	90	0	1	R	
821	2013	90	0	12	A	
751	1	82	0	16	A	
748	3	82	0	16	A	
716	89	82	0	1	N	
737	13	82	0	3	N	
762	20	82	0	2	N	
797	10	82	0	1	N	
724	15	82	0	16	A	
779	32	82	0	1	N	
698	36	82	0	5	N	
709	98	82	0	1	N	
705	27	82	0	16	A	
788	59	82	0	1	N	
775	48	82	0	4	R	
733	69	82	0	4	R	
769	79	82	0	16	A	
800	2005	93	0	5	R	
818	2011	93	0	12	A	
817	95	93	0	0	N	
1360	110	176	0	0	I	
1369	2	176	0	0	I	
1377	109	176	0	0	I	
1342	50	177	0	0	I	
1351	75	177	0	0	I	
1385	47	177	0	0	I	
984	9	76	0	0	N	
994	2057	80	84	12	A	
837	2016	91	0	2	N	
986	9	78	31	1	N	
978	2069	76	0	0	N	
991	2057	76	0	0	N	
845	2018	92	0	3	N	
868	2035	93	0	16	A	
871	2036	92	0	0	N	
854	2023	92	0	3	R	
858	2026	92	0	3	R	
851	2019	92	0	8	R	
877	2041	92	0	11	R	
855	2024	92	0	17	A	
841	2017	92	0	0	N	
844	107	92	0	3	R	
849	2020	92	0	2	R	
839	104	92	0	2	R	
853	2022	92	0	17	A	
864	2030	92	0	11	R	
874	2039	92	0	1	N	
985	9	74	0	1	N	
996	2057	74	0	16	A	
846	2018	90	0	1	R	
863	2030	90	0	1	N	
875	2039	90	0	1	N	
852	2019	90	0	6	R	
838	2016	90	0	1	N	
878	2041	90	0	1	N	
857	2025	90	0	1	N	
842	2017	90	0	1	N	
972	2061	90	0	1	N	
879	2042	90	0	1	N	
974	2058	90	0	1	N	
848	2020	90	0	1	N	
859	2027	90	0	1	N	
865	2032	93	0	15	A	
884	2047	93	0	12	A	
885	2048	93	0	\N	N	
895	2028	93	0	6	R	
870	2036	93	0	\N	N	
886	2049	93	0	14	A	
869	2037	93	0	15	A	
872	2038	93	0	16	A	
894	2006	93	0	16	A	
862	2031	93	0	\N	N	
850	2021	93	0	14	A	
890	2052	93	0	13	A	
880	2043	93	0	8	R	
867	2034	93	0	13	A	
883	2046	93	0	13	A	
987	9	77	0	0	I	
988	9	75	0	0	I	
892	2054	93	0	\N	N	
861	2029	93	0	14	A	
993	2057	75	0	0	I	
873	2038	92	0	0	I	ESTUDIANTE YA PASO UNIDAD CURRICULAR (REVISAR)
856	2025	92	0	0	I	ESTUDIANTE YA PASO UNIDAD CURRICULAR (REVISAR)
889	2051	93	0	\N	N	
891	116	93	0	12	A	
866	2033	93	0	13	A	
887	2050	93	0	\N	E	
893	2044	93	0	14	A	
876	2040	93	0	8	R	
882	2045	93	0	0	N	
992	2057	79	0	16	A	
983	9	73	0	1	N	
995	2057	73	0	18	A	
1085	19	84	0	0	N	
1248	2112	170	0	5	R	
1009	37	162	0	19	A	
1007	2071	76	0	12	A	
1361	46	176	0	0	I	
1370	55	176	0	0	I	
1378	62	176	0	0	I	
1343	6	177	0	0	I	
1352	25	177	0	0	I	
1004	2070	76	0	0	N	
1067	121	76	0	0	N	
1090	5	84	0	15	A	
1071	6	84	0	16	A	
1080	8	84	0	16	A	
1069	13	84	0	0	N	
1084	12	84	0	0	N	
1092	16	84	0	18	A	
1159	104	82	0	0	N	no aparecia en mi lista
1087	25	84	0	18	A	
1073	36	84	0	0	N	
1072	37	84	0	0	N	
1082	39	84	0	0	N	
1083	40	84	0	18	A	
1141	2057	72	0	13	A	
1074	31	84	0	3	R	
1081	52	84	0	0	N	
1039	107	162	0	12	A	
1086	45	84	0	16	A	
1091	62	84	0	15	A	
1110	2069	72	0	0	N	
1077	64	84	0	0	N	
1070	71	84	0	14	A	
1088	43	84	0	0	N	
1089	75	84	0	19	A	
1076	79	84	0	14	A	
1079	47	84	0	8	R	PER
1132	2036	72	0	0	N	
1155	96	72	0	0	N	
1134	9	72	0	0	N	
1112	26	72	0	0	N	
1107	99	72	0	0	N	
1062	120	163	2	1	N	
1066	2061	163	20	2	N	
1156	46	72	0	12	A	
1037	2051	163	38	4	N	
1059	94	163	2	1	N	
1144	91	72	0	14	A	
1139	42	72	0	0	N	
1101	58	72	0	12	A	
1052	2042	163	27	3	N	
1143	67	72	0	14	A	
1106	2059	72	0	0	N	
1133	63	72	0	0	N	
1109	80	72	0	14	A	
1148	77	72	0	0	N	
1142	60	72	0	0	N	
1028	4	162	0	16	A	
1012	89	162	0	4	N	
1033	17	162	0	16	A	
1021	19	162	0	17	A	
1025	12	162	0	17	A	
1018	21	162	0	17	A	
1041	27	162	0	18	A	
1011	31	162	0	17	A	
1068	121	162	0	7	R	
1023	26	162	0	2	N	
1008	98	162	0	1	N	
1030	38	162	0	19	A	
1026	33	162	0	15	A	
1010	36	162	0	15	A	
1024	43	162	0	18	A	
1029	58	162	0	15	A	
1063	120	162	0	14	A	
1031	60	162	0	15	A	
1014	47	162	0	14	A	
1016	66	162	0	7	N	
1040	104	162	0	1	N	
1013	74	162	0	15	A	
1020	71	162	0	16	A	
1022	70	162	0	6	N	
1015	79	162	0	18	A	
1032	77	162	0	14	A	
1017	34	162	0	14	A	
1138	106	82	0	16	A	
1065	2048	163	2	1	N	
1057	7	163	38	3	N	
1064	2053	163	52	4	N	
1038	2070	163	36	3	N	
1051	2047	163	75	13	A	
1048	122	163	20	2	N	
1054	2046	163	72	12	A	
1053	2050	163	6	1	N	
1036	2044	163	81	14	A	
1154	1	72	0	13	A	
1136	4	72	0	13	A	
1145	17	72	0	17	A	
1147	21	72	0	16	A	
1108	38	72	0	13	A	
1153	41	72	0	13	A	
1152	57	72	0	13	A	
1140	70	72	0	6	R	PER
1075	27	84	0	10	R	PER
1078	33	84	0	12	A	
1093	50	84	0	14	A	
1027	6	162	0	18	A	
1035	39	162	0	2	N	
1019	80	162	0	15	A	
1362	57	176	0	0	I	
1371	56	176	0	0	I	
1379	90	176	0	0	I	
1353	71	177	0	0	I	
1386	77	177	0	0	I	
1388	7	177	0	0	I	
1390	65	177	0	0	I	
1391	2033	177	0	0	I	
1395	2036	177	0	0	I	
1325	2014	167	0	12	A	
1188	2083	168	0	0	N	
1396	2124	93	0	12	A	
1215	2091	169	0	0	N	
1219	2099	169	0	\N	N	
1207	2075	169	0	18	A	
1208	2077	169	0	14	A	
1209	2079	169	0	18	A	
1214	2089	169	0	12	A	
1206	2073	169	0	15	A	
1216	2093	169	0	14	A	
1212	2085	169	0	17	A	
1210	2081	169	0	18	A	
1218	2097	169	0	18	A	
1221	2103	169	0	19	A	
1217	2095	169	0	17	A	
1222	2105	169	0	18	A	
1213	2087	169	0	12	A	
1226	2113	169	0	18	A	
1220	2101	169	0	12	A	
1227	2115	169	0	18	A	
1225	2111	169	0	15	A	
1224	2109	169	0	18	A	
1223	2107	169	0	17	A	
1354	33	176	0	0	I	
1363	41	176	0	0	I	
1372	76	176	0	0	I	
1380	66	176	0	0	I	
1345	79	177	0	0	I	
1387	2057	177	0	0	I	
1389	104	177	0	0	I	
1392	2034	177	0	0	I	
1163	2079	167	0	12	A	
1306	3	167	0	1	R	
1305	114	167	0	12	A	
1304	105	167	0	12	A	
1323	101	167	0	12	A	
1165	2083	167	0	0	N	
1182	2117	167	0	0	N	
1173	2099	167	0	1	R	
1184	2075	168	0	17	A	
1319	4	168	0	15	A	
1185	2077	168	0	14	A	
1183	2073	168	0	13	A	
1187	2081	168	0	13	A	
1189	2085	168	0	12	A	
1186	2079	168	0	16	A	
1278	2080	172	0	12	A	
1190	2087	168	0	14	A	
1191	2089	168	0	12	A	
1193	2093	168	0	15	A	
1321	90	168	0	2	N	
1194	2095	168	0	13	A	
1192	2091	168	0	13	A	
1301	34	168	0	2	N	
1314	41	168	0	2	N	
1275	2074	172	0	17	A	
1277	2078	172	0	16	A	
1303	2036	172	0	0	N	
1296	2116	172	0	11	R	
1276	2076	172	0	16	A	
1161	2075	167	0	10	R	
1279	2082	172	0	15	A	
1282	2088	172	0	15	A	
1281	2086	172	0	12	A	
1310	32	172	0	14	A	
1283	2090	172	0	16	A	
1285	2094	172	0	17	A	
1284	2092	172	0	4	N	
1280	2084	172	0	12	A	
1286	2096	172	0	17	A	
1297	2118	172	0	18	A	
1289	2102	172	0	17	A	
1287	2098	172	0	15	A	
1290	2104	172	0	16	A	
1288	2100	172	0	11	R	
1292	2108	172	0	16	A	
1311	59	172	0	13	A	
1295	2114	172	0	16	A	
1294	2112	172	0	15	A	
1291	2106	172	0	14	A	
1293	2110	172	0	15	A	
1230	2076	170	0	4	R	
1316	117	170	0	2	R	
1318	109	170	0	4	R	
1231	2078	170	0	4	R	
1233	2082	170	0	4	R	
1232	2080	170	0	4	R	
1250	2116	170	0	4	R	
1235	2086	170	0	4	R	
1234	2084	170	0	4	R	
1237	2090	170	0	14	A	
1236	2088	170	0	14	A	
1238	2092	170	0	2	R	
1229	2074	170	0	4	R	
1317	108	170	0	4	R	
1239	2094	170	0	12	A	
1309	92	170	0	0	N	
1242	2100	170	0	3	R	
1240	2096	170	0	3	R	
1241	2098	170	0	4	R	
1247	2110	170	0	12	A	PER
1251	2118	170	0	17	A	
1315	112	170	0	0	N	
1243	2102	170	0	15	A	
1246	2108	170	0	4	R	
1228	2117	169	0	0	N	
1245	2106	170	0	4	R	
1249	2114	170	0	6	R	
1313	99	168	0	13	A	
1160	2073	167	0	2	R	
1164	2081	167	0	8	R	
1162	2077	167	0	3	R	
1167	2087	167	0	1	R	
1168	2089	167	0	1	R	
1170	2093	167	0	1	R	
1169	2091	167	0	11	R	
1312	106	167	0	1	N	
1172	2097	167	0	8	R	
1174	2101	167	0	1	R	
1171	2095	167	0	1	R	
1175	2103	167	0	1	R	
1302	42	167	0	12	A	
1307	122	167	0	1	N	
1176	2105	167	0	1	R	
1166	2085	167	0	4	R	
1179	2111	167	0	6	R	
1177	2107	167	0	8	R	
1178	2109	167	0	1	R	
1300	70	167	0	1	R	
1180	2113	167	0	1	R	
1181	2115	167	0	5	R	
1244	2104	170	0	12	A	PER
1211	2083	169	0	0	N	
1256	2082	171	0	12	A	
1262	2094	171	0	19	A	
1253	2076	171	0	12	A	
1273	2116	171	0	15	A	
1260	2090	171	0	18	A	
1259	2088	171	0	0	N	
1261	2092	171	0	0	N	
1308	92	171	0	0	N	
1254	2078	171	0	16	A	
1255	2080	171	0	16	A	
1267	2104	171	0	17	A	
1268	2106	171	0	19	A	
1269	2108	171	0	19	A	
1266	2102	171	0	15	A	
1263	2096	171	0	15	A	
1271	2112	171	0	15	A	
1265	2100	171	0	\N	N	
1257	2084	171	0	12	A	
1264	2098	171	0	17	A	
1270	2110	171	0	0	N	
1274	2118	171	0	19	A	
1272	2114	171	0	0	N	
1252	2074	171	0	19	A	
1258	2086	171	0	12	A	
\.


--
-- TOC entry 2115 (class 0 OID 17004)
-- Dependencies: 162
-- Data for Name: t_curso; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_curso (codigo, cod_periodo, cod_uni_curricular, cod_docente, seccion, fec_inicio, fec_final, capacidad, observaciones) FROM stdin;
87	102	6	88	2A	\N	\N	18	
89	102	6	88	2B	\N	\N	18	
12	101	1	84	01	\N	\N	40	
11	101	2	85	01	\N	\N	40	
13	101	3	86	01	\N	\N	40	
17	101	1	87	03	\N	\N	40	
19	101	2	85	03	\N	\N	40	
18	101	3	86	03	\N	\N	40	
15	101	1	84	02	\N	\N	40	
16	101	3	86	02	\N	\N	40	
14	101	2	87	02	\N	\N	40	
86	102	5	83	2A	\N	\N	18	
22	101	1	88	04	\N	\N	40	
88	102	5	83	2B	\N	\N	18	
93	102	4	87	4	\N	\N	34	
76	102	4	84	1	\N	\N	34	
73	102	8	2063	1	\N	\N	36	
81	102	4	84	2	\N	\N	36	
85	102	50	2066	2	\N	\N	36	
83	102	9	2065	2	\N	\N	35	
90	102	4	2067	3	\N	\N	34	
84	102	7	2072	2	\N	\N	25	
75	102	50	2066	1	\N	\N	36	
74	102	9	2065	1	\N	\N	36	
78	102	6	81	1A	\N	\N	18	
77	102	5	2063	1A	\N	\N	18	
80	102	6	81	1B	\N	\N	18	
79	102	5	2063	1B	\N	\N	18	
163	102	6	86	4A	\N	\N	18	
72	102	7	2072	1	\N	\N	25	
82	102	8	83	2	\N	\N	38	
162	102	1	87	E	2015-05-04	\N	32	Sección extraordinaria
91	102	6	88	3A	\N	\N	17	
92	102	6	88	3B	\N	\N	17	
168	102	2	2119	1	2015-11-16	\N	30	
172	102	2	2119	2	2015-11-16	\N	30	
169	102	3	2120	1	2015-11-16	\N	30	
171	102	3	2120	2	2015-11-16	\N	30	
167	102	1	2067	1	2015-11-16	\N	35	
170	102	1	84	2	2015-11-16	\N	35	
176	102	52	2123	2	\N	\N	30	
177	102	52	2123	1	\N	\N	30	
\.


--
-- TOC entry 2108 (class 0 OID 16896)
-- Dependencies: 154
-- Data for Name: t_docente; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_docente (codigo, cod_instituto, num_empleado, cod_estado) FROM stdin;
81	11	1011	A
82	11	\N	A
83	11	\N	A
84	11	999	A
85	11	9000	A
86	11	9002	A
87	11	9004	A
88	11	913	A
2063	11	\N	A
2064	11	\N	A
2065	11	\N	A
2066	11	\N	A
2067	11	\N	A
2068	11	1	A
2072	11	\N	A
2119	11	\N	A
2120	11	\N	A
2123	11	\N	A
\.


--
-- TOC entry 2116 (class 0 OID 17030)
-- Dependencies: 163
-- Data for Name: t_est_cur_estudiante; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_est_cur_estudiante (codigo, nombre) FROM stdin;
P	Preinscrito
I	Inscrito
C	Cursando
E	Retirado
A	Aprobado
R	Reprobado
N	Reprobado por inasistencia
\.


--
-- TOC entry 2107 (class 0 OID 16891)
-- Dependencies: 153
-- Data for Name: t_est_docente; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_est_docente (codigo, nombre) FROM stdin;
A	Activo
R	Retirado
J	Jubilado
\.


--
-- TOC entry 2109 (class 0 OID 16916)
-- Dependencies: 155
-- Data for Name: t_est_estudiante; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_est_estudiante (codigo, nombre) FROM stdin;
A	Activo
R	Retirado
C	Congelado
G	Graduado
\.


--
-- TOC entry 2104 (class 0 OID 16847)
-- Dependencies: 150
-- Data for Name: t_est_periodo; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_est_periodo (codigo, nombre) FROM stdin;
A	Abierto
C	Cerrado
\.


--
-- TOC entry 2113 (class 0 OID 16977)
-- Dependencies: 159
-- Data for Name: t_est_usu_con_estudios; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_est_usu_con_estudios (codigo, nombre) FROM stdin;
A	Activo
R	Retirado
J	Jubilado
\.


--
-- TOC entry 2111 (class 0 OID 16952)
-- Dependencies: 157
-- Data for Name: t_est_usu_enc_pensum; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_est_usu_enc_pensum (codigo, nombre) FROM stdin;
A	Activo
R	Retirado
J	Jubilado
\.


--
-- TOC entry 2124 (class 0 OID 33095)
-- Dependencies: 173
-- Data for Name: t_est_usu_ministerio; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_est_usu_ministerio (codigo, nombre) FROM stdin;
A	Activo
R	Retirado
J	Jubilado
\.


--
-- TOC entry 2110 (class 0 OID 16921)
-- Dependencies: 156
-- Data for Name: t_estudiante; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_estudiante (codigo, cod_instituto, cod_pensum, num_carnet, num_expediente, cod_rusnies, cod_estado) FROM stdin;
2073	11	1	\N	\N	\N	A
2075	11	1	\N	\N	\N	A
2077	11	1	\N	\N	\N	A
2079	11	1	\N	\N	\N	A
2081	11	1	\N	\N	\N	A
2085	11	1	\N	\N	\N	A
2087	11	1	\N	\N	\N	A
2089	11	1	\N	\N	\N	A
2091	11	1	\N	\N	\N	A
2093	11	1	\N	\N	\N	A
2095	11	1	\N	\N	\N	A
2097	11	1	\N	\N	\N	A
2099	11	1	\N	\N	\N	A
2101	11	1	\N	\N	\N	A
2103	11	1	\N	\N	\N	A
2105	11	1	\N	\N	\N	A
2107	11	1	\N	\N	\N	A
2109	11	1	\N	\N	\N	A
2111	11	1	\N	\N	\N	A
2113	11	1	\N	\N	\N	A
2115	11	1	\N	\N	\N	A
2117	11	1	\N	\N	\N	A
2074	11	1	\N	\N	\N	A
2076	11	1	\N	\N	\N	A
2078	11	1	\N	\N	\N	A
2080	11	1	\N	\N	\N	A
2082	11	1	\N	\N	\N	A
2086	11	1	\N	\N	\N	A
2088	11	1	\N	\N	\N	A
2090	11	1	\N	\N	\N	A
2092	11	1	\N	\N	\N	A
2094	11	1	\N	\N	\N	A
2096	11	1	\N	\N	\N	A
2098	11	1	\N	\N	\N	A
2100	11	1	\N	\N	\N	A
2104	11	1	\N	\N	\N	A
2106	11	1	\N	\N	\N	A
2108	11	1	\N	\N	\N	A
2110	11	1	\N	\N	\N	A
2112	11	1	\N	\N	\N	A
2114	11	1	\N	\N	\N	A
2118	11	1	\N	\N	\N	A
2083	11	1	\N	\N	\N	A
2084	11	1	\N	\N	\N	A
2102	11	1	\N	\N	\N	A
2116	11	1	\N	\N	\N	A
2121	11	1	\N	\N	\N	A
2122	11	1	\N	\N	\N	A
2124	11	1	\N	\N	\N	A
2034	11	1	\N	\N	\N	A
2035	11	1	\N	\N	\N	A
2036	11	1	\N	\N	\N	A
1	11	1	\N	\N	\N	A
2	11	1	\N	\N	\N	A
3	11	1	\N	\N	\N	A
4	11	1	\N	\N	\N	A
5	11	1	\N	\N	\N	A
6	11	1	\N	\N	\N	A
7	11	1	\N	\N	\N	A
8	11	1	\N	\N	\N	A
9	11	1	\N	\N	\N	A
10	11	1	\N	\N	\N	A
11	11	1	\N	\N	\N	A
12	11	1	\N	\N	\N	A
13	11	1	\N	\N	\N	A
14	11	1	\N	\N	\N	A
15	11	1	\N	\N	\N	A
16	11	1	\N	\N	\N	A
17	11	1	\N	\N	\N	A
18	11	1	\N	\N	\N	A
19	11	1	\N	\N	\N	A
20	11	1	\N	\N	\N	A
21	11	1	\N	\N	\N	A
22	11	1	\N	\N	\N	A
23	11	1	\N	\N	\N	A
24	11	1	\N	\N	\N	A
25	11	1	\N	\N	\N	A
26	11	1	\N	\N	\N	A
27	11	1	\N	\N	\N	A
28	11	1	\N	\N	\N	A
29	11	1	\N	\N	\N	A
30	11	1	\N	\N	\N	A
31	11	1	\N	\N	\N	A
32	11	1	\N	\N	\N	A
33	11	1	\N	\N	\N	A
34	11	1	\N	\N	\N	A
35	11	1	\N	\N	\N	A
36	11	1	\N	\N	\N	A
37	11	1	\N	\N	\N	A
38	11	1	\N	\N	\N	A
39	11	1	\N	\N	\N	A
40	11	1	\N	\N	\N	A
41	11	1	\N	\N	\N	A
42	11	1	\N	\N	\N	A
43	11	1	\N	\N	\N	A
44	11	1	\N	\N	\N	A
45	11	1	\N	\N	\N	A
46	11	1	\N	\N	\N	A
47	11	1	\N	\N	\N	A
48	11	1	\N	\N	\N	A
49	11	1	\N	\N	\N	A
50	11	1	\N	\N	\N	A
51	11	1	\N	\N	\N	A
52	11	1	\N	\N	\N	A
53	11	1	\N	\N	\N	A
54	11	1	\N	\N	\N	A
55	11	1	\N	\N	\N	A
56	11	1	\N	\N	\N	A
57	11	1	\N	\N	\N	A
58	11	1	\N	\N	\N	A
59	11	1	\N	\N	\N	A
60	11	1	\N	\N	\N	A
61	11	1	\N	\N	\N	A
62	11	1	\N	\N	\N	A
63	11	1	\N	\N	\N	A
64	11	1	\N	\N	\N	A
65	11	1	\N	\N	\N	A
66	11	1	\N	\N	\N	A
67	11	1	\N	\N	\N	A
68	11	1	\N	\N	\N	A
69	11	1	\N	\N	\N	A
70	11	1	\N	\N	\N	A
71	11	1	\N	\N	\N	A
72	11	1	\N	\N	\N	A
73	11	1	\N	\N	\N	A
74	11	1	\N	\N	\N	A
75	11	1	\N	\N	\N	A
76	11	1	\N	\N	\N	A
77	11	1	\N	\N	\N	A
78	11	1	\N	\N	\N	A
79	11	1	\N	\N	\N	A
80	11	1	\N	\N	\N	A
89	11	1	\N	\N	\N	A
90	11	1	\N	\N	\N	A
91	11	1	\N	\N	\N	A
92	11	1	\N	\N	\N	A
93	11	1	\N	\N	\N	A
94	11	1	\N	\N	\N	A
95	11	1	\N	\N	\N	A
96	11	1	\N	\N	\N	A
97	11	1	\N	\N	\N	A
98	11	1	\N	\N	\N	A
99	11	1	\N	\N	\N	A
100	11	1	\N	\N	\N	A
101	11	1	\N	\N	\N	A
102	11	1	\N	\N	\N	A
103	11	1	\N	\N	\N	A
104	11	1	\N	\N	\N	A
105	11	1	\N	\N	\N	A
106	11	1	\N	\N	\N	A
107	11	1	\N	\N	\N	A
108	11	1	\N	\N	\N	A
109	11	1	\N	\N	\N	A
110	11	1	\N	\N	\N	A
111	11	1	\N	\N	\N	A
112	11	1	\N	\N	\N	A
113	11	1	\N	\N	\N	A
114	11	1	\N	\N	\N	A
115	11	1	\N	\N	\N	A
116	11	1	\N	\N	\N	A
117	11	1	\N	\N	\N	A
118	11	1	\N	\N	\N	A
119	11	1	\N	\N	\N	A
120	11	1	\N	\N	\N	A
121	11	1	\N	\N	\N	A
122	11	1	\N	\N	\N	A
2037	11	1	\N	\N	\N	A
2038	11	1	\N	\N	\N	A
2039	11	1	\N	\N	\N	A
2040	11	1	\N	\N	\N	A
2041	11	1	\N	\N	\N	A
2005	11	1	\N	\N	\N	A
2006	11	1	\N	\N	\N	A
127	11	1	\N	\N	\N	A
2007	11	1	\N	\N	\N	A
2008	11	1	\N	\N	\N	A
2009	11	1	\N	\N	\N	A
2010	11	1	\N	\N	\N	A
2011	11	1	\N	\N	\N	A
2012	11	1	\N	\N	\N	A
2013	11	1	\N	\N	\N	A
2014	11	1	\N	\N	\N	A
2015	11	1	\N	\N	\N	A
2016	11	1	\N	\N	\N	A
2017	11	1	\N	\N	\N	A
2018	11	1	\N	\N	\N	A
2019	11	1	\N	\N	\N	A
2020	11	1	\N	\N	\N	A
2021	11	1	\N	\N	\N	A
2022	11	1	\N	\N	\N	A
2023	11	1	\N	\N	\N	A
2024	11	1	\N	\N	\N	A
2025	11	1	\N	\N	\N	A
2026	11	1	\N	\N	\N	A
2027	11	1	\N	\N	\N	A
2028	11	1	\N	\N	\N	A
2029	11	1	\N	\N	\N	A
2030	11	1	\N	\N	\N	A
2031	11	1	\N	\N	\N	A
2032	11	1	\N	\N	\N	A
2033	11	1	\N	\N	\N	A
2042	11	1	\N	\N	\N	A
2043	11	1	\N	\N	\N	A
2044	11	1	\N	\N	\N	A
2045	11	1	\N	\N	\N	A
2046	11	1	\N	\N	\N	A
2047	11	1	\N	\N	\N	A
2048	11	1	\N	\N	\N	A
2049	11	1	\N	\N	\N	A
2050	11	1	\N	\N	\N	A
2051	11	1	\N	\N	\N	A
2052	11	1	\N	\N	\N	A
2053	11	1	\N	\N	\N	A
2054	11	1	\N	\N	\N	A
2057	11	1	\N	\N	\N	A
2058	11	1	\N	\N	\N	A
2059	11	1	\N	\N	\N	A
2060	11	1	\N	\N	\N	A
2061	11	1	\N	\N	\N	A
2069	11	1	\N	\N	\N	A
2070	11	1	\N	\N	\N	A
2071	11	1	\N	\N	\N	A
\.


--
-- TOC entry 2128 (class 0 OID 66035)
-- Dependencies: 179
-- Data for Name: t_estudiante_temp; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_estudiante_temp (id, cedula, apellidos, nombres, sexo, discapacidad, condicion, anio, fec_ingreso, telefono1, telefono2, email, apellido1, apellido2, nombre1, nombre2, seccion) FROM stdin;
1	26546741	ACOSTA BOLIVAR	XAVIER EDEL	M	f	010	0	2015-09-22 00:00:00	(416)8172089	(416)4228239	xavieracosta1997@gmail.com	ACOSTA	BOLIVAR	XAVIER	EDEL	A
3	27031150	ALVAREZ GONZALEZ	LUIMAR ANDRE	M	f	011	0	2015-10-05 00:00:00	(021)8314975	(041)1563404	alvarezluimar47@hotmail.com	ALVAREZ	GONZALEZ	LUIMAR	ANDRE	A
5	24914191	BARRIOS PAREDES	VICENT JOSE	M	f	025	0	2015-10-15 00:00:00	(212)6817439	(412)8740233	vicentbarrios995@gmail.com	BARRIOS	PAREDES	VICENT	JOSE	A
7	26279030	BRACHO PICADO	CESAR LEONARDO	M	f	012	0	2015-10-15 00:00:00	(212)3220868	(426)1049736	cesarambo222@hotmail.com	BRACHO	PICADO	CESAR	LEONARDO	A
9	27302703	CONTRERAS URBINA	YORBI JESUS	M	f	010	0	2015-09-22 00:00:00	(414)2024802	(426)3102417	yorbijesuscontreras123@gmail.com	CONTRERAS	URBINA	YORBI	JESUS	A
13	25510702	GIMENEZ VELASCO	DANIEL ALEJANDRO	M	f	010	0	2015-09-22 00:00:00	(210)6817545	(412)2012584	daniel_velasco_1996@hotmail.com	GIMENEZ	VELASCO	DANIEL	ALEJANDRO	A
15	24520761	GOMEZ AYALA	DEYBER ENRIQUE	M	t	010	0	2015-09-28 00:00:00	(000)0000000	(416)4014665	deybermimo@gmail.com	GOMEZ	AYALA	DEYBER	ENRIQUE	A
17	25948336	GONZALEZ HIDALGO	CARLOS ALFREDO	M	f	011	0	2015-10-05 00:00:00	(212)3816600	(424)1509445	carlos_cagh15@hotmail.com	GONZALEZ	HIDALGO	CARLOS	ALFREDO	A
19	25825337	HIDALGO CARMARGO	CARLOS ANTONIO	M	f	012	0	2015-10-15 00:00:00	(212)2348887	(416)0976966	hidalgocarlos0612@gmail.com	HIDALGO	CARMARGO	CARLOS	ANTONIO	A
21	26409425	LANDAETA CHACON	CAMILO RAUL	M	f	012	0	2015-10-15 00:00:00	(212)6723546	(412)5644894	kmiilooxp@gmail.com	LANDAETA	CHACON	CAMILO	RAUL	A
23	25206298	MEDINA BARROSO	ENDRY JAVIER	M	f	010	0	2015-09-22 00:00:00	(426)4181964	(426)9096661	endry_hiphop15@yahoo.com	MEDINA	BARROSO	ENDRY	JAVIER	A
25	26217793	MENDOZA SANHUEZA	AUGUSTO GUILLERMO	M	f	010	0	2015-09-22 00:00:00	(424)2085242	(414)3358072	augusto_m98@hotmail.com	MENDOZA	SANHUEZA	AUGUSTO	GUILLERMO	A
27	24883016	MUJICA CABELLO	EDUARD JHOAN	M	f	025	0	2015-10-15 00:00:00	(212)7148309	(424)8955892	mujica.jhoan1996@hotmail.com	MUJICA	CABELLO	EDUARD	JHOAN	A
29	23712937	OCHOA LARTIGUEZ	HECTOR ANTONIO	M	t	010	0	2015-09-22 00:00:00	(212)4842028	(412)3809791	noralartiguez@hotmail.com	OCHOA	LARTIGUEZ	HECTOR	ANTONIO	A
31	25896865	QUINTANA LOVERA	DAHIRYARLETH DALESKA	F	f	010	0	2015-09-22 00:00:00	(212)3228513	(424)2293989	daydeydami@hotmail.com	QUINTANA	LOVERA	DAHIRYARLETH	DALESKA	A
33	26271931	RODRIGUEZ LUJANO-	JOSE RAFAEL	M	f	011	0	2015-10-05 00:00:00	(212)4324862	(412)9807789	jose_rodriguez121@hotmail.com	RODRIGUEZ	LUJANO-	JOSE	RAFAEL	A
35	27040324	SANCHEZ ARJONA	ASHLEY VANESSA	F	f	011	0	2015-10-05 00:00:00	(212)3641944	(416)6123096	ashleysanchez0510@gmail.com	SANCHEZ	ARJONA	ASHLEY	VANESSA	A
37	24901181	TARAZONA ALMEIDA	CARLOS AUGUSTO	M	f	010	0	2015-09-22 00:00:00	(212)5772552	(416)8101496	krlos_tarazona@hotmail.com	TARAZONA	ALMEIDA	CARLOS	AUGUSTO	A
39	27446164	USMA BARRIOS	RENZO NICOLAS	M	f	011	0	2015-10-13 00:00:00	(426)9015897	(416)3027957	renzousma98@gmail.com	USMA	BARRIOS	RENZO	NICOLAS	A
41	26498841	VIELMA GONZALEZ	JERISMAR SOFIA	F	f	011	0	2015-10-06 00:00:00	(212)3644895	(416)6238037	jerismarv@hotmail.com	VIELMA	GONZALEZ	JERISMAR	SOFIA	A
43	26111652	ZAPATA PARRA	ANYELIS YODARLIS	F	f	012	0	2015-10-15 00:00:00	(239)9954902	(412)5436816	anyelis_zp@hotmail.com	ZAPATA	PARRA	ANYELIS	YODARLIS	A
45	14214908	FERNANDEZ MARTINEZ	MERYURY DELMAR	F	f	020	0	2015-10-08 00:00:00	(212)3231162	(426)1054002	meryury@gmail.com	FERNANDEZ	MARTINEZ	MERYURY	DELMAR	A
2	25231567	ALAYON ZERPA	YOHENDER GREGORIO	M	f	012	0	2015-10-15 00:00:00	(212)8448636	(412)9583435	joezp1996@gmail.com	ALAYON	ZERPA	YOHENDER	GREGORIO	B
4	25867437	BARJAS OROZCO	ANDERSON JOSE	M	f	010	0	2015-09-22 00:00:00	(212)5199608	(412)3091283	andersonbarjas@hotmail.com	BARJAS	OROZCO	ANDERSON	JOSE	B
6	26725644	BAYONA VALDIVIESO	VALERIA NAZARETH	F	t	025	0	2015-10-15 00:00:00	(212)6133381	(416)1938184	bmbv11@gmail.com	BAYONA	VALDIVIESO	VALERIA	NAZARETH	B
8	19606571	CHACON PARRA	EBERT DAVID	M	f	011	0	2015-10-05 00:00:00	(212)6817575	(424)1223445	ebert7575@hotmail.com	CHACON	PARRA	EBERT	DAVID	B
10	25676438	CORREA TRIAS	ERIKSSON ALEXANDER	M	f	025	0	2015-10-15 00:00:00	(212)8165149	(424)2701388	erikssontrias83@gmail.com	CORREA	TRIAS	ERIKSSON	ALEXANDER	B
14	26078575	GODOY OJEDA	JOSE RAMON	M	f	011	0	2015-10-05 00:00:00	(021)8374065	(412)9507712	jose-ferrary@hotmail.com	GODOY	OJEDA	JOSE	RAMON	B
16	25840309	GOMEZ DELGADO	MICHAEL JOSE	M	f	010	0	2015-09-22 00:00:00	(212)3839059	(042)1124928	michajgd@gmail.com	GOMEZ	DELGADO	MICHAEL	JOSE	B
18	26952461	GUTIERREZ REVENGA	KATHERINE GIANNY	F	f	010	0	2015-09-22 00:00:00	(416)4057846	(414)2057590	katherineggutierrez@hotmail.com	GUTIERREZ	REVENGA	KATHERINE	GIANNY	B
20	25579875	HOBAICA PAREDES	MIGUEL ANDRES	M	f	025	0	2015-10-06 00:00:00	(212)3723313	(414)3223442	miguelhobaica11@gmail.com	HOBAICA	PAREDES	MIGUEL	ANDRES	B
22	18032156	LOPEZ NAVARRO	JOSE IGNACIO	M	f	012	0	2015-10-20 00:00:00	(212)3727056	(424)1648164	joseilopezn@hotmail.com	LOPEZ	NAVARRO	JOSE	IGNACIO	B
24	26180533	MENA DURAN	FRANCISCO JAVIER	M	f	010	0	2015-09-28 00:00:00	(212)3555056	(412)5435256	dact3rius69@hotmail.com	MENA	DURAN	FRANCISCO	JAVIER	B
26	27333426	MONGES NESSI	LUIS ALEJANDRO	M	f	011	0	2015-10-05 00:00:00	(212)6810521	(414)1276878	mongesluis14@gmail.com	MONGES	NESSI	LUIS	ALEJANDRO	B
28	21194419	NASR JAIMES	YORBELY ROSALIA	F	t	010	0	2015-09-22 00:00:00	(212)3737346	(416)3000790	yornasr@gmail.com	NASR	JAIMES	YORBELY	ROSALIA	B
32	26624056	RAMIREZ LARA	STALYN DANIEL	M	f	012	0	2015-10-15 00:00:00	(212)3226814	(412)2212217	stalyndaniel08@hotmail.com	RAMIREZ	LARA	STALYN	DANIEL	B
34	25774228	ROSALES GARCIA	ERICK ALEJANDRO	M	f	011	0	2015-10-05 00:00:00	(212)4726983	(424)2515141	erickalejandrorosales@hotmail.com	ROSALES	GARCIA	ERICK	ALEJANDRO	B
36	26921594	STROCCHIA HERNANDEZ	SAMUEL ALEJANDRO	M	f	013	0	2015-10-13 00:00:00	(212)3932123	(416)8339754	linkinhank@gmail.com	STROCCHIA	HERNANDEZ	SAMUEL	ALEJANDRO	B
38	27098844	URBINA VELEZ	JEREMY JOEL	M	f	011	0	2015-10-15 00:00:00	(021)3220420	(414)3680589	jeremyurbina@hotmail.com	URBINA	VELEZ	JEREMY	JOEL	B
40	26624385	VALERO FRANCO	JOSDAVIN VALERO	M	f	012	0	2015-10-15 00:00:00	(212)3211861	(424)2227329	elkincito_09@hotmail.com	VALERO	FRANCO	JOSDAVIN	VALERO	B
42	24041084	ZAMBRANO CONTRERAS	JONATHAN RENIER	M	t	010	0	2015-09-22 00:00:00	(212)8618582	(424)4263824	reni_zambrano@hotmail.com	ZAMBRANO	CONTRERAS	JONATHAN	RENIER	B
46	16679121	LUGO GOZALEZ	ALEXIS EDUARDO	M	f	020	0	2015-10-08 00:00:00	(212)5371055	(424)1284012	ras.alexislugo.i@hotmail.com	LUGO	GOZALEZ	ALEXIS	EDUARDO	B
11	20755583	DE DEFREITAS ANDRADE	ANGEL EDUARDO	M	f	011	0	2015-10-05 00:00:00	(212)6826351	(416)4262463	angel_18_9@hotmail.com	DE DEFREITAS	ANDRADE	ANGEL	EDUARDO	A
12	25869581	DIAZ	YONAIKER JOSE	M	f	025	0	2015-10-20 00:00:00	(412)3805582	(414)3230442	yonaikerdiaz54@gmail.com	DIAZ	\N	YONAIKER	JOSE	B
30	27370246	OROZCO HIDALGO	EDGLIS DEL CARMEN	F	f	025	0	2015-10-15 00:00:00	(212)8734354	(416)7929406	edglis__g.10@hotmail.com	OROZCO	HIDALGO	EDGLIS	DEL CARMEN	B
44	19560846	CHUNGA ABARCA	JEAN FRANCO BRYAN	M	f	020	0	2015-10-08 00:00:00	(212)8892026	(416)2396433	jeanfrancobryan@gmail.com	CHUNGA	ABARCA	JEAN	FRANCO BRYAN	B
\.


--
-- TOC entry 2118 (class 0 OID 17060)
-- Dependencies: 165
-- Data for Name: t_fotografia; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_fotografia (cod_persona, tipo, imagen) FROM stdin;
\.


--
-- TOC entry 2103 (class 0 OID 16830)
-- Dependencies: 149
-- Data for Name: t_instituto; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_instituto (codigo, nom_corto, nombre, direccion) FROM stdin;
11	IUTFRP	Instituto Universitario de Tecnología “Dr. Federico Rivero Palacio”	Km 8, Panamericana
12	CUC	Colegio Universitario de Caracas	Chacao
13	CULTCA	Colegio Universitario de Los Teques Cecilio Acosta	Km 23, Panamericana
14	IUTAG	Instituto Universitario de Tecnología Alonso Gamero	Parque Los Orumos
15	IUTOMS	Instituto Universitario de Tecnología del Oeste Mariscal Sucre	Antimano
16	CUFM	Colegio Universitario Francisco de Miranda	
17	CUJLPR	Colegio Universitario ProfesorJosé Lorenzo Pérez Rodríguez	
18	IUTAI	Instituto Universitario de Tecnología Agroindustrial	
19	IUTCABIMAS	Instituto Universitariode Tecnología de Cabimas	
20	IUTCARIPITO	Instituto Universitariode Tecnología de Caripito	
21	IUTCUMANA	Instituto Universitario de Tecnología de Cumaná	
22	IUTEB	Instituto Universitario de Tecnologíadel Estado Bolívar	
23	IUTEP	Instituto Universitario de Tecnologíadel Estado Portuguesa	
24	IUTET	Instituto Universitario de Tecnologíadel Estado Trujillo	
25	IUTL	Instituto Universitario de Tecnología de los Llanos	
26	IUTM	Instituto Universitario de Tecnología de Maracaibo	Maracaibo
27	IUTDELTA	Instituto Universitario de Tecnología Dr. Delfín Mendoza	Delta Amacuro
28	IUTJNV	Instituto Universitario de Tecnología Jacinto Navarro Vallenilla	Carupano
29	IUT-JAA	Instituto Universitario de Tecnología José Antonio Anzoategui	
30	IUTE	Instituto Universitario de Tecnología de Ejido	
31	IUTPC	Instituto Universitario de Tecnología de Puerto Cabello	Puerto Cabello
32	IUTVAL	Instituto Universitario de Tecnología de Valencia	Valencia
\.


--
-- TOC entry 2098 (class 0 OID 16762)
-- Dependencies: 144
-- Data for Name: t_pensum; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_pensum (codigo, nombre, nom_corto, observaciones) FROM stdin;
1	Programa Nacional de Formación Informática	PNFI	implementado en 2008
2	Programa nacional de formacion en administracion(LICENCIATURA)	PNFA	No Posee
3	PENSUM DE PRUEBA TECNOLO	PNFDPT	IMPLEMENTADO EN 2008
\.


--
-- TOC entry 2105 (class 0 OID 16852)
-- Dependencies: 151
-- Data for Name: t_periodo; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_periodo (codigo, nombre, cod_instituto, cod_pensum, fec_inicio, fec_final, observaciones, cod_estado) FROM stdin;
102	2015-2016	11	1	2015-03-02	2016-03-02		A
103	2000	11	3	2015-03-01	2015-03-31		A
101	2014-2015	11	1	2014-02-17	2015-12-05		C
\.


--
-- TOC entry 2106 (class 0 OID 16876)
-- Dependencies: 152
-- Data for Name: t_persona; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_persona (codigo, cedula, rif, nombre1, nombre2, apellido1, apellido2, sexo, fec_nacimiento, tip_sangre, telefono1, telefono2, cor_personal, cor_institucional, direccion) FROM stdin;
2002	123457	\N	Olivares	\N	Simon	\N	M	\N	\N	\N	\N	\N	\N	\N
2003	10000	\N	Usuario	\N	Informatica	\N	M	\N	\N	\N	\N	\N	\N	\N
2004	10001	\N	Usuario	\N	Informatica2	\N	M	\N	\N	\N	\N	\N	\N	\N
2001	123459	\N	Manuel	\N	Fernandez	\N	M	\N	\N	\N	\N	\N	\N	\N
8	24886638	12488663	CARLOS	eduardo	BOLIVAR	barrios	M	1996-11-24	O+	0212-3838974	0414-3054914	carlos_ebb@outlook.com	\N	fecha ingreso: 2014
6	25579242	\N	KEWIN	jose	BARBOZA	alvarez	M	1997-01-22	A+	\N	0424-2061338	kewinbarboza@gmail.com	\N	fecha ingreso: 2014
2	21132248	\N	ADRIAN	Antonio	ALBARRACIN	vieira	M	\N	A+	0212-2581143	0424-1140038	dinoxo@hotmail.com	\N	fecha ingreso: 2014
60	24286613	\N	JOSE	GREGORIO	ROJAS	UZCATEGUI	M	\N	O+	0212-3228472	0412-5777041	tenkuu17@gmail.com	\N	fecha ingreso: 2014
4	25516379	\N	MARCOS	DANIEL	AVILA	MORENO	M	\N	O+	0212-8414772	0412-6177085	marcosdavilam97@gmail.com	\N	fecha ingreso: 2014
5	25702779	\N	KYMBERLYN	yuliana	AVILAN	romero	F	1997-04-22	A+	0212-7413056	0416-7083603	kymberlyn_11@hotmail.com	\N	fecha ingreso: 2014
3	24885401	\N	ANDRY	JOSE	ARIAS	MORENO	M	\N	O+	0414-2399594	0424-2309733	an_arias1996@hotmail.com	\N	fecha ingreso: 2014
2005	19587797	\N	carlos	steven	martinez	molina	M	1991-12-01	N	04242608988	\N	sstevenfortune@gmail.com	\N	Los teques El Barbecho
2008	22667049	\N	ANTHONY	DAVID	LINARES	MUJICA	M	1995-05-25	O	04269172263	02128084767	los_ktfa@hotmail.com	\N	Km 35. Sector Cumbre Roja. Barrio Caña Larga. Estado Miranda
2011	21468468	\N	Jesús	Alberto	Ovalles	Rivas	M	1992-04-29	O	04125335858	\N	caknekdo@gmail.com	\N	Colinas de San Pedro
108	22694445	\N	JEFFERSON	ADRIAN	DIAZ	CORRALES	M	1994-11-29	O+	04122124672	\N	jead_diaz@hotmail.com	\N	Charallave. Estado Miranda
2014	25386349	\N	carlig 	joanny	calles	figueredo	F	1996-06-06	N	04262194216	\N	carlig56@gmail.com	\N	san antonio - picacho
2015	25716112	25716112-5	SINAI	GITANYALI	PIÑERO	ARANA	F	1996-03-29	N	04141113815	02123141266	sinaigitanyali@hotmail.com	\N	La Matica. Los Teques. Estado Miranda
2016	24723780	24723780-8	CARLOS	ALBERTO	LANDAETA	ROJAS	M	1995-10-12	A	04141733864	04166376325	carloslandaeta95@gmail.com	\N	Catia. Distrito Capital
2018	24464394	\N	Edinson	Johan	Alvarez	Goméz	M	1996-09-01	A	04143652702	\N	ejagforce@gmail.com	\N	Paracotos, Miranda
92	24462857	\N	MIKE	ANTHONY	GONZALEZ	DUARTE	M	1996-08-23	O+	04264005159	04129942191	ekimanthony1996@hotmail.com	\N	Parroquia Santa Teresa. Distrito Capital
2020	24697525	\N	Adriancys	Jesús	Villegas	Toro	M	1996-09-28	N	04126034086	02392125174	adriancysvillegast@gmail.com	\N	Valles del Tuy, Cua, Estado Miranda
2021	22048756	\N	jose	miguel	manrrique	daboin	M	1995-03-07	A	04268191111	02123213314	jmanriquedaboin@gmail.com	\N	sector el vigia- callejon calderon- los teques 
2022	21089422	21089422-1	FRANCHESKA	ANDREINA	RADA	DIAZ	F	1994-01-20	O	04268210054	02126723560	cskrada.fr@gmail.com	\N	El Valle. Distrito Capital
2023	24898458	248984585	Cesar	Alejandro	Cardenas	Aguinagalde	M	1994-08-30	N	04264044810	04166374507	c.l.l.c@hotmail.com	\N	Popatria, Caracas
2024	22667677	v-22667677-1	jose	david	brito	sansonetti	M	1994-09-15	A	04162159779	02126401317	david.brito0018@gmail.com	\N	los teques- los alpes
2025	21121102	\N	YOSMAR	JOSE	MARQUEZ	PERDOMO	M	1993-10-15	N	02124167260	04160138149	yosmarmarquez93@gmail.com	\N	Casco Central Los Teques. Estado Miranda
2026	19274723	\N	Daniel	Segundo	Muncibay	Gonzalez	M	1990-02-07	O	04122149992	02125510182	danielmuci12@hotmail.com	\N	San Bernardino, Caracas
2027	22540078	\N	gabriel	jesse	vazquez	osorio	M	1993-03-23	O	04122130836	02123836558	gjvo93@gmail.com	\N	carrizal- montaña alta
2028	20481769	20481769-0	FRAY	AGUSTIN	ALVAREZ	CASTRO	M	1990-10-27	O	04261068604	02392317707	alvarez.fry@gmail.com	\N	Urb. Vista Linda. Santa Teresa. Estado Miranda
2029	20748839	\N	Maykol	Adad	Riobueno	Ortiz	M	1991-05-02	O	04140204573	\N	maykoladad@gmail.com	\N	Los Teques, El Cabotaje, Av. Bertorelli
2030	21470449	\N	juan	carlos	carmona	Carlos	M	1992-06-29	A	04167644523	\N	nauj_carlos_1992@hotmail.com	\N	matica arriba cale federacionLos Teques
2031	20596696	\N	JOHAN	JESUS	FAJARDO	GARCIA	M	1991-05-16	O	04129626069	\N	johan.fajardo29@gmail.com	\N	Guatire. Estado Miranda
2032	24101206	\N	stephanie	Lisha	Alvarez	Lugo	M	1995-03-27	N/S	04264157742	02123641387	slal27@hotmail.com	\N	La Estrella, Los Teques
2033	21469345	\N	JOSE	JESUS	SANCHEZ	GONZALEZ	M	1994-10-20	A	04160112815	04127204685	chuo_751@hotmail.com	\N	La Matica. Los Teques. Estado Miranda
2034	23608372	\N	Jhorfrank	Mitchell	Perez	Blanco	M	1995-02-25	O	04122016864	04141353771	jhorfrank@hotmail.com	\N	Los Teques, El Encanto
2035	24087122	\N	FRANCI	ANDREINA	MOLINA	MESA	F	1994-10-23	A	04242035385	04262138947	fran_ci23@hotmail.com	\N	Catia. Distrito Capital
2036	23652815	\N	Ambar	Cris	Castro	Navas	F	1995-08-30	O	04241294674	02392125168	ambarprofesional@outlook.es	\N	VAlles del Tuy Urb La Morita Cua
2037	24286582	\N	Daniela	Dessiree	Bencomo	Diaz	F	1995-07-22	O	04140202389	02123643514	danielabencomo22@gmail.com	\N	Los Teques, Calle Guaicaipuro
2038	25896828	\N	WILLMBERT	JESUS ARTURO	HERNANDEZ	CARRILLO	M	1995-02-10	O	04241474723	04166363506	willmbert.h@hotmail.com	\N	Calle Guaicaipuro. Centro Los Teques. Estado Miranda
2039	18761086	\N	Carmen	Jasmin	Cedeño	Pacheco	F	1989-05-10	O	04164200801	\N	carmen_yasmin_88@hotmail.com	\N	La Pastora, Caracas
2040	21119846	\N	Gabriel	Antonio	Vegas	Gonzalez	M	1992-10-28	O	04141617058	02124902247	gabriel.vegas7@gmail.com	\N	El Solar de LA quinta edif 2D apto 2d44, Los Teques
2041	23782833	\N	Jeison	Alejandro	Peña	Lopez	M	1995-08-20	A	04122707817	\N	japl20_95@hotmail.com	\N	Los Teques, San Pedro
2042	23625597	\N	DANIEL	ALBERTO	TORRES	GONZALEZ	M	1993-08-17	A	04122088133	02123227748	daniel20_tg@gmail.com	\N	Los Teques. Santa Rosa. Estado Miranda
2043	22033729	\N	Genersis	Abixai	martinez	Prin	F	1995-05-11	O	04241038079	02128720591	prinj0611@hotmail.com	\N	Catia, Caracas
2044	25672909	\N	MARTIN	EDUARDO	SEMERIA	JIMENEZ	M	1996-05-09	A	04249401958	02123229062	alucardms56@gmail.com	\N	El Tambor. Los Teques
2045	24464560	\N	Ana	Betsabe	Rodriguez	Guerra	M	1994-08-18	N	04262050693	02124297387	betsa2009@gmail.com	\N	San Antonio de los Altos, Urb Polonias Nuevas Quinta MAria Nieves
2046	24315308	\N	Angelo	Adriano	Mendoza	Barrios	M	1995-10-25	A	04169062555	04241356655	angelo.adriano.mendoza.25@gmail.com	\N	El Valle, Caracas
2047	23778230	\N	DIANA	CAROLINA	ALTUVE	VALENZUELA	F	1995-11-22	O	02124340190	04163031262	caroldc777@gmail.com	\N	Las Adjuntas. Distrito Capital
2048	21468381	\N	Fernando	Jose	Avolio	Reyes	M	1993-11-06	A	04241068111	02128893200	ferzavolio@hotmail.com	\N	Los Teques, El Rincon casa
2049	24463298	\N	José	Alexander	Dias	Gonzalez	M	1995-12-26	N	04140131670	\N	alex.dias2612@gmail.com	\N	La Rosaleda Sur, San Antonio de Los Altos
2050	21091197	\N	GIOVANNI	EULISES	SOJO	PEÑA	M	1992-09-03	A	04242105594	04164111626	sojobk@gmail.com	\N	Carretera Charallave, Cua. Estado Miranda
2000	6972243	\N	Marcos	\N	Castro	\N	M	\N	\N	\N	\N	\N	\N	\N
7	25215291	\N	RICHARD	\N	BELENO	\N	M	\N	\N	(416)7143306	(426)2112927	richard2152010@hotmail.com	\N	fecha ingreso: 2014
12	25579898	\N	BHRANER	jousseff	CAÑAS	briceño	M	1997-09-20	O+	0212-3727617	0412-8218246	bhranerc@hotmail.com	\N	fecha ingreso: 2014
19	24205289	\N	LEIKER	douglas	GOMEZ	seyagos	M	\N	O+	0212-3732303	0424-1859806	leiker.dgs@gmail.com	\N	fecha ingreso: 2014
91	24523846	\N	ANDRES	jose	RODRIGUEs	fernandez	M	1994-07-13	O+	0212-6405990	0412-0192880	ajrf_24@hotmail.com	\N	\N
90	20562719	\N	ENRIQUE	jose	GONZALEZ	cardenas	M	1993-03-22	O+	0212-3521768	0426-5171695	kiq22_03@hotmail.com	\N	\N
26	25896656	\N	LUIS	mario	HERNANDEZ	campos	M	1997-10-11	O+	0212-3644893	0412-0193482	luis.mario19@hotmail.com	\N	fecha ingreso: 2014
25	25840024	\N	JHOYMAR	anais	GUZMAN	ortiz	F	1997-05-29	O+	0212-3838169	0424-2088809	jhoymarguzman97@hotmail.com	\N	fecha ingreso: 2014
21	22344254	\N	LUIS	LEONARDO	GONZALEZ	ARRIETA	M	\N	A+	0244-3320464	0412-8470486	luisleonardo_14@hotmail.com	\N	fecha ingreso: 2014
17	21467180	\N	FELIX	alejandro	FISNEDO	parra	M	1994-05-25	O+	0212-3234221	0424-1233363	felixalex_1@hotmail.com	\N	fecha ingreso: 2014
67	21622060	\N	JUAN	jose	SANTIAGO	pages	M	1994-08-22	O+	0212-3720208	0426-2210821	jjsantiago50@gmail.com	\N	fecha ingreso: 2014
18	25386679	\N	EDGAR	ALEXANDER	FUENTES	QUINONES	M	\N	O+	0212-8986673	0414-9210703	edgar_pelotero_53@hotmail.com	\N	fecha ingreso: 2014
29	22667812	\N	JOHAN	CARLOS	ISENA	PALMA	M	\N	A-	0212-6136147	0426-8119300	johan_isena@hotmail.com	\N	fecha ingreso: 2014
16	25896369	\N	FRANCO	ATILIO	COLMENAREZ	GARCIA	M	\N	N/S	0212-3224909	0412-3995488	francolmenagar2@hotmail.com	\N	fecha ingreso: 2014
65	24463384	\N	RICHARD	antonio	SANCHEZ	paul	M	1995-10-19	O+	0416-6296842	0416-7144551	rs_iut@hotmail.com	\N	fecha ingreso: 2014
64	24928045	\N	IZTEY DEL CARMEN	\N	SAAVEDRA	PEREZ	M	\N	O+	0212-4325728	0426-2879048	izteydelc@hotmail.com	\N	fecha ingreso: 2014
22	24278553	\N	KIMBERLY	ALEJANDRA	GONZALEZ	FERMIN	M	\N	O+	0212-2856076	0412-2966606	kimberlygonzalezf@hotmail.com	\N	fecha ingreso: 2014
27	24524100	\N	CRISTIAN	jesus	HERNANDEZ	hernandez	M	1995-09-18	O+	0212-3729704	0412-2873151	scris008@hotmail.com	\N	fecha ingreso: 2014
14	24218574	\N	ANA	gabriela	CESPEDES	orta	F	1995-07-22	O+	0212-3080240	0412-9347645	anagabriela.cespedes@hotmail.com	\N	fecha ingreso: 2014
98	21091195	\N	ALVER	JIOSE	LAYA	PEÑA	M	\N	N/S	0424-2144081	\N	\N	\N	\N
66	23689982	\N	YILBER	jesus	SANCHEZ	suarez	M	1994-05-08	AB+	0212-6826148	0412-9243311	yipo0426@hotmail.com	\N	fecha ingreso: 2014
2059	19659566	\N	KENNY	\N	SOLÓRZANO	\N	M	\N	N/S	04123823220	\N	kennysolo@gmail.com	\N	\N
87	4822028	\N	CARLOS	\N	CARRANZA	\N	M	\N	N/S	04265144031	\N	carranza58@gmail.com	\N	\N
89	19710678	\N	FRANCISCO	ANTONIO	BELLORIN	CIOFFI	M	\N	N/S	0416-7073978	0212-8735247	winner_1607@hotmail.com	\N	\N
9	25683254	\N	HANJORI BRIGITTE	\N	BRAVO	\N	F	\N	\N	(426)4062135	(426)4079093	hanjoribravo@hotmail.com	\N	fecha ingreso: 2014
83	13950317	\N	ODALIS	\N	DE SANTIAGO	\N	F	\N	A-	04143503084	\N	odalisdesantiago48@gmail.com	\N	\N
121	20745121	\N	ARTURO	JOSE	GOMEZ	ALGUERA	M	1993-05-18	A+	04126323849	02129351689	arturo_85000@hotmail.com	\N	San Antonio. Estado Miranda
96	27187937	\N	KEIMEC	ENRIQUE	COLMENAREZ	DELGADO	M	\N	N/S	\N	\N	\N	\N	\N
15	25626328	\N	ANDREW	miguel	CIOFFI	ruiz	M	\N	A+	0212-8711254	0414-1219450	cioffi_97@hotmail.com	\N	fecha ingreso: 2014
11	26739019	\N	CARLOS	\N	CABRERA	\N	M	\N	\N	(239)2484775	(412)2092925	carlosecl_420@hotmail.com	\N	fecha ingreso: 2014
111	21120479	\N	ALEXANDER	\N	ESCULPI	\N	M	\N	N/S	04129174493	\N	alexandermiguel06@hotmail.com	\N	\N
85	6843380	\N	MARBELLA	\N	CASTAÑEDA	\N	F	\N	N	\N	\N	\N	\N	\N
93	20290474	\N	KIARA	\N	RUIZ	\N	F	\N	\N	\N	\N	\N	\N	\N
97	19478775	\N	SIMON	\N	BELANDIA	\N	M	\N	\N	\N	\N	\N	\N	\N
101	18910926	\N	JOSE. L.	\N	GOMEZ	\N	M	\N	\N	\N	\N	\N	\N	\N
102	20413619	\N	CHRISTIAN	\N	BARRIOS	\N	M	\N	\N	\N	\N	\N	\N	\N
103	24886765	\N	ANTHONI	\N	MORENO	\N	M	\N	\N	\N	\N	\N	\N	\N
105	21377392	\N	AXEL	\N	NAVAS	\N	M	\N	\N	\N	\N	\N	\N	\N
114	21470514	\N	JESÙS	\N	BERMÙDEZ	\N	M	\N	\N	\N	\N	\N	\N	\N
115	21469109	\N	DANIEL	\N	ROJAS	\N	M	\N	\N	\N	\N	\N	\N	\N
118	20411185	\N	HUBER	\N	QUISPE	\N	M	\N	\N	\N	\N	\N	\N	\N
119	23691273	\N	GREGORY	\N	HERNANDEZ	\N	M	\N	\N	\N	\N	\N	\N	\N
13	26624428	\N	JANELY	karina	CARRILLO	silva	F	1997-12-10	A+	0212-3118050	0426-2170040	jesus-castillo-11@hotmail.es	\N	fecha ingreso: 2014
20	22540174	\N	CARLOS	EDUARDO	GONZALEZ	ALBARRAN	M	\N	O+	0212-3725430	0416-0141794	carlansor@gmail.com	\N	fecha ingreso: 2014
10	25948887	\N	ABRAHAN	ALEXANDER	BRITO	MOGOLLON	M	\N	A+	0414-2860527	0414-2860527	ABRAHANMOGOLLON@GMAIL.COM	\N	fecha ingreso: 2014
82	13728932	\N	LUIS	\N	MENDOZA	\N	M	\N	N/S	04264064248	\N	lm2014p@gmail.com	\N	\N
81	16148116	\N	JOHAN	\N	ALAMO	\N	M	\N	N/S	04166156819	\N	johan.alamo@gmail.com	\N	\N
127	20754390	\N	MARÍA	salome	MORALES	\N	F	1993-07-21	O+	04263193622	\N	mariasalome093@hotmail.com	\N	Santa Eduvigis Caracas
2006	25237827	\N	JOSE	MANUEL	FRANCO	HERNANDEZ	M	1995-01-27	O	02123838212	04143168551	jose2711995@hotmail.es	\N	Lomas de Urquia. Carrizal. Estado Miranda
100	24591520	\N	LEXANDRA	\N	YANEZ	ramirez	F	1995-03-02	A+	04120901062	02128811639	ramirezlexa@gmail.com	\N	Altagracia, Caracas
112	26125500	\N	OSCAR	OMAR	ROA	GUERRERO	M	1994-10-01	O+	04165301329	04142993464	oscomar_roa@hotmail.com	\N	\N
2009	23610504	\N	IRVIN	ALEJANDRO	SANTANA	CASTRO	M	1996-04-13	A	04164210525	04142378220	irviinalejandro96@gmail.com	\N	Caricuao. UD 3. Dtto Capital
99	20430078	\N	CARLOS	julio	GONZALEZ	\N	M	1993-01-26	A+	04241959735	02123227748	carlos.jg_18@hotmail.com	\N	los teques- santa rosa
95	19014886	\N	EDUARDO	JESUS	PARISCA	RIVAS	M	1989-08-12	O+	04241256643	02123236370	eduardo_00712@live.com	\N	Cabotaje. Los Teques. Estado Miranda
110	21091754	\N	OSMAR	anselmo	IBAÑEZ	de santiago	M	1992-08-31	O+	04149007832	02129420451	oswamorocho@hotmail.com	\N	\N
2012	19388228	\N	Eric	Alexis	Diaz	Rivas	M	1988-02-19	N/S	04129887064	\N	ericdiaz19@hotmail.com	\N	Los Teques, Municipio Guaicaipuro
109	22905285	\N	DANIEL	josé	CEDRE	caro	M	1995-06-15	O+	04263132778	\N	cedredaniel@gmail.com	\N	La Mata, Los Teques
117	22025926	\N	CARLOS	ALBERTO	BELISARIO	CALDERON	M	1995-06-20	A+	04129030670	04129644486	carlosbelisario35@hotmail.com	\N	Km 5. El Junquito. Distrito Capital
107	24998528	\N	MIGUEL	GADIEL	VENTURA	RODRIGUEZ	M	1996-09-21	A+	04262184934	02122750970	miguelgadielv@hotmail.com	\N	Lagunetica. Estado Miranda
122	24997618	\N	LUIS	Alfredo	RANGEL	CAstillo	M	1995-03-21	O+	04120130537	\N	luis.rangel2103@gmail.com	\N	Carret Panamericana km 41 calle ppal jabillal
125	22667832	\N	HECTOR	ALEJANDRO	ZEA	\N	M	\N	N	\N	\N	hector	\N	LOS TEQUES
23	24183908	\N	JUAN	\N	GONZALEZ	\N	M	\N	\N	(424)2403701	(426)1964591	chachi28_@hotmail.com	\N	fecha ingreso: 2014
24	22874136	\N	HERWIN	\N	GUARIMAN	\N	M	\N	\N	(424)1310107	(416)0840316	herwin_x_159@hotmail.com	\N	fecha ingreso: 2014
28	25932406	\N	OLIVER	\N	HERRERA	\N	M	\N	\N	(212)2983870	(426)5191670	xdcoxnordx@gmail.com	\N	fecha ingreso: 2014
30	25369363	\N	JOBRIAN	\N	JASPE	\N	M	\N	\N	(212)3834763	(414)4660212	jobrianjesus@hotmail.com	\N	fecha ingreso: 2014
49	25579083	\N	LUIS	\N	PEREIRA	\N	M	\N	\N	(212)3231196	(414)1534200	luispereira.aa.aa.aa@hotmail.com	\N	fecha ingreso: 2014
51	21470095	\N	YOEGLIS DEL CARMEN	\N	PERNIA	\N	F	\N	\N	(416)6008469	(414)6550830	yo-e-glis16@hotmail.com	\N	fecha ingreso: 2014
53	25236932	\N	ALFREDO	\N	PORRAS	\N	M	\N	\N	(212)3235338	(424)1718833	ajp_ra21@hotmail.com	\N	fecha ingreso: 2014
68	24998099	\N	LUIS	\N	SILVA	\N	M	\N	\N	(212)3210502	(414)3177367	l.a.s.b.96@hotmail.com	\N	fecha ingreso: 2014
72	21121250	\N	ERNESTO	\N	TORREALBA	\N	M	\N	\N	(212)3728479	(424)1557855		\N	fecha ingreso: 2014
73	25252577	\N	HERIBERTH	\N	TOVAR	\N	M	\N	\N	(212)6727091	(426)7161809	heriberth14@hotmail.com	\N	fecha ingreso: 2014
78	26687114	\N	AXELLYNG	\N	VERGEL	\N	F	\N	\N	(426)8178278	(426)5209882	giosely_ledezma@hotmail.com	\N	fecha ingreso: 2014
35	22909143	\N	ANGEL	\N	LOPEZ	\N	M	\N	N/S	0212-6811798	0412-6997489	ilusiondream_angel@hotmail.com	\N	fecha ingreso: 2014
40	25594817	\N	ROMMEL	omar	MONTOYA	rodriguez	M	1997-01-16	O+	0212-6357260	0414-4666342	rommelmontoya97@gmail.com	\N	fecha ingreso: 2014
58	24774216	\N	RAFAEL	jose	RODRIGUEZ	martinez	M	1995-09-19	O+	0212-6810230	0141-0174278	rafael_rodriguezve@hotmail.com	\N	fecha ingreso: 2014
38	25231066	\N	JOSE	rafael	MENDEZ	vasquez	M	1996-10-08	A+	0212-6429997	0412-8267915	josemendez810@gmail.com	\N	fecha ingreso: 2014
33	23643645	\N	ALEJANDRO	javier	LEON	bolaño	M	1995-11-27	A+	0212-3838995	0412-6013229	oniceoner@gmail.com	\N	fecha ingreso: 2014
70	19931246	\N	KERBY	richard	TABARES	olmedo	M	1991-09-16	O+	0212-3642445	0414-9046770	krtabares@gmail.com	\N	fecha ingreso: 2014
34	23637639	\N	BRAIAM	\N	LINARES	\N	M	\N	N/S	0416-4252411	0414-2376548	BM25LB03@GMAIL.COM	\N	fecha ingreso: 2014
55	24204646	\N	JOSE	ENRIQUE	QUIROZ	GONZALEZ	M	\N	O+	0212-4904394	0424-2880238	joseequirozg96@hotmail.com	\N	fecha ingreso: 2014
45	25702416	\N	STEFANY	julieth	OROPEZA	jaimes	M	\N	O+	0212-3210291	0426-4059820	stefanny_julieth_2007@hotmail.com	\N	fecha ingreso: 2014
50	25967667	\N	ALEJANDRO	\N	PEREYRA	LEAL	M	\N	O+	0212-3724179	0424-8056251	ale_pereyra97@hotmail.com	\N	fecha ingreso: 2014
76	21469234	\N	NEUMAN	sandino	UZCATEGUI	garcia	M	1993-09-17	O+	\N	0141-1329126	neuman007elkid@gmail.com	\N	fecha ingreso: 2014
44	25976281	\N	MARIA	fernanda	NORIEGA	gutierrez	F	1997-02-25	O+	0212-3834379	0414-2128061	mariafernanda_815@hotmail.com	\N	fecha ingreso: 2014
62	25702958	\N	KRISBELL	leonergi	ROMERO	barreto	F	1997-09-10	A+	0212-7413056	0426-9043906	krisbellrjb@gmail.com	\N	fecha ingreso: 2014
39	25896950	\N	ALEJANDRO	jose	MOLERO	dun	M	1997-12-09	O+	0212-3642540	0426-9033199	alejandromolero09@hotmail.com	\N	fecha ingreso: 2014
52	26078380	\N	CHRISTIAN	HIGDALIAS	POLANCO	ALTUVE	M	\N	O+	0212-3223365	0416-9163947	christian_9b3@hotmail.com	\N	fecha ingreso: 2014
61	24462558	\N	LOLI	jacqueri	ROJAS	zuniaga	F	1996-07-27	O+	0424-2435770	0414-2865618	lolirojas16@hotmail.com	\N	fecha ingreso: 2014
77	19931786	\N	ROBERT	JUVENAL	VELASQUEZ	QUINTERO	M	\N	N/S	0212-3235229	0412-0192378	flocmusic_646@hotmail.com	\N	fecha ingreso: 2014
63	26272734	\N	YORJHANA	nazareth	RUIZ	malave	F	1998-03-16	O+	0212-4431379	0424-2707012	yorjhananrm@hotmail.com	\N	fecha ingreso: 2014
71	25386797	\N	JUAN	LEANDRO	TEIXEIRA	DA SILVA	M	\N	N/S	0212-3236062	0414-2922811	tdsjl@hotmail.com	\N	fecha ingreso: 2014
75	25237682	\N	ODALYS	dayana	URBINA	serrano	F	1996-10-07	O+	0212-9153042	0416-0126420	odaliitaz_14@hotmail.com	\N	fecha ingreso: 2014
43	25579438	\N	ALICIA	DESIREE	MORENO	RAMIREZ	M	\N	N/S	0424-2720778	0426-9211116	aliciamorenosni@hotmail.com	\N	fecha ingreso: 2014
80	24671815	\N	LEANDRO	tomas	VILORIA	flores	M	1995-04-10	A+	0239-2487936	0424-2781356	leandro_tomas_viloria@hotmail.com	\N	fecha ingreso: 2014
57	26283492	\N	EVERLIN	KATIHUSKA	REYES	PADRINO	M	\N	A+	0412-2094514	0412-2036849	kati.reyes@hotmail.com	\N	fecha ingreso: 2014
42	24524502	\N	NESTOR	MANUEL	MORENO	AVILA	M	\N	O+	0212-3281801	0416-9054276	tfd_nestor16@hotmail.com	\N	fecha ingreso: 2014
41	26284010	\N	JOSE	MANUEL	MORALES	JIMENEZ	M	\N	O+	0424-1084444	0424-1450633	darkgastry@hotmail.com	\N	fecha ingreso: 2014
46	25639865	\N	ENGERHARD	alexander	PACHECO	guitierrz	M	1997-07-25	O+	0212-4423180	0426-1906001	engelhard25@hotmail.com	\N	fecha ingreso: 2014
31	25510149	\N	VICTOR	jonmir	LARA	brito	M	1996-04-30	O+	0212-8724980	0426-6100685	isjonmlr@hotmail.com	\N	fecha ingreso: 2014
54	25976863	\N	LUIS	ANGEL	PORTILLO	AREVALO	M	\N	O+	0244-3210532	0412-1493314	luisangeljo@hotmail.com	\N	fecha ingreso: 2014
56	23607963	\N	ROSA	franyesca	RESPLANDOR	luna	F	1995-08-30	O+	0212-4316126	0424-2577509	franyeska_resplandor@hotmail.com	\N	fecha ingreso: 2014
47	24933891	\N	JONAIKER	JOSE	PATIÑO	ANZOLA	M	\N	O+	0212-6819449	0424-6879404	jonaikerpowers@hotmail.com	\N	fecha ingreso: 2014
113	23192057	\N	DIEGO	Armando	CABALLERO	Escalona	M	1995-05-23	N/S	04128068386	\N	kballerodiego@gmail.com	\N	Catia, Caracas
37	24900144	\N	MANUEL	ALEJANDRO	MAURERA	PALACIOS	M	\N	A+	0212-5161282	0426-4189615	manuelmaurera@hotmail.com	\N	fecha ingreso: 2014
36	25252504	\N	FRAYBERT	FRANCISCO	MACHILLANDA	PERDOMO	M	\N	O+	0212-6415938	0426-3623737	fraybert_34_12@hotmail.com	\N	fecha ingreso: 2014
1	26323516	\N	JOSE	jesus	ADAMES	oropeza	M	1996-10-06	N/S	0212-4357483	0414-1362234	josejesus1996_6@hotmail.com	\N	fecha ingreso: 2014
69	23950826	\N	KIRVING	JESUS	SOMARRIBA	SALAZAR	M	\N	N/S	0212-4438471	0414-3392648	kirvingsomarriba@hotmail.com	\N	fecha ingreso: 2014
48	26343663	\N	RICHARD	jesus	PEÑA	peña	M	1997-09-11	A+	0212-3938183	0416-2043069	richardpena1997@hotmail.com	\N	fecha ingreso: 2014
79	25278612	\N	CLEN	JHONDAYKER	VIELMA	CAMACHO	M	\N	A+	0212-3737819	0424-9276991	CLENVIELMA@GMAIL.COM	\N	fecha ingreso: 2014
59	25896319	\N	MARIO	ali	RODRIGUEZ	urbina	M	1997-10-30	A+	\N	0426-4098044	mario_urbina10@hotmail.com	\N	fecha ingreso: 2014
32	27042856	\N	ESTEBAN	ALFREDO	LARA	DOMINGUEZ	M	\N	A+	0212-3280389	0414-8522507	soladiadominguez1962@gmail.com	\N	fecha ingreso: 2014
2007	22785229	\N	Joseph	daniel	Gallardo	gonzalez	M	1994-10-19	A	04241804186	\N	daniel._.12@hotmail.com	\N	Los Teques, El Vigia
2010	22282022	\N	Kiara	emperatriz	Salcedo	infante	F	1994-11-20	A	04122517764	02123726171	kiarasalcedo599@gmail.com	\N	Rosaleda Sur, San Antonio de Los Altos
2013	20614839	\N	JUNIOR	ALBERTO	PEREZ	GARCIA	M	1993-12-06	A	04168149051	02128634593	juniior_pk@hotmail.com	\N	Calle principal del Manicomio. Distrito Capital
106	25639748	\N	KEVIN	Andrés	MEDINA	Mejías	M	1996-02-07	A+	04242276509	\N	fneris_m@hotmail.com	\N	Carrizal, Los Teques
104	24407267	\N	ZADQUIEL	alejandro	RICAURTE	benitez	M	1996-10-22	O+	04125976916	02399956664	zadquiel_zr@outlook.com	\N	santa teresa del tuy- miranda
2017	24410044	\N	Yoelvis	David	Sarmiento	Montilla	M	1995-06-09	N	\N	\N	yoelvis.yds@gmail.com	\N	San Antonio de Los Altos, El Sitio
2019	25231056	\N	samuel	david	martinez	castejon	M	1996-10-01	O	04129377240	02123730014	samuel_jet_96@outlook.com	\N	san antonio de los altos - miranda
2051	24285694	\N	Pedro	José	Rondón	Linares	M	1995-05-20	O	04129287076	04164018441	pedro.rondon0518@gmail.com	\N	Los Lagos parte alta, Los Teques
2052	22350085	\N	RAMON	JESUS	MARTINEZ	OLIVARI	M	1994-10-25	O	04262209279	02126387677	ramonmarto@gmail.com	\N	Los Teques, Carrizal. Estado Miranda
2053	21536580	\N	Cristian	jose	chiquito	chiquito	M	1992-09-28	O	04262834380	\N	cssyiut123@gmail.com	\N	CAracas, Brisas de Propatria
116	19508757	\N	FRANCISCO	Xavier	RODRIGUEZ	Chacón	M	1990-09-26	A+	04242134090	02128583848	frank90_xavier@hotmail.com	\N	23 de Enero, Caracas
2054	21375417	\N	Astrid	Carolina	Alvarez	\N	F	\N	N	04166982736	\N	\N	\N	Los Teques, La Rosaleda
2055	6240502	\N	ELENA	BEATRIZ	VILLALBA	FERNANDEZ	F	1967-01-16	A	04265149663	02124838786	ebvillalba88@gmail.com	\N	Caracas
2058	19586147	\N	JOSÉ	GREGORIO	VASCONCELOS	YEPEZ	M	1991-10-17	N/S	04127073756	\N	rmadrid_98@hotmail.com	\N	\N
2057	21200752	\N	GABRIEL	\N	BRACAMONTE	\N	M	\N	N/S	\N	\N	gabobrako@gmail.com	\N	Viene por traslado (según alexis mola)
2062	25846828	\N	WIMBER	\N	HERNANDEZ	\N	M	\N	N/S	\N	\N	\N	\N	\N
2063	12187525	\N	NORKA	\N	PARELES	\N	F	\N	N	04162148922	\N	npareles@gmail.com	\N	\N
86	6524216	\N	RICHARD	\N	GÓMEZ	\N	M	\N	N/S	04129835230	\N	rcgc@hotmail.com	\N	\N
2064	17559834	\N	OSCAR	\N	MENDOZA	\N	M	\N	N	\N	\N	oscardmendoza@gmail.com	\N	\N
2065	11028233	\N	JESUS	\N	GUTIERREZ	\N	M	\N	N/S	04168079889	\N	jeantgutierrez@gmail.com	\N	\N
88	14196922	\N	ROXYDEL	\N	DULCEY	RANGEL	M	\N	N/S	04168033676	\N	roxydeld@gmail.com	\N	\N
2066	11672531	\N	GIAN	MARCOS	WARACAO	\N	M	\N	N	04265182119	\N	gianmarcos77@yahoo.com	\N	\N
84	5836636	\N	PEDRO	JOSÉ	BALZA	SALAS	M	\N	N/S	04265167072	\N	pedro.balza@ucv.ve	\N	\N
2060	20652562	\N	DAIRON	YORVIZ	MORENO	SOTO	M	1991-11-01	N/S	04242027633	\N	yorviz_750@hotmail.com	\N	\N
2068	6721252	\N	BETZAIDA	INMACULADA	ROMERO	INFANTE	F	1970-12-19	N	04265194613	02129851057	abril231@yahoo.es	\N	CARACAS- LOS NARANJOS
74	21014944	\N	JUAN 	jose	TOVAR	vazquez	M	1991-09-02	N/S	0212-8985578	0412-2061163	juanjtovar1991@gmail.com	\N	fecha ingreso: 2014
120	20095483	\N	GIORDANYS	ROBERTO	MOLD	RAMOS	M	1991-06-29	N/S	04269128431	02124298390	mozart693@hotmail.com	\N	San Antonio. El Valle. Distrito Capital
2069	20304417	\N	JEFFERSON	STEVENS	ARRAIZ	ALTUVE	M	1991-12-24	N	04166269272	\N	jefferson2030@gmail.com	\N	\N
2061	23640496	\N	YEREMI	\N	GONZÁLEZ	\N	M	\N	N/S	\N	\N	yerejbg@gmail.com	\N	\N
94	27207513	\N	CRISTHIAN	ALFONSO	SALOM	BRICEÑO	M	1997-05-26	N/S	0424-2150235	\N	christianalfonso710@hotmail.com	\N	LOS TEQUES - CARRIZAL - MONTAÑA ALTA
2070	20328783	\N	OSCAR	EDUARDO	DAVILA	MONTILLA	M	1992-08-13	N	04143227833	\N	oscar_davila1@hotmail.com	\N	\N
2071	19194367	\N	RUBEN	DARIO	ARROYO	MADERA	M	1988-09-24	N	04169207623	\N	gatonegro_cat@hotmail.com	\N	\N
2072	4773940	\N	CARLOS	\N	LANDAZABAL	\N	M	\N	\N	0416-9150749	\N	cjlr3110@gmail.com	\N	\N
2073	26546741	\N	XAVIER	EDEL	ACOSTA	BOLIVAR	M	\N	\N	(416)8172089	(416)4228239	xavieracosta1997@gmail.com	\N	\N
2075	27031150	\N	LUIMAR	ANDRE	ALVAREZ	GONZALEZ	M	\N	\N	(021)8314975	(041)1563404	alvarezluimar47@hotmail.com	\N	\N
2077	24914191	\N	VICENT	JOSE	BARRIOS	PAREDES	M	\N	\N	(212)6817439	(412)8740233	vicentbarrios995@gmail.com	\N	\N
2079	26279030	\N	CESAR	LEONARDO	BRACHO	PICADO	M	\N	\N	(212)3220868	(426)1049736	cesarambo222@hotmail.com	\N	\N
2081	27302703	\N	YORBI	JESUS	CONTRERAS	URBINA	M	\N	\N	(414)2024802	(426)3102417	yorbijesuscontreras123@gmail.com	\N	\N
2085	25510702	\N	DANIEL	ALEJANDRO	GIMENEZ	VELASCO	M	\N	\N	(210)6817545	(412)2012584	daniel_velasco_1996@hotmail.com	\N	\N
2087	24520761	\N	DEYBER	ENRIQUE	GOMEZ	AYALA	M	\N	\N	(000)0000000	(416)4014665	deybermimo@gmail.com	\N	\N
2089	25948336	\N	CARLOS	ALFREDO	GONZALEZ	HIDALGO	M	\N	\N	(212)3816600	(424)1509445	carlos_cagh15@hotmail.com	\N	\N
2091	25825337	\N	CARLOS	ANTONIO	HIDALGO	CARMARGO	M	\N	\N	(212)2348887	(416)0976966	hidalgocarlos0612@gmail.com	\N	\N
2093	26409425	\N	CAMILO	RAUL	LANDAETA	CHACON	M	\N	\N	(212)6723546	(412)5644894	kmiilooxp@gmail.com	\N	\N
2095	25206298	\N	ENDRY	JAVIER	MEDINA	BARROSO	M	\N	\N	(426)4181964	(426)9096661	endry_hiphop15@yahoo.com	\N	\N
2097	26217793	\N	AUGUSTO	GUILLERMO	MENDOZA	SANHUEZA	M	\N	\N	(424)2085242	(414)3358072	augusto_m98@hotmail.com	\N	\N
2099	24883016	\N	EDUARD	JHOAN	MUJICA	CABELLO	M	\N	\N	(212)7148309	(424)8955892	mujica.jhoan1996@hotmail.com	\N	\N
2101	23712937	\N	HECTOR	ANTONIO	OCHOA	LARTIGUEZ	M	\N	\N	(212)4842028	(412)3809791	noralartiguez@hotmail.com	\N	\N
2103	25896865	\N	DAHIRYARLETH	DALESKA	QUINTANA	LOVERA	F	\N	\N	(212)3228513	(424)2293989	daydeydami@hotmail.com	\N	\N
2105	26271931	\N	JOSE	RAFAEL	RODRIGUEZ	LUJANO-	M	\N	\N	(212)4324862	(412)9807789	jose_rodriguez121@hotmail.com	\N	\N
2107	27040324	\N	ASHLEY	VANESSA	SANCHEZ	ARJONA	F	\N	\N	(212)3641944	(416)6123096	ashleysanchez0510@gmail.com	\N	\N
2109	24901181	\N	CARLOS	AUGUSTO	TARAZONA	ALMEIDA	M	\N	\N	(212)5772552	(416)8101496	krlos_tarazona@hotmail.com	\N	\N
2111	27446164	\N	RENZO	NICOLAS	USMA	BARRIOS	M	\N	\N	(426)9015897	(416)3027957	renzousma98@gmail.com	\N	\N
2113	26498841	\N	JERISMAR	SOFIA	VIELMA	GONZALEZ	F	\N	\N	(212)3644895	(416)6238037	jerismarv@hotmail.com	\N	\N
2115	26111652	\N	ANYELIS	YODARLIS	ZAPATA	PARRA	F	\N	\N	(239)9954902	(412)5436816	anyelis_zp@hotmail.com	\N	\N
2117	14214908	\N	MERYURY	DELMAR	FERNANDEZ	MARTINEZ	F	\N	\N	(212)3231162	(426)1054002	meryury@gmail.com	\N	\N
2074	25231567	\N	YOHENDER	GREGORIO	ALAYON	ZERPA	M	\N	\N	(212)8448636	(412)9583435	joezp1996@gmail.com	\N	\N
2076	25867437	\N	ANDERSON	JOSE	BARJAS	OROZCO	M	\N	\N	(212)5199608	(412)3091283	andersonbarjas@hotmail.com	\N	\N
2078	26725644	\N	VALERIA	NAZARETH	BAYONA	VALDIVIESO	F	\N	\N	(212)6133381	(416)1938184	bmbv11@gmail.com	\N	\N
2080	19606571	\N	EBERT	DAVID	CHACON	PARRA	M	\N	\N	(212)6817575	(424)1223445	ebert7575@hotmail.com	\N	\N
2082	25676438	\N	ERIKSSON	ALEXANDER	CORREA	TRIAS	M	\N	\N	(212)8165149	(424)2701388	erikssontrias83@gmail.com	\N	\N
2086	26078575	\N	JOSE	RAMON	GODOY	OJEDA	M	\N	\N	(021)8374065	(412)9507712	jose-ferrary@hotmail.com	\N	\N
2088	25840309	\N	MICHAEL	JOSE	GOMEZ	DELGADO	M	\N	\N	(212)3839059	(042)1124928	michajgd@gmail.com	\N	\N
2090	26952461	\N	KATHERINE	GIANNY	GUTIERREZ	REVENGA	F	\N	\N	(416)4057846	(414)2057590	katherineggutierrez@hotmail.com	\N	\N
2092	25579875	\N	MIGUEL	ANDRES	HOBAICA	PAREDES	M	\N	\N	(212)3723313	(414)3223442	miguelhobaica11@gmail.com	\N	\N
2094	18032156	\N	JOSE	IGNACIO	LOPEZ	NAVARRO	M	\N	\N	(212)3727056	(424)1648164	joseilopezn@hotmail.com	\N	\N
2096	26180533	\N	FRANCISCO	JAVIER	MENA	DURAN	M	\N	\N	(212)3555056	(412)5435256	dact3rius69@hotmail.com	\N	\N
2098	27333426	\N	LUIS	ALEJANDRO	MONGES	NESSI	M	\N	\N	(212)6810521	(414)1276878	mongesluis14@gmail.com	\N	\N
2100	21194419	\N	YORBELY	ROSALIA	NASR	JAIMES	F	\N	\N	(212)3737346	(416)3000790	yornasr@gmail.com	\N	\N
2104	26624056	\N	STALYN	DANIEL	RAMIREZ	LARA	M	\N	\N	(212)3226814	(412)2212217	stalyndaniel08@hotmail.com	\N	\N
2067	3673294	\N	GUILLERMO	\N	ARCILA	\N	M	\N	N	\N	\N	guillermoantonioarcila@hotmail.com	\N	\N
2106	25774228	\N	ERICK	ALEJANDRO	ROSALES	GARCIA	M	\N	\N	(212)4726983	(424)2515141	erickalejandrorosales@hotmail.com	\N	\N
2108	26921594	\N	SAMUEL	ALEJANDRO	STROCCHIA	HERNANDEZ	M	\N	\N	(212)3932123	(416)8339754	linkinhank@gmail.com	\N	\N
2110	27098844	\N	JEREMY	JOEL	URBINA	VELEZ	M	\N	\N	(021)3220420	(414)3680589	jeremyurbina@hotmail.com	\N	\N
2112	26624385	\N	JOSDAVIN	VALERO	VALERO	FRANCO	M	\N	\N	(212)3211861	(424)2227329	elkincito_09@hotmail.com	\N	\N
2114	24041084	\N	JONATHAN	RENIER	ZAMBRANO	CONTRERAS	M	\N	\N	(212)8618582	(424)4263824	reni_zambrano@hotmail.com	\N	\N
2118	16679121	\N	ALEXIS	EDUARDO	LUGO	GOZALEZ	M	\N	\N	(212)5371055	(424)1284012	ras.alexislugo.i@hotmail.com	\N	\N
2083	20755583	\N	ANGEL	EDUARDO	DE DEFREITAS	ANDRADE	M	\N	\N	(212)6826351	(416)4262463	angel_18_9@hotmail.com	\N	\N
2084	25869581	\N	YONAIKER	JOSE	DIAZ	\N	M	\N	\N	(412)3805582	(414)3230442	yonaikerdiaz54@gmail.com	\N	\N
2102	27370246	\N	EDGLIS	DEL CARMEN	OROZCO	HIDALGO	F	\N	\N	(212)8734354	(416)7929406	edglis__g.10@hotmail.com	\N	\N
2116	19560846	\N	JEAN	FRANCO BRYAN	CHUNGA	ABARCA	M	\N	\N	(212)8892026	(416)2396433	jeanfrancobryan@gmail.com	\N	\N
2119	6864142	\N	DAVID	\N	MORA	\N	M	\N	\N	04142497747	\N	asesorestrategicorh@gmail.com	\N	\N
2120	8812054	\N	IRIS	\N	ALBARRÁN	\N	F	\N	\N	04126121399	\N	irisalba2005@gmail.com	\N	\N
2121	22692702	\N	PEDRO	\N	RIVERO	\N	M	\N	\N	\N	\N	pedro_rivero_321@hotmail.com	\N	\N
2122	24524018	\N	HOOGLLER	DANIEL	SILVA	ARDANA	M	\N	\N	\N	\N	hoogler-daniel@hotmail.com	\N	\N
2123	18233663	\N	ANDREA	ALEJANDRA	CANINO	ROSILLO	F	1988-08-08	\N	04142240773	\N	andreacalejandra@gmail.com	\N	San Antonio
2124	25253326	\N	JESUS	RAFAEL	ALVAREZ	TOVAR	M	\N	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 2129 (class 0 OID 66046)
-- Dependencies: 180
-- Data for Name: t_persona_temp_2; Type: TABLE DATA; Schema: sis; Owner: alamoj
--

COPY t_persona_temp_2 (cedula, email) FROM stdin;
26546741	xavieracosta1997@gmail.com
21410693	rafael.r.acosta.m.93@gmail.com
26323516	josejesus1996_6@hotmail.com
24997125	kathy21114@hotmail.com
25231567	joezp1996@gmail.com
21132248	dinoxo@hotmail.com
21177269	mushasy215@hotmail.com
23778230	rap7caroldc@hotmail.com
20481769	daredevil_806@hotmail.com
21375417	daniela_2491@hotmail.com
24464394	the_ejag_@hotmail.com
27031150	alvarezluimar47@hotmail.com
24101206	chicastephanie27@hotmail.com
24285580	marco7895@hotmail.com
25253326	jesusrafa11@hotmail.com
26296145	aaron_yny@hotmail.com
24885401	an_arias1996@hotmail.com
20304417	el_cairo_2@hotmail.com
19194367	gatonegro_cat@hotmail.com
20630278	lavane4864@hotmail.com
22029310	jgam310@hotmail.com
25516379	marcosdavilam97@gmail.com
25702779	kymberlyn_11@hotmail.com
21468381	ferzavolio@hotmail.com
24897416	jefersonbarboza94@hotmail.com
25579242	kewinbarboza@gmail.com
25867437	andersonbarjas@hotmail.com
20413619	christbarrios@gmail.com
24914191	vicentbarrios995@gmail.com
26725644	bmbv11@gmail.com
19478775	sebg_nomis@hotmail.com
25215291	richard2152010@hotmail.com
22025926	carlosbelisario35@hotmail.com
22540488	luizhbello@gmail.com
19710678	winner_1607@hotmail.com
24286582	nanibencomo@hotmail.com
21120673	franklinbenitez23@hotmail.com
21470514	jesusbermudezperez@hotmail.com
24886638	carlos_ebb@outlook.com
21200752	gabobrako@gmail.com
26279030	cesarambo222@hotmail.com
25683254	hanjoribravo@hotmail.com
22048752	yeik_brother@hotmail.com
25948887	abrahanmogollon@hotmail.com
22667677	xxl.brito@hotmail.com
23192057	diego_23192@hotmail.com
26739019	carlosecl_420@hotmail.com
25386349	jocarlian@gmail.com
25579898	bhranerc@hotmail.com
24898458	c.l.l.c@hotmail.com
21470449	nauj_carlos_1992@hotmail.com
26624428	jesus-castillo-11@hotmail.es
23652815	ambarprofesional@outlook.es
25252859	yosle_b_14@hotmail.com
18761086	carmen_yasmin_88@hotmail.com
22905285	daniel_cedre@hotmail.com
24592402	rusth04.cg@gmail.com
24218574	anagabriela.cespedes@hotmail.com
19606571	ebert7575@hotmail.com
21536580	cristian_chiqui92@hotmail.com
25626328	cioffi_97@hotmail.com
27187937	elyaraque@hotmail.com
25896369	francolmenagar2@hotmail.com
27302703	yorbijesuscontreras123@gmail.com
25676438	erikssontrias83@gmail.com
21118702	madacostac2@hotmail.com
20411242	any_daboin_1991@hotmmail.com
20328783	oscar_davila1@hotmail.com
21119614	michaelmoises@hotmail.com
18817784	endrys_carolina@@hotmail.com
20755583	angel_18_9@hotmail.com
20304149	banaba61@hotmail.com
24997485	giancarlosdelmelo@hotmail.com
24463298	alex.dias2612@gmail.com
25869581	yonaikerdiaz54@gmail.com
22694445	jead_diaz@hotmail.com
25579011	debi_queen@hotmail.com
21090413	jjdg21090@hotmail.com
20629655	alexleo_93@hotmail.com
19388228	ericdiaz19@hotmail.com
21120479	alexandermiguel06@hotmail.com
19255424	amilhause.10@gmail.com
20596696	johan.fajro29@gmail.com
22540003	jfioretti55@gmail.com
21467180	felixalex_1@hotmail.com
24750160	german_jossue@hotmail.com
25237827	jose2711995@hotmail.com
25386679	edgar_pelotero_53@hotmail.com
22785229	daniel._.12@hotmail.com
23625850	danielgarcia767@hotmail.com
19930811	brayangavidia@gmail.com
25510702	daniel_velasco_1996@hotmail.com
26078575	jose-ferrary@hotmail.com
22048719	martingomes36@gmail.com
20745121	arturo_85000@hotmail.com
24520761	deybermimo@gmail.com
18910926	leonardo_jlg@hotmail.com
25840309	michajgd@gmail.com
24205289	leiker.dgs@gmail.com
20430078	trankoscjg20@hotmail.com
22540174	carlansor@gmail.com
22344254	luisleonardo_14@hotmail.com
23640496	mozitha17@hotmail.com
25531876	yarmelis_gonzalez@hotmail.com
20562719	kiq22_03@hotmail.com
19737313	cgonzalez_565@hotmail.com
25516368	mauriciojose14@gmail.com
24462857	ekimanthony1996@hotmail.com
24278553	kimberlygonzalezf@hotmail.com
25948336	carlos_cagh15@hotmail.com
26952461	katherineggutierrez@hotmail.com
25840024	jhoymarguzman97@hotmail.com
25896656	luis.mario19@hotmail.com
25896828	willmbert.h@hotmail.com
23691273	gregory.hernandez12345@gmail.com
24524100	scris@hotmail.com
24440522	oraherrera@hotmail.com
25932406	xdcoxnordx@gmail.com
25825337	hidalgocarlos0612@gmail.com
25579875	miguelhobaica11@gmail.com
21091754	osmamorocho@gmail.com
22667812	johan_isena@hotmail.com
26409425	kmiilooxp@gmail.com
24723780	carlos_95_ladaeta@hotmail.com
25510149	isjonmlr@hotmail.com
27042856	soladiadominguez1962@gmail.com
21091195	alverjose19@hotmail.com
22667117	nestor151_@hotmail.com
23643645	oniceoner@gmail.com
24759460	l.2395@hotmail.com
23600171	dawralf@gmail.com
23637639	bm25lb03@gmail.com
22667049	los_ktfa@hotmail.com
18032156	joseilopezn@hotmail.com
21469677	odloyo@gmail.com
25252504	fraybert_34_12@hotmail.com
22048756	jmanriquedaboin@gmail.com
21121102	yosmarmarquez93@gmail.com
25231056	samuel_jet_96@outlook.com
19587797	sstevenfortune@gmail.com
22350085	ramonmarto@gmail.com
22033729	prinj0611@hotmail.com
24900144	manuelmaurera@hotmail.com
25206298	endry_hiphop15@yahoo.com
25639748	arango.vino.tinto@hotmai.com
19274797	jarvi_mm@hotmail.com
26180533	dact3rius69@hotmail.com
25231066	josemendez810@gmail.com
24315308	angelo.adriano.mendoza.25@@@gmail.com
26217793	augusto_m98@hotmail.com
20095483	mozart693@hotmail.com
25896950	alejandromolero09@hotmail.com
24087122	fran_ci23@hotmail.com
27333426	mongesluis14@gmail.com
21121583	cheche-71@hotmail.com
25594817	rommelmontoya97@gmail.com
20754390	mariasalome093@hotmail.com
26284010	darkgastry@hotmail.com
19851117	erny1027@hotmail.com
24524502	tfd_nestor16@hotmail.com
25579438	aliciamorenosni@hotmail.com
20652562	yorviz_750@hotmail.com
24883016	mujica.jhoan1996@hotmail.com
19274723	danielmuci12@hotmail.com
21194419	yornasr@gmail.com
21377392	prototipoexpress@hotmail.com
25976281	mariafernanda_815@hotmail.com
21121127	dgennaromanuel@gmail.com
23712937	noralartiguez@hotmail.com
25702416	stefanny_julieth_2007@hotmail.com
27370246	edglis__g.10@hotmail.com
21468468	caknekto@gmail.com
25639865	engelhard25@hotmail.com
24218005	pachecojose0908@gmail.com
13245591	rafaelpaivab@gmail.com
26004129	lennys_palma14@hotmail.com
24933891	jonaikerpowers@hotmail.com
21091868	victoria_isabelpb@hotmail.com
25702346	area_5@hotmail.es
23782833	japl20_95@hotmail.com
26343663	richardpena1997@hotmail.com
24073562	antroxper@gmail.com
25967667	ale_pereyra97@hotmail.com
23608372	jhorfrank@hotmail.com
20614839	juniior_pk@hotmail.com
25716112	sinaigitanyali@hotmail.com
26078380	christian_9b3@hotmail.com
25976863	luisangeljo@hotmail.com
25896865	daydeydami@hotmail.com
24204646	joseequirozg96@hotmail.com
21089422	veroniica_rada@hotmail.com
26624056	stalyndaniel08@hotmail.com
22540539	ger276@hotmail.com
24997618	luis.rangel2103@gmail.com
21252634	tuamado@hotmail.com
23607963	franyeska_resplandor@hotmail.com
26283492	kati.reyes@hotmail.com
24407267	zadquiel_zr@outlook.
20748839	maykoladad@gmail.com
24998193	jose-rh@hotmail.com
22692702	pedro_rivero_321@hotmail.com
26125500	oscomar_roa@hotmail.com
24523846	ajrf_24@hotmail.com
19508757	fran90_xavier@hotmail.com
20116262	mayrodriguez1@hotmail
26271931	jose_rodriguez121@hotmail.com
24774216	rafael_rodriguezve@hotmail.com
25896319	mario_urbina10@hotmail.com
21469109	darn93@hotmail.com
24286613	tenkuu17@gmail.com
24462558	lolirojas16@hotmail.com
22752141	zuke.romero25@gmail.com
25702958	krisbellrjb@gmail.com
24285694	pedro.rondon0518@gmail.com
25774228	erickalejandrorosales@hotmail.com
20114774	bjlra_18@hotmail.com
26272734	yorjhananrm@hotmail.com
24928045	izteydelc@hotmail.com
21436241	keybersalas@hotmail.com
22282022	kiarasalcedo599@gmail.com
27207613	christianalfonso710@hotmail.com
20454787	linda_morenita2007@hotmail.com
27040324	ashleysanchez0510@gmail.com
21469345	chuo_751@hotmail.com
24524566	aleelmejor12@hotmail.com
24463384	rs_iut@hotmail.com
23689982	yipo0426@hotmail.com
23610504	irviinalejandro96@gmail.com
21622060	jjsantiago50@gmail.com
24410044	yoelvis.yds@gmail.com
25672909	msemeriaj@hotmail.com
25531985	yma29.1.12@gmail.com
21091197	giovanni_sojo@hotmail.com
19659566	kennysolo@hotmail.com
23950826	kirvingsomarriba@hotmail.com
24063554	karlossoto_11@hotmail.com
26921594	linkinhank@gmail.com
19931246	krtabares@gmail.com
20365535	frederys@hotmail.com
24901181	krlos_tarazona@hotmail.com
25386797	tdsjl@hotmail.com
23625597	daniel20_tg@gmail.com
20745288	isaactorrestorres@hotmail.com
21014944	juanjtovar1991@gmail.com
25237682	odaliitaz_14@hotmail.com
27098844	jeremyurbina@hotmail.com
27446164	renzousma98@gmail.com
21469234	neuman007elkid@gmail.com
24773358	daniel_7537@hotmail.com
26624385	elkincito_09@hotmail.com
24669462	luzcalvete@gmail.com
22540078	gjvo23_wy@hotmail.com
21119846	gabriel_vegas7@hotmail.com
19931786	flocmusic_646@hotmail.com
24998528	miguelgadielv@hotmail.com
25278612	clenvielma@gmail.com
26498841	jerismarv@hotmail.com
24697525	adrian_te_k@hotmail.com
24671815	leandro_ltomas-viloria@hotmail.com
24591520	lexaynzrmz@hotmail.com
19678033	yaniyepez28@hotmail.com
24041084	reni_zambrano@hotmail.com
26111652	anyelis_zp@hotmail.com
\.


--
-- TOC entry 2102 (class 0 OID 16813)
-- Dependencies: 148
-- Data for Name: t_prelacion; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_prelacion (codigo, cod_uni_curricular, cod_uni_cur_prelada) FROM stdin;
\.


--
-- TOC entry 2100 (class 0 OID 16784)
-- Dependencies: 146
-- Data for Name: t_tip_uni_curricular; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_tip_uni_curricular (codigo, nombre) FROM stdin;
O	Obligatoria
E	Electiva
A	Acreditable
\.


--
-- TOC entry 2099 (class 0 OID 16769)
-- Dependencies: 145
-- Data for Name: t_trayecto; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_trayecto (codigo, cod_pensum, num_trayecto, certificado, min_credito) FROM stdin;
7	2	1	ASISTENTE ADMINISTRATIVO	0
8	2	2	TSU EN ADMINISTRACIÓN	0
10	2	4	LICENCIADO EN ADMINISTRACIÓN	0
11	3	0	NO TIENE	8
12	3	1	ASISTENTE DE LABORATORIO	12
1	1	0	NO POSEE	0
2	1	1	SOPORTE TÉCNICO	0
3	1	2	TSU INFORMÁTICA	0
4	1	3	DESARROLLADOR DE APLICACIONES	0
5	1	4	INGENIERO EN INFORMÁTICA	0
6	2	0	NO POSEE	0
9	2	3	NO POSEE	0
\.


--
-- TOC entry 2101 (class 0 OID 16789)
-- Dependencies: 147
-- Data for Name: t_uni_curricular; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_uni_curricular (codigo, cod_uni_ministerio, cod_trayecto, nombre, cod_tipo, hta, hti, uni_credito, dur_semanas, not_min_aprobatoria, not_maxima) FROM stdin;
1	MAC015	1	MATEMÁTICA	O	5	5	5	12	12	20
2	PNS013	1	PROYECTO NACIONAL Y NUEVA CIUDADANÍA	O	4	2.5	3	12	12	20
3	IPC012	1	INTRODUCCIÓN A LOS PROYECTOS Y AL PNF	O	2	2.5	2	12	12	20
6	APT1312	2	ALGORÍTMICA Y PROGRAMACIÓN I	O	6	2.5	12	36	12	20
7	FCS133	2	FORMACIÓN CRÍTICA I	O	2	0.5	3	36	12	20
8	PTP139	2	PROYECTO SOCIO TECNOLÓGICO I	O	6	0.5	9	36	12	20
9	IDC133	2	INGLÉS	O	2	0.5	3	36	12	20
10	MAC226	3	MATEMÁTICA II	O	5	1.5	6	24	12	20
11	RCT226	3	REDES DE COMPUTADORAS	O	5	1.5	6	24	12	20
12	POT2312	3	PROGRAMACIÓN II	O	6	2.5	12	36	12	20
13	ISC213	3	INGENIERÍA DEL SOFTWARE I	O	5	2	3	12	12	20
14	BDC213	3	BASE DE DATOS	O	5	2	3	12	12	20
15	FCS233	3	FORMACIÓN CRÍTICA II	O	2	0.5	3	36	12	20
16	PTP239	3	PROYECTO SOCIO TECNOLÓGICO II	O	6	0.5	9	36	12	20
17	PRO6002	6	LA ADMINISTRACIÓN EN EL NUEVO MODELO SOCIAL	O	30	30	2	12	12	20
18	PNNC8003	6	PROYECTO NACIONAL Y NUEVA CIUDADANIA	O	40	40	3	12	12	20
19	DI6002	6	DESARROLLO INTEGRAL	O	30	30	2	12	12	20
20	MA6002	6	MATEMATICA	O	30	30	2	12	12	20
21	PRO700124	7	ANÁLISIS Y EJECUCIÓN DE LOS PROCESOS ADMINISTRATIVOS EN LAS ORGANIZACIONES	O	350	350	24	36	16	20
22	APN15015	7	ADMINISTRACIÓN PÚBLICA NACIONAL	O	175	175	5	36	12	20
23	OF6012	7	 OPERACIONES FINANCIERAS	O	30	30	2	36	12	20
24	CON18016	7	CONTABILIDAD I	O	90	90	6	36	12	20
25	TPM9013	7	TEORÍA Y PRÁCTICA DEL MERCADEO	O	45	45	3	36	12	20
26	PRO700224	8	SUPERVISIÓN Y CONDUCCIÓN TÉCNICA DE PROCESOS ADMINISTRATIVOS	O	350	350	24	36	16	20
27	ESMD15025	8	ECONOMÍA, SUSTENTABILIDAD Y MODELOS DE DESARROLLO	O	175	175	5	36	12	20
28	CON9023	8	CONTABILIDAD II	O	45	45	3	36	12	20
29	ADC6022	8	ADMINISTRACIÒN DE COSTOS	O	30	30	2	36	12	20
30	OM6022	8	ORGANIZACIÓN Y MÉTODOS	O	30	30	2	36	12	20
31	THAT9023	8	TALENTO HUMANO Y AMBIENTE DE TRABAJO	O	45	45	3	36	12	20
32	PRO700324	9	DISEÑO, PLANIFICACIÓN, DESARROLLO E INNOVACIÓN DE SISTEMAS ADMINISTRATIVOS	O	350	350	24	36	16	20
33	PSAPD15035	9	PARTICIPACIÓN SOCIAL EN LA ADMINISTRACIÓN, PRODUCCIÓN Y DISTRIBUCIÓN	O	175	175	5	36	12	20
34	ADP6032	9	ADMINISTRACIÓN DE LA PRODUCCIÓN	O	30	30	2	36	12	20
35	PPU4032	9	PRESUPUESTO PÚBLICO	O	20	20	2	36	12	20
36	PPR3031	9	PRESUPUESTO PRIVADO	O	15	15	1	36	12	20
37	ADM6032	9	ADMINISTRACIÓN DEL MERCADEO	O	30	30	1	36	12	20
38	FEP3031	9	FORMULACIÓN Y EVALUACIÓN DE PROYECTOS	O	15	15	1	36	12	20
39	PRO700424	10	DIRECCIÓN, CONTROL Y EVALUACIÓN DE SISTEMAS ADMINISTRATIVOS	O	350	350	24	36	16	20
40	APUALC15045	10	ADMINISTRACIÓN EN LOS PROCESOS DE UNIDAD DE AMÉRICA LATINA Y EL CARIBE EN EL NUEVO CONTEXTO MUNDIAL	O	175	175	5	36	12	20
41	AIEF6042	10	ANÁLISIS E INTERPRETACIÓN DE ESTADOS FINANCIEROS	O	30	30	2	36	12	20
42	SFN6042	10	SISTEMA FINANCIERO NACIONAL	O	30	30	2	24	12	20
43	AF6042	10	ADMINISTRACIÓN FINANCIERA	O	30	30	2	24	12	20
44	PDETH9042	10	PLANIFICACIÓN Y DESARROLLO ESTRATÉGICO DEL TALENTO HUMANO	O	45	45	3	36	12	20
45	NPG9043	10	NUEVOS PARADIGMAS PARA LA GESTIÓN DEL TALENTO HUMANO.	O	45	45	3	12	12	20
51	sincod	2	TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN	E	5	1.5	3	12	12	20
47	MAT001	11	MATEMATICA	O	4	2	6	12	12	20
46	PNCMIN	11	PNNC	O	2	2	2	12	12	20
48	MAT1TM	12	MATEMATICA	O	6	2	6	36	12	20
49	fc005	12	formación crítica	O	2	4	9	36	12	20
52	\N	2	LÓGICA Y DEPURACIÓN	E	5	1.5	3	12	12	20
50	AAA1303	2	ACREDITABLE	O	2	2	3	12	12	20
4	MAC139	2	MATEMÁTICA I	O	5	5	9	36	12	20
5	ACT139	2	ARQUITECTURA DEL COMPUTADOR	O	5	5	9	36	12	20
\.


--
-- TOC entry 2114 (class 0 OID 16982)
-- Dependencies: 160
-- Data for Name: t_usu_con_estudios; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_usu_con_estudios (codigo, cod_estado, cod_instituto) FROM stdin;
2000	A	11
\.


--
-- TOC entry 2112 (class 0 OID 16957)
-- Dependencies: 158
-- Data for Name: t_usu_enc_pensum; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_usu_enc_pensum (codigo, cod_estado, cod_instituto, cod_pensum) FROM stdin;
2002	A	11	\N
2003	A	11	\N
2004	A	11	\N
\.


--
-- TOC entry 2125 (class 0 OID 33100)
-- Dependencies: 174
-- Data for Name: t_usu_ministerio; Type: TABLE DATA; Schema: sis; Owner: usuarioscn
--

COPY t_usu_ministerio (codigo, cod_estado) FROM stdin;
2001	A
\.


SET search_path = tmp, pg_catalog;

--
-- TOC entry 2130 (class 0 OID 66068)
-- Dependencies: 182
-- Data for Name: activos_infor_dic_2015; Type: TABLE DATA; Schema: tmp; Owner: postgres
--

COPY activos_infor_dic_2015 (cedula, nombres, apellidos) FROM stdin;
82290858	DANIEL	ABREU PEREZ
26546741	XAVIER EDEL	ACOSTA BOLIVAR
21410693	RAFAEL ROBERTO	ACOSTA MARTINEZ
26323516	JOSE JESUS	ADAMES OROPEZA
24997125	KATHERYNE DE JESUS	ADAMES OROPEZA
24592167	GIANFRANCO JORDAN	AGOGLITTA PALENCIA
20291018	ANTHONY JOSE	AGUERO PEREIRA
18329570	MAYRA ALEJANDRA	AGUILERA DIAZ
25231567	YOHENDER GREGORIO	ALAYON ZERPA
21132248	ADRIAN ANTONIO	ALBARRACIN VIEIRA
18739751	OMAR MARCEL	ALCALA RODRIGUEZ
21177269	THONY DANIEL	ALCALA VANEGAS
23778230	DIANA CAROLINA	ALTUVE VALENZUELA
24670941	EDUARDO JOSE	ALVARADO DELGADO
20481769	FRAY AGUSTIN	ALVAREZ CASTRO
21375417	ASTRID DANIELA	ALVAREZ ENRIQUEZ
24464394	EDINSON JOHAN	ALVAREZ GOMEZ
27031150	LUIMAR ANDRE	ALVAREZ GONZALEZ
24101206	STEPHANIE LISHA	ALVAREZ LUGO
24285580	MARCO IGNACIO	ALVAREZ TALLADA
25253326	JESUS RAFAEL	ALVAREZ TOVAR
20489059	ERICK IVAN	ALVIAREZ GUERRERO
26296145	AARON MANUEL	ANDRADE CENTENO
8684649	JHONNY NICOLAS	ARANGUREN HERNANDEZ
21467526	ALFREDO ALEJANDRO	ARGUINZONES DE GOUVEIA
24885401	ANDRY JOSE	ARIAS MORENO
20304417	JEFFERSON STEVENS	ARRAIZ ALTUVE
18249094	LEONARDO ENRIQUE	ARRIAGA LIMONGI
20327509	MARIAN	ARRIAGA LIMONGI
19194367	RUBEN DARIO	ARROYO MADERA
20630278	FRANCYS VANESSA	ARTEAGA APONTE
22029310	JOSE GREGORIO	ARTIGAS MORENO
20745328	ABELARDO MICHELE	ASTUDILLO ESPOSITO
25516379	MARCOS DANIEL	AVILA MORENO
25702779	KYMBERLYN YULIANA ELIANETH	AVILAN ROMERO
21468381	FERNANDO JOSE	AVOLIO REYES
6312371	MIRIAM YAMILET	AYALA HERNANDEZ
24897416	JEFERSON GABRIEL	BARBOZA AGUAYO
25579242	KEWIN JOSE	BARBOZA ALVAREZ
25867437	ANDERSON JOSE	BARJAS OROZCO
20413619	CHRISTIAN ALFONSO	BARRIOS PALMA
24914191	VICENT JOSE	BARRIOS PAREDES
26725644	VALERIA NAZARETH	BAYONA VALDIVIESO
19478775	SIMON ESTEBAN	BELANDRIA GONZALEZ
25215291	RICHARD	BELENO ALTAHONA
22025926	CARLOS ALBERTO	BELISARIO CALDERON
21120393	KATHERINE	BELLO GARCIA
22540488	LUIS FERNANDO	BELLO MACHADO
20746849	ELEINY JOSEFINA	BELLO MANZO
22351491	ADRIAN JOSE	BELLO RUIZ
19710678	FRANCISCO ANTONIO	BELLORIN CIOFFI
24286582	DANIELA DESSIREE	BENCOMO DIAZ
21120673	FRANKLIN JOSE	BENITEZ AZUAJE
20871144	ALEXIS ENRIQUE	BEQUIZ ANDRADE
21470514	JESUS LEANDRO	BERMUDEZ PEREZ
24886638	CARLOS EDUARDO	BOLIVAR BARRIOS
16563137	FREYMAN IVES	BONILLA CORRAL
21200752	GABRIEL ANTONIO	BRACAMONTE GOMEZ
26279030	CESAR LEONARDO	BRACHO PICADO
25683254	HANJORI BRIGITTE ARACELIS	BRAVO FERNANDEZ
20116823	ADRIAN JOSE	BRAVO VILORIA
22048752	YEIKDERSON EDUARDO	BRICEÑO GUIJE
19764594	YERDXON RAFAEL	BRICEÑO GUIJE
25948887	ABRAHAN ALEXANDER	BRITO MOGOLLON
22667677	JOSE DAVID	BRITO SANSONETTI
23192057	DIEGO ARMANDO JESUS	CABALLERO ESCALONA
23618050	JOSE DAVID	CABAÑALES RAMIREZ
26739019	CARLOS ENRIQUE	CABRERA LOPEZ
19594403	BRISLEYDI DAVIANA	CALDERON SEIJAS
25386349	CARLIG JOANNY	CALLES FIGUEREDO
20307062	JENIREE KARINA	CALZADILLA PEREZ
22351692	LEONARDO ANTONIO	CAMACARO ARMAS
18740500	EDGAR ANTONIO	CAMACHO OCHOA
22666462	KATHERINE ANDREINA	CAMPOS NARANJO
25579898	BHRANER JOUSSEFF	CAÑAS RODRIGUEZ
24898458	CESAR ALEJANDRO	CARDENAS AGUINAGALDE
20654346	DEIBY ALEXANDER	CARDONA LAGUNA
21470449	JUAN CARLOS	CARMONA CARTAYA
19293033	LUIS EDUARDO	CARPINTERO VETENCOURT
26624428	JANELY KARINA	CARRILLO SILVA
18329658	JESUS ALBERTO	CASIQUE PEREZ
21468422	NITSUGA ROSSMARY	CASTILLO GONZALEZ
24981683	GERALDINE VERONICA	CASTILLO SANZ
23652815	AMBAR CRIS	CASTRO NAVAS
20412322	ROLANDO ALEXANDER	CEBALLOS BRICEÑO
25252859	YOSLEIDA CAROLINA	CEDEÑO BRICEÑO
21436674	OMER EDUARDO	CEDEÑO GIMENEZ
18761086	CARMEN JASMIN	CEDEÑO PACHECO
22905285	DANIEL JOSE	CEDRE CARO
24592402	RUSBETH GIUSETH	CERVERA GALLARDO
24218574	ANA GABRIELA	CESPEDES ORTA
19606571	EBERT DAVID	CHACON PARRA
21536580	CRISTIAN JOSE	CHIQUITO CHIQUITO
19763832	EDGAR ALEXANDER	CHIRINOS MAYAUDON
19560846	JEAN FRANCO BRYAN	CHUNGA ABARCA
25626328	ANDREW MIGUEL	CIOFFI RUIZ
27187937	KEIMEC ENRIQUE	COLMENAREZ DELGADO
25896369	FRANCO ATILIO	COLMENAREZ GARCIA
18491779	ELY JOSE	COLMENAREZ MOLINA
19288622	ROXANA MARIA	CONTRERAS JIMENEZ
27302703	YORBI JESUS	CONTRERAS URBINA
18740030	DANIEL ARTURO	CORRALES RAMIREZ
25676438	ERIKSSON ALEXANDER	CORREA TRIAS
21118702	MANUEL ALEJANDRO	DA COSTA CONTRERAS
20411242	JOHANY NAZARETH	DABOIN TORRES
19587468	KARELYN JOSE	DAVILA BARRIOS
21073925	JHOANYELY CAROLINA	DAVILA LEON
20328783	OSCAR EDUARDO	DAVILA MONTILLA
21119614	MICHAEL MOISES GIGAK	DE ABREU COLMENARES
18995885	STEPHANY DEL CARMEN	DE ANDRADE CORREIA
18817784	ENDRYS CAROLINA	DE AVILA SOTO
20755583	ANGEL EDUARDO	DE DEFREITAS ANDRADE
20304149	LEONARDO JOSE	DE LA CRUZ DIAZ
21117823	JUAN MANUEL	DE SOUSA LUIS
24997485	GIANCARLOS	DELMELO SPIZZIRRI
24463298	JOSE ALEXANDER	DIAS GONZALEZ
25869581	YONAIKER JOSE	DIAZ
22694445	JEFFERSON ADRIAN	DIAZ CORRALES
25579011	DEBORA KARINA	DIAZ FAGUNDEZ
22447732	PAUL LEONARDO	DIAZ FIGUERA
21090413	JHEYSSON JOSE	DIAZ GARCIA
20629655	ALEXIS LEONARDO	DIAZ MONSALVE
19388228	ERIC ALEXIS	DIAZ RIVAS
10806945	JORGE LUIS	DORIA SIEM
13853914	DAMELYS CECILIA	DUGARTE ROJAS
14194118	JUAN JOSE	ECHENIQUE VISBAL
21120479	ALEXANDER MIGUEL	ESCULPI RIOS
21134047	ALEX RAFAEL	ESTEVES BALADO
19085395	LUIS ENRIQUE	ESTRADA OVALLES
19255424	AMILCAR JOSE	EXPOSITO MOLINA
20596696	JOHAN JESUS	FAJARDO GARCIA
14214908	MERYURY DELMAR	FERNANDEZ MARTINEZ
22540003	PASCUAL JEANFRANCO	FIORETTI MOSQUERA
21467180	FELIX ALEJANDRO	FISNEDO BARRA
24750160	GERMAN JOSSUE	FLORES CALDERA
20174437	CESAR ANTONIO	FRANCO ALARCON
25237827	JOSE MANUEL	FRANCO HERNANDEZ
25386679	EDGAR ALEXANDER JULIAN DAVID	FUENTES QUIÑONES
22785229	JOSEPH DANIEL	GALLARDO GONZALEZ
21468674	ANTHONY MIGUEL	GAMEZ TORRES
6940384	LUIS ANTONIO	GARAVITO RUIZ
19764347	ANDRES JAVIER	GARCIA AVILA
19565827	JOYNERT ALBERTO	GARCIA FRANCO
19514142	EDSON MANUEL	GARCIA JOVES
21436476	EDWIN ALEXANDER	GARCIA MOLINA
23625850	DANIEL ALEJANDRO	GARCIA RODRIGUEZ
20793920	MAIYELI BETHANIA	GARCIA RODRIGUEZ
19310441	RAFAEL ANTONIO	GARCIA RODRIGUEZ
20976738	DANIEL ALEJANDRO	GARCIA TARAZONA
19930811	BRAYAN RASEC	GAVIDIA GUTIERREZ
20747171	MANUEL YEIXON	GIL PADILLA
25510702	DANIEL ALEJANDRO	GIMENEZ VELASCO
26078575	JOSE RAMON	GODOY OJEDA
22048719	MARTIN LAVY	GOMES DI LENA
20745121	ARTURO JOSE	GOMEZ ALGUERA
24520761	DEYBER ENRIQUE	GOMEZ AYALA
18910926	JOSE LEONARDO	GOMEZ CEGARRA
25840309	MICHAEL JOSE	GOMEZ DELGADO
24205289	LEIKER DOUGLAS	GOMEZ SAYAGO
20430078	CARLOS JULIO	GONZALEZ
22540174	CARLOS EDUARDO	GONZALEZ ALBARRAN
22344254	LUIS LEONARDO	GONZALEZ ARRIETA
20910921	ANDERSON JOSE	GONZALEZ AVILA
23640496	YEREMI JOSEIRI	GONZALEZ BARCELO
25531876	YARMELIS DEL CARMEN	GONZALEZ CARCAMO
20562719	ENRIQUE JOSE	GONZALEZ CARDENAS
19737313	CHRISTIAN ALEJANDRO	GONZALEZ CARRASQUEL
25516368	MAURICIO JOSE	GONZALEZ DIAZ
24462857	MIKE ANTHONY	GONZALEZ DUARTE
21134094	BILLY ROGERS	GONZALEZ FERMIN
24278553	KIMBERLY ALEJANDRA	GONZALEZ FERMIN
25948336	CARLOS ALFREDO	GONZALEZ HIDALGO
12333258	FRANCISCO ALEXANDER	GONZALEZ MONTILLA
12482277	DARWING OSWALDO	GONZALEZ NIEVES
19368595	JOSE BENJAMIN	GUERRERO GODDEFROY
26952461	KATHERINE GIANNY	GUTIERREZ REVENGA
20748103	ALI JAVIER	GUZMAN GIL
25840024	JHOYMAR ANAIS	GUZMAN ORTIZ
18491087	LUIS ENRIQUE	HENRIQUEZ DIAZ
10510347	CARLOS JOSE	HENRIQUEZ PEREZ
25896656	LUIS MARIO	HERNANDEZ CAMPOS
25896828	WILLMBERT JESUS ARTURO	HERNANDEZ CARILLO
23691273	GREGORY JOSE	HERNANDEZ DELGADO
22749572	JOSIBEL DEL VALLE	HERNANDEZ GARCIA
24524100	CRISTIAN JESUS	HERNANDEZ HERNANDEZ
24440522	ORIAMNA MILENA	HERRERA FONSECA
25932406	OLIVER ALEXANDER	HERRERA SANCHEZ
19015636	JUAN CARLOS	HERRERA SILVOSA
25825337	CARLOS ANTONIO	HIDALGO CARMARGO
25579875	MIGUEL ANDRES	HOBAICA PAREDES
21091754	OSMAN ANSELMO	IBAÑEZ DE SANTIAGO
19930632	DAMIAN FERNANDO	INOJOSA RAMOS
22667812	JOHAN CARLOS	ISENA PALMA
9488713	ALICIA CAROLINA	ISTURIZ UZCANGA
21534616	MARIA LAURA	JARAMILLO
10579953	JUAN JOSE	JIMENEZ JIMENEZ
20746474	NATALI JANELI	KHAIYAT ZAMBRANO
26409425	CAMILO RAUL	LANDAETA CHACON
24723780	CARLOS ALBERTO	LANDAETA ROJAS
25510149	VICTOR JONMIR	LARA BRITO
27042856	ESTEBAN ALFREDO	LARA DOMINGUEZ
21091195	ALVER JOSE	LAYA PEÑA
20746625	YANUEL ALEJANDRO	LEAL TORTOZA
22667117	NESTOR ARMANDO	LEON ASSUNTO
23643645	ALEJANDRO JAVIER	LEON BOLAÑO
24759460	LUIS ARTURO	LIANZA LOPEZ
23600171	RAFAEL DAVID	LICONA RODRIGUEZ
23637639	BRAIAM MIGUEL	LINARES BUSTILLOS
21121177	ALAN PAUL	LINARES MENDOZA
22667049	ANTHONY DAVID	LINARES MUJICA
18443849	CARLOS ALFONSO	LINDARTE ARNAO
18330284	KATHERIN COROMOTO	LONGA PADRINO
19930509	JOSE GREGORIO	LOPEZ
20745320	JOHAN CARLOS	LOPEZ MARQUEZ
18032156	JOSE IGNACIO	LOPEZ NAVARRO
21469677	ODLANIER MARCEL	LOYO ROMERO
16679121	ALEXIS EDUARDO	LUGO GOZALEZ
19672784	ANGELICA VANESSA	LUGO SUAREZ
19391686	YENNY CAROLINE	LUQUEZ CHACOBELA
25252504	FRAYBERT FRANCISCO	MACHILLANDA PERDOMO
22753086	LILIBETH MARGARITA	MANEIRO MAITA
22048756	JOSE MIGUEL	MANRRIQUE DABOIN
20411533	SARA ELISA	MARCANO ACOSTA
21118019	GABRIELA VALENTINA	MARCANO POLEO
19274909	GUSTAVO ALFONSO	MARIN CARRASCO
5566330	ANTONIO	MARQUEZ MUÑOZ
21121102	YOSMAR JOSE	MARQUEZ PERDOMO
22048258	CARLOS ALEJANDRO	MARQUEZ PIÑANGO
12161175	DUNIA DEL SOCORRO	MARRERO MENDOZA
25231056	SAMUEL DAVID	MARTINEZ CASTEJON
19885087	CARLOS EDUARDO	MARTINEZ MARTINO
19587797	CARLOS STEVEN	MARTINEZ MOLINA
22350085	RAMON JESUS	MARTINEZ OLIVARI
22033729	GENERSIS ABIXAI	MARTINEZ PRIN
24900144	MANUEL ALEJANDRO	MAURERA PALACIOS
25206298	ENDRY JAVIER	MEDINA BARROSO
25639748	KEVIN ANDRES	MEDINA MEJIA
20748982	OSWALDO ANDRES	MEDINA SERRUDO
19274797	JARVI JAVIER	MELENDEZ MORENO
26180533	FRANCISCO JAVIER	MENA DURAN
22440606	EVELYN DANIELA	MENDEZ GOMEZ
25231066	JOSE RAFAEL	MENDEZ VASQUEZ
24315308	ANGELO ADRIANO	MENDOZA BARRIOS
26217793	AUGUSTO GUILLERMO	MENDOZA SANHUEZA
19452086	YOHAN MANUEL	MERCEDES CHACIN
20630977	MIKAEL HEDANFRAVICH	MIJARES CARTAYA
21119542	GERALDYN ELIANA	MILLAN MALAVE
20095483	GIORDANYS ROBERTO	MODL RAMOS
25896950	ALEJANDRO JOSE	MOLERO DUN
19933139	JONARVER ORLENIS	MOLINA FUENTES
24087122	FRANCI ANDREINA	MOLINA MESA
27333426	LUIS ALEJANDRO	MONGES NESSI
21121583	JOSE DANIEL	MONTERREY HIDALGO
22440127	BREIDDY RAFAEL	MONTERREY PRETEROTI
14909190	EDUARDO ALEJANDRO	MONTILVA CASTRO
5138799	RUBEN DARIO	MONTOYA
25594817	ROMMEL OMAR	MONTOYA RODRIGUEZ
20754390	MARIA SALOME	MORALES
26284010	JOSE MANUEL	MORALES JIMENEZ
19851117	SEGUNDO ERNY	MORALES NUÑEZ
22770044	JOHANS ALEJANDRO	MORALES SALINAS
24524502	NESTOR MANUEL	MORENO AVILA
25579438	ALICIA DESIREE	MORENO RAMIREZ
20652562	DAIRON YORVIZ	MORENO SOTO
22540205	GABRIELA VANESSA	MORGADO BRITO
19388519	LUIS ALFREDO	MORIN LORCA
19587707	YERITZA MONSERRAT	MORRILLO MORRILLO
24883016	EDUARD JHOAN	MUJICA CABELLO
19274723	DANIEL SEGUNDO	MUNCIBAY GONZALEZ
21194419	YORBELY ROSALIA	NASR JAIMES
21377392	EMERSON AXEL	NAVAS RAMIREZ
21121105	VICTOR JAVIER	NIEVES OROPEZA
25976281	MARIA FERNANDA	NORIEGA GUTIERREZ
21284308	ROGER ENRRIQUE	OBANDO MONTILLA
21121127	MANUEL ALEJANDRO	OCHOA DE GENNARO
23712937	HECTOR ANTONIO	OCHOA LARTIGUEZ
19930650	JORGEN OSLER	OLIVEROS MARRERO
25702416	STEFANY JULIETH	OROPEZA JAIMES
27370246	EDGLIS DEL CARMEN	OROZCO HIDALGO
24462442	WENDY TERESA	ORRILLO TOVAR
18994045	GIOVANNA DEL CARMEN	ORTIZ OVELMEJIAS
21468468	JESUS ALBERTO	OVALLES RIVAS
22351198	DANIEL ANDRES	OVIEDO LIZCANO
25639865	ENGERHARD ALEXANDER	PACHECO GUTIERREZ
24218005	JOSE GREGORIO	PACHECO RIVERA
13245591	RAFAEL DANIEL	PAIVA BERNAL
26004129	ALENNYS EDELMIRA	PALMA QUEVEDO
22565035	MIGUELANGEL	PALMA RIVAS
21091399	GUSTAVO ALBERTO	PARRA DURAN
18740115	GRICELIS	PARRA ZAPATA
24933891	JONAIKER JOSE	PATIÑO ANZOLA
21091868	VICTORIA ISABEL	PAZ BURGUILLO
25702346	JESUS GABRIEL	PEÑA BASTARDO
21120613	LUIS MIGUEL	PEÑA BASTARDO
23782833	JEISON ALEJANDRO	PEÑA LOPEZ
26343663	RICHARD JESUS	PEÑA PEÑA
16263766	ALEXANDER JESUS	PEÑA RODRIGUEZ
24073562	ANGEL JOSE	PERDOMO SARMIENTO
25967667	ALEJANDRO	PEREYRA LEAL
23608372	JHORFRANK MITCHELL	PEREZ BLANCO
22666793	YENIRELIS CAROLINA	PEREZ CASTELLANO
20614839	JUNIOR ALBERTO	PEREZ GARCIA
21120397	EDWARD JESUS	PEREZ RANGEL
20747482	LUIS MIGUEL	PINO DI RAUSO
25716112	SINAI GITANYALI	PIÑERO ARANA
26078380	CHRISTIAN HIGDALIAS	POLANCO ALTUVE
23635762	CLARISBEL ROXANA	PONCE CANELON
25976863	LUIS ANGEL JOSE	PORTILLO AREVALO
16812356	JEAN RAMON	QUERO OLIVARES
18033257	OSCAR DANIEL	QUIJANO CASTELLANO
25896865	DAHIRYARLETH DALESKA	QUINTANA LOVERA
20746466	JOSE MIGUEL	QUINTERO GODOY
24204646	JOSE ENRIQUE	QUIROZ GONZALEZ
21089422	FRANCHESKA ANDREINA	RADA DIAZ
18234026	JAVIER ANTONIO	RAMIREZ BENAVIDES
22534005	EZEQUIEL AMADOR	RAMIREZ GARCIA
26624056	STALYN DANIEL	RAMIREZ LARA
21132106	ERICK GERSON	RAMIREZ QUEVEDO
17677322	LUIS ALBERTO	RAMIREZ ROSALES
22540539	GERMAN ALFONSO	RAMON LEON
24997618	LUIS ALFREDO	RANGEL CASTILLO
21252634	JUAN CARLOS	RENGIFO CRESPO
23607963	ROSA FRANYESKA	RESPLANDOR LUNA
26283492	EVERLIN KATIHUSKA	REYES PADRINO
24407267	ZADQUIEL ALEJANDRO	RICAURTE BENITEZ
19930797	LEIDY ORIANA	RICO CASTILLO
12730824	EDGAR ESTEBAN	RINCON SILVA
20748839	MAYKOL ADAD	RIOBUENO ORTIZ
23707541	KATHERINE ALEXANDRA	RIOS DIAZ
18547969	XAVIER ALIX	RIVAS PARRA
24998193	JOSE ARMANDO	RIVERO HERNANDEZ
22692702	PEDRO DANIEL	RIVERO ROMERO
26125500	OSCAR OMAR	ROA GUERRERO
24523846	ANDRES JOSE	RODRIGUES FERNANDEZ
19508757	FRANCISCO XAVIER	RODRIGUEZ CHACON
20116262	MAYGRET GABRIELA	RODRIGUEZ HERNANDEZ
26271931	JOSE RAFAEL	RODRIGUEZ LUJANO-
24774216	RAFAEL JOSE	RODRIGUEZ MARTINEZ
20746174	CARLOS DANIEL	RODRIGUEZ RODRIGUEZ
25896319	MARIO ALI	RODRIGUEZ URBINA
19754799	YAHIL ALEXANDRA	ROJAS NEWMAN
21469109	DANIEL ALEXANDER	ROJAS NIEVES
19388996	CRISTIAN GABRIEL	ROJAS SOLORZANO
24286613	JOSE GREGORIO	ROJAS UZCATEGUI
24462558	LOLI JACQUERI	ROJAS ZUNIAGA
22752141	ZUKEYLA ALEJANDRA	ROMERO
25702958	KRISBELL LEONERGI	ROMERO BARRETO
7927698	MARLON MANUEL	ROMERO BLANCO
20328261	GIBREISKA LISBETH	ROMERO MENDEZ
24285694	PEDRO JOSE	RONDON LINARES
25774228	ERICK ALEJANDRO	ROSALES GARCIA
20114774	BERMY JESUS LUIS	ROSILLO ACERO
26272734	YORJHANA NAZARETH	RUIZ MALAVE
24928045	IZTEY DEL CARMEN	SAAVEDRA PEREZ
21073940	HEDWIG GERMAINE	SAHNKOW ORELLANA
16033714	EDUARDO ANTONIO	SALAS MARCANO
21436241	KEYBER ZAPHIEL	SALAS MERCADO
22282022	KIARA EMPERATRIZ	SALCEDO INFANTE
22351251	DARWIN JOSE	SALCEDO PEREZ
27207613	CHRISTIAN ALFONSO	SALOM BRICEÑO
20454787	MILDRED DEL CARMEN	SANABRIA MAITA
24222394	EDGARDO MOISES	SANABRIA VEITIA
27040324	ASHLEY VANESSA	SANCHEZ ARJONA
21469345	JOSE JESUS	SANCHEZ GONZALEZ
24524566	ALEJANDRO ENRIQUE	SANCHEZ HERNANDEZ
24463384	RICHARD ANTONIO	SANCHEZ PAUL
23689982	YILBER JESUS	SANCHEZ SUAREZ
10542767	ROBERTO ANTONIO	SANDOVAL FAJARDO
23610504	IRVIN ALEJANDRO	SANTANA CASTRO
21622060	JUAN JOSE	SANTIAGO PAGES
19586897	HENRY JOSE	SANTIAGO RIVAS
24410044	YOELVIS DAVID	SARMIENTO MONTILLA
25672909	MARTIN EDUARDO	SEMERIA JIMENEZ
19552359	JAIME JAVIER	SERNA LIRA
18760108	EDUARDO RAMON	SIRGO OJEDA
25531985	YMARU	SMITH GARCIA
21091197	GIOVANNI EULISES	SOJO PEÑA
19659566	KENNY JOSE	SOLORZANO AVILAN
23950826	KIRVING JESUS	SOMARRIBA SALAZAR
22754550	FRICKMAN ALEXIS	SOMASA RAMIREZ
22540822	JEAN PIERRE	SOSA GOMEZ
24063554	KARLOS ALFONZO	SOTO GONZALEZ
21118197	JOSE SEGUNDO	SOTO TARAZONA
26921594	SAMUEL ALEJANDRO	STROCCHIA HERNANDEZ
20748416	ENRIQUE ALEJANDRO	SUAREZ JUKISZ
19763729	MARIO AUGUSTO	SULBARAN CASTEJON
19931246	KERBY RICHARD	TABARES OLMEDO
20365535	FREDERYS FRANCISCO	TAGLIAFERRO HERNANDEZ
24901181	CARLOS AUGUSTO	TARAZONA ALMEIDA
25386797	JUAN LEANDRO	TEIXEIRA DA SILVA
19797264	ANTHONY ISRAEL	TERAN CAMACHO
21310256	MIGUEL EDUARDO	TERRAMI SANCHEZ
23625597	DANIEL ALBERTO	TORRES GONZALEZ
20301617	JOSTER ARQUIMIDES	TORRES RIVERO
13139463	MARCO MANUEL	TORRES SANCHEZ
20745288	ISAAC ABRAHAM	TORRES TORRES
21014944	JUAN JOSE	TOVAR VAZQUEZ
19387328	YARELLY DARIANA	UGARTE PEREZ
25237682	ODALYS DAYANA	URBINA SERRANO
27098844	JEREMY JOEL	URBINA VELEZ
27446164	RENZO NICOLAS	USMA BARRIOS
21469234	NEUMAN SANDINO	UZCATEGUI GARCIA
24773358	DANIEL ELVER	VALDERRAMA MEJIA
26624385	JOSDAVIN VALERO	VALERO FRANCO
24669462	ANDRES EDUARDO	VASQUEZ CALVETE
22540078	GABRIEL JESSE	VAZQUEZ OSORIO
21119846	GABRIEL ANTONIO	VEGAS GONZALEZ
20745067	LAURA JOSEFINA	VELASQUEZ PADILLA
19931786	ROBERT JUVENAL	VELASQUEZ QUINTERO
24998528	MIGUEL GADIEL	VENTURA RODRIGUEZ
25278612	CLEN JHONDAYKER	VIELMA CAMACHO
26498841	JERISMAR SOFIA	VIELMA GONZALEZ
24886516	JHONNY JESUS	VIELMA GONZALEZ
19334575	FERNANDO MIGUEL	VILLALOBOS MERLINA
20127135	HENDERSON	VILLEGAS CASTILLO
16683277	ROMNY DANIEL	VILLEGAS CASTILLO
20413673	ORLANDO LUIS	VILLEGAS MAYORA
24697525	ADRIANCYS JESUS	VILLEGAS TORO
24671815	LEANDRO TOMAS	VILORIA FLORES
24591520	LEXANDRA	YANEZ RAMIREZ
19678033	YANILCAR AYARITH	YEPEZ YEPEZ
23638689	ISAAC ALEJANDRO	YRIARTE GARCIA
24041084	JONATHAN RENIER	ZAMBRANO CONTRERAS
10187002	ALI JOSE RAFAEL	ZAPATA MENDEZ
26111652	ANYELIS YODARLIS	ZAPATA PARRA
22667832	HECTOR ALEJANDRO	ZEA SANCHEZ
18740922	JULIO FRANCISCO	ZERPA MAYOR
\.


SET search_path = err, pg_catalog;

--
-- TOC entry 2050 (class 2606 OID 57805)
-- Dependencies: 176 176
-- Name: pk_codigo; Type: CONSTRAINT; Schema: err; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_error
    ADD CONSTRAINT pk_codigo PRIMARY KEY (codigo);


--
-- TOC entry 2052 (class 2606 OID 57807)
-- Dependencies: 177 177
-- Name: pk_est_error; Type: CONSTRAINT; Schema: err; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t_est_error
    ADD CONSTRAINT pk_est_error PRIMARY KEY (codigo);


SET search_path = per, pg_catalog;

--
-- TOC entry 2042 (class 2606 OID 17116)
-- Dependencies: 171 171 171
-- Name: ca_mod_usuario; Type: CONSTRAINT; Schema: per; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_mod_usuario
    ADD CONSTRAINT ca_mod_usuario UNIQUE (cod_usuario, cod_modulo);


--
-- TOC entry 2036 (class 2606 OID 17093)
-- Dependencies: 169 169
-- Name: ca_usuario; Type: CONSTRAINT; Schema: per; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_usuario
    ADD CONSTRAINT ca_usuario UNIQUE (codigo);


--
-- TOC entry 2044 (class 2606 OID 17114)
-- Dependencies: 171 171
-- Name: cp_mod_usuario; Type: CONSTRAINT; Schema: per; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_mod_usuario
    ADD CONSTRAINT cp_mod_usuario PRIMARY KEY (codigo);


--
-- TOC entry 2034 (class 2606 OID 17085)
-- Dependencies: 168 168
-- Name: cp_modulo; Type: CONSTRAINT; Schema: per; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_modulo
    ADD CONSTRAINT cp_modulo PRIMARY KEY (codigo);


--
-- TOC entry 2040 (class 2606 OID 17103)
-- Dependencies: 170 170
-- Name: cp_tabla; Type: CONSTRAINT; Schema: per; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_tabla
    ADD CONSTRAINT cp_tabla PRIMARY KEY (nombre);


--
-- TOC entry 2038 (class 2606 OID 17091)
-- Dependencies: 169 169
-- Name: cp_usuario; Type: CONSTRAINT; Schema: per; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_usuario
    ADD CONSTRAINT cp_usuario PRIMARY KEY (nombre);


SET search_path = sis, pg_catalog;

--
-- TOC entry 2022 (class 2606 OID 17014)
-- Dependencies: 162 162 162 162
-- Name: ca_curso_01; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT ca_curso_01 UNIQUE (cod_periodo, cod_uni_curricular, seccion);


--
-- TOC entry 2028 (class 2606 OID 17044)
-- Dependencies: 164 164 164
-- Name: ca_est_curso; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT ca_est_curso UNIQUE (cod_estudiante, cod_curso);


--
-- TOC entry 2006 (class 2606 OID 16927)
-- Dependencies: 156 156
-- Name: ca_estudiante_01; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT ca_estudiante_01 UNIQUE (num_carnet);


--
-- TOC entry 2008 (class 2606 OID 16929)
-- Dependencies: 156 156
-- Name: ca_estudiante_02; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT ca_estudiante_02 UNIQUE (num_expediente);


--
-- TOC entry 2010 (class 2606 OID 16931)
-- Dependencies: 156 156
-- Name: ca_estudiante_03; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT ca_estudiante_03 UNIQUE (cod_rusnies);


--
-- TOC entry 1980 (class 2606 OID 16836)
-- Dependencies: 149 149
-- Name: ca_instituto; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_instituto
    ADD CONSTRAINT ca_instituto UNIQUE (nom_corto);


--
-- TOC entry 1962 (class 2606 OID 16768)
-- Dependencies: 144 144
-- Name: ca_pensum; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_pensum
    ADD CONSTRAINT ca_pensum UNIQUE (nom_corto);


--
-- TOC entry 1986 (class 2606 OID 16860)
-- Dependencies: 151 151 151 151
-- Name: ca_periodo; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT ca_periodo UNIQUE (cod_instituto, cod_pensum, fec_inicio);


--
-- TOC entry 1990 (class 2606 OID 16884)
-- Dependencies: 152 152
-- Name: ca_persona_01; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_01 UNIQUE (cedula);


--
-- TOC entry 1992 (class 2606 OID 16886)
-- Dependencies: 152 152
-- Name: ca_persona_02; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_02 UNIQUE (rif);


--
-- TOC entry 1994 (class 2606 OID 16888)
-- Dependencies: 152 152
-- Name: ca_persona_03; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_03 UNIQUE (cor_personal);


--
-- TOC entry 1996 (class 2606 OID 16890)
-- Dependencies: 152 152
-- Name: ca_persona_04; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT ca_persona_04 UNIQUE (cor_institucional);


--
-- TOC entry 1976 (class 2606 OID 16819)
-- Dependencies: 148 148 148
-- Name: ca_prelacion; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT ca_prelacion UNIQUE (cod_uni_curricular, cod_uni_cur_prelada);


--
-- TOC entry 1966 (class 2606 OID 16778)
-- Dependencies: 145 145 145
-- Name: ca_trayecto; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_trayecto
    ADD CONSTRAINT ca_trayecto UNIQUE (num_trayecto, cod_pensum);


--
-- TOC entry 1972 (class 2606 OID 16802)
-- Dependencies: 147 147
-- Name: ca_uni_curricular; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_uni_curricular
    ADD CONSTRAINT ca_uni_curricular UNIQUE (cod_uni_ministerio);


--
-- TOC entry 2024 (class 2606 OID 17012)
-- Dependencies: 162 162
-- Name: cp_curso; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cp_curso PRIMARY KEY (codigo);


--
-- TOC entry 2002 (class 2606 OID 16900)
-- Dependencies: 154 154
-- Name: cp_docente; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_docente
    ADD CONSTRAINT cp_docente PRIMARY KEY (codigo);


--
-- TOC entry 2026 (class 2606 OID 17034)
-- Dependencies: 163 163
-- Name: cp_est_cur_estudiante; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_est_cur_estudiante
    ADD CONSTRAINT cp_est_cur_estudiante PRIMARY KEY (codigo);


--
-- TOC entry 2030 (class 2606 OID 17042)
-- Dependencies: 164 164
-- Name: cp_est_curso; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cp_est_curso PRIMARY KEY (codigo);


--
-- TOC entry 2000 (class 2606 OID 16895)
-- Dependencies: 153 153
-- Name: cp_est_docente; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_est_docente
    ADD CONSTRAINT cp_est_docente PRIMARY KEY (codigo);


--
-- TOC entry 2004 (class 2606 OID 16920)
-- Dependencies: 155 155
-- Name: cp_est_estudiante; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_est_estudiante
    ADD CONSTRAINT cp_est_estudiante PRIMARY KEY (codigo);


--
-- TOC entry 1984 (class 2606 OID 16851)
-- Dependencies: 150 150
-- Name: cp_est_periodo; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_est_periodo
    ADD CONSTRAINT cp_est_periodo PRIMARY KEY (codigo);


--
-- TOC entry 2018 (class 2606 OID 33118)
-- Dependencies: 159 159
-- Name: cp_est_usu_con_estudios; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_est_usu_con_estudios
    ADD CONSTRAINT cp_est_usu_con_estudios PRIMARY KEY (codigo);


--
-- TOC entry 2014 (class 2606 OID 57849)
-- Dependencies: 157 157
-- Name: cp_est_usu_enc_pesum; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_est_usu_enc_pensum
    ADD CONSTRAINT cp_est_usu_enc_pesum PRIMARY KEY (codigo);


--
-- TOC entry 2046 (class 2606 OID 33099)
-- Dependencies: 173 173
-- Name: cp_est_usu_ministerio; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_est_usu_ministerio
    ADD CONSTRAINT cp_est_usu_ministerio PRIMARY KEY (codigo);


--
-- TOC entry 2012 (class 2606 OID 16925)
-- Dependencies: 156 156
-- Name: cp_estudiante; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cp_estudiante PRIMARY KEY (codigo);


--
-- TOC entry 2032 (class 2606 OID 17064)
-- Dependencies: 165 165
-- Name: cp_fotografia; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_fotografia
    ADD CONSTRAINT cp_fotografia PRIMARY KEY (cod_persona);


--
-- TOC entry 1982 (class 2606 OID 16834)
-- Dependencies: 149 149
-- Name: cp_instituto; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_instituto
    ADD CONSTRAINT cp_instituto PRIMARY KEY (codigo);


--
-- TOC entry 1964 (class 2606 OID 16766)
-- Dependencies: 144 144
-- Name: cp_pensum; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_pensum
    ADD CONSTRAINT cp_pensum PRIMARY KEY (codigo);


--
-- TOC entry 1988 (class 2606 OID 16858)
-- Dependencies: 151 151
-- Name: cp_periodo; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT cp_periodo PRIMARY KEY (codigo);


--
-- TOC entry 1998 (class 2606 OID 16882)
-- Dependencies: 152 152
-- Name: cp_persona; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_persona
    ADD CONSTRAINT cp_persona PRIMARY KEY (codigo);


--
-- TOC entry 1978 (class 2606 OID 16817)
-- Dependencies: 148 148
-- Name: cp_prelacion; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cp_prelacion PRIMARY KEY (codigo);


--
-- TOC entry 1968 (class 2606 OID 16776)
-- Dependencies: 145 145
-- Name: cp_trayecto; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_trayecto
    ADD CONSTRAINT cp_trayecto PRIMARY KEY (codigo);


--
-- TOC entry 1970 (class 2606 OID 16788)
-- Dependencies: 146 146
-- Name: cp_uni_cur_tipo; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_tip_uni_curricular
    ADD CONSTRAINT cp_uni_cur_tipo PRIMARY KEY (codigo);


--
-- TOC entry 1974 (class 2606 OID 16800)
-- Dependencies: 147 147
-- Name: cp_uni_curricular; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_uni_curricular
    ADD CONSTRAINT cp_uni_curricular PRIMARY KEY (codigo);


--
-- TOC entry 2020 (class 2606 OID 33116)
-- Dependencies: 160 160
-- Name: cp_usu_con_estudios; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_usu_con_estudios
    ADD CONSTRAINT cp_usu_con_estudios PRIMARY KEY (codigo);


--
-- TOC entry 2016 (class 2606 OID 57866)
-- Dependencies: 158 158
-- Name: cp_usu_enc_pensum; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_usu_enc_pensum
    ADD CONSTRAINT cp_usu_enc_pensum PRIMARY KEY (codigo);


--
-- TOC entry 2048 (class 2606 OID 33104)
-- Dependencies: 174 174
-- Name: cp_usu_ministerio; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_usu_ministerio
    ADD CONSTRAINT cp_usu_ministerio PRIMARY KEY (codigo);


--
-- TOC entry 2054 (class 2606 OID 66041)
-- Dependencies: 179 179
-- Name: t_estudiante_temp_id_key; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_estudiante_temp
    ADD CONSTRAINT t_estudiante_temp_id_key UNIQUE (id);


--
-- TOC entry 2056 (class 2606 OID 66039)
-- Dependencies: 179 179
-- Name: t_estudiante_temp_pkey; Type: CONSTRAINT; Schema: sis; Owner: usuarioscn; Tablespace: 
--

ALTER TABLE ONLY t_estudiante_temp
    ADD CONSTRAINT t_estudiante_temp_pkey PRIMARY KEY (cedula);


--
-- TOC entry 2058 (class 2606 OID 66050)
-- Dependencies: 180 180
-- Name: t_persona_temp_2_pkey; Type: CONSTRAINT; Schema: sis; Owner: alamoj; Tablespace: 
--

ALTER TABLE ONLY t_persona_temp_2
    ADD CONSTRAINT t_persona_temp_2_pkey PRIMARY KEY (cedula);


SET search_path = tmp, pg_catalog;

--
-- TOC entry 2060 (class 2606 OID 66072)
-- Dependencies: 182 182
-- Name: activos_infor_dic_2015_pkey; Type: CONSTRAINT; Schema: tmp; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY activos_infor_dic_2015
    ADD CONSTRAINT activos_infor_dic_2015_pkey PRIMARY KEY (cedula);


SET search_path = err, pg_catalog;

--
-- TOC entry 2096 (class 2606 OID 57808)
-- Dependencies: 1997 176 152
-- Name: fk_err_usuario; Type: FK CONSTRAINT; Schema: err; Owner: usuarioscn
--

ALTER TABLE ONLY t_error
    ADD CONSTRAINT fk_err_usuario FOREIGN KEY (cod_usuario) REFERENCES sis.t_persona(codigo);


--
-- TOC entry 2097 (class 2606 OID 57813)
-- Dependencies: 2051 177 176
-- Name: fk_est_error; Type: FK CONSTRAINT; Schema: err; Owner: usuarioscn
--

ALTER TABLE ONLY t_error
    ADD CONSTRAINT fk_est_error FOREIGN KEY (cod_estatus) REFERENCES t_est_error(codigo);


SET search_path = per, pg_catalog;

--
-- TOC entry 2093 (class 2606 OID 17122)
-- Dependencies: 168 171 2033
-- Name: cf_mod_usuario__modulo; Type: FK CONSTRAINT; Schema: per; Owner: usuarioscn
--

ALTER TABLE ONLY t_mod_usuario
    ADD CONSTRAINT cf_mod_usuario__modulo FOREIGN KEY (cod_modulo) REFERENCES t_modulo(codigo);


--
-- TOC entry 2092 (class 2606 OID 17117)
-- Dependencies: 171 2035 169
-- Name: cf_mod_usuario__usuario; Type: FK CONSTRAINT; Schema: per; Owner: usuarioscn
--

ALTER TABLE ONLY t_mod_usuario
    ADD CONSTRAINT cf_mod_usuario__usuario FOREIGN KEY (cod_usuario) REFERENCES t_usuario(codigo);


--
-- TOC entry 2091 (class 2606 OID 17104)
-- Dependencies: 170 2033 168
-- Name: cf_tabla__modulo; Type: FK CONSTRAINT; Schema: per; Owner: usuarioscn
--

ALTER TABLE ONLY t_tabla
    ADD CONSTRAINT cf_tabla__modulo FOREIGN KEY (cod_modulo) REFERENCES t_modulo(codigo);


--
-- TOC entry 2090 (class 2606 OID 17094)
-- Dependencies: 1997 152 169
-- Name: cf_usuario__persona; Type: FK CONSTRAINT; Schema: per; Owner: usuarioscn
--

ALTER TABLE ONLY t_usuario
    ADD CONSTRAINT cf_usuario__persona FOREIGN KEY (codigo) REFERENCES sis.t_persona(codigo);


SET search_path = sis, pg_catalog;

--
-- TOC entry 2085 (class 2606 OID 17025)
-- Dependencies: 2001 162 154
-- Name: cf_curso__docente; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cf_curso__docente FOREIGN KEY (cod_docente) REFERENCES t_docente(codigo);


--
-- TOC entry 2083 (class 2606 OID 17015)
-- Dependencies: 151 162 1987
-- Name: cf_curso__periodo; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cf_curso__periodo FOREIGN KEY (cod_periodo) REFERENCES t_periodo(codigo);


--
-- TOC entry 2084 (class 2606 OID 17020)
-- Dependencies: 1973 162 147
-- Name: cf_curso__uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_curso
    ADD CONSTRAINT cf_curso__uni_curricular FOREIGN KEY (cod_uni_curricular) REFERENCES t_uni_curricular(codigo);


--
-- TOC entry 2070 (class 2606 OID 16906)
-- Dependencies: 1999 154 153
-- Name: cf_docente__est_docente; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_docente
    ADD CONSTRAINT cf_docente__est_docente FOREIGN KEY (cod_estado) REFERENCES t_est_docente(codigo);


--
-- TOC entry 2069 (class 2606 OID 16901)
-- Dependencies: 152 154 1997
-- Name: cf_docente__persona; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_docente
    ADD CONSTRAINT cf_docente__persona FOREIGN KEY (codigo) REFERENCES t_persona(codigo);


--
-- TOC entry 2087 (class 2606 OID 17050)
-- Dependencies: 164 2023 162
-- Name: cf_est_curso__curso; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cf_est_curso__curso FOREIGN KEY (cod_curso) REFERENCES t_curso(codigo);


--
-- TOC entry 2088 (class 2606 OID 17055)
-- Dependencies: 163 164 2025
-- Name: cf_est_curso__est_cur_estado; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cf_est_curso__est_cur_estado FOREIGN KEY (cod_estado) REFERENCES t_est_cur_estudiante(codigo);


--
-- TOC entry 2086 (class 2606 OID 17045)
-- Dependencies: 156 164 2011
-- Name: cf_est_curso__estudiante; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_cur_estudiante
    ADD CONSTRAINT cf_est_curso__estudiante FOREIGN KEY (cod_estudiante) REFERENCES t_estudiante(codigo);


--
-- TOC entry 2080 (class 2606 OID 33119)
-- Dependencies: 2017 160 159
-- Name: cf_est_usu_con_estudios; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_con_estudios
    ADD CONSTRAINT cf_est_usu_con_estudios FOREIGN KEY (cod_estado) REFERENCES t_est_usu_con_estudios(codigo);


--
-- TOC entry 2073 (class 2606 OID 16937)
-- Dependencies: 155 156 2003
-- Name: cf_estudiante__est_estado; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cf_estudiante__est_estado FOREIGN KEY (cod_estado) REFERENCES t_est_estudiante(codigo);


--
-- TOC entry 2074 (class 2606 OID 16947)
-- Dependencies: 144 156 1963
-- Name: cf_estudiante__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cf_estudiante__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- TOC entry 2072 (class 2606 OID 16932)
-- Dependencies: 152 156 1997
-- Name: cf_estudiante__persona; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT cf_estudiante__persona FOREIGN KEY (codigo) REFERENCES t_persona(codigo);


--
-- TOC entry 2089 (class 2606 OID 17065)
-- Dependencies: 152 165 1997
-- Name: cf_fotografia__persona; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_fotografia
    ADD CONSTRAINT cf_fotografia__persona FOREIGN KEY (cod_persona) REFERENCES t_persona(codigo);


--
-- TOC entry 2067 (class 2606 OID 16871)
-- Dependencies: 150 151 1983
-- Name: cf_periodo__est_periodo; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT cf_periodo__est_periodo FOREIGN KEY (cod_estado) REFERENCES t_est_periodo(codigo);


--
-- TOC entry 2066 (class 2606 OID 16866)
-- Dependencies: 144 151 1963
-- Name: cf_periodo__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT cf_periodo__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- TOC entry 2064 (class 2606 OID 16820)
-- Dependencies: 148 1973 147
-- Name: cf_prelacion_01; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cf_prelacion_01 FOREIGN KEY (cod_uni_curricular) REFERENCES t_uni_curricular(codigo);


--
-- TOC entry 2065 (class 2606 OID 16825)
-- Dependencies: 147 1973 148
-- Name: cf_prelacion_02; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_prelacion
    ADD CONSTRAINT cf_prelacion_02 FOREIGN KEY (cod_uni_cur_prelada) REFERENCES t_uni_curricular(codigo);


--
-- TOC entry 2061 (class 2606 OID 16779)
-- Dependencies: 1963 144 145
-- Name: cf_trayecto__pensum; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_trayecto
    ADD CONSTRAINT cf_trayecto__pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- TOC entry 2062 (class 2606 OID 16803)
-- Dependencies: 147 1967 145
-- Name: cf_uni_curicular__trayecto; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_uni_curricular
    ADD CONSTRAINT cf_uni_curicular__trayecto FOREIGN KEY (cod_trayecto) REFERENCES t_trayecto(codigo);


--
-- TOC entry 2063 (class 2606 OID 16808)
-- Dependencies: 147 1969 146
-- Name: cf_uni_curricular__tip_uni_curricular; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_uni_curricular
    ADD CONSTRAINT cf_uni_curricular__tip_uni_curricular FOREIGN KEY (cod_tipo) REFERENCES t_tip_uni_curricular(codigo);


--
-- TOC entry 2081 (class 2606 OID 33124)
-- Dependencies: 149 160 1981
-- Name: cf_usu_con_est_instituto; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_con_estudios
    ADD CONSTRAINT cf_usu_con_est_instituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- TOC entry 2082 (class 2606 OID 33129)
-- Dependencies: 152 1997 160
-- Name: cf_usu_cont_est_persona; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_con_estudios
    ADD CONSTRAINT cf_usu_cont_est_persona FOREIGN KEY (codigo) REFERENCES t_persona(codigo);


--
-- TOC entry 2076 (class 2606 OID 33158)
-- Dependencies: 152 1997 158
-- Name: cf_usu_dep_persona; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_enc_pensum
    ADD CONSTRAINT cf_usu_dep_persona FOREIGN KEY (codigo) REFERENCES t_persona(codigo);


--
-- TOC entry 2094 (class 2606 OID 33105)
-- Dependencies: 1997 152 174
-- Name: cf_usu_min__persona; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_ministerio
    ADD CONSTRAINT cf_usu_min__persona FOREIGN KEY (codigo) REFERENCES t_persona(codigo);


--
-- TOC entry 2095 (class 2606 OID 33110)
-- Dependencies: 173 174 2045
-- Name: cf_usu_min_estado; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_ministerio
    ADD CONSTRAINT cf_usu_min_estado FOREIGN KEY (cod_estado) REFERENCES t_est_usu_ministerio(codigo);


--
-- TOC entry 2071 (class 2606 OID 57838)
-- Dependencies: 1981 149 154
-- Name: fk_docente__intituto; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_docente
    ADD CONSTRAINT fk_docente__intituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- TOC entry 2075 (class 2606 OID 57843)
-- Dependencies: 1981 156 149
-- Name: fk_estudiante__intituto; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_estudiante
    ADD CONSTRAINT fk_estudiante__intituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- TOC entry 2068 (class 2606 OID 57833)
-- Dependencies: 1981 151 149
-- Name: fk_periodo__intituto; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_periodo
    ADD CONSTRAINT fk_periodo__intituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- TOC entry 2079 (class 2606 OID 57860)
-- Dependencies: 158 157 2013
-- Name: fk_usu_enc_pensum_est_usu_enc_pensum; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_enc_pensum
    ADD CONSTRAINT fk_usu_enc_pensum_est_usu_enc_pensum FOREIGN KEY (cod_estado) REFERENCES t_est_usu_enc_pensum(codigo);


--
-- TOC entry 2077 (class 2606 OID 57850)
-- Dependencies: 1981 149 158
-- Name: fk_usu_enc_pensum_instituto; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_enc_pensum
    ADD CONSTRAINT fk_usu_enc_pensum_instituto FOREIGN KEY (cod_instituto) REFERENCES t_instituto(codigo);


--
-- TOC entry 2078 (class 2606 OID 57855)
-- Dependencies: 144 1963 158
-- Name: fk_usu_enc_pensum_pensum; Type: FK CONSTRAINT; Schema: sis; Owner: usuarioscn
--

ALTER TABLE ONLY t_usu_enc_pensum
    ADD CONSTRAINT fk_usu_enc_pensum_pensum FOREIGN KEY (cod_pensum) REFERENCES t_pensum(codigo);


--
-- TOC entry 2134 (class 0 OID 0)
-- Dependencies: 8
-- Name: err; Type: ACL; Schema: -; Owner: usuarioscn
--

REVOKE ALL ON SCHEMA err FROM PUBLIC;
REVOKE ALL ON SCHEMA err FROM usuarioscn;
GRANT ALL ON SCHEMA err TO usuarioscn;
GRANT ALL ON SCHEMA err TO alamoj;
GRANT ALL ON SCHEMA err TO carranzac;
GRANT ALL ON SCHEMA err TO dulceyr;
GRANT ALL ON SCHEMA err TO balzap;
GRANT ALL ON SCHEMA err TO gutierrezj;
GRANT ALL ON SCHEMA err TO castanedam;
GRANT ALL ON SCHEMA err TO parelesn;
GRANT ALL ON SCHEMA err TO landazabalc;
GRANT ALL ON SCHEMA err TO waracaog;
GRANT ALL ON SCHEMA err TO caninoa;
GRANT ALL ON SCHEMA err TO santiagoo;
GRANT ALL ON SCHEMA err TO arcilag;
GRANT ALL ON SCHEMA err TO gomezr;
GRANT ALL ON SCHEMA err TO mendozal;
GRANT ALL ON SCHEMA err TO morad;
GRANT ALL ON SCHEMA err TO albarrani;
GRANT ALL ON SCHEMA err TO romerob;
GRANT ALL ON SCHEMA err TO castrom;


--
-- TOC entry 2135 (class 0 OID 0)
-- Dependencies: 7
-- Name: per; Type: ACL; Schema: -; Owner: usuarioscn
--

REVOKE ALL ON SCHEMA per FROM PUBLIC;
REVOKE ALL ON SCHEMA per FROM usuarioscn;
GRANT ALL ON SCHEMA per TO usuarioscn;
GRANT ALL ON SCHEMA per TO alamoj;
GRANT ALL ON SCHEMA per TO mendozal;
GRANT ALL ON SCHEMA per TO vielmaj;
GRANT ALL ON SCHEMA per TO desantiagoo;
GRANT ALL ON SCHEMA per TO balzap;
GRANT ALL ON SCHEMA per TO "castañedam";
GRANT ALL ON SCHEMA per TO carranzac;
GRANT ALL ON SCHEMA per TO dulceyr;
GRANT ALL ON SCHEMA per TO gutierrezj;
GRANT ALL ON SCHEMA per TO castanedam;
GRANT ALL ON SCHEMA per TO parelesn;
GRANT ALL ON SCHEMA per TO landazabalc;
GRANT ALL ON SCHEMA per TO waracaog;
GRANT ALL ON SCHEMA per TO caninoa;
GRANT ALL ON SCHEMA per TO santiagoo;
GRANT ALL ON SCHEMA per TO arcilag;
GRANT ALL ON SCHEMA per TO gomezr;
GRANT ALL ON SCHEMA per TO morad;
GRANT ALL ON SCHEMA per TO albarrani;
GRANT ALL ON SCHEMA per TO romerob;
GRANT ALL ON SCHEMA per TO castrom;


--
-- TOC entry 2137 (class 0 OID 0)
-- Dependencies: 9
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO balzap;
GRANT ALL ON SCHEMA public TO gutierrezj;
GRANT ALL ON SCHEMA public TO castanedam;
GRANT ALL ON SCHEMA public TO parelesn;
GRANT ALL ON SCHEMA public TO landazabalc;
GRANT ALL ON SCHEMA public TO waracaog;
GRANT ALL ON SCHEMA public TO caninoa;
GRANT ALL ON SCHEMA public TO santiagoo;
GRANT ALL ON SCHEMA public TO arcilag;
GRANT ALL ON SCHEMA public TO gomezr;
GRANT ALL ON SCHEMA public TO mendozal;
GRANT ALL ON SCHEMA public TO morad;
GRANT ALL ON SCHEMA public TO albarrani;
GRANT ALL ON SCHEMA public TO romerob;
GRANT ALL ON SCHEMA public TO castrom;


--
-- TOC entry 2138 (class 0 OID 0)
-- Dependencies: 6
-- Name: sis; Type: ACL; Schema: -; Owner: usuarioscn
--

REVOKE ALL ON SCHEMA sis FROM PUBLIC;
REVOKE ALL ON SCHEMA sis FROM usuarioscn;
GRANT ALL ON SCHEMA sis TO usuarioscn;
GRANT ALL ON SCHEMA sis TO jhonny;
GRANT ALL ON SCHEMA sis TO alamoj;
GRANT ALL ON SCHEMA sis TO mendozal;
GRANT ALL ON SCHEMA sis TO vielmaj;
GRANT ALL ON SCHEMA sis TO desantiagoo;
GRANT ALL ON SCHEMA sis TO balzap;
GRANT ALL ON SCHEMA sis TO "castañedam";
GRANT ALL ON SCHEMA sis TO carranzac;
GRANT ALL ON SCHEMA sis TO fernandezm;
GRANT ALL ON SCHEMA sis TO informatica2;
GRANT ALL ON SCHEMA sis TO informatica1;
GRANT ALL ON SCHEMA sis TO olivaress;
GRANT ALL ON SCHEMA sis TO castrom;
GRANT ALL ON SCHEMA sis TO romerob;
GRANT ALL ON SCHEMA sis TO mendozao;
GRANT ALL ON SCHEMA sis TO dulceyr;
GRANT ALL ON SCHEMA sis TO gutierrezj;
GRANT ALL ON SCHEMA sis TO castanedam;
GRANT ALL ON SCHEMA sis TO parelesn;
GRANT ALL ON SCHEMA sis TO landazabalc;
GRANT ALL ON SCHEMA sis TO waracaog;
GRANT ALL ON SCHEMA sis TO caninoa;
GRANT ALL ON SCHEMA sis TO santiagoo;
GRANT ALL ON SCHEMA sis TO arcilag;
GRANT ALL ON SCHEMA sis TO gomezr;
GRANT ALL ON SCHEMA sis TO morad;
GRANT ALL ON SCHEMA sis TO albarrani;


SET search_path = err, pg_catalog;

--
-- TOC entry 2139 (class 0 OID 0)
-- Dependencies: 176
-- Name: t_error; Type: ACL; Schema: err; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_error FROM PUBLIC;
REVOKE ALL ON TABLE t_error FROM usuarioscn;
GRANT ALL ON TABLE t_error TO usuarioscn;
GRANT ALL ON TABLE t_error TO alamoj;
GRANT ALL ON TABLE t_error TO carranzac;
GRANT ALL ON TABLE t_error TO balzap;
GRANT ALL ON TABLE t_error TO gutierrezj;
GRANT ALL ON TABLE t_error TO castanedam;
GRANT ALL ON TABLE t_error TO parelesn;
GRANT ALL ON TABLE t_error TO landazabalc;
GRANT ALL ON TABLE t_error TO waracaog;
GRANT ALL ON TABLE t_error TO caninoa;
GRANT ALL ON TABLE t_error TO santiagoo;
GRANT ALL ON TABLE t_error TO arcilag;
GRANT ALL ON TABLE t_error TO gomezr;
GRANT ALL ON TABLE t_error TO mendozal;
GRANT ALL ON TABLE t_error TO morad;
GRANT ALL ON TABLE t_error TO albarrani;
GRANT ALL ON TABLE t_error TO romerob;
GRANT ALL ON TABLE t_error TO castrom;


--
-- TOC entry 2140 (class 0 OID 0)
-- Dependencies: 177
-- Name: t_est_error; Type: ACL; Schema: err; Owner: postgres
--

REVOKE ALL ON TABLE t_est_error FROM PUBLIC;
REVOKE ALL ON TABLE t_est_error FROM postgres;
GRANT ALL ON TABLE t_est_error TO postgres;
GRANT ALL ON TABLE t_est_error TO usuarioscn;
GRANT ALL ON TABLE t_est_error TO alamoj;
GRANT ALL ON TABLE t_est_error TO carranzac;
GRANT ALL ON TABLE t_est_error TO balzap;
GRANT ALL ON TABLE t_est_error TO gutierrezj;
GRANT ALL ON TABLE t_est_error TO castanedam;
GRANT ALL ON TABLE t_est_error TO parelesn;
GRANT ALL ON TABLE t_est_error TO landazabalc;
GRANT ALL ON TABLE t_est_error TO waracaog;
GRANT ALL ON TABLE t_est_error TO caninoa;
GRANT ALL ON TABLE t_est_error TO santiagoo;
GRANT ALL ON TABLE t_est_error TO arcilag;
GRANT ALL ON TABLE t_est_error TO gomezr;
GRANT ALL ON TABLE t_est_error TO mendozal;
GRANT ALL ON TABLE t_est_error TO morad;
GRANT ALL ON TABLE t_est_error TO albarrani;
GRANT ALL ON TABLE t_est_error TO romerob;
GRANT ALL ON TABLE t_est_error TO castrom;


SET search_path = per, pg_catalog;

--
-- TOC entry 2141 (class 0 OID 0)
-- Dependencies: 172
-- Name: t_menu; Type: ACL; Schema: per; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_menu FROM PUBLIC;
REVOKE ALL ON TABLE t_menu FROM usuarioscn;
GRANT ALL ON TABLE t_menu TO usuarioscn;
GRANT ALL ON TABLE t_menu TO jhonny;
GRANT ALL ON TABLE t_menu TO vielmaj;
GRANT ALL ON TABLE t_menu TO desantiagoo;
GRANT ALL ON TABLE t_menu TO balzap;
GRANT ALL ON TABLE t_menu TO "castañedam";
GRANT ALL ON TABLE t_menu TO carranzac;
GRANT ALL ON TABLE t_menu TO romerob;
GRANT ALL ON TABLE t_menu TO alamoj;
GRANT ALL ON TABLE t_menu TO gutierrezj;
GRANT ALL ON TABLE t_menu TO castanedam;
GRANT ALL ON TABLE t_menu TO parelesn;
GRANT ALL ON TABLE t_menu TO landazabalc;
GRANT ALL ON TABLE t_menu TO waracaog;
GRANT ALL ON TABLE t_menu TO caninoa;
GRANT ALL ON TABLE t_menu TO santiagoo;
GRANT ALL ON TABLE t_menu TO arcilag;
GRANT ALL ON TABLE t_menu TO gomezr;
GRANT ALL ON TABLE t_menu TO mendozal;
GRANT ALL ON TABLE t_menu TO morad;
GRANT ALL ON TABLE t_menu TO albarrani;
GRANT ALL ON TABLE t_menu TO castrom;


--
-- TOC entry 2148 (class 0 OID 0)
-- Dependencies: 171
-- Name: t_mod_usuario; Type: ACL; Schema: per; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_mod_usuario FROM PUBLIC;
REVOKE ALL ON TABLE t_mod_usuario FROM usuarioscn;
GRANT ALL ON TABLE t_mod_usuario TO usuarioscn;
GRANT ALL ON TABLE t_mod_usuario TO jhonny;
GRANT ALL ON TABLE t_mod_usuario TO vielmaj;
GRANT ALL ON TABLE t_mod_usuario TO desantiagoo;
GRANT ALL ON TABLE t_mod_usuario TO balzap;
GRANT ALL ON TABLE t_mod_usuario TO "castañedam";
GRANT ALL ON TABLE t_mod_usuario TO carranzac;
GRANT ALL ON TABLE t_mod_usuario TO romerob;
GRANT ALL ON TABLE t_mod_usuario TO alamoj;
GRANT ALL ON TABLE t_mod_usuario TO gutierrezj;
GRANT ALL ON TABLE t_mod_usuario TO castanedam;
GRANT ALL ON TABLE t_mod_usuario TO parelesn;
GRANT ALL ON TABLE t_mod_usuario TO landazabalc;
GRANT ALL ON TABLE t_mod_usuario TO waracaog;
GRANT ALL ON TABLE t_mod_usuario TO caninoa;
GRANT ALL ON TABLE t_mod_usuario TO santiagoo;
GRANT ALL ON TABLE t_mod_usuario TO arcilag;
GRANT ALL ON TABLE t_mod_usuario TO gomezr;
GRANT ALL ON TABLE t_mod_usuario TO mendozal;
GRANT ALL ON TABLE t_mod_usuario TO morad;
GRANT ALL ON TABLE t_mod_usuario TO albarrani;
GRANT ALL ON TABLE t_mod_usuario TO castrom;


--
-- TOC entry 2152 (class 0 OID 0)
-- Dependencies: 168
-- Name: t_modulo; Type: ACL; Schema: per; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_modulo FROM PUBLIC;
REVOKE ALL ON TABLE t_modulo FROM usuarioscn;
GRANT ALL ON TABLE t_modulo TO usuarioscn;
GRANT ALL ON TABLE t_modulo TO jhonny;
GRANT ALL ON TABLE t_modulo TO vielmaj;
GRANT ALL ON TABLE t_modulo TO desantiagoo;
GRANT ALL ON TABLE t_modulo TO balzap;
GRANT ALL ON TABLE t_modulo TO "castañedam";
GRANT ALL ON TABLE t_modulo TO carranzac;
GRANT ALL ON TABLE t_modulo TO romerob;
GRANT ALL ON TABLE t_modulo TO alamoj;
GRANT ALL ON TABLE t_modulo TO gutierrezj;
GRANT ALL ON TABLE t_modulo TO castanedam;
GRANT ALL ON TABLE t_modulo TO parelesn;
GRANT ALL ON TABLE t_modulo TO landazabalc;
GRANT ALL ON TABLE t_modulo TO waracaog;
GRANT ALL ON TABLE t_modulo TO caninoa;
GRANT ALL ON TABLE t_modulo TO santiagoo;
GRANT ALL ON TABLE t_modulo TO arcilag;
GRANT ALL ON TABLE t_modulo TO gomezr;
GRANT ALL ON TABLE t_modulo TO mendozal;
GRANT ALL ON TABLE t_modulo TO morad;
GRANT ALL ON TABLE t_modulo TO albarrani;
GRANT ALL ON TABLE t_modulo TO castrom;


--
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 170
-- Name: t_tabla; Type: ACL; Schema: per; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_tabla FROM PUBLIC;
REVOKE ALL ON TABLE t_tabla FROM usuarioscn;
GRANT ALL ON TABLE t_tabla TO usuarioscn;
GRANT ALL ON TABLE t_tabla TO jhonny;
GRANT ALL ON TABLE t_tabla TO vielmaj;
GRANT ALL ON TABLE t_tabla TO desantiagoo;
GRANT ALL ON TABLE t_tabla TO balzap;
GRANT ALL ON TABLE t_tabla TO "castañedam";
GRANT ALL ON TABLE t_tabla TO carranzac;
GRANT ALL ON TABLE t_tabla TO romerob;
GRANT ALL ON TABLE t_tabla TO alamoj;
GRANT ALL ON TABLE t_tabla TO gutierrezj;
GRANT ALL ON TABLE t_tabla TO castanedam;
GRANT ALL ON TABLE t_tabla TO parelesn;
GRANT ALL ON TABLE t_tabla TO landazabalc;
GRANT ALL ON TABLE t_tabla TO waracaog;
GRANT ALL ON TABLE t_tabla TO caninoa;
GRANT ALL ON TABLE t_tabla TO santiagoo;
GRANT ALL ON TABLE t_tabla TO arcilag;
GRANT ALL ON TABLE t_tabla TO gomezr;
GRANT ALL ON TABLE t_tabla TO mendozal;
GRANT ALL ON TABLE t_tabla TO morad;
GRANT ALL ON TABLE t_tabla TO albarrani;
GRANT ALL ON TABLE t_tabla TO castrom;


--
-- TOC entry 2161 (class 0 OID 0)
-- Dependencies: 169
-- Name: t_usuario; Type: ACL; Schema: per; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_usuario FROM PUBLIC;
REVOKE ALL ON TABLE t_usuario FROM usuarioscn;
GRANT ALL ON TABLE t_usuario TO usuarioscn;
GRANT ALL ON TABLE t_usuario TO jhonny;
GRANT ALL ON TABLE t_usuario TO vielmaj;
GRANT ALL ON TABLE t_usuario TO desantiagoo;
GRANT ALL ON TABLE t_usuario TO balzap;
GRANT ALL ON TABLE t_usuario TO "castañedam";
GRANT ALL ON TABLE t_usuario TO carranzac;
GRANT ALL ON TABLE t_usuario TO romerob;
GRANT ALL ON TABLE t_usuario TO alamoj;
GRANT ALL ON TABLE t_usuario TO gutierrezj;
GRANT ALL ON TABLE t_usuario TO castanedam;
GRANT ALL ON TABLE t_usuario TO parelesn;
GRANT ALL ON TABLE t_usuario TO landazabalc;
GRANT ALL ON TABLE t_usuario TO waracaog;
GRANT ALL ON TABLE t_usuario TO caninoa;
GRANT ALL ON TABLE t_usuario TO santiagoo;
GRANT ALL ON TABLE t_usuario TO arcilag;
GRANT ALL ON TABLE t_usuario TO gomezr;
GRANT ALL ON TABLE t_usuario TO mendozal;
GRANT ALL ON TABLE t_usuario TO morad;
GRANT ALL ON TABLE t_usuario TO albarrani;
GRANT ALL ON TABLE t_usuario TO castrom;


SET search_path = sis, pg_catalog;

--
-- TOC entry 2162 (class 0 OID 0)
-- Dependencies: 164
-- Name: t_cur_estudiante; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_cur_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_cur_estudiante FROM usuarioscn;
GRANT ALL ON TABLE t_cur_estudiante TO usuarioscn;
GRANT ALL ON TABLE t_cur_estudiante TO jhonny;
GRANT ALL ON TABLE t_cur_estudiante TO alamoj;
GRANT ALL ON TABLE t_cur_estudiante TO mendozal;
GRANT ALL ON TABLE t_cur_estudiante TO vielmaj;
GRANT ALL ON TABLE t_cur_estudiante TO desantiagoo;
GRANT ALL ON TABLE t_cur_estudiante TO balzap;
GRANT ALL ON TABLE t_cur_estudiante TO "castañedam";
GRANT ALL ON TABLE t_cur_estudiante TO carranzac;
GRANT ALL ON TABLE t_cur_estudiante TO fernandezm;
GRANT ALL ON TABLE t_cur_estudiante TO informatica2;
GRANT ALL ON TABLE t_cur_estudiante TO informatica1;
GRANT ALL ON TABLE t_cur_estudiante TO olivaress;
GRANT ALL ON TABLE t_cur_estudiante TO castrom;
GRANT ALL ON TABLE t_cur_estudiante TO romerob;
GRANT ALL ON TABLE t_cur_estudiante TO mendozao;
GRANT ALL ON TABLE t_cur_estudiante TO dulceyr;
GRANT ALL ON TABLE t_cur_estudiante TO gutierrezj;
GRANT ALL ON TABLE t_cur_estudiante TO castanedam;
GRANT ALL ON TABLE t_cur_estudiante TO parelesn;
GRANT ALL ON TABLE t_cur_estudiante TO landazabalc;
GRANT ALL ON TABLE t_cur_estudiante TO waracaog;
GRANT ALL ON TABLE t_cur_estudiante TO caninoa;
GRANT ALL ON TABLE t_cur_estudiante TO santiagoo;
GRANT ALL ON TABLE t_cur_estudiante TO arcilag;
GRANT ALL ON TABLE t_cur_estudiante TO gomezr;
GRANT ALL ON TABLE t_cur_estudiante TO morad;
GRANT ALL ON TABLE t_cur_estudiante TO albarrani;


--
-- TOC entry 2163 (class 0 OID 0)
-- Dependencies: 162
-- Name: t_curso; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_curso FROM PUBLIC;
REVOKE ALL ON TABLE t_curso FROM usuarioscn;
GRANT ALL ON TABLE t_curso TO usuarioscn;
GRANT ALL ON TABLE t_curso TO jhonny;
GRANT ALL ON TABLE t_curso TO alamoj;
GRANT ALL ON TABLE t_curso TO mendozal;
GRANT ALL ON TABLE t_curso TO vielmaj;
GRANT ALL ON TABLE t_curso TO desantiagoo;
GRANT ALL ON TABLE t_curso TO balzap;
GRANT ALL ON TABLE t_curso TO "castañedam";
GRANT ALL ON TABLE t_curso TO carranzac;
GRANT ALL ON TABLE t_curso TO fernandezm;
GRANT ALL ON TABLE t_curso TO informatica2;
GRANT ALL ON TABLE t_curso TO informatica1;
GRANT ALL ON TABLE t_curso TO olivaress;
GRANT ALL ON TABLE t_curso TO castrom;
GRANT ALL ON TABLE t_curso TO romerob;
GRANT ALL ON TABLE t_curso TO mendozao;
GRANT ALL ON TABLE t_curso TO dulceyr;
GRANT ALL ON TABLE t_curso TO gutierrezj;
GRANT ALL ON TABLE t_curso TO castanedam;
GRANT ALL ON TABLE t_curso TO parelesn;
GRANT ALL ON TABLE t_curso TO landazabalc;
GRANT ALL ON TABLE t_curso TO waracaog;
GRANT ALL ON TABLE t_curso TO caninoa;
GRANT ALL ON TABLE t_curso TO santiagoo;
GRANT ALL ON TABLE t_curso TO arcilag;
GRANT ALL ON TABLE t_curso TO gomezr;
GRANT ALL ON TABLE t_curso TO morad;
GRANT ALL ON TABLE t_curso TO albarrani;


--
-- TOC entry 2166 (class 0 OID 0)
-- Dependencies: 161
-- Name: t_curso_codigo_seq; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON SEQUENCE t_curso_codigo_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE t_curso_codigo_seq FROM usuarioscn;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO usuarioscn;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO jhonny;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO mendozal;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO alamoj;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO vielmaj;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO desantiagoo;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO balzap;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO "castañedam";
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO carranzac;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO informatica1;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO fernandezm;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO informatica2;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO olivaress;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO castrom;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO gutierrezj;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO castanedam;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO parelesn;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO landazabalc;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO waracaog;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO caninoa;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO santiagoo;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO arcilag;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO gomezr;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO morad;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO albarrani;
GRANT ALL ON SEQUENCE t_curso_codigo_seq TO romerob;


--
-- TOC entry 2167 (class 0 OID 0)
-- Dependencies: 154
-- Name: t_docente; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_docente FROM PUBLIC;
REVOKE ALL ON TABLE t_docente FROM usuarioscn;
GRANT ALL ON TABLE t_docente TO usuarioscn;
GRANT ALL ON TABLE t_docente TO jhonny;
GRANT ALL ON TABLE t_docente TO alamoj;
GRANT ALL ON TABLE t_docente TO mendozal;
GRANT ALL ON TABLE t_docente TO vielmaj;
GRANT ALL ON TABLE t_docente TO desantiagoo;
GRANT ALL ON TABLE t_docente TO balzap;
GRANT ALL ON TABLE t_docente TO "castañedam";
GRANT ALL ON TABLE t_docente TO carranzac;
GRANT ALL ON TABLE t_docente TO fernandezm;
GRANT ALL ON TABLE t_docente TO informatica2;
GRANT ALL ON TABLE t_docente TO informatica1;
GRANT ALL ON TABLE t_docente TO olivaress;
GRANT ALL ON TABLE t_docente TO castrom;
GRANT ALL ON TABLE t_docente TO romerob;
GRANT ALL ON TABLE t_docente TO mendozao;
GRANT ALL ON TABLE t_docente TO dulceyr;
GRANT ALL ON TABLE t_docente TO gutierrezj;
GRANT ALL ON TABLE t_docente TO castanedam;
GRANT ALL ON TABLE t_docente TO parelesn;
GRANT ALL ON TABLE t_docente TO landazabalc;
GRANT ALL ON TABLE t_docente TO waracaog;
GRANT ALL ON TABLE t_docente TO caninoa;
GRANT ALL ON TABLE t_docente TO santiagoo;
GRANT ALL ON TABLE t_docente TO arcilag;
GRANT ALL ON TABLE t_docente TO gomezr;
GRANT ALL ON TABLE t_docente TO morad;
GRANT ALL ON TABLE t_docente TO albarrani;


--
-- TOC entry 2168 (class 0 OID 0)
-- Dependencies: 163
-- Name: t_est_cur_estudiante; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_est_cur_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_est_cur_estudiante FROM usuarioscn;
GRANT ALL ON TABLE t_est_cur_estudiante TO usuarioscn;
GRANT ALL ON TABLE t_est_cur_estudiante TO jhonny;
GRANT ALL ON TABLE t_est_cur_estudiante TO alamoj;
GRANT ALL ON TABLE t_est_cur_estudiante TO mendozal;
GRANT ALL ON TABLE t_est_cur_estudiante TO vielmaj;
GRANT ALL ON TABLE t_est_cur_estudiante TO desantiagoo;
GRANT ALL ON TABLE t_est_cur_estudiante TO balzap;
GRANT ALL ON TABLE t_est_cur_estudiante TO "castañedam";
GRANT ALL ON TABLE t_est_cur_estudiante TO carranzac;
GRANT ALL ON TABLE t_est_cur_estudiante TO fernandezm;
GRANT ALL ON TABLE t_est_cur_estudiante TO informatica2;
GRANT ALL ON TABLE t_est_cur_estudiante TO informatica1;
GRANT ALL ON TABLE t_est_cur_estudiante TO olivaress;
GRANT ALL ON TABLE t_est_cur_estudiante TO castrom;
GRANT ALL ON TABLE t_est_cur_estudiante TO romerob;
GRANT ALL ON TABLE t_est_cur_estudiante TO mendozao;
GRANT ALL ON TABLE t_est_cur_estudiante TO dulceyr;
GRANT ALL ON TABLE t_est_cur_estudiante TO gutierrezj;
GRANT ALL ON TABLE t_est_cur_estudiante TO castanedam;
GRANT ALL ON TABLE t_est_cur_estudiante TO parelesn;
GRANT ALL ON TABLE t_est_cur_estudiante TO landazabalc;
GRANT ALL ON TABLE t_est_cur_estudiante TO waracaog;
GRANT ALL ON TABLE t_est_cur_estudiante TO caninoa;
GRANT ALL ON TABLE t_est_cur_estudiante TO santiagoo;
GRANT ALL ON TABLE t_est_cur_estudiante TO arcilag;
GRANT ALL ON TABLE t_est_cur_estudiante TO gomezr;
GRANT ALL ON TABLE t_est_cur_estudiante TO morad;
GRANT ALL ON TABLE t_est_cur_estudiante TO albarrani;


--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 153
-- Name: t_est_docente; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_est_docente FROM PUBLIC;
REVOKE ALL ON TABLE t_est_docente FROM usuarioscn;
GRANT ALL ON TABLE t_est_docente TO usuarioscn;
GRANT ALL ON TABLE t_est_docente TO jhonny;
GRANT ALL ON TABLE t_est_docente TO alamoj;
GRANT ALL ON TABLE t_est_docente TO mendozal;
GRANT ALL ON TABLE t_est_docente TO vielmaj;
GRANT ALL ON TABLE t_est_docente TO desantiagoo;
GRANT ALL ON TABLE t_est_docente TO balzap;
GRANT ALL ON TABLE t_est_docente TO "castañedam";
GRANT ALL ON TABLE t_est_docente TO carranzac;
GRANT ALL ON TABLE t_est_docente TO fernandezm;
GRANT ALL ON TABLE t_est_docente TO informatica2;
GRANT ALL ON TABLE t_est_docente TO informatica1;
GRANT ALL ON TABLE t_est_docente TO olivaress;
GRANT ALL ON TABLE t_est_docente TO castrom;
GRANT ALL ON TABLE t_est_docente TO romerob;
GRANT ALL ON TABLE t_est_docente TO mendozao;
GRANT ALL ON TABLE t_est_docente TO dulceyr;
GRANT ALL ON TABLE t_est_docente TO gutierrezj;
GRANT ALL ON TABLE t_est_docente TO castanedam;
GRANT ALL ON TABLE t_est_docente TO parelesn;
GRANT ALL ON TABLE t_est_docente TO landazabalc;
GRANT ALL ON TABLE t_est_docente TO waracaog;
GRANT ALL ON TABLE t_est_docente TO caninoa;
GRANT ALL ON TABLE t_est_docente TO santiagoo;
GRANT ALL ON TABLE t_est_docente TO arcilag;
GRANT ALL ON TABLE t_est_docente TO gomezr;
GRANT ALL ON TABLE t_est_docente TO morad;
GRANT ALL ON TABLE t_est_docente TO albarrani;


--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 155
-- Name: t_est_estudiante; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_est_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_est_estudiante FROM usuarioscn;
GRANT ALL ON TABLE t_est_estudiante TO usuarioscn;
GRANT ALL ON TABLE t_est_estudiante TO jhonny;
GRANT ALL ON TABLE t_est_estudiante TO alamoj;
GRANT ALL ON TABLE t_est_estudiante TO mendozal;
GRANT ALL ON TABLE t_est_estudiante TO vielmaj;
GRANT ALL ON TABLE t_est_estudiante TO desantiagoo;
GRANT ALL ON TABLE t_est_estudiante TO balzap;
GRANT ALL ON TABLE t_est_estudiante TO "castañedam";
GRANT ALL ON TABLE t_est_estudiante TO carranzac;
GRANT ALL ON TABLE t_est_estudiante TO fernandezm;
GRANT ALL ON TABLE t_est_estudiante TO informatica2;
GRANT ALL ON TABLE t_est_estudiante TO informatica1;
GRANT ALL ON TABLE t_est_estudiante TO olivaress;
GRANT ALL ON TABLE t_est_estudiante TO castrom;
GRANT ALL ON TABLE t_est_estudiante TO romerob;
GRANT ALL ON TABLE t_est_estudiante TO mendozao;
GRANT ALL ON TABLE t_est_estudiante TO dulceyr;
GRANT ALL ON TABLE t_est_estudiante TO gutierrezj;
GRANT ALL ON TABLE t_est_estudiante TO castanedam;
GRANT ALL ON TABLE t_est_estudiante TO parelesn;
GRANT ALL ON TABLE t_est_estudiante TO landazabalc;
GRANT ALL ON TABLE t_est_estudiante TO waracaog;
GRANT ALL ON TABLE t_est_estudiante TO caninoa;
GRANT ALL ON TABLE t_est_estudiante TO santiagoo;
GRANT ALL ON TABLE t_est_estudiante TO arcilag;
GRANT ALL ON TABLE t_est_estudiante TO gomezr;
GRANT ALL ON TABLE t_est_estudiante TO morad;
GRANT ALL ON TABLE t_est_estudiante TO albarrani;


--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 150
-- Name: t_est_periodo; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_est_periodo FROM PUBLIC;
REVOKE ALL ON TABLE t_est_periodo FROM usuarioscn;
GRANT ALL ON TABLE t_est_periodo TO usuarioscn;
GRANT ALL ON TABLE t_est_periodo TO jhonny;
GRANT ALL ON TABLE t_est_periodo TO alamoj;
GRANT ALL ON TABLE t_est_periodo TO mendozal;
GRANT ALL ON TABLE t_est_periodo TO vielmaj;
GRANT ALL ON TABLE t_est_periodo TO desantiagoo;
GRANT ALL ON TABLE t_est_periodo TO balzap;
GRANT ALL ON TABLE t_est_periodo TO "castañedam";
GRANT ALL ON TABLE t_est_periodo TO carranzac;
GRANT ALL ON TABLE t_est_periodo TO fernandezm;
GRANT ALL ON TABLE t_est_periodo TO informatica2;
GRANT ALL ON TABLE t_est_periodo TO informatica1;
GRANT ALL ON TABLE t_est_periodo TO olivaress;
GRANT ALL ON TABLE t_est_periodo TO castrom;
GRANT ALL ON TABLE t_est_periodo TO romerob;
GRANT ALL ON TABLE t_est_periodo TO mendozao;
GRANT ALL ON TABLE t_est_periodo TO dulceyr;
GRANT ALL ON TABLE t_est_periodo TO gutierrezj;
GRANT ALL ON TABLE t_est_periodo TO castanedam;
GRANT ALL ON TABLE t_est_periodo TO parelesn;
GRANT ALL ON TABLE t_est_periodo TO landazabalc;
GRANT ALL ON TABLE t_est_periodo TO waracaog;
GRANT ALL ON TABLE t_est_periodo TO caninoa;
GRANT ALL ON TABLE t_est_periodo TO santiagoo;
GRANT ALL ON TABLE t_est_periodo TO arcilag;
GRANT ALL ON TABLE t_est_periodo TO gomezr;
GRANT ALL ON TABLE t_est_periodo TO morad;
GRANT ALL ON TABLE t_est_periodo TO albarrani;


--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 159
-- Name: t_est_usu_con_estudios; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_est_usu_con_estudios FROM PUBLIC;
REVOKE ALL ON TABLE t_est_usu_con_estudios FROM usuarioscn;
GRANT ALL ON TABLE t_est_usu_con_estudios TO usuarioscn;
GRANT ALL ON TABLE t_est_usu_con_estudios TO jhonny;
GRANT ALL ON TABLE t_est_usu_con_estudios TO alamoj;
GRANT ALL ON TABLE t_est_usu_con_estudios TO mendozal;
GRANT ALL ON TABLE t_est_usu_con_estudios TO informatica1;
GRANT ALL ON TABLE t_est_usu_con_estudios TO balzap;
GRANT ALL ON TABLE t_est_usu_con_estudios TO gutierrezj;
GRANT ALL ON TABLE t_est_usu_con_estudios TO castanedam;
GRANT ALL ON TABLE t_est_usu_con_estudios TO parelesn;
GRANT ALL ON TABLE t_est_usu_con_estudios TO landazabalc;
GRANT ALL ON TABLE t_est_usu_con_estudios TO waracaog;
GRANT ALL ON TABLE t_est_usu_con_estudios TO caninoa;
GRANT ALL ON TABLE t_est_usu_con_estudios TO santiagoo;
GRANT ALL ON TABLE t_est_usu_con_estudios TO arcilag;
GRANT ALL ON TABLE t_est_usu_con_estudios TO gomezr;
GRANT ALL ON TABLE t_est_usu_con_estudios TO morad;
GRANT ALL ON TABLE t_est_usu_con_estudios TO albarrani;
GRANT ALL ON TABLE t_est_usu_con_estudios TO romerob;
GRANT ALL ON TABLE t_est_usu_con_estudios TO castrom;


--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 157
-- Name: t_est_usu_enc_pensum; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_est_usu_enc_pensum FROM PUBLIC;
REVOKE ALL ON TABLE t_est_usu_enc_pensum FROM usuarioscn;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO usuarioscn;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO jhonny;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO alamoj;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO mendozal;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO informatica1;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO balzap;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO gutierrezj;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO castanedam;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO parelesn;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO landazabalc;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO waracaog;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO caninoa;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO santiagoo;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO arcilag;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO gomezr;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO morad;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO albarrani;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO romerob;
GRANT ALL ON TABLE t_est_usu_enc_pensum TO castrom;


--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 173
-- Name: t_est_usu_ministerio; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_est_usu_ministerio FROM PUBLIC;
REVOKE ALL ON TABLE t_est_usu_ministerio FROM usuarioscn;
GRANT ALL ON TABLE t_est_usu_ministerio TO usuarioscn;
GRANT ALL ON TABLE t_est_usu_ministerio TO informatica1;
GRANT ALL ON TABLE t_est_usu_ministerio TO balzap;
GRANT ALL ON TABLE t_est_usu_ministerio TO gutierrezj;
GRANT ALL ON TABLE t_est_usu_ministerio TO castanedam;
GRANT ALL ON TABLE t_est_usu_ministerio TO parelesn;
GRANT ALL ON TABLE t_est_usu_ministerio TO landazabalc;
GRANT ALL ON TABLE t_est_usu_ministerio TO waracaog;
GRANT ALL ON TABLE t_est_usu_ministerio TO caninoa;
GRANT ALL ON TABLE t_est_usu_ministerio TO santiagoo;
GRANT ALL ON TABLE t_est_usu_ministerio TO arcilag;
GRANT ALL ON TABLE t_est_usu_ministerio TO gomezr;
GRANT ALL ON TABLE t_est_usu_ministerio TO mendozal;
GRANT ALL ON TABLE t_est_usu_ministerio TO morad;
GRANT ALL ON TABLE t_est_usu_ministerio TO albarrani;
GRANT ALL ON TABLE t_est_usu_ministerio TO romerob;
GRANT ALL ON TABLE t_est_usu_ministerio TO castrom;


--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 156
-- Name: t_estudiante; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE t_estudiante FROM usuarioscn;
GRANT ALL ON TABLE t_estudiante TO usuarioscn;
GRANT ALL ON TABLE t_estudiante TO jhonny;
GRANT ALL ON TABLE t_estudiante TO alamoj;
GRANT ALL ON TABLE t_estudiante TO mendozal;
GRANT ALL ON TABLE t_estudiante TO vielmaj;
GRANT ALL ON TABLE t_estudiante TO desantiagoo;
GRANT ALL ON TABLE t_estudiante TO balzap;
GRANT ALL ON TABLE t_estudiante TO "castañedam";
GRANT ALL ON TABLE t_estudiante TO carranzac;
GRANT ALL ON TABLE t_estudiante TO informatica1;
GRANT ALL ON TABLE t_estudiante TO fernandezm;
GRANT ALL ON TABLE t_estudiante TO informatica2;
GRANT ALL ON TABLE t_estudiante TO olivaress;
GRANT ALL ON TABLE t_estudiante TO castrom;
GRANT ALL ON TABLE t_estudiante TO romerob;
GRANT ALL ON TABLE t_estudiante TO gutierrezj;
GRANT ALL ON TABLE t_estudiante TO castanedam;
GRANT ALL ON TABLE t_estudiante TO parelesn;
GRANT ALL ON TABLE t_estudiante TO landazabalc;
GRANT ALL ON TABLE t_estudiante TO waracaog;
GRANT ALL ON TABLE t_estudiante TO caninoa;
GRANT ALL ON TABLE t_estudiante TO santiagoo;
GRANT ALL ON TABLE t_estudiante TO arcilag;
GRANT ALL ON TABLE t_estudiante TO gomezr;
GRANT ALL ON TABLE t_estudiante TO morad;
GRANT ALL ON TABLE t_estudiante TO albarrani;


--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 179
-- Name: t_estudiante_temp; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_estudiante_temp FROM PUBLIC;
REVOKE ALL ON TABLE t_estudiante_temp FROM usuarioscn;
GRANT ALL ON TABLE t_estudiante_temp TO usuarioscn;
GRANT ALL ON TABLE t_estudiante_temp TO balzap;
GRANT ALL ON TABLE t_estudiante_temp TO gutierrezj;
GRANT ALL ON TABLE t_estudiante_temp TO castanedam;
GRANT ALL ON TABLE t_estudiante_temp TO parelesn;
GRANT ALL ON TABLE t_estudiante_temp TO landazabalc;
GRANT ALL ON TABLE t_estudiante_temp TO waracaog;
GRANT ALL ON TABLE t_estudiante_temp TO caninoa;
GRANT ALL ON TABLE t_estudiante_temp TO santiagoo;
GRANT ALL ON TABLE t_estudiante_temp TO arcilag;
GRANT ALL ON TABLE t_estudiante_temp TO gomezr;
GRANT ALL ON TABLE t_estudiante_temp TO mendozal;
GRANT ALL ON TABLE t_estudiante_temp TO morad;
GRANT ALL ON TABLE t_estudiante_temp TO albarrani;
GRANT ALL ON TABLE t_estudiante_temp TO romerob;
GRANT ALL ON TABLE t_estudiante_temp TO castrom;


--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 165
-- Name: t_fotografia; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_fotografia FROM PUBLIC;
REVOKE ALL ON TABLE t_fotografia FROM usuarioscn;
GRANT ALL ON TABLE t_fotografia TO usuarioscn;
GRANT ALL ON TABLE t_fotografia TO jhonny;
GRANT ALL ON TABLE t_fotografia TO alamoj;
GRANT ALL ON TABLE t_fotografia TO mendozal;
GRANT ALL ON TABLE t_fotografia TO vielmaj;
GRANT ALL ON TABLE t_fotografia TO desantiagoo;
GRANT ALL ON TABLE t_fotografia TO balzap;
GRANT ALL ON TABLE t_fotografia TO "castañedam";
GRANT ALL ON TABLE t_fotografia TO carranzac;
GRANT ALL ON TABLE t_fotografia TO informatica1;
GRANT ALL ON TABLE t_fotografia TO romerob;
GRANT ALL ON TABLE t_fotografia TO gutierrezj;
GRANT ALL ON TABLE t_fotografia TO castanedam;
GRANT ALL ON TABLE t_fotografia TO parelesn;
GRANT ALL ON TABLE t_fotografia TO landazabalc;
GRANT ALL ON TABLE t_fotografia TO waracaog;
GRANT ALL ON TABLE t_fotografia TO caninoa;
GRANT ALL ON TABLE t_fotografia TO santiagoo;
GRANT ALL ON TABLE t_fotografia TO arcilag;
GRANT ALL ON TABLE t_fotografia TO gomezr;
GRANT ALL ON TABLE t_fotografia TO morad;
GRANT ALL ON TABLE t_fotografia TO albarrani;
GRANT ALL ON TABLE t_fotografia TO castrom;


--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 149
-- Name: t_instituto; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_instituto FROM PUBLIC;
REVOKE ALL ON TABLE t_instituto FROM usuarioscn;
GRANT ALL ON TABLE t_instituto TO usuarioscn;
GRANT ALL ON TABLE t_instituto TO jhonny;
GRANT ALL ON TABLE t_instituto TO alamoj;
GRANT ALL ON TABLE t_instituto TO mendozal;
GRANT ALL ON TABLE t_instituto TO vielmaj;
GRANT ALL ON TABLE t_instituto TO desantiagoo;
GRANT ALL ON TABLE t_instituto TO balzap;
GRANT ALL ON TABLE t_instituto TO "castañedam";
GRANT ALL ON TABLE t_instituto TO carranzac;
GRANT ALL ON TABLE t_instituto TO fernandezm;
GRANT ALL ON TABLE t_instituto TO informatica2;
GRANT ALL ON TABLE t_instituto TO informatica1;
GRANT ALL ON TABLE t_instituto TO olivaress;
GRANT ALL ON TABLE t_instituto TO castrom;
GRANT ALL ON TABLE t_instituto TO romerob;
GRANT ALL ON TABLE t_instituto TO mendozao;
GRANT ALL ON TABLE t_instituto TO dulceyr;
GRANT ALL ON TABLE t_instituto TO gutierrezj;
GRANT ALL ON TABLE t_instituto TO castanedam;
GRANT ALL ON TABLE t_instituto TO parelesn;
GRANT ALL ON TABLE t_instituto TO landazabalc;
GRANT ALL ON TABLE t_instituto TO waracaog;
GRANT ALL ON TABLE t_instituto TO caninoa;
GRANT ALL ON TABLE t_instituto TO santiagoo;
GRANT ALL ON TABLE t_instituto TO arcilag;
GRANT ALL ON TABLE t_instituto TO gomezr;
GRANT ALL ON TABLE t_instituto TO morad;
GRANT ALL ON TABLE t_instituto TO albarrani;


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 144
-- Name: t_pensum; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_pensum FROM PUBLIC;
REVOKE ALL ON TABLE t_pensum FROM usuarioscn;
GRANT ALL ON TABLE t_pensum TO usuarioscn;
GRANT ALL ON TABLE t_pensum TO jhonny;
GRANT ALL ON TABLE t_pensum TO alamoj;
GRANT ALL ON TABLE t_pensum TO mendozal;
GRANT ALL ON TABLE t_pensum TO vielmaj;
GRANT ALL ON TABLE t_pensum TO desantiagoo;
GRANT ALL ON TABLE t_pensum TO balzap;
GRANT ALL ON TABLE t_pensum TO "castañedam";
GRANT ALL ON TABLE t_pensum TO carranzac;
GRANT ALL ON TABLE t_pensum TO fernandezm;
GRANT ALL ON TABLE t_pensum TO informatica2;
GRANT ALL ON TABLE t_pensum TO informatica1;
GRANT ALL ON TABLE t_pensum TO olivaress;
GRANT ALL ON TABLE t_pensum TO castrom;
GRANT ALL ON TABLE t_pensum TO romerob;
GRANT ALL ON TABLE t_pensum TO mendozao;
GRANT ALL ON TABLE t_pensum TO dulceyr;
GRANT ALL ON TABLE t_pensum TO gutierrezj;
GRANT ALL ON TABLE t_pensum TO castanedam;
GRANT ALL ON TABLE t_pensum TO parelesn;
GRANT ALL ON TABLE t_pensum TO landazabalc;
GRANT ALL ON TABLE t_pensum TO waracaog;
GRANT ALL ON TABLE t_pensum TO caninoa;
GRANT ALL ON TABLE t_pensum TO santiagoo;
GRANT ALL ON TABLE t_pensum TO arcilag;
GRANT ALL ON TABLE t_pensum TO gomezr;
GRANT ALL ON TABLE t_pensum TO morad;
GRANT ALL ON TABLE t_pensum TO albarrani;


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 151
-- Name: t_periodo; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_periodo FROM PUBLIC;
REVOKE ALL ON TABLE t_periodo FROM usuarioscn;
GRANT ALL ON TABLE t_periodo TO usuarioscn;
GRANT ALL ON TABLE t_periodo TO jhonny;
GRANT ALL ON TABLE t_periodo TO alamoj;
GRANT ALL ON TABLE t_periodo TO mendozal;
GRANT ALL ON TABLE t_periodo TO vielmaj;
GRANT ALL ON TABLE t_periodo TO desantiagoo;
GRANT ALL ON TABLE t_periodo TO balzap;
GRANT ALL ON TABLE t_periodo TO "castañedam";
GRANT ALL ON TABLE t_periodo TO carranzac;
GRANT ALL ON TABLE t_periodo TO fernandezm;
GRANT ALL ON TABLE t_periodo TO informatica2;
GRANT ALL ON TABLE t_periodo TO informatica1;
GRANT ALL ON TABLE t_periodo TO olivaress;
GRANT ALL ON TABLE t_periodo TO castrom;
GRANT ALL ON TABLE t_periodo TO romerob;
GRANT ALL ON TABLE t_periodo TO mendozao;
GRANT ALL ON TABLE t_periodo TO dulceyr;
GRANT ALL ON TABLE t_periodo TO gutierrezj;
GRANT ALL ON TABLE t_periodo TO castanedam;
GRANT ALL ON TABLE t_periodo TO parelesn;
GRANT ALL ON TABLE t_periodo TO landazabalc;
GRANT ALL ON TABLE t_periodo TO waracaog;
GRANT ALL ON TABLE t_periodo TO caninoa;
GRANT ALL ON TABLE t_periodo TO santiagoo;
GRANT ALL ON TABLE t_periodo TO arcilag;
GRANT ALL ON TABLE t_periodo TO gomezr;
GRANT ALL ON TABLE t_periodo TO morad;
GRANT ALL ON TABLE t_periodo TO albarrani;


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 152
-- Name: t_persona; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_persona FROM PUBLIC;
REVOKE ALL ON TABLE t_persona FROM usuarioscn;
GRANT ALL ON TABLE t_persona TO usuarioscn;
GRANT ALL ON TABLE t_persona TO jhonny;
GRANT ALL ON TABLE t_persona TO alamoj;
GRANT ALL ON TABLE t_persona TO mendozal;
GRANT ALL ON TABLE t_persona TO vielmaj;
GRANT ALL ON TABLE t_persona TO desantiagoo;
GRANT ALL ON TABLE t_persona TO balzap;
GRANT ALL ON TABLE t_persona TO "castañedam";
GRANT ALL ON TABLE t_persona TO carranzac;
GRANT ALL ON TABLE t_persona TO fernandezm;
GRANT ALL ON TABLE t_persona TO informatica2;
GRANT ALL ON TABLE t_persona TO informatica1;
GRANT ALL ON TABLE t_persona TO olivaress;
GRANT ALL ON TABLE t_persona TO castrom;
GRANT ALL ON TABLE t_persona TO romerob;
GRANT ALL ON TABLE t_persona TO mendozao;
GRANT ALL ON TABLE t_persona TO dulceyr;
GRANT ALL ON TABLE t_persona TO gutierrezj;
GRANT ALL ON TABLE t_persona TO castanedam;
GRANT ALL ON TABLE t_persona TO parelesn;
GRANT ALL ON TABLE t_persona TO landazabalc;
GRANT ALL ON TABLE t_persona TO waracaog;
GRANT ALL ON TABLE t_persona TO caninoa;
GRANT ALL ON TABLE t_persona TO santiagoo;
GRANT ALL ON TABLE t_persona TO arcilag;
GRANT ALL ON TABLE t_persona TO gomezr;
GRANT ALL ON TABLE t_persona TO morad;
GRANT ALL ON TABLE t_persona TO albarrani;


--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 180
-- Name: t_persona_temp_2; Type: ACL; Schema: sis; Owner: alamoj
--

REVOKE ALL ON TABLE t_persona_temp_2 FROM PUBLIC;
REVOKE ALL ON TABLE t_persona_temp_2 FROM alamoj;
GRANT ALL ON TABLE t_persona_temp_2 TO alamoj;
GRANT ALL ON TABLE t_persona_temp_2 TO balzap;
GRANT ALL ON TABLE t_persona_temp_2 TO gutierrezj;
GRANT ALL ON TABLE t_persona_temp_2 TO castanedam;
GRANT ALL ON TABLE t_persona_temp_2 TO parelesn;
GRANT ALL ON TABLE t_persona_temp_2 TO landazabalc;
GRANT ALL ON TABLE t_persona_temp_2 TO waracaog;
GRANT ALL ON TABLE t_persona_temp_2 TO caninoa;
GRANT ALL ON TABLE t_persona_temp_2 TO santiagoo;
GRANT ALL ON TABLE t_persona_temp_2 TO arcilag;
GRANT ALL ON TABLE t_persona_temp_2 TO gomezr;
GRANT ALL ON TABLE t_persona_temp_2 TO mendozal;
GRANT ALL ON TABLE t_persona_temp_2 TO morad;
GRANT ALL ON TABLE t_persona_temp_2 TO albarrani;
GRANT ALL ON TABLE t_persona_temp_2 TO romerob;
GRANT ALL ON TABLE t_persona_temp_2 TO castrom;


--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 148
-- Name: t_prelacion; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_prelacion FROM PUBLIC;
REVOKE ALL ON TABLE t_prelacion FROM usuarioscn;
GRANT ALL ON TABLE t_prelacion TO usuarioscn;
GRANT ALL ON TABLE t_prelacion TO jhonny;
GRANT ALL ON TABLE t_prelacion TO alamoj;
GRANT ALL ON TABLE t_prelacion TO mendozal;
GRANT ALL ON TABLE t_prelacion TO vielmaj;
GRANT ALL ON TABLE t_prelacion TO desantiagoo;
GRANT ALL ON TABLE t_prelacion TO balzap;
GRANT ALL ON TABLE t_prelacion TO "castañedam";
GRANT ALL ON TABLE t_prelacion TO carranzac;
GRANT ALL ON TABLE t_prelacion TO informatica1;
GRANT ALL ON TABLE t_prelacion TO romerob;
GRANT ALL ON TABLE t_prelacion TO gutierrezj;
GRANT ALL ON TABLE t_prelacion TO castanedam;
GRANT ALL ON TABLE t_prelacion TO parelesn;
GRANT ALL ON TABLE t_prelacion TO landazabalc;
GRANT ALL ON TABLE t_prelacion TO waracaog;
GRANT ALL ON TABLE t_prelacion TO caninoa;
GRANT ALL ON TABLE t_prelacion TO santiagoo;
GRANT ALL ON TABLE t_prelacion TO arcilag;
GRANT ALL ON TABLE t_prelacion TO gomezr;
GRANT ALL ON TABLE t_prelacion TO morad;
GRANT ALL ON TABLE t_prelacion TO albarrani;
GRANT ALL ON TABLE t_prelacion TO castrom;


--
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 146
-- Name: t_tip_uni_curricular; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_tip_uni_curricular FROM PUBLIC;
REVOKE ALL ON TABLE t_tip_uni_curricular FROM usuarioscn;
GRANT ALL ON TABLE t_tip_uni_curricular TO usuarioscn;
GRANT ALL ON TABLE t_tip_uni_curricular TO jhonny;
GRANT ALL ON TABLE t_tip_uni_curricular TO alamoj;
GRANT ALL ON TABLE t_tip_uni_curricular TO mendozal;
GRANT ALL ON TABLE t_tip_uni_curricular TO vielmaj;
GRANT ALL ON TABLE t_tip_uni_curricular TO desantiagoo;
GRANT ALL ON TABLE t_tip_uni_curricular TO balzap;
GRANT ALL ON TABLE t_tip_uni_curricular TO "castañedam";
GRANT ALL ON TABLE t_tip_uni_curricular TO carranzac;
GRANT ALL ON TABLE t_tip_uni_curricular TO fernandezm;
GRANT ALL ON TABLE t_tip_uni_curricular TO informatica2;
GRANT ALL ON TABLE t_tip_uni_curricular TO informatica1;
GRANT ALL ON TABLE t_tip_uni_curricular TO olivaress;
GRANT ALL ON TABLE t_tip_uni_curricular TO castrom;
GRANT ALL ON TABLE t_tip_uni_curricular TO romerob;
GRANT ALL ON TABLE t_tip_uni_curricular TO mendozao;
GRANT ALL ON TABLE t_tip_uni_curricular TO dulceyr;
GRANT ALL ON TABLE t_tip_uni_curricular TO gutierrezj;
GRANT ALL ON TABLE t_tip_uni_curricular TO castanedam;
GRANT ALL ON TABLE t_tip_uni_curricular TO parelesn;
GRANT ALL ON TABLE t_tip_uni_curricular TO landazabalc;
GRANT ALL ON TABLE t_tip_uni_curricular TO waracaog;
GRANT ALL ON TABLE t_tip_uni_curricular TO caninoa;
GRANT ALL ON TABLE t_tip_uni_curricular TO santiagoo;
GRANT ALL ON TABLE t_tip_uni_curricular TO arcilag;
GRANT ALL ON TABLE t_tip_uni_curricular TO gomezr;
GRANT ALL ON TABLE t_tip_uni_curricular TO morad;
GRANT ALL ON TABLE t_tip_uni_curricular TO albarrani;


--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 145
-- Name: t_trayecto; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_trayecto FROM PUBLIC;
REVOKE ALL ON TABLE t_trayecto FROM usuarioscn;
GRANT ALL ON TABLE t_trayecto TO usuarioscn;
GRANT ALL ON TABLE t_trayecto TO jhonny;
GRANT ALL ON TABLE t_trayecto TO alamoj;
GRANT ALL ON TABLE t_trayecto TO mendozal;
GRANT ALL ON TABLE t_trayecto TO vielmaj;
GRANT ALL ON TABLE t_trayecto TO desantiagoo;
GRANT ALL ON TABLE t_trayecto TO balzap;
GRANT ALL ON TABLE t_trayecto TO "castañedam";
GRANT ALL ON TABLE t_trayecto TO carranzac;
GRANT ALL ON TABLE t_trayecto TO fernandezm;
GRANT ALL ON TABLE t_trayecto TO informatica2;
GRANT ALL ON TABLE t_trayecto TO informatica1;
GRANT ALL ON TABLE t_trayecto TO olivaress;
GRANT ALL ON TABLE t_trayecto TO castrom;
GRANT ALL ON TABLE t_trayecto TO romerob;
GRANT ALL ON TABLE t_trayecto TO mendozao;
GRANT ALL ON TABLE t_trayecto TO dulceyr;
GRANT ALL ON TABLE t_trayecto TO gutierrezj;
GRANT ALL ON TABLE t_trayecto TO castanedam;
GRANT ALL ON TABLE t_trayecto TO parelesn;
GRANT ALL ON TABLE t_trayecto TO landazabalc;
GRANT ALL ON TABLE t_trayecto TO waracaog;
GRANT ALL ON TABLE t_trayecto TO caninoa;
GRANT ALL ON TABLE t_trayecto TO santiagoo;
GRANT ALL ON TABLE t_trayecto TO arcilag;
GRANT ALL ON TABLE t_trayecto TO gomezr;
GRANT ALL ON TABLE t_trayecto TO morad;
GRANT ALL ON TABLE t_trayecto TO albarrani;


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 147
-- Name: t_uni_curricular; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_uni_curricular FROM PUBLIC;
REVOKE ALL ON TABLE t_uni_curricular FROM usuarioscn;
GRANT ALL ON TABLE t_uni_curricular TO usuarioscn;
GRANT ALL ON TABLE t_uni_curricular TO jhonny;
GRANT ALL ON TABLE t_uni_curricular TO alamoj;
GRANT ALL ON TABLE t_uni_curricular TO mendozal;
GRANT ALL ON TABLE t_uni_curricular TO vielmaj;
GRANT ALL ON TABLE t_uni_curricular TO desantiagoo;
GRANT ALL ON TABLE t_uni_curricular TO balzap;
GRANT ALL ON TABLE t_uni_curricular TO "castañedam";
GRANT ALL ON TABLE t_uni_curricular TO carranzac;
GRANT ALL ON TABLE t_uni_curricular TO fernandezm;
GRANT ALL ON TABLE t_uni_curricular TO informatica2;
GRANT ALL ON TABLE t_uni_curricular TO informatica1;
GRANT ALL ON TABLE t_uni_curricular TO olivaress;
GRANT ALL ON TABLE t_uni_curricular TO castrom;
GRANT ALL ON TABLE t_uni_curricular TO romerob;
GRANT ALL ON TABLE t_uni_curricular TO mendozao;
GRANT ALL ON TABLE t_uni_curricular TO dulceyr;
GRANT ALL ON TABLE t_uni_curricular TO gutierrezj;
GRANT ALL ON TABLE t_uni_curricular TO castanedam;
GRANT ALL ON TABLE t_uni_curricular TO parelesn;
GRANT ALL ON TABLE t_uni_curricular TO landazabalc;
GRANT ALL ON TABLE t_uni_curricular TO waracaog;
GRANT ALL ON TABLE t_uni_curricular TO caninoa;
GRANT ALL ON TABLE t_uni_curricular TO santiagoo;
GRANT ALL ON TABLE t_uni_curricular TO arcilag;
GRANT ALL ON TABLE t_uni_curricular TO gomezr;
GRANT ALL ON TABLE t_uni_curricular TO morad;
GRANT ALL ON TABLE t_uni_curricular TO albarrani;


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 160
-- Name: t_usu_con_estudios; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_usu_con_estudios FROM PUBLIC;
REVOKE ALL ON TABLE t_usu_con_estudios FROM usuarioscn;
GRANT ALL ON TABLE t_usu_con_estudios TO usuarioscn;
GRANT ALL ON TABLE t_usu_con_estudios TO jhonny;
GRANT ALL ON TABLE t_usu_con_estudios TO alamoj;
GRANT ALL ON TABLE t_usu_con_estudios TO mendozal;
GRANT ALL ON TABLE t_usu_con_estudios TO informatica1;
GRANT ALL ON TABLE t_usu_con_estudios TO balzap;
GRANT ALL ON TABLE t_usu_con_estudios TO gutierrezj;
GRANT ALL ON TABLE t_usu_con_estudios TO castanedam;
GRANT ALL ON TABLE t_usu_con_estudios TO parelesn;
GRANT ALL ON TABLE t_usu_con_estudios TO landazabalc;
GRANT ALL ON TABLE t_usu_con_estudios TO waracaog;
GRANT ALL ON TABLE t_usu_con_estudios TO caninoa;
GRANT ALL ON TABLE t_usu_con_estudios TO santiagoo;
GRANT ALL ON TABLE t_usu_con_estudios TO arcilag;
GRANT ALL ON TABLE t_usu_con_estudios TO gomezr;
GRANT ALL ON TABLE t_usu_con_estudios TO morad;
GRANT ALL ON TABLE t_usu_con_estudios TO albarrani;
GRANT ALL ON TABLE t_usu_con_estudios TO romerob;
GRANT ALL ON TABLE t_usu_con_estudios TO castrom;


--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 158
-- Name: t_usu_enc_pensum; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_usu_enc_pensum FROM PUBLIC;
REVOKE ALL ON TABLE t_usu_enc_pensum FROM usuarioscn;
GRANT ALL ON TABLE t_usu_enc_pensum TO usuarioscn;
GRANT ALL ON TABLE t_usu_enc_pensum TO jhonny;
GRANT ALL ON TABLE t_usu_enc_pensum TO alamoj;
GRANT ALL ON TABLE t_usu_enc_pensum TO mendozal;
GRANT ALL ON TABLE t_usu_enc_pensum TO informatica1;
GRANT ALL ON TABLE t_usu_enc_pensum TO balzap;
GRANT ALL ON TABLE t_usu_enc_pensum TO gutierrezj;
GRANT ALL ON TABLE t_usu_enc_pensum TO castanedam;
GRANT ALL ON TABLE t_usu_enc_pensum TO parelesn;
GRANT ALL ON TABLE t_usu_enc_pensum TO landazabalc;
GRANT ALL ON TABLE t_usu_enc_pensum TO waracaog;
GRANT ALL ON TABLE t_usu_enc_pensum TO caninoa;
GRANT ALL ON TABLE t_usu_enc_pensum TO santiagoo;
GRANT ALL ON TABLE t_usu_enc_pensum TO arcilag;
GRANT ALL ON TABLE t_usu_enc_pensum TO gomezr;
GRANT ALL ON TABLE t_usu_enc_pensum TO morad;
GRANT ALL ON TABLE t_usu_enc_pensum TO albarrani;
GRANT ALL ON TABLE t_usu_enc_pensum TO romerob;
GRANT ALL ON TABLE t_usu_enc_pensum TO castrom;


--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 174
-- Name: t_usu_ministerio; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE t_usu_ministerio FROM PUBLIC;
REVOKE ALL ON TABLE t_usu_ministerio FROM usuarioscn;
GRANT ALL ON TABLE t_usu_ministerio TO usuarioscn;
GRANT ALL ON TABLE t_usu_ministerio TO fernandezm;
GRANT ALL ON TABLE t_usu_ministerio TO informatica2;
GRANT ALL ON TABLE t_usu_ministerio TO informatica1;
GRANT ALL ON TABLE t_usu_ministerio TO olivaress;
GRANT ALL ON TABLE t_usu_ministerio TO castrom;
GRANT ALL ON TABLE t_usu_ministerio TO balzap;
GRANT ALL ON TABLE t_usu_ministerio TO gutierrezj;
GRANT ALL ON TABLE t_usu_ministerio TO castanedam;
GRANT ALL ON TABLE t_usu_ministerio TO parelesn;
GRANT ALL ON TABLE t_usu_ministerio TO landazabalc;
GRANT ALL ON TABLE t_usu_ministerio TO waracaog;
GRANT ALL ON TABLE t_usu_ministerio TO caninoa;
GRANT ALL ON TABLE t_usu_ministerio TO santiagoo;
GRANT ALL ON TABLE t_usu_ministerio TO arcilag;
GRANT ALL ON TABLE t_usu_ministerio TO gomezr;
GRANT ALL ON TABLE t_usu_ministerio TO mendozal;
GRANT ALL ON TABLE t_usu_ministerio TO morad;
GRANT ALL ON TABLE t_usu_ministerio TO albarrani;
GRANT ALL ON TABLE t_usu_ministerio TO romerob;


--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 178
-- Name: v_cur_estudiante_temp; Type: ACL; Schema: sis; Owner: alamoj
--

REVOKE ALL ON TABLE v_cur_estudiante_temp FROM PUBLIC;
REVOKE ALL ON TABLE v_cur_estudiante_temp FROM alamoj;
GRANT ALL ON TABLE v_cur_estudiante_temp TO alamoj;
GRANT ALL ON TABLE v_cur_estudiante_temp TO balzap;
GRANT ALL ON TABLE v_cur_estudiante_temp TO gutierrezj;
GRANT ALL ON TABLE v_cur_estudiante_temp TO castanedam;
GRANT ALL ON TABLE v_cur_estudiante_temp TO parelesn;
GRANT ALL ON TABLE v_cur_estudiante_temp TO landazabalc;
GRANT ALL ON TABLE v_cur_estudiante_temp TO waracaog;
GRANT ALL ON TABLE v_cur_estudiante_temp TO caninoa;
GRANT ALL ON TABLE v_cur_estudiante_temp TO santiagoo;
GRANT ALL ON TABLE v_cur_estudiante_temp TO arcilag;
GRANT ALL ON TABLE v_cur_estudiante_temp TO gomezr;
GRANT ALL ON TABLE v_cur_estudiante_temp TO mendozal;
GRANT ALL ON TABLE v_cur_estudiante_temp TO morad;
GRANT ALL ON TABLE v_cur_estudiante_temp TO albarrani;
GRANT ALL ON TABLE v_cur_estudiante_temp TO romerob;
GRANT ALL ON TABLE v_cur_estudiante_temp TO castrom;


--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 167
-- Name: v_docente; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE v_docente FROM PUBLIC;
REVOKE ALL ON TABLE v_docente FROM usuarioscn;
GRANT ALL ON TABLE v_docente TO usuarioscn;
GRANT ALL ON TABLE v_docente TO jhonny;
GRANT ALL ON TABLE v_docente TO alamoj;
GRANT ALL ON TABLE v_docente TO mendozal;
GRANT ALL ON TABLE v_docente TO vielmaj;
GRANT ALL ON TABLE v_docente TO desantiagoo;
GRANT ALL ON TABLE v_docente TO balzap;
GRANT ALL ON TABLE v_docente TO "castañedam";
GRANT ALL ON TABLE v_docente TO carranzac;
GRANT ALL ON TABLE v_docente TO fernandezm;
GRANT ALL ON TABLE v_docente TO informatica2;
GRANT ALL ON TABLE v_docente TO informatica1;
GRANT ALL ON TABLE v_docente TO olivaress;
GRANT ALL ON TABLE v_docente TO castrom;
GRANT ALL ON TABLE v_docente TO romerob;
GRANT ALL ON TABLE v_docente TO mendozao;
GRANT ALL ON TABLE v_docente TO dulceyr;
GRANT ALL ON TABLE v_docente TO gutierrezj;
GRANT ALL ON TABLE v_docente TO castanedam;
GRANT ALL ON TABLE v_docente TO parelesn;
GRANT ALL ON TABLE v_docente TO landazabalc;
GRANT ALL ON TABLE v_docente TO waracaog;
GRANT ALL ON TABLE v_docente TO caninoa;
GRANT ALL ON TABLE v_docente TO santiagoo;
GRANT ALL ON TABLE v_docente TO arcilag;
GRANT ALL ON TABLE v_docente TO gomezr;
GRANT ALL ON TABLE v_docente TO morad;
GRANT ALL ON TABLE v_docente TO albarrani;


--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 166
-- Name: v_estudiante; Type: ACL; Schema: sis; Owner: usuarioscn
--

REVOKE ALL ON TABLE v_estudiante FROM PUBLIC;
REVOKE ALL ON TABLE v_estudiante FROM usuarioscn;
GRANT ALL ON TABLE v_estudiante TO usuarioscn;
GRANT ALL ON TABLE v_estudiante TO jhonny;
GRANT ALL ON TABLE v_estudiante TO mendozal;
GRANT ALL ON TABLE v_estudiante TO alamoj;
GRANT ALL ON TABLE v_estudiante TO vielmaj;
GRANT ALL ON TABLE v_estudiante TO desantiagoo;
GRANT ALL ON TABLE v_estudiante TO balzap;
GRANT ALL ON TABLE v_estudiante TO "castañedam";
GRANT ALL ON TABLE v_estudiante TO carranzac;
GRANT ALL ON TABLE v_estudiante TO fernandezm;
GRANT ALL ON TABLE v_estudiante TO informatica2;
GRANT ALL ON TABLE v_estudiante TO informatica1;
GRANT ALL ON TABLE v_estudiante TO olivaress;
GRANT ALL ON TABLE v_estudiante TO castrom;
GRANT ALL ON TABLE v_estudiante TO romerob;
GRANT ALL ON TABLE v_estudiante TO mendozao;
GRANT ALL ON TABLE v_estudiante TO dulceyr;
GRANT ALL ON TABLE v_estudiante TO gutierrezj;
GRANT ALL ON TABLE v_estudiante TO castanedam;
GRANT ALL ON TABLE v_estudiante TO parelesn;
GRANT ALL ON TABLE v_estudiante TO landazabalc;
GRANT ALL ON TABLE v_estudiante TO waracaog;
GRANT ALL ON TABLE v_estudiante TO caninoa;
GRANT ALL ON TABLE v_estudiante TO santiagoo;
GRANT ALL ON TABLE v_estudiante TO arcilag;
GRANT ALL ON TABLE v_estudiante TO gomezr;
GRANT ALL ON TABLE v_estudiante TO morad;
GRANT ALL ON TABLE v_estudiante TO albarrani;


--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 181
-- Name: v_pensum; Type: ACL; Schema: sis; Owner: postgres
--

REVOKE ALL ON TABLE v_pensum FROM PUBLIC;
REVOKE ALL ON TABLE v_pensum FROM postgres;
GRANT ALL ON TABLE v_pensum TO postgres;
GRANT ALL ON TABLE v_pensum TO balzap;
GRANT ALL ON TABLE v_pensum TO gutierrezj;
GRANT ALL ON TABLE v_pensum TO castanedam;
GRANT ALL ON TABLE v_pensum TO parelesn;
GRANT ALL ON TABLE v_pensum TO landazabalc;
GRANT ALL ON TABLE v_pensum TO waracaog;
GRANT ALL ON TABLE v_pensum TO caninoa;
GRANT ALL ON TABLE v_pensum TO santiagoo;
GRANT ALL ON TABLE v_pensum TO arcilag;
GRANT ALL ON TABLE v_pensum TO gomezr;
GRANT ALL ON TABLE v_pensum TO mendozal;
GRANT ALL ON TABLE v_pensum TO morad;
GRANT ALL ON TABLE v_pensum TO albarrani;
GRANT ALL ON TABLE v_pensum TO romerob;
GRANT ALL ON TABLE v_pensum TO castrom;


--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 175
-- Name: v_prelacion; Type: ACL; Schema: sis; Owner: alamoj
--

REVOKE ALL ON TABLE v_prelacion FROM PUBLIC;
REVOKE ALL ON TABLE v_prelacion FROM alamoj;
GRANT ALL ON TABLE v_prelacion TO alamoj;
GRANT ALL ON TABLE v_prelacion TO balzap;
GRANT ALL ON TABLE v_prelacion TO gutierrezj;
GRANT ALL ON TABLE v_prelacion TO castanedam;
GRANT ALL ON TABLE v_prelacion TO parelesn;
GRANT ALL ON TABLE v_prelacion TO landazabalc;
GRANT ALL ON TABLE v_prelacion TO waracaog;
GRANT ALL ON TABLE v_prelacion TO caninoa;
GRANT ALL ON TABLE v_prelacion TO santiagoo;
GRANT ALL ON TABLE v_prelacion TO arcilag;
GRANT ALL ON TABLE v_prelacion TO gomezr;
GRANT ALL ON TABLE v_prelacion TO mendozal;
GRANT ALL ON TABLE v_prelacion TO morad;
GRANT ALL ON TABLE v_prelacion TO albarrani;
GRANT ALL ON TABLE v_prelacion TO romerob;
GRANT ALL ON TABLE v_prelacion TO castrom;


-- Completed on 2016-03-18 14:29:53 VET

--
-- PostgreSQL database dump complete
--




