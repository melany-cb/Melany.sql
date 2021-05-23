--CODIGO MELANY
--package FICHA
create table ejercicio.estado_formacion(
	nombre_estado varchar(40) not null ,
	estado varchar(40) not null,
	constraint pk_estado_formacion primary key (nombre_estado)
);
create table ejercicio.aprendiz(
	numero_documento varchar(50) not null ,
	sigla varchar(10) not null ,
	numero_ficha varchar(100) not null ,
	nombre_estado varchar(40)not null,
	constraint pk_aprendiz primary key (numero_documento,sigla,numero_ficha),
	constraint FK_cliente foreign key (numero_documento,sigla)references ejercicio.cliente (numero_documento,sigla),
	constraint FK_ficha foreign key (numero_ficha)references ejercicio.ficha (numero_ficha) on update cascade on delete restrict,
	constraint FK_estado_formacion foreign key (nombre_estado)references ejercicio.estado_formacion (nombre_estado) on update cascade on delete restrict
);
create table ejercicio.ficha_Planeacion(
	numero_ficha varchar(100)not null,
	codigo_planeacion varchar(40)not null,
	estado varchar(40) not null,
	constraint pk_ficha_Planeacion primary key (numero_ficha,codigo_planeacion),
	constraint FK_ficha foreign key (numero_ficha)references ejercicio.ficha (numero_ficha) on update cascade on delete restrict,
	constraint FK_Planeacion foreign key (codigo_planeacion)references ejercicio.Planeacion (codigo) on update cascade on delete restrict
);
Create table ejercicio.ficha_has_trimestre(
	numero_ficha varchar (100) not null,
	sigla_jornada varchar (20) not null,
	nivel varchar (40) not null,
	nombre_trimestre int4 not null,
	constraint pk_ficha_has_trimestre primary key (numero_ficha, sigla_jornada, nivel, nombre_trimestre),
	constraint FK_ficha foreign key (numero_ficha) references ejercicio.ficha (numero_ficha) on update cascade on delete restrict,
	constraint FK_trimestre foreign key (sigla_jornada, nivel,nombre_trimestre)references ejercicio.trimestre (sigla_jornada, nivel,nombre_trimestre) on update cascade on delete restrict
);
create table ejercicio.resultados_vistos(
	codigo_resultado varchar(40) not null,
	codigo_competencia varchar (50) not null,
	codigo_programa varchar(50) not null,
	version_programa varchar (40) not null,
	numero_ficha varchar (100)not null,
	sigla_jornada varchar (20) not null,
	nivel varchar (40) not null,
	nombre_trimestre int4 not null,
	codigo_planeacion varchar (40) not null,
	constraint pk_resultados_vistos primary key (codigo_resultado, codigo_competencia, codigo_programa,version_programa,numero_ficha,sigla_jornada,nivel,nombre_trimestre,codigo_planeacion),
	constraint FK_ficha_has_trimestre foreign key (numero_ficha,sigla_jornada,nivel,nombre_trimestre) references ejercicio.ficha_has_trimestre (numero_ficha,sigla_jornada,nivel,nombre_trimestre) on update cascade on delete restrict,
	constraint FK_Planeacion foreign key (codigo_planeacion) references ejercicio.Planeacion (codigo) on update cascade on delete restrict,
	constraint FK_resultado_aprendizaje foreign key (codigo_resultado, codigo_competencia, codigo_programa, version_programa) references ejercicio.resultado_aprendizaje (codigo_resultado, codigo_competencia, codigo_programa, version_programa) on update cascade on delete restrict
	);
--Package PROGRAMADO
create table ejercicio.nivel_formacion(
	nivel varchar(40) not null ,
	estado varchar(40) not null,
	constraint pk_nivel_formacion primary key (nivel)
);
create table ejercicio.programa(
	codigo varchar (50) not null,
	version varchar (40) not null,
	nombre varchar (500) not null,
	sigla varchar (40) not null,
	estado varchar (40) not null,
	nivel varchar (40) not null,
	constraint pk_programa primary key (codigo, version),
	constraint FK_nivel_formacion foreign key (nivel) references ejercicio.nivel_formacion (nivel) on update cascade on delete restrict
);
create table ejercicio.Planeacion(
	codigo varchar (40) not null, 
	estado varchar(40) not null,
	fecha date not null,
	constraint pk_Planeacion primary key (codigo)
);
create table ejercicio.competencia(
	codigo_competencia varchar (50) not null, 
	denominacion varchar (1000) not null,
	codigo_programa varchar(50) not null,
	version_programa varchar (40) not null,
	constraint pk_competencia primary key (codigo_competencia, codigo_programa, version_programa),
	constraint FK_programa foreign key (codigo_programa, version_programa) references ejercicio.programa (codigo, version) on update cascade on delete restrict
);
create table ejercicio.resultado_aprendizaje(
	codigo_resultado varchar (40) not null, 
	denominacion varchar (1000) not null,
	codigo_competencia varchar(50) not null,
	codigo_programa varchar (50) not null,
	version_programa varchar (40) not null,
	constraint pk_resultado_aprendizaje primary key (codigo_resultado,codigo_competencia, codigo_programa, version_programa),
	constraint FK_competencia foreign key (codigo_competencia, codigo_programa, version_programa) references ejercicio.competencia (codigo_competencia, codigo_programa, version_programa) on update cascade on delete restrict
);
create table ejercicio.planeacion_trimestre(
	codigo_resultado varchar (40) not null,
	codigo_competencia varchar (50) not null, 
	codigo_programa varchar (50) not null,
	version_programa varchar (40) not null,
	sigla_jornada varchar (20) not null,
	nivel varchar (40) not null,
	nombre_trimestre int4 not null,
	codigo_planeacion varchar (40) not null,
	constraint pk_planeacion_trimestre primary key (codigo_resultado, codigo_competencia, codigo_programa, version_programa, sigla_jornada,nivel, nombre_trimestre,codigo_planeacion),
	constraint FK_resultado_aprendizaje foreign key (codigo_resultado, codigo_competencia, codigo_programa, version_programa) references ejercicio.resultado_aprendizaje (codigo_resultado, codigo_competencia, codigo_programa, version_programa) on update cascade on delete restrict,
	constraint FK_trimestre foreign key (sigla_jornada,nivel,nombre_trimestre) references ejercicio.trimestre (sigla_jornada,nivel,nombre_trimestre) on update cascade on delete restrict,
	constraint FK_Planeacion foreign key (codigo_planeacion) references ejercicio.Planeacion (codigo) on update cascade on delete restrict
);
create table ejercicio.actividad_planeacion(
	codigo_resultado varchar (40) not null,
	codigo_competencia varchar (50) not null,
	codigo_programa varchar (50) not null,
	version_programa varchar (40) not null,
	sigla_jornada varchar (20) not null,
	nivel varchar (40) not null,
	nombre_trimestre int4 not null,
	nombre_fase varchar (40) not null,
	codigo_proyecto varchar (40) not null,
	numero_actividad int4 not null,
	codigo_planeacion varchar (40) not null,
	constraint pk_actividad_planeacion primary key (codigo_resultado,codigo_competencia,codigo_programa,version_programa,sigla_jornada,nivel,nombre_trimestre,nombre_fase,codigo_proyecto,numero_actividad,codigo_planeacion),
	constraint FK_planeacion_trimestre foreign key (codigo_resultado,codigo_competencia, codigo_programa, version_programa, sigla_jornada, nivel, nombre_trimestre, codigo_planeacion) references ejercicio.planeacion_trimestre (codigo_resultado,codigo_competencia, codigo_programa, version_programa, sigla_jornada, nivel, nombre_trimestre, codigo_planeacion)on update cascade on delete restrict,
	constraint FK_actividad_proyecto foreign key (numero_actividad, nombre_fase,codigo_proyecto) references ejercicio.actividad_proyecto (numero_actividad, nombre_fase,codigo_proyecto) on update cascade on delete restrict
);



	