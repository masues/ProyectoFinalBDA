-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         03 de febrero de 2021
-- @Descripcion:   Creanción de objetos Proyecto Subastas (DDL).



-- 
-- MODULE: ADMINISTRACION DE USUARIOS
--

conn mse_admin_users/mario
-- 
-- TABLE: PAIS 
--

CREATE TABLE PAIS(
    PAIS_ID    NUMBER(10, 0)    NOT NULL,
    CLAVE      VARCHAR2(10)     NOT NULL,
    NOMBRE     VARCHAR2(40)     NOT NULL,
    CONSTRAINT PAIS_PK PRIMARY KEY (PAIS_ID)
    USING INDEX(
		CREATE UNIQUE INDEX PAIS_IPK on PAIS(PAIS_ID)
		TABLESPACE ADMIN_USR_INDEX_TS	
	)
)TABLESPACE ADMIN_USR_TS;

-- 
-- TABLE: BANCO 
--

CREATE TABLE BANCO(
    BANCO_ID       NUMBER(10, 0)    NOT NULL,
    NOMBRE         VARCHAR2(40)     NOT NULL,
    CLAVE          VARCHAR2(20)     NOT NULL,
    DESCRIPCION    VARCHAR2(300)    NOT NULL,
    CONSTRAINT BANCO_PK PRIMARY KEY (BANCO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX BANCO_IPK on BANCO(BANCO_ID)
		TABLESPACE ADMIN_USR_INDEX_TS	
	)
)TABLESPACE ADMIN_USR_TS;


-- 
-- TABLE: USUARIO 
--

CREATE TABLE USUARIO(
    USUARIO_ID            NUMBER(10, 0)    NOT NULL,
    NOMBRE                VARCHAR2(40)     NOT NULL,
    APELLIDO1             VARCHAR2(40)     NOT NULL,
    APELLIDO2             VARCHAR2(40)     NOT NULL,
    CORREO_ELECTRONICO    VARCHAR2(40)     NOT NULL,
    ESTADO                VARCHAR2(40)     NOT NULL,
    FOTO_PERFIL           BLOB             NULL,
    RESENIA               VARCHAR2(200)    NOT NULL,
    USUARIO               VARCHAR2(15)     NOT NULL,
    CONSTRASENIA          VARCHAR2(50)     NOT NULL,
    PAIS_ID               NUMBER(10, 0)    NOT NULL,
    AVAL_ID               NUMBER(10, 0),
    CONSTRAINT USUARIO_PK PRIMARY KEY (USUARIO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX USUARIO_IPK on USUARIO(USUARIO_ID  )
		TABLESPACE ADMIN_USR_INDEX_TS	
	), 
    CONSTRAINT USUARIO_PAIS_ID_FK FOREIGN KEY (PAIS_ID)
    REFERENCES PAIS(PAIS_ID),
    CONSTRAINT USUARIO_AVAL_ID_FK FOREIGN KEY (AVAL_ID)
    REFERENCES USUARIO(USUARIO_ID)
)
LOB(FOTO_PERFIL) STORE AS (tablespace ADMIN_USR_BLOB_TS)
TABLESPACE ADMIN_USR_TS;

-- Concede permisos de selección y referencia al usuario rrr_admin_objects
grant references,select on USUARIO to rrr_admin_objects;

-- 
-- TABLE: CUENTA_BANCARIA 
--

CREATE TABLE CUENTA_BANCARIA(
    CUENTA_BANCARIA_ID    NUMBER(10, 0)    NOT NULL,
    RFC                   VARCHAR2(13)     NOT NULL,
    CLABE                 CHAR(18)         NOT NULL,
    USUARIO_ID            NUMBER(10, 0)    NOT NULL,
    BANCO_ID              NUMBER(10, 0)    NOT NULL,
    CONSTRAINT CUENTA_BANCARIA_PK PRIMARY KEY (CUENTA_BANCARIA_ID)
    USING INDEX(
		CREATE UNIQUE INDEX CUENTA_BANCARIA_IPK on CUENTA_BANCARIA(CUENTA_BANCARIA_ID)
		TABLESPACE ADMIN_USR_INDEX_TS	
	), 
    CONSTRAINT CTA_BANCARIA_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES USUARIO(USUARIO_ID),
    CONSTRAINT CTA_BANCARIA_BANCO_ID_FK FOREIGN KEY (BANCO_ID)
    REFERENCES BANCO(BANCO_ID)
)TABLESPACE ADMIN_USR_TS;



-- 
-- TABLE: TARJETA_BANCARIA 
--

CREATE TABLE TARJETA_BANCARIA(
    TARJETA_BANCARIA_ID    NUMBER(10, 0)    NOT NULL,
    NUMERO                 VARCHAR2(16)     NOT NULL,
    TIPO                   VARCHAR2(30)     NOT NULL,
    MES_EXPIRACION         CHAR(2)          NOT NULL,
    ANIO_EXPIRACION        CHAR(2)          NOT NULL,
    USUARIO_ID             NUMBER(10, 0)    NOT NULL,
    BANCO_ID               NUMBER(10, 0)    NOT NULL,
    CONSTRAINT TARJETA_BANCARIA_PK PRIMARY KEY (TARJETA_BANCARIA_ID)
    USING INDEX(
		CREATE UNIQUE INDEX TARJETA_BANCARIA_IPK on TARJETA_BANCARIA(TARJETA_BANCARIA_ID)
		TABLESPACE ADMIN_USR_INDEX_TS	
	), 
    CONSTRAINT TARJETA_BANCARIA_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES USUARIO(USUARIO_ID),
    CONSTRAINT TARJETA_BANCARIA_BANCO_ID_FK FOREIGN KEY (BANCO_ID)
    REFERENCES BANCO(BANCO_ID)
)TABLESPACE ADMIN_USR_TS;




-- 
-- TABLE: FACTURA 
--

CREATE TABLE FACTURA(
    FACTURA_ID             NUMBER(10, 0)    NOT NULL,
    FOLIO                  VARCHAR2(40)     NOT NULL,
    FECHA_GENERACION       DATE             NOT NULL,
    MONTO_TOTAL_COMPRAS    NUMBER(11, 2)    NOT NULL,
    IVA                    NUMBER(11, 2)    NOT NULL,
    USUARIO_ID             NUMBER(10, 0)    NOT NULL,
    CUENTA_BANCARIA_ID     NUMBER(10, 0),
    TARJETA_BANCARIA_ID    NUMBER(10, 0),
    CONSTRAINT FACTURA_PK PRIMARY KEY (FACTURA_ID)USING INDEX(
		CREATE UNIQUE INDEX FACTURA_IPK on FACTURA(FACTURA_ID)
		TABLESPACE ADMIN_USR_INDEX_TS	
	), 
    CONSTRAINT FACTURA_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES USUARIO(USUARIO_ID),
    CONSTRAINT FACTURA_CUENTA_BANCARIA_ID_FK FOREIGN KEY (CUENTA_BANCARIA_ID)
    REFERENCES CUENTA_BANCARIA(CUENTA_BANCARIA_ID),
    CONSTRAINT FACTURA_TARJETA_BANCARIA_ID_FK FOREIGN KEY (TARJETA_BANCARIA_ID)
    REFERENCES TARJETA_BANCARIA(TARJETA_BANCARIA_ID)
)TABLESPACE ADMIN_USR_TS;

grant references,select on FACTURA to rrr_admin_objects;

--
--INDICES ADMINISTRACION DE USUARIOS
--

-- 
-- index: cta_bancaria_clabe_iuk
--

create unique index cta_bancaria_clabe_iuk on CUENTA_BANCARIA(CLABE) tablespace ADMIN_USR_INDEX_TS;
-- 
-- index: factura_folio_iuk
--

create unique index factura_folio_iuk on FACTURA(FOLIO)
tablespace ADMIN_USR_INDEX_TS;
-- 
-- index: tarj_bancaria_numero_iuk
--

create unique index tarj_bancaria_numero_iuk on TARJETA_BANCARIA(NUMERO)
tablespace ADMIN_USR_INDEX_TS;

-- 

-- 
-- index: pais_clave_iuk
--

create unique index pais_clave_iuk on PAIS(CLAVE)
tablespace ADMIN_USR_INDEX_TS;
-- 
-- index: usr_correo_electronico_iuk
--

create unique index usr_correo_electronico_iuk on USUARIO(CORREO_ELECTRONICO)
tablespace ADMIN_USR_INDEX_TS;

-- 

-- 
-- index: usr_usuario_iuk
--

create unique index usr_usuario_iuk on USUARIO(USUARIO)
tablespace ADMIN_USR_INDEX_TS;

-- 


-- 
-- MODULE: ADMINISTRACION DE OBJETOS
--

conn rrr_admin_objects/ricardo

-- 
-- TABLE: STATUS_OBJETO 
--

CREATE TABLE STATUS_OBJETO(
    STATUS_OBJETO_ID    NUMBER(10, 0)    NOT NULL,
    NOMBRE_STATUS       VARCHAR2(5)      NOT NULL,
    DESCRIPCION         VARCHAR2(25)     NOT NULL,
    CONSTRAINT STATUS_OBJETO_PK PRIMARY KEY (STATUS_OBJETO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX STATUS_OBJETO_IPK on STATUS_OBJETO(STATUS_OBJETO_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	)
)TABLESPACE ADMIN_OBJ_TS;


-- 
-- TABLE: SUBASTA 
--

CREATE TABLE SUBASTA(
    SUBASTA_ID          NUMBER(10, 0)    NOT NULL,
    FECHA_INICIO        DATE             NOT NULL,
    URL                 VARCHAR2(200)    NOT NULL,
    INGRESO_ESPERADO    NUMBER(11, 2)    NOT NULL,
    TOTAL_RECAUDADO     NUMBER(11, 2),
    CONSTRAINT SUBASTA_PK PRIMARY KEY (SUBASTA_ID)
    USING INDEX(
		CREATE UNIQUE INDEX SUBASTA_IPK on SUBASTA(SUBASTA_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	)
)TABLESPACE ADMIN_OBJ_TS;


-- 
-- TABLE: OBJETO 
--

CREATE TABLE OBJETO(
    OBJETO_ID               NUMBER(10, 0)    NOT NULL,
    NOMBRE                  VARCHAR2(40)     NOT NULL,
    DESCRIPCION             VARCHAR2(300)    NOT NULL,
    PRECIO_INICIAL_VENTA    VARCHAR2(40)     NOT NULL,
    CODIGO_BARRAS_TXT       VARCHAR2(40)     NOT NULL,
    CODIGO_BARRAS_IMG       BLOB             NULL,
    FECHA_STATUS_ACTUAL     DATE             NOT NULL,
    FECHA_FIN_OFERTA        DATE             NOT NULL,
    COMISION_VENDEDOR       NUMBER(11, 2),
    TIPO                    CHAR(1)          NOT NULL,
    SUBASTA_ID              NUMBER(10, 0)    NOT NULL,
    USR_VENDEDOR_ID         NUMBER(10, 0),
    STATUS_ACTUAL_ID        NUMBER(10, 0)    NOT NULL,
    CONSTRAINT OBJETO_PK PRIMARY KEY (OBJETO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX OBJETO_IPK on OBJETO(OBJETO_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	), 
    CONSTRAINT OBJETO_STATUS_ACTUAL_ID_FK FOREIGN KEY (STATUS_ACTUAL_ID)
    REFERENCES STATUS_OBJETO(STATUS_OBJETO_ID),
    CONSTRAINT OBJETO_SUBASTA_ID_FK FOREIGN KEY (SUBASTA_ID)
    REFERENCES SUBASTA(SUBASTA_ID),
    CONSTRAINT OBJETO_USR_VENDEDOR_ID_FK FOREIGN KEY (USR_VENDEDOR_ID)
    REFERENCES MSE_ADMIN_USERS.USUARIO(USUARIO_ID)
)
LOB(CODIGO_BARRAS_IMG) STORE AS (tablespace ADMIN_OBJ_BLOB_TS)
TABLESPACE ADMIN_OBJ_TS;





-- 
-- TABLE: HACIENDA 
--

CREATE TABLE HACIENDA(
    OBJETO_ID    NUMBER(10, 0)    NOT NULL,
    EXTENSION    NUMBER(7, 3)     NOT NULL,
    DIRECCION    VARCHAR2(100)    NOT NULL,
    CONSTRAINT HACIENDA_PK PRIMARY KEY (OBJETO_ID), 
    CONSTRAINT HACIENDA_OBJETO_FK FOREIGN KEY (OBJETO_ID)
    REFERENCES OBJETO(OBJETO_ID)
)TABLESPACE ADMIN_OBJ_TS;




-- 
-- TABLE: ACTIVIDAD 
--

CREATE TABLE ACTIVIDAD(
    ACTIVIDAD_ID    NUMBER(10, 0)    NOT NULL,
    ACTIVIDAD       VARCHAR2(40)     NOT NULL,
    OBJETO_ID       NUMBER(10, 0)    NOT NULL,
    CONSTRAINT ACTIVIDAD_PK PRIMARY KEY (ACTIVIDAD_ID)
    USING INDEX(
		CREATE UNIQUE INDEX ACTIVIDAD_IPK on ACTIVIDAD(ACTIVIDAD_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	), 
    CONSTRAINT HACIENDA_OBJETO_ID FOREIGN KEY (OBJETO_ID)
    REFERENCES HACIENDA(OBJETO_ID)
)TABLESPACE ADMIN_OBJ_TS;



-- 
-- TABLE: MARCA_AUTO 
--

CREATE TABLE MARCA_AUTO(
    MARCA_AUTO_ID    VARCHAR2(40)    NOT NULL,
    NOMBRE_MARCA     VARCHAR2(40)    NOT NULL,
    CONSTRAINT MARCA_AUTO_PK PRIMARY KEY (MARCA_AUTO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX AMARCA_AUTO_IPK on MARCA_AUTO(MARCA_AUTO_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	)
)TABLESPACE ADMIN_OBJ_TS;


-- 
-- TABLE: MODELO_AUTO 
--

CREATE TABLE MODELO_AUTO(
    MODELO_AUTO_ID    VARCHAR2(40)    NOT NULL,
    NOMBRE_MODELO     VARCHAR2(40)    NOT NULL,
    MARCA_AUTO_ID     VARCHAR2(40)    NOT NULL,
    CONSTRAINT MODELO_AUTO_PK PRIMARY KEY (MODELO_AUTO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX MODELO_AUTO_IPK on MODELO_AUTO(MODELO_AUTO_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	),
    CONSTRAINT MODOELO_AUTO_MARCA_AUTO_ID_FK FOREIGN KEY (MARCA_AUTO_ID)
    REFERENCES MARCA_AUTO(MARCA_AUTO_ID)
)TABLESPACE ADMIN_OBJ_TS;



-- 
-- TABLE: AUTO 
--

CREATE TABLE AUTO(
    OBJETO_ID         NUMBER(10, 0)    NOT NULL,
    ANIO              CHAR(4)          NOT NULL,
    NUM_SERIE         VARCHAR2(17)     NOT NULL,
    NUM_CILINDROS     NUMBER(38, 0)    NOT NULL,
    MODELO_AUTO_ID    VARCHAR2(40)     NOT NULL,
    CONSTRAINT AUTO_PK PRIMARY KEY (OBJETO_ID), 
    CONSTRAINT AUTO_OBJETO_ID_FK FOREIGN KEY (OBJETO_ID)
    REFERENCES OBJETO(OBJETO_ID),
    CONSTRAINT AUTO_MODELO_AUTO_ID_FK FOREIGN KEY (MODELO_AUTO_ID)
    REFERENCES MODELO_AUTO(MODELO_AUTO_ID)
)TABLESPACE ADMIN_OBJ_TS;


-- 
-- TABLE: CASA 
--

CREATE TABLE CASA(
    OBJETO_ID      NUMBER(10, 0)    NOT NULL,
    LATITUD        VARCHAR2(20)     NOT NULL,
    LONGITUD       VARCHAR2(20)     NOT NULL,
    DIRECCION      VARCHAR2(100)    NOT NULL,
    DESCRIPCION    VARCHAR2(300)    NOT NULL,
    CONSTRAINT CASA_PK PRIMARY KEY (OBJETO_ID), 
    CONSTRAINT CASA_OBJETO_ID_FK FOREIGN KEY (OBJETO_ID)
    REFERENCES OBJETO(OBJETO_ID)
)TABLESPACE ADMIN_OBJ_TS;



-- 
-- TABLE: FOTOGRAFIA_OBJETO 
--

CREATE TABLE FOTOGRAFIA_OBJETO(
    FOTOGRAFIA_OBJETO_ID    NUMBER(10, 0)    NOT NULL,
    FOTOGRAFIA              BLOB             NULL,
    OBJETO_ID               NUMBER(10, 0)    NOT NULL,
    CONSTRAINT FOTOGRAFIA_OBJETO_PK PRIMARY KEY (FOTOGRAFIA_OBJETO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX FOTOGRAFIA_OBJETO_IPK on FOTOGRAFIA_OBJETO(FOTOGRAFIA_OBJETO_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	),
    CONSTRAINT FOTOGRAFIA_OBJETO_OBJETO_ID_FK FOREIGN KEY (OBJETO_ID)
    REFERENCES OBJETO(OBJETO_ID)
)
LOB(FOTOGRAFIA) STORE AS (tablespace ADMIN_OBJ_BLOB_TS)
TABLESPACE ADMIN_OBJ_TS;



-- 
-- TABLE: HISTORICO_STATUS_OBJETO 
--

CREATE TABLE HISTORICO_STATUS_OBJETO(
    HISTORICO_STATUS_OBJETO_ID    VARCHAR2(40)     NOT NULL,
    FECHA_STATUS                  DATE             NOT NULL,
    OBJETO_ID                     NUMBER(10, 0)    NOT NULL,
    STATUS_OBJETO_ID              NUMBER(10, 0)    NOT NULL,
    CONSTRAINT HISTORICO_STATUS_OBJETO_PK PRIMARY KEY (HISTORICO_STATUS_OBJETO_ID)
    USING INDEX(
		CREATE UNIQUE INDEX HISTORICO_STATUS_OBJETO_IPK on HISTORICO_STATUS_OBJETO(HISTORICO_STATUS_OBJETO_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	), 
    CONSTRAINT HISTORICO_STATUS_OBJETO_ID_FK FOREIGN KEY (OBJETO_ID)
    REFERENCES OBJETO(OBJETO_ID),
    CONSTRAINT HISTORICO_STATUS_OBJETO_STATUS_OBJETO_ID_FK FOREIGN KEY (STATUS_OBJETO_ID)
    REFERENCES STATUS_OBJETO(STATUS_OBJETO_ID)
)TABLESPACE ADMIN_OBJ_TS;



-- 
-- TABLE: OFERTA 
--

CREATE TABLE OFERTA(
    OFERTA_ID           NUMBER(10, 0)    NOT NULL,
    FECHA_CAPTURA       TIMESTAMP(6)     NOT NULL,
    OFERTA_ECONOMICA    NUMBER(9, 2)     NOT NULL,
    NUM_OFERTA          NUMBER(5, 0)     NOT NULL,
    OFERTA_GANADORA     CHAR(1)          NOT NULL,
    OBJETO_ID           NUMBER(10, 0)    NOT NULL,
    USUARIO_ID          NUMBER(10, 0)    NOT NULL,
    FACTURA_ID          NUMBER(10, 0),
    CONSTRAINT OFERTA_PK PRIMARY KEY (OFERTA_ID)
    USING INDEX(
		CREATE UNIQUE INDEX OFERTA_IPK on OFERTA(OFERTA_ID)
		TABLESPACE ADMIN_OBJ_INDEX_TS	
	),
    CONSTRAINT OFERTA_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES MSE_ADMIN_USERS.USUARIO(USUARIO_ID),
    CONSTRAINT OFERTA_OBJETO_ID_FK FOREIGN KEY (OBJETO_ID)
    REFERENCES OBJETO(OBJETO_ID),
    CONSTRAINT OFERTA_FACTURA_ID_FK FOREIGN KEY (FACTURA_ID)
    REFERENCES MSE_ADMIN_USERS.FACTURA(FACTURA_ID)
)TABLESPACE ADMIN_OBJ_TS;

--
--INDICES ADMINISTRACION DE OBJETOS
--

-- 
-- index: oferta_num_oferta_iuk
--

create unique index oferta_num_oferta_iuk on OFERTA(NUM_OFERTA) tablespace ADMIN_OBJ_INDEX_TS;
-- 
-- index: oferta_objeto_id_usuario_id_ix
--

create unique index oferta_objeto_id_usuario_id_ix on OFERTA(OFERTA_ID , USUARIO_ID )
tablespace ADMIN_OBJ_INDEX_TS;

-- 
-- index: auto_num_serie_iuk
--
create unique index auto_num_serie_iuk on AUTO(NUM_SERIE)
tablespace ADMIN_OBJ_INDEX_TS;
