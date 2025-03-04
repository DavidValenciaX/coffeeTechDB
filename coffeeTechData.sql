--
-- Data for Name: coffee_variety; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coffee_variety (coffee_variety_id, name) FROM stdin;
1	Castillo
2	Borbon
3	Caturra
4	Colombia
5	Tipica
6	Tabi
\.


--
-- Data for Name: cultural_works; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cultural_works (cultural_works_id, name, description) FROM stdin;
1	Chequeo de Salud	Evaluación de la salud general de las plantas de café para identificar enfermedades, plagas o deficiencias y así aplicar medidas preventivas y correctivas.
2	Chequeo de estado de maduración	Inspección de cultivos para determinar el nivel de maduración de los frutos y planificar la cosecha en el momento óptimo para la mejor calidad.
\.


--
-- Data for Name: unit_of_measure_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unit_of_measure_type (unit_of_measure_type_id, name) FROM stdin;
1	Longitud
2	Área
3	Masa
4	Densidad
5	Temperatura
6	Precipitación
\.


--
-- Data for Name: unit_of_measure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unit_of_measure (unit_of_measure_id, name, abbreviation, unit_of_measure_type_id) FROM stdin;
1	Metro	m	1
2	Kilómetro	km	1
4	Plantas por hectárea	pl/ha	4
5	Kilogramos	kg	3
6	Grados Celsius	°C	5
7	Milímetros	mm	6
9	Metro cuadrado	m²	2
10	Kilómetro cuadrado	km²	2
3	Hectárea	ha	2
\.


--
-- Data for Name: farm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.farm (farm_id, name, area, area_unit_id, status_id) FROM stdin;
69	hola	25.00	9	9
70	Prueba1	10.00	9	9
71	Prueba2	10.00	9	9
29	Finca mia	200.00	3	9
72	PruebaAuto1	10.00	9	9
116	00	1.00	10	9
4	prueba2 	200.00	9	9
30	                  ddf                                                                  	25.00	9	9
6	Prueba 3	100.00	9	9
113	Finca 5	98.00	3	9
32	La Arcadia	1.00	3	9
8	prueba 4	100.00	10	9
73	PruebaAuto2	10.00	9	9
74	PruebaAuto3	10.00	9	9
9	pruebaedit	100.00	10	9
11	Finca arrayanes	50.00	10	9
75	PruebaAutomatizada1	10.00	9	9
33	Finca prueba 3. 	28.00	9	9
76	PruebasAutomatizadas1	10.00	9	9
35	Prueba colaboradores 1	76.00	10	9
36	Prueba colaboradores 2	87.00	3	9
37	Finca Don Dimadón	100.00	10	9
38	aaaa	6500.00	3	9
39	Aura L	1000.00	3	9
40	j	11.00	9	9
12	finca 1	0.12	10	9
77	PruebasAutomatizadas2	10.00	9	9
41	el toro	500.00	9	9
13	finca 0	100.00	10	9
10	PRUEBAEDIT	0.25	10	9
78	PruebasAutomatizadas3	10.00	9	9
1	Finca prueba 4	90.00	10	9
44	Finca prueba1	25.00	9	9
79	PruebasAutomatizadas5	10.00	9	9
80	PruebasAutomatizadas6	10.00	9	9
81	PruebasAutomatizadas7	10.00	9	9
82	PruebasAutomatizadas8	10.00	9	9
45	prueba.       con espacios.      x	25.00	9	9
5	Prueba editada 2 veces.	0.40	9	9
83	PruebasAutomatizadas9	10.00	9	9
84	PruebasAutomatizadas10	10.00	9	9
85	PruebasAutomatizadas21	99.00	9	9
86	PruebasAutomatizadas22	198.00	9	9
28	Prueba25	5000.00	3	9
3	23456789012345678901234567890	120.00	10	9
19	kwkwkek	20.00	10	9
20	976	665.00	9	9
21	dndkek	304.00	9	9
23	ldekle	30.00	10	9
24	kskskwkw	230.00	10	9
25	hghh	765.00	9	9
26	jdkwkwkw	3440.00	3	9
27	p \np lolo	12.00	9	9
17	phhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh\nlljjhuu\nljhhy\nluis	678.00	9	9
87	PruebasAutomatizadas23	297.00	9	9
15	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	30.00	10	9
46	hola	54.00	3	9
107	string2	7.00	3	10
34	Soy propietaria	30.00	10	9
42	Soy administradora de finca	67.00	10	9
48	Soy operadora de campo	98.00	3	9
88	PruebasAutomatizadas24	396.00	9	9
89	PruebasAutomatizadas25	495.00	9	9
90	PruebasAutomatizadas26	594.00	9	9
91	PruebasAutomatizadas27	693.00	9	9
92	PruebasAutomatizadas28	792.00	9	9
50	Finca caché passed	25.00	10	9
49	PRUEBAS COSTOS	455.00	10	9
51	pruebaFincaExitosa	25.00	9	9
52	FincaInvalida	0.11	10	9
53	FincaInvalidaa	25.00	9	9
54	....	25.00	9	9
55	🫠😄😄🫠	9.00	9	9
93	PruebasAutomatizadas29	891.00	9	9
14	prueba con muchos caracteres tantos que no caben e	0.90	10	9
56	PruebaValidaciones	10000.00	9	9
57	PruebaAutomatizada	250.00	3	9
58	PruebaAutomatizada2	250.00	3	9
59	PruebaAutomatizada3	250.00	3	9
60	monastery	56.00	3	9
61	Prueba error	98.00	3	9
63	string	6.00	3	9
64	string2	36.00	3	9
65	string6	5.00	3	9
94	PruebasAutomatizadas210	990.00	9	9
67	Finca naromu761	88.00	3	9
68	la pola	265.00	3	9
95	PruebasAutomatizadas31	99.00	9	9
62	ExcepcionesFinca	500.00	9	9
66	Finca prueba 23	87.00	10	9
96	PruebasAutomatizadas32	198.00	9	9
97	PruebasAutomatizadas33	297.00	9	9
98	PruebasAutomatizadas34	396.00	9	9
99	PruebasAutomatizadas41	99.00	9	9
100	PruebasAutomatizadas42	198.00	9	9
101	PruebasAutomatizadas43	297.00	9	9
102	PruebasAutomatizada1	99.00	9	9
103	PruebasAutomatizada2	198.00	9	9
104	PruebasAutomatizada3	297.00	9	9
105	PruebasAutomatizada4	396.00	9	9
47	Finca 4	87.00	10	9
109	string2	3.00	3	9
110	Finca 1	89.00	3	9
108	string5	9.00	3	9
112	PruebaColaboradores2	60.00	3	9
111	PruebaColaboradores	50.00	10	9
16	La Pola	89.00	10	9
31	finca 2	230.00	9	9
114	Finca 7	87.00	10	9
115	hola	8668.00	10	9
18	polita finca	678.00	9	9
43	Finca 2 jjjnnnuvtvt. gvt tbtvtvyy g tvtbbtbyjjkk	3500.00	10	9
7	finca 03	5.00	3	9
117	fincajdjdjd	1.00	3	9
118	Finca Isis	35.00	3	9
119	nsnd\ndkkdmd\nkxkx	6449.00	10	9
120	Kevin	100.00	3	9
121	monte bello	35.00	10	9
122	sfs	23.00	3	9
123	df	4.00	3	9
22	Finca 76	666.00	10	9
135	hola 3	36.00	10	9
126	finca 1 de David operador	50.00	10	9
125	finca 1 de davi	56.00	3	9
127	La chiquis	75.00	3	9
136	Pruebas tareas 2	369.00	10	9
138	pruebaFloracion	602.00	3	9
141	Tai	1000.00	9	9
142	poro	35.00	3	9
143	finca Q	16.00	3	9
144	finca isis	35.00	10	9
145	y	25.00	9	9
146	Natalia	676.00	3	9
147	jajaja	3366.00	9	9
148	Villa Claudia	5.00	3	9
2	Pruebas tareas 1	100.00	3	9
149	prueba Integración	300.00	9	9
150	san isidro	100.00	3	9
151	La Finca de Lú	5.00	3	9
152	Prueba render	300.00	10	9
153	la esperanza	12.00	3	9
154	la arboleda	2.00	3	9
155	prueba 4	64.00	10	9
156	Las delicias	450.00	3	9
157	Prueba detección	25.00	3	9
158	uuu	36.00	10	9
159	finca	300.00	9	9
160	Farm 1	2.00	3	9
\.


--
-- Data for Name: status_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status_type (status_type_id, name) FROM stdin;
1	General
2	User
3	Farm
4	Plot
5	Health_Check
6	Notification
7	Invitation
8	user_role_farm
9	Flowering
10	Task
11	Transaction
12	Deteccion
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (status_id, name, status_type_id) FROM stdin;
1	Activo	1
2	Inactivo	1
3	Pendiente	1
4	En Proceso	1
5	Activo	2
6	Verificado	2
7	No Verificado	2
8	Suspendido	2
9	Activo	3
10	Inactivo	3
11	Activo	4
12	Inactivo	4
13	Completado	5
14	Pendiente	5
15	Revisado	5
16	Aceptada	7
17	Rechazada	7
18	Pendiente	6
22	Activo	8
23	Inactivo	8
24	Pendiente	7
19	Respondida	6
25	Activa	9
26	Cosechada	9
27	Por hacer	10
28	Terminado	10
21	AsignacionTarea	6
20	Programada	6
29	Inactivo	10
30	Inactivo	9
31	Inactivo	6
32	ActualizacionTarea	6
33	Activo	11
34	Inactivo	11
35	Pendiente	12
36	Aceptado	12
37	Descartado	12
38	Desactivado	12
\.


--
-- Data for Name: plot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plot (plot_id, name, longitude, latitude, altitude, coffee_variety_id, farm_id, status_id) FROM stdin;
74	el platanal	-75.32068882137537	2.958413029167802	451.0	2	154	11
60	lote prueba audit	-75.2850976	2.9600333	466.0	1	22	11
6	Kokj	-75.2999694	2.9455685	446.0	3	47	11
7	Jii	-75.2999694	2.9455685	446.0	4	47	11
8	Jjj	-75.2999841	2.9455803	446.0	5	47	11
9	Jui	-75.2999841	2.9455803	446.0	5	47	11
14	dkdkeke	-75.2911776	2.9360855	null	6	31	11
11	Lote 5	-75.2999594	2.9455725	446.0	2	110	11
33	pruebalista	-75.28429593890905	2.9477530178585627	453.0	2	4	11
16	nuevo cafe	-75.2990418	2.9421948	447.0	3	17	11
12	hola s	-75.2911804	2.9360835	446.0	1	31	11
17	Lote 3	-75.2999552	2.9456033	null	5	43	11
15	Lote 4	-75.2999807	2.9455525	446.0	4	110	11
38	Lote #1	-75.2903996	2.9521875	456.0	2	49	11
23	Lote número 3	-75.2903864	2.9521744	456.0	5	111	11
22	pruebaFinca	-75.2903864	2.9521744	456.0	1	111	11
34	pruebaTiempo	-75.02788983285427	2.8475683478296356	2512.0	6	111	11
13	dkskwl	-75.2911776	2.9360855	446.0	5	31	11
18	Lote 1	-75.2999575	2.9455881	null	4	43	11
24	Programa	-75.2847031	2.9542778	460.0	2	6	11
25	lote 2	-75.2999636	2.9455752	446.0	6	43	11
26	Lote 7	-75.2989	2.9456	446.0	6	43	11
27	lote 8	-75.2999803	2.9455635	null	5	43	11
28	Café 2	-75.2851616	2.9600494	null	2	17	11
36	prueba #3	-75.29019545763731	2.952325146304347	456.0	2	111	11
61	lote 1	-75.28782203793526	2.9568115395147987	459.0	5	20	11
35	prueba #4	-75.28839770704508	2.950134678911053	461.0	2	111	11
19	Lote 4	-75.2694422006607	2.9211934527652472	457.0	1	43	11
20	Lote 5	-75.25413919240236	2.9432923703014446	551.0	2	43	11
21	Lote 6	-75.29273383319378	2.9326827746295914	438.0	6	43	11
29	lote 5	-75.4067974537611	2.95651822859395	532.0	6	43	11
4	Iij	-75.31893901526928	2.9134415345260707	457.0	2	47	11
5	Lote 2	-75.2999694	2.9455685	446.0	2	47	11
31	lote py	-75.27789182960987	2.9663722276370175	505.0	1	18	11
30	lote 1	-75.28629619628191	2.95708141227985	459.0	2	18	11
32	loree	-75.28695769608021	2.9582995220325166	459.0	6	18	11
62	hjs	-75.2999429	2.9455404	446.0	2	113	11
63	popo	-75.2999395	2.9455335	446.0	2	113	11
37	PruebaEdicion 	-75.57105123996735	6.282370229298068	1480.0	5	111	11
39	el chapuro	-75.1693406	2.8334891	1533.0	6	43	11
40	lote 1	-75.1693143	2.8334962	1533.0	6	121	11
41	Lote1	-75.2904074	2.9671361	454.0	2	120	11
10	Lote 2	-75.27497258037329	2.927061516493102	462.0	6	43	11
42	loteError	-75.2903892	2.9521835	456.0	6	4	11
64	lote 2	-75.2999587	2.9455535	446.0	1	2	11
43	fsdf	-122.09686808288097	37.417219554353615	3.0	5	35	11
44	popo 	-75.2999795	2.9455567	446.0	2	43	11
46	lote 1	-75.2990204	2.9422027	447.0	3	125	11
47	Lote 1	-75.2989896	2.9421507	447.0	4	39	11
48	jkz	-75.299963	2.9456072	446.0	2	113	11
50	lote prueba 2	-75.2999552	2.9455886	446.0	2	136	11
49	lote 1	-75.30054342001677	2.948946360263388	439.0	2	2	11
52	pruebaFloraciones	-75.2990214	2.9422018	447.0	6	138	11
53	lote	-75.28678771108389	2.9580634673334094	459.0	1	18	11
54	y	-75.2999448	2.9455405	446.0	2	142	11
55	lote 1	-75.39674788713455	2.435668398996459	1473.0	4	143	11
56	lote Isis 1	-75.2999672	2.945552	446.0	2	144	11
57	nuevoLote	-75.290404	2.9522014	456.0	5	62	11
58	loteError	-75.2904114	2.9521809	456.0	2	111	11
65	DesSur	-75.56549672037363	2.899938919007542	1700.0	4	148	11
66	lote 1	-75.29685068875551	2.492748292957544	1618.0	2	32	11
67	lotes	-75.38973726332188	2.420916432411954	1774.0	6	41	11
68	lote 2	-75.2990756	2.9421894	447.0	1	20	11
59	pruebaCostos	-75.2904035	2.9522347	456.0	2	111	11
69	pruebas	-75.2876495	2.9332172	444.0	2	149	11
70	jose	-75.299949	2.9455513	446.0	5	150	11
71	Lote1	-75.3014488	2.95384	435.0	4	151	11
72	pruebaLoteRender	-75.28724033385515	2.952765783980406	456.0	5	152	11
73	el naranjo	-75.62358532100916	2.693764790739285	1071.0	3	153	11
75	Castillo	-75.2904054	2.9522535	456.0	1	156	11
76	Lote 1	-75.29055587947369	2.95760977340891	459.0	2	157	11
77	lou	-75.2851681	2.9600344	466.0	5	158	11
78	Hola@123 4 	-75.2990333	2.942197	447.0	4	26	11
79	prueba 26	-75.29291354119778	2.9932970026530668	446.0	2	153	11
80	prueba 27	-75.30769620090723	2.927387649348107	433.0	6	153	11
81	prueba 28	-75.1421482488513	3.078099916650326	551.0	1	153	11
82	29 prueba	-75.31094569712877	2.97370959959667	446.0	3	153	11
83	Plot 1	-75.2990615	2.9422004	447.0	6	160	11
\.


--
-- Data for Name: cultural_work_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cultural_work_tasks (cultural_work_tasks_id, cultural_works_id, plot_id, reminder_owner, reminder_collaborator, collaborator_user_id, owner_user_id, status_id, task_date, created_at) FROM stdin;
84	1	38	t	t	38	77	29	2024-11-04	2024-11-03 19:49:31.725171
90	1	62	f	f	82	2	28	2024-11-05	2024-11-06 21:29:40.340865
31	2	50	t	t	46	2	28	2024-10-22	2024-10-20 23:58:34.615847
51	1	50	f	f	46	2	28	2024-10-24	2024-10-29 18:40:59.577346
50	1	50	t	t	46	2	29	2024-10-31	2024-10-29 18:37:31.469487
52	2	50	t	t	46	2	27	2024-10-30	2024-10-29 18:42:38.862353
91	1	66	f	f	105	30	28	2024-11-03	2024-11-07 09:17:19.552589
114	1	59	f	f	8	38	28	2024-11-14	2024-11-14 09:45:50.970812
92	1	66	f	t	105	30	29	2024-11-09	2024-11-07 09:24:29.40664
93	2	66	f	t	105	30	27	2024-11-08	2024-11-07 09:31:07.548499
94	1	66	f	f	105	30	28	2024-11-03	2024-11-07 09:50:34.450636
95	1	66	f	t	105	30	27	2024-11-09	2024-11-07 10:12:24.736862
96	1	67	f	t	26	30	27	2024-11-08	2024-11-07 10:25:59.468979
97	2	67	f	t	105	30	27	2024-11-18	2024-11-07 10:28:34.444282
89	1	38	t	t	38	77	29	2024-11-04	2024-11-03 19:50:36.3144
49	1	49	t	t	38	2	28	2024-10-25	2024-10-29 18:33:41.413199
57	2	37	t	t	2	38	28	2024-10-31	2024-10-29 19:55:41.461772
46	2	56	t	t	2	103	28	2024-10-30	2024-10-29 10:30:24.397276
28	1	49	f	t	46	2	28	2024-10-27	2024-10-20 21:25:18.660058
53	2	49	t	t	30	2	27	2024-10-30	2024-10-29 19:02:38.86165
54	1	37	t	t	77	38	27	2024-10-30	2024-10-29 19:50:45.326563
55	1	49	f	f	46	2	28	2024-10-28	2024-10-29 19:53:51.794037
56	1	49	f	f	46	2	28	2024-10-13	2024-10-29 19:54:31.4283
30	2	49	t	f	46	2	28	2024-10-20	2024-10-20 22:04:11.214589
29	1	49	f	t	46	2	29	2024-10-20	2024-10-20 21:33:06.451214
32	1	49	t	t	46	2	28	2024-10-21	2024-10-21 23:06:07.840494
58	2	49	t	t	30	2	27	2024-10-30	2024-10-29 19:58:13.512013
59	1	37	f	f	2	38	28	2024-10-26	2024-10-29 19:59:48.653752
61	1	33	t	t	77	38	27	2024-10-30	2024-10-29 20:16:46.854334
62	1	42	f	f	77	38	28	2024-10-29	2024-10-29 20:17:26.621116
63	1	42	t	t	77	38	27	2024-10-30	2024-10-29 20:17:37.974573
64	1	58	f	f	2	38	28	2024-10-29	2024-10-29 20:37:43.318294
65	2	58	t	t	77	38	27	2024-10-30	2024-10-29 20:37:53.322444
36	1	49	f	f	46	2	28	2024-10-27	2024-10-28 22:56:11.55894
37	1	49	f	f	46	2	28	2024-10-27	2024-10-28 22:56:18.390522
38	1	49	f	f	46	2	28	2024-10-27	2024-10-28 22:56:46.922921
39	1	49	f	f	46	2	28	2024-10-27	2024-10-28 23:04:13.730344
40	1	49	f	f	30	2	28	2024-10-21	2024-10-28 23:06:00.608061
41	2	49	f	f	30	2	28	2024-10-22	2024-10-28 23:14:54.386798
45	2	49	f	f	46	2	28	2024-10-21	2024-10-28 23:56:21.883001
47	1	56	f	f	2	103	28	2024-10-22	2024-10-29 10:30:35.609966
34	1	48	t	t	82	2	29	2024-10-30	2024-10-27 23:35:41.622896
66	1	55	t	t	30	105	29	2024-11-01	2024-10-30 05:56:59.34409
42	1	49	t	t	30	2	28	2024-10-29	2024-10-28 23:40:06.594033
43	1	49	t	t	30	2	28	2024-10-28	2024-10-28 23:40:37.340483
44	2	49	t	t	38	2	29	2024-10-29	2024-10-28 23:56:13.442988
35	1	49	t	t	46	2	28	2024-10-24	2024-10-28 22:38:26.031459
48	1	49	f	f	38	2	28	2024-10-23	2024-10-29 18:15:45.492003
98	1	59	t	t	2	38	28	2024-11-10	2024-11-09 18:17:40.354488
33	2	49	t	t	46	2	29	2024-10-24	2024-10-21 23:06:29.405698
99	1	59	f	f	2	38	28	2024-11-09	2024-11-09 19:59:54.295562
67	1	55	t	t	30	105	29	2024-11-03	2024-10-30 06:00:08.351072
100	1	59	f	f	2	38	28	2024-11-09	2024-11-09 20:00:02.98978
68	2	59	t	t	8	38	29	2024-11-01	2024-10-31 11:34:10.906641
69	1	59	f	f	2	38	28	2024-10-30	2024-10-31 11:43:56.322656
70	1	59	f	f	2	38	28	2024-10-23	2024-10-31 11:46:45.45976
72	1	31	t	t	38	37	27	2024-11-01	2024-10-31 14:12:41.776033
73	1	48	t	t	82	2	29	2024-11-14	2024-11-03 19:20:06.393529
74	1	38	t	t	38	77	29	2024-11-04	2024-11-03 19:46:06.694465
75	1	38	t	t	38	77	29	2024-11-04	2024-11-03 19:46:07.357254
76	1	38	f	f	38	77	29	2024-11-04	2024-11-03 19:46:41.438881
77	1	38	f	f	38	77	29	2024-11-04	2024-11-03 19:46:41.806666
78	1	38	f	f	38	77	28	2024-11-02	2024-11-03 19:47:40.451573
79	1	38	f	f	38	77	29	2024-11-04	2024-11-03 19:47:51.898593
80	1	38	f	f	38	77	29	2024-11-04	2024-11-03 19:48:06.320658
85	1	48	t	t	82	2	27	2024-11-06	2024-11-03 19:49:51.926015
86	1	48	f	f	82	2	28	2024-11-02	2024-11-03 19:50:02.353115
81	2	38	t	t	38	77	29	2024-11-04	2024-11-03 19:48:22.414664
82	2	38	t	t	38	77	29	2024-11-04	2024-11-03 19:48:22.74545
87	1	48	f	f	82	2	28	2024-11-02	2024-11-03 19:50:11.963863
88	1	48	f	f	82	2	28	2024-11-02	2024-11-03 19:50:12.710408
83	1	38	t	t	38	77	29	2024-11-04	2024-11-03 19:49:31.298923
101	1	59	t	t	2	38	28	2024-11-10	2024-11-09 20:05:14.379792
104	2	31	t	f	38	37	27	2024-11-12	2024-11-11 20:28:37.857497
105	1	30	f	f	38	37	28	2024-11-13	2024-11-13 10:45:23.330059
60	1	49	t	t	38	2	27	2024-11-14	2024-10-29 20:12:44.472286
107	1	64	t	t	38	2	27	2024-11-14	2024-11-13 14:42:58.369931
108	2	64	t	t	38	2	27	2024-11-14	2024-11-13 14:43:10.822109
109	1	59	t	t	77	38	27	2024-11-14	2024-11-13 14:47:34.653309
71	1	59	f	f	77	38	28	2025-04-17	2024-10-31 11:56:19.855597
110	2	59	t	t	77	38	27	2024-11-15	2024-11-14 08:21:40.436997
111	1	59	f	f	77	38	27	2024-11-15	2024-11-14 08:23:07.763402
112	1	12	f	f	38	8	28	2024-11-14	2024-11-14 09:22:54.813139
113	1	12	t	t	38	8	27	2024-11-15	2024-11-14 09:24:05.341035
115	2	59	f	f	8	38	27	2024-11-15	2024-11-14 09:46:06.295099
117	2	64	f	f	37	2	28	2024-11-14	2024-11-14 14:16:41.52166
118	2	59	t	t	2	38	28	2024-11-15	2024-11-14 14:17:15.603199
119	1	75	t	t	38	112	27	2024-11-26	2024-11-25 10:55:40.642871
120	2	76	f	f	37	80	28	2024-11-25	2024-11-25 12:05:49.384294
121	1	76	f	f	37	80	28	2024-11-25	2024-11-25 12:05:57.947572
122	1	76	t	t	37	80	28	2024-11-26	2024-11-25 12:18:32.700869
103	2	56	f	f	2	103	29	2024-11-13	2024-11-11 15:31:46.390532
123	1	56	f	f	2	103	28	2024-11-25	2024-11-25 18:18:25.402574
124	1	56	f	f	2	103	28	2024-11-25	2024-11-25 18:18:33.68519
126	2	56	f	f	2	103	28	2024-11-25	2024-11-25 18:18:54.388729
127	2	56	f	f	2	103	28	2024-11-25	2024-11-25 18:19:01.390386
128	2	56	f	f	2	103	28	2024-11-25	2024-11-25 18:19:08.725015
106	1	59	t	t	2	38	28	2024-11-14	2024-11-13 14:38:38.47371
116	1	59	t	t	2	38	28	2024-11-15	2024-11-14 14:16:38.944821
132	2	56	f	f	2	103	28	2024-11-26	2024-11-25 18:19:55.398619
125	1	56	t	t	2	103	28	2024-11-27	2024-11-25 18:18:48.378513
131	1	56	f	f	2	103	28	2024-11-26	2024-11-25 18:19:47.402954
130	1	56	f	f	2	103	28	2024-11-26	2024-11-25 18:19:39.353343
129	1	56	t	f	2	103	28	2024-11-26	2024-11-25 18:19:28.384307
133	2	56	f	f	2	103	28	2024-11-26	2024-11-25 18:20:03.380978
102	1	59	t	t	2	38	28	2024-11-10	2024-11-09 20:05:36.012236
134	2	56	f	f	2	103	28	2024-11-26	2024-11-25 19:02:37.44063
135	2	56	f	f	2	103	28	2024-11-25	2024-11-25 19:22:35.981752
136	2	56	f	f	2	103	28	2024-11-26	2024-11-25 19:23:34.395144
137	2	56	f	f	2	103	28	2024-11-26	2024-11-25 19:25:44.50832
139	1	56	f	f	2	103	28	2024-11-26	2024-11-25 21:07:16.914796
138	2	56	f	f	2	103	28	2024-11-26	2024-11-25 21:07:03.895829
140	1	56	f	f	2	103	28	2024-11-29	2024-11-28 09:47:06.383942
141	1	56	f	f	2	103	27	2024-11-29	2024-11-28 10:11:09.509384
142	2	74	f	f	6	64	28	2024-11-28	2024-11-28 12:45:28.427019
143	2	74	f	f	6	64	28	2024-11-28	2024-11-28 12:48:10.76683
144	2	74	f	t	6	64	27	2024-11-29	2024-11-28 12:48:35.561975
145	1	59	t	t	2	38	27	2024-11-29	2024-11-28 14:02:08.54679
146	2	59	f	f	2	38	27	2024-11-30	2024-11-28 14:07:55.392773
147	1	83	t	t	38	103	28	2024-11-29	2024-11-28 14:24:10.63534
148	2	83	t	t	38	103	28	2024-11-29	2024-11-28 14:26:43.749074
\.


--
-- Data for Name: flowering_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flowering_type (flowering_type_id, name) FROM stdin;
1	Principal
2	Mitaca
\.


--
-- Data for Name: flowering; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flowering (flowering_id, plot_id, flowering_date, harvest_date, status_id, flowering_type_id) FROM stdin;
5	12	2024-10-09	2025-04-09	25	2
4	12	2024-10-09	2025-04-09	26	1
9	49	2024-04-22	2024-10-21	26	2
8	49	2024-04-22	\N	30	2
7	49	2024-04-22	2024-10-18	26	1
97	75	2024-11-18	\N	25	1
11	49	2024-04-11	2024-10-18	26	2
12	49	2024-02-10	2024-08-09	26	1
13	49	2024-03-13	2024-10-24	26	1
14	50	2024-10-15	\N	25	1
15	50	2024-04-11	2024-10-17	26	1
6	49	2024-04-21	2024-10-24	26	1
10	49	2024-04-22	\N	30	2
16	49	2024-10-17	2025-04-12	26	1
17	49	2024-10-10	\N	30	1
18	49	2024-10-11	2025-04-18	26	1
19	49	2024-10-11	\N	30	1
21	49	2024-06-12	\N	30	1
22	49	2024-07-31	\N	30	1
23	49	2024-10-10	\N	30	1
24	49	2024-08-22	\N	30	1
25	49	2024-08-23	\N	30	1
26	49	2024-08-19	\N	30	1
20	49	2024-10-22	\N	30	2
27	49	2024-04-23	\N	30	1
29	35	2024-10-08	\N	25	2
30	37	2024-10-23	2025-04-23	26	1
31	37	2024-10-24	2025-04-24	26	1
32	37	2024-10-24	\N	30	1
33	37	2024-10-24	2025-04-10	26	1
35	37	2024-10-23	2025-04-24	26	1
36	37	2024-10-19	\N	30	1
34	37	2024-10-24	\N	30	2
37	37	2024-10-24	\N	30	2
39	37	2024-10-24	2025-04-24	26	1
38	37	2024-10-24	\N	30	1
40	37	2024-10-24	2025-05-20	26	2
43	52	2024-10-23	\N	25	2
42	52	2024-10-19	2025-04-25	26	1
44	52	2024-10-20	2025-05-15	26	1
45	6	2024-10-16	\N	25	1
46	55	2024-09-10	2025-04-09	26	1
47	48	2024-10-17	\N	25	1
41	37	2024-10-19	2025-05-01	26	1
48	37	2024-10-28	2025-05-03	26	2
49	37	2024-10-28	2025-05-04	26	2
50	37	2024-10-27	2025-05-01	26	2
51	37	2024-10-19	2025-05-19	26	2
52	22	2024-10-01	2025-04-01	26	1
53	22	2024-10-02	2025-04-02	26	1
54	22	2024-10-03	2025-04-03	26	1
55	22	2024-10-19	2025-04-19	26	2
56	22	2024-10-19	2025-04-19	26	1
57	22	2024-10-20	2025-04-20	26	1
58	22	2024-10-21	2025-04-21	26	1
59	22	2024-10-04	2025-04-04	26	1
60	22	2024-10-05	2025-04-05	26	1
61	22	2024-10-19	2025-05-19	26	2
62	48	2024-10-18	2025-04-19	26	2
63	56	2024-10-15	\N	25	1
64	22	2024-10-29	\N	30	1
65	22	2024-10-29	\N	30	2
66	22	2024-10-29	2025-06-10	26	1
67	22	2024-10-28	\N	30	2
68	22	2024-10-19	2025-05-01	26	1
69	22	2024-10-29	\N	30	1
70	57	2024-10-29	\N	25	1
71	14	2024-08-06	\N	25	1
72	38	2024-10-31	2025-05-30	26	1
73	37	2024-03-04	2024-09-30	26	1
74	59	2024-10-31	\N	25	1
75	31	2024-10-16	\N	25	1
76	31	2024-11-02	\N	25	2
28	49	2024-04-16	2024-11-08	26	1
77	49	2024-11-02	\N	30	1
79	49	2024-11-02	2025-05-10	26	2
78	49	2024-11-01	\N	30	1
80	49	2024-05-26	\N	30	1
81	49	2024-05-05	\N	30	1
82	49	2024-05-04	\N	25	1
83	60	2024-11-01	\N	30	1
84	60	2024-11-01	2025-04-20	26	1
85	61	2024-11-01	2025-04-20	26	1
86	60	2024-11-03	2025-04-20	26	1
87	48	2024-11-02	\N	25	2
88	38	2024-11-03	\N	30	1
89	38	2024-11-03	\N	30	2
90	38	2024-05-16	2024-11-03	26	1
91	38	2024-05-16	2024-11-03	26	1
92	62	2024-11-10	\N	25	2
93	62	2024-11-11	\N	25	1
94	72	2024-11-01	\N	25	1
95	72	2024-11-13	\N	25	2
96	60	2024-11-18	\N	25	1
98	75	2024-11-19	\N	25	2
99	83	2024-09-12	\N	25	1
\.


--
-- Data for Name: recommendation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommendation (recommendation_id, recommendation, name) FROM stdin;
1	Aplicar un fertilizante rico en nitrógeno, como el sulfato de amonio o la urea.	nitrogen_N
2	Utilizar fertilizantes con alto contenido de fósforo, como superfosfato o fosfato monoamónico.	phosphorus_P
3	Aplicar fertilizantes ricos en potasio, como el sulfato de potasio o cenizas de madera.	potassium_K
4	Aplicar fungicidas a base de cobre o específicos para Cercospora según indicaciones de un especialista.	cercospora
5	Usar fungicidas sistémicos o preventivos para combatir la roya, aplicando según el ciclo de la enfermedad y las condiciones climáticas.	ferrugem
6	Aplicar fungicidas específicos para roya, especialmente aquellos aprobados para su uso en el cultivo afectado.	leaf_rust
7	Está sanita, sigue así	hoja_sana
11	Dejar que las frutas continúen madurando antes de la recolección.	Verde
8	Recolectar las frutas sobremaduras y procesarlas adecuadamente.	Sobremaduro
9	Recolectar las frutas maduras para su comercialización.	Maduro
10	Mantener las frutas pintonas bajo observación y recolectar según el progreso de maduración.	Pintón
12	No se han identificado granos. No se requiere acción adicional.	No hay granos
\.


--
-- Data for Name: health_checks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.health_checks (health_checks_id, check_date, recommendation_id, prediction, cultural_work_tasks_id, status_id) FROM stdin;
1	2024-11-09	11	unripe	57	36
2	2024-11-09	9	ripe	57	36
78	2024-11-13	12	No hay granos	104	35
79	2024-11-13	12	No hay granos	104	35
8	2024-11-09	11	unripe	57	36
9	2024-11-09	9	ripe	57	36
148	2024-11-25	9	Verde = 2, Maduro = 5	132	35
149	2024-11-25	9	Pintón = 3, Maduro = 34, Sobremaduro = 2	132	36
150	2024-11-25	9	Maduro = 20, Sobremaduro = 7	133	36
151	2024-11-25	4	cercospora	125	36
152	2024-11-25	6	leaf_rust	131	36
153	2024-11-25	6	leaf_rust	131	36
154	2024-11-25	5	ferrugem	131	36
155	2024-11-25	6	leaf_rust	130	36
156	2024-11-25	4	cercospora	130	36
157	2024-11-25	6	leaf_rust	129	35
158	2024-11-25	5	ferrugem	129	35
160	2024-11-25	6	leaf_rust	129	35
159	2024-11-25	6	leaf_rust	129	36
161	2024-11-25	5	ferrugem	129	36
162	2024-11-25	6	leaf_rust	129	36
163	2024-11-26	8	Verde = 99, Pintón = 90, Maduro = 43, Sobremaduro = 128	134	35
164	2024-11-26	8	Pintón = 1, Sobremaduro = 2	134	35
165	2024-11-26	9	Pintón = 3, Maduro = 34, Sobremaduro = 2	134	35
166	2024-11-26	9	Maduro = 20, Sobremaduro = 7	134	35
167	2024-11-26	12	No hay granos	134	35
168	2024-11-26	8	Verde = 99, Pintón = 90, Maduro = 43, Sobremaduro = 128	134	35
169	2024-11-26	8	Pintón = 1, Sobremaduro = 2	134	35
170	2024-11-26	9	Pintón = 3, Maduro = 34, Sobremaduro = 2	134	35
171	2024-11-26	12	No hay granos	134	35
172	2024-11-26	12	No hay granos	134	35
173	2024-11-26	8	Verde = 99, Pintón = 90, Maduro = 43, Sobremaduro = 128	134	35
174	2024-11-26	9	Pintón = 3, Maduro = 34, Sobremaduro = 2	134	35
175	2024-11-26	9	Maduro = 20, Sobremaduro = 7	134	35
176	2024-11-26	8	Pintón = 1, Sobremaduro = 2	134	36
177	2024-11-26	9	Pintón = 3, Maduro = 34, Sobremaduro = 2	134	36
178	2024-11-26	9	Maduro = 20, Sobremaduro = 7	134	36
179	2024-11-26	9	Verde = 2, Maduro = 5	134	36
80	2024-11-13	12	No hay granos	104	35
81	2024-11-13	9	Maduro = 2	104	35
71	2024-11-10	6	leaf_rust	101	36
72	2024-11-10	6	leaf_rust	102	35
73	2024-11-11	6	leaf_rust	102	35
74	2024-11-11	6	leaf_rust	102	35
180	2024-11-26	8	Verde = 99, Pintón = 90, Maduro = 43, Sobremaduro = 128	134	36
82	2024-11-13	9	Maduro = 4	104	35
83	2024-11-13	12	Maduro = 4	104	35
84	2024-11-13	9	Maduro = 5	104	35
85	2024-11-13	12	Maduro = 5	104	35
86	2024-11-13	8	Maduro = 5, Sobremaduro = 1	104	35
87	2024-11-13	12	Maduro = 5, Sobremaduro = 1	104	35
181	2024-11-26	12	No hay granos	134	36
182	2024-11-26	12	No hay granos	134	36
183	2024-11-26	12	No hay granos	134	36
184	2024-11-26	12	No hay granos	134	36
185	2024-11-26	12	No hay granos	134	36
186	2024-11-26	9	Maduro = 20, Sobremaduro = 7	136	36
100	2024-11-13	12	No hay granos	104	35
101	2024-11-13	12	No hay granos	104	35
104	2024-11-13	12	No hay granos	104	35
105	2024-11-13	12	No hay granos	104	35
70	2024-11-09	6	leaf_rust	98	38
115	2024-11-13	6	leaf_rust	71	36
116	2024-11-13	7	hoja_sana	71	36
117	2024-11-13	6	leaf_rust	106	35
118	2024-11-14	9	Maduro = 2	110	35
119	2024-11-14	9	Maduro = 3	110	35
120	2024-11-14	10	Verde = 1, Pintón = 2, Maduro = 4	110	35
121	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 4	110	35
122	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 4	110	35
123	2024-11-14	9	Verde = 1, Pintón = 2, Maduro = 7	110	35
124	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 7	110	35
125	2024-11-14	9	Verde = 1, Pintón = 2, Maduro = 11	110	35
126	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 11	110	35
127	2024-11-14	9	Verde = 1, Pintón = 2, Maduro = 13	110	35
128	2024-11-14	9	Maduro = 2	110	35
129	2024-11-14	9	Maduro = 3	110	35
130	2024-11-14	10	Verde = 1, Pintón = 2, Maduro = 4	110	35
131	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 4	110	35
132	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 4	110	35
133	2024-11-14	9	Verde = 1, Pintón = 2, Maduro = 7	110	35
134	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 7	110	35
135	2024-11-14	9	Verde = 1, Pintón = 2, Maduro = 11	110	35
136	2024-11-14	12	Verde = 1, Pintón = 2, Maduro = 11	110	35
137	2024-11-14	9	Verde = 1, Pintón = 2, Maduro = 13	110	35
138	2024-11-14	7	hoja_sana	111	35
139	2024-11-14	10	Verde = 3, Pintón = 6, Sobremaduro = 1	118	36
140	2024-11-25	7	hoja_sana	122	36
141	2024-11-25	6	leaf_rust	102	36
142	2024-11-25	2	phosphorus_P	106	36
143	2024-11-25	6	leaf_rust	116	36
208	2024-11-26	9	Pintón = 3, Maduro = 34, Sobremaduro = 2	137	36
209	2024-11-26	8	Pintón = 1, Sobremaduro = 2	137	36
210	2024-11-26	8	Verde = 99, Pintón = 90, Maduro = 43, Sobremaduro = 128	137	36
211	2024-11-26	9	Verde = 2, Maduro = 5	137	36
212	2024-11-26	9	Maduro = 20, Sobremaduro = 7	137	36
213	2024-11-25	6	leaf_rust	139	35
214	2024-11-25	4	cercospora	139	35
215	2024-11-25	6	leaf_rust	139	35
216	2024-11-25	5	ferrugem	139	35
217	2024-11-25	6	leaf_rust	139	35
218	2024-11-25	6	leaf_rust	139	36
219	2024-11-25	4	cercospora	139	36
220	2024-11-25	6	leaf_rust	139	36
221	2024-11-25	5	ferrugem	139	36
222	2024-11-25	6	leaf_rust	139	36
223	2024-11-25	8	Verde = 99, Pintón = 90, Maduro = 43, Sobremaduro = 128	138	36
226	2024-11-28	3	potassium_K	140	35
227	2024-11-28	3	potassium_K	140	36
228	2024-11-28	3	potassium_K	140	36
229	2024-11-28	1	nitrogen_N	141	35
230	2024-11-28	1	nitrogen_N	141	35
231	2024-11-28	5	ferrugem	141	35
232	2024-11-28	6	leaf_rust	141	35
233	2024-11-28	2	phosphorus_P	141	35
234	2024-11-28	2	phosphorus_P	141	35
235	2024-11-28	2	phosphorus_P	141	35
236	2024-11-28	6	leaf_rust	141	35
250	2024-11-28	3	potassium_K	141	35
251	2024-11-28	3	potassium_K	141	35
252	2024-11-28	3	potassium_K	141	35
253	2024-11-28	3	potassium_K	141	35
254	2024-11-28	3	potassium_K	141	35
255	2024-11-28	3	potassium_K	141	35
256	2024-11-28	6	leaf_rust	141	35
257	2024-11-28	6	leaf_rust	141	35
258	2024-11-28	6	leaf_rust	141	35
259	2024-11-28	6	leaf_rust	141	35
260	2024-11-28	7	hoja_sana	141	35
261	2024-11-28	6	leaf_rust	141	35
264	2024-11-28	6	leaf_rust	141	35
265	2024-11-28	6	leaf_rust	141	35
266	2024-11-28	6	leaf_rust	141	35
269	2024-11-28	7	hoja_sana	141	35
271	2024-11-28	6	leaf_rust	141	35
273	2024-11-28	6	leaf_rust	141	35
275	2024-11-28	6	leaf_rust	141	35
277	2024-11-28	7	hoja_sana	141	35
287	2024-11-28	6	leaf_rust	141	35
288	2024-11-28	2	phosphorus_P	141	35
290	2024-11-28	7	hoja_sana	141	35
291	2024-11-28	4	cercospora	141	35
292	2024-11-28	4	cercospora	141	35
297	2024-11-28	6	leaf_rust	141	35
298	2024-11-28	6	leaf_rust	141	35
299	2024-11-28	6	leaf_rust	141	35
300	2024-11-28	4	cercospora	141	35
301	2024-11-28	6	leaf_rust	141	35
302	2024-11-28	7	hoja_sana	141	35
303	2024-11-28	6	leaf_rust	141	35
308	2024-11-28	7	hoja_sana	147	36
309	2024-11-28	4	cercospora	147	36
310	2024-11-28	7	hoja_sana	147	36
311	2024-11-28	6	leaf_rust	147	36
312	2024-11-28	6	leaf_rust	147	36
313	2024-11-28	9	Pintón = 4, Maduro = 11	148	36
314	2024-11-28	9	Maduro = 20, Sobremaduro = 7	148	36
315	2024-11-28	11	Verde = 80, Pintón = 64, Maduro = 17, Sobremaduro = 65	148	36
316	2024-11-28	9	Verde = 2, Maduro = 10	148	36
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, email, password_hash, verification_token, session_token, status_id, fcm_token) FROM stdin;
72	🐍🐁🧡🧡🧡🧡🥺🤨🗣️🤨🗣️🤨🗣️🤑🤨❤️🧏❤️🧏❤️🧏❤️🚬✨🙂🙏🙂🙏☠️🤢👉☠️👉☠️🚩🚩☝️🚩👈🚩😳👈🤡🤡🤡🤡🤡🤡🤡🤫🤫🤫🤫🤫🗿😎✨🤌😍😍😍😍😈😍😈😍👍🫵🐒🥳🐒🐒🥳🐒🐒🤑✨✨🤑✨🗣️🗣️✨🗣️🗣️	prappotaunnumu-5923@yopmail.com	$argon2id$v=19$m=65536,t=3,p=4$K4WwtpYSojSmlLI2JmSM8Q$T6YzIIRGFKQMd5h209pRlPF5qEdT6mAk2QzxQPrpxSc	\N	Z6x_11oTHJWdgp8WsCDrSOdyFj8wPrv_H0LL19QPOzE	6	\N
57	Brayis	anbrawil3@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$bk2JUYox5pwT4vzfW0tp7Q$sEdnLUQ6poNyaFA1w7i2ke3o41CVyUTal5UAFjASsEM	hLRcb5cfxHY	\N	7	\N
58	Felipe	juankastro0331@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$y7lX6j1njHHu3dsbI8RYaw$Hlf8fIaDTEf2Mbo57vZfpBTR7/LPH8dfpO+rRg0KHmw	\N	a6_8afyQVaphpZB5fC1aEilzjH2Q-yKxFTJyQ221mks	6	\N
73	na	Rodriguez@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$yLn3ntPaG0PIOae0Vur9Pw$4X6nMBdYlGNVWrHZw0Jec+9UNmWcxKD8CUmk4WC4Dt8	\N	\N	6	\N
75	Nata	natyrm15173444@gmail.comp	$argon2id$v=19$m=65536,t=3,p=4$xNjbmxMipNT6X6u1ds4Z4w$yNYO0vYyGJ9MxMSC0mISEt7dTCV5EHQycGPAxXSJ4vg	\N	\N	6	\N
61	شذ𠜎𡃁𡈼𥻘𠮷あいうえおカタカナПривет🚀💼📊	u20202193111@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$aW0tJSTEmLOW8r53ztl77w$bVcImHYYfjGo2BMQrfkvHm0X6RfEMOUdLXBOHpzyNhA	\N	\N	6	\N
76	nataromu	nataromu761@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$S2mtVWrtHUOI0XpvTendGw$HxAvH25c6zNoZRqN+Ze+A59IZS7Q/XckBKaOU5x4M34	\N	aFdJKH7TWCW5jBl6uIk2xBdZYVYOBK4L	6	dVtXofKIQliSjp2Sg-4ukl:APA91bEnBf34LJ-wFtpkpqqg7QAmEJScM-EsJPtSebq1x5yZ8sovuegygcI8MpDX1YrI5gQQbroW3s7StzyRP-LPN_pgfIv8CzRXSgmswAf72NA1tLmECt8jDlgudeYWtpML7NRrchbF
62	Deissy L	deissymlr@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$5bzXute6V6o15nwPwTgHgA$WrloPgR8b1YOtXP/AoerqmPo+5Nq4VTThd3gYSMOlOY	\N	\N	6	\N
6	sebastian ramirez	u20202193043@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$AwBgDOH8X2tNyVkLIYSwFg$sGE5z9UBGHR6wTFFgwKI7zExpZ/kekeIYlMf5sKTYR4	\N	kl6otvwuzS0625De1UI3iRy80Y3XPD0O	6	f-Djtkc-SI24p_FO4sZwQe:APA91bEpIMs6dqFNEjVhWk4JX11sKsXrN4BNcQhJEsSbXpEEzZKuDpq4K_zBW1aiSwhiMq3-PAhUWnj2XWfBifaF5AHDQmujt_NLtgf-A6Q1vRgakGhDWbc
67	isidk	proiddeimmunnappe-5365@yopmail.com	$argon2id$v=19$m=65536,t=3,p=4$irGW8h4DoBTC2Huv1ZrzHg$lfbN23lNF/+S0svAHEJQRb3JBOkcKVyoiDMmRksso7s	\N	EqNvAFg0MJZJHtMtMwXmZLt4ZqXNJe_j_pz2joectks	6	\N
71	C@Прт🚀	buquoudduquema-8516@yopmail.com	$argon2id$v=19$m=65536,t=3,p=4$mNP635tzrlUqhZAyRkiJ8Q$1Je6/j6vQbqP77OE4Vvhe9FVNDWm0x1ZS3U8sLKQvd0	\N	\N	6	\N
8	Dylan23	u20202192371@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$PGcs5bw3JkQI4VyLkXLu/Q$Zk2ov+Zkcz6aDlqSrulVyC7/ilQa3ddEK1BX49Bf08I	\N	ewgifdhD8ShN8IL3M6bWwScotx6Xg2d5	6	cBifhjmZSMWfNwzcJWaOt-:APA91bEEA0YlpipcliP52O-LN1P4SnNdfeOY0ACgpogoUv8pOenW7_wuXmLrY0AfwV-93g6ZAgbXZWoRKtrNRFzA4Ai9-0F3GEFkQB0pdxGeOVVl3LtNFVw
82	naty rmu	nataromu762@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$/T8HAOBcq/V+L8X4v3durQ$8RcP0N4pVMxj+OHBZ4OP+C0whEHa9b7ZqgmPUkhQwoc	\N	R04oQQqKpCl5oev2YkdTnPcolxAF65z9	6	eXPlwhsjQeWYsgqPWhv5-J:APA91bH2yY5ZtRisx8wYR_PEKycRZUWAZj3mWuQ_8JS1HwYrc36JQ-MwiyVSgy_GhaG6diqPiAiN0qvvpcW7DLRSI_6e4uQwS1J1ojae1LrfDlNNCJBaLe_1FAFUXHWE2b05feJqAfKZ
68	Daniel	prueba22@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$3DtnrHUOQehda+0dA8D4/w$fQGp2b+x1j154voTKUPgmo0M2413OyNN4/Pp1A90gts	mReRO0YHJ34	\N	7	\N
1	John Doe	john.doe@example.com	$argon2id$v=19$m=65536,t=3,p=4$IqT0/j+ndC7lXOu9dw7hvA$r/XGzZSBodfew5R1keSJS8dXJYI5E6BGjxx/O2jK0dE	vgWTf4ENzQ0lOTWBxUvKHw	\N	7	\N
28	PruebaAutomatizada2	pruebas@gmail.comm	$argon2id$v=19$m=65536,t=3,p=4$jDGmlBJCSCklZGzN+Z+zVg$QjkzkhOllatv4V1uC6bQIMkNvbWhETJDVTDgq6yiMxU	RRbLMh9lXFuXzEqE83E9CA	\N	7	\N
16	Prueba	prueba1@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$55wT4pzzHqOU8t7bO6d0Lg$xhZIiAGyxwu4HWttAs7Fnx2HvTYXsPNrqmriqd4evhQ	2u-ZNqZLd55recTDIghb6g	\N	7	\N
4	Dylan	dylan34b@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$T8mZEwIA4JwTYkxpTWntHQ$YnXBg6sFJ0VUDjITKQ6c7XYwvkQqfUtwA+tMk2wOnQE	\N	\N	6	\N
5	Jhon	jhon18@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$CKGU8v7/X0uptZYyphTC2A$UBFsnDRn2GEjyIhZ8qnp3qDaR+8MMaxMFJWPShbIVEo	Gvj9fi25SROazKvcALTykg	\N	7	\N
17	PruebaPassword	pruebacontrasea@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$wDgHAEBoTYnxXutdq7UWYg$LN6CXxO73ZHUZ1AyESS24OjHm+/FTPF2T9UDAvNiKUw	jTspyusVmwHpVZfS5IFnoA	\N	7	\N
19	pruebas	pruebas@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$3du7F2Is5VxrDQHgXIvxng$fpIM7ZiW10bReu5lbBj5/iGidIxYUkuscwGPAu6hJNI	\N	\N	6	\N
38	Prueba	u20202191528@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$h9D6PyckpNRaS+lda21tLQ$Uah3TNEijDkzB3WRON1aGI6jPa7HcdzC0Z3vOuUdoDU	4IsI	\N	6	\N
85	Test User	test_8b2221ab-55a1-4326-9912-4c925bc9d4a8@example.com	$argon2id$v=19$m=65536,t=3,p=4$2vvfW6uVMuZ8LyUEYIzxvg$iiPxGANM9YiZyTT2Z37IwPqsivCdoEON8v4VzUVBhZw	KOqN	\N	7	\N
78	Valentin	valentin12@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$xJjTuve+txZC6P2/V2rNWQ$tCB6yO+yVhqie6Mf+kjOMOqMTxj6pR9sE/nbO4JMhn4	\N	bHQTjAWmloLsdRjJ48fpnRpB95JPtcXK	6	\N
87	Test User	test_5353bba6-caa3-41ac-b5de-f4d2f30ce69d@example.com	$argon2id$v=19$m=65536,t=3,p=4$bg3B2JszBqC0FkLIuZdyzg$pDCPAC0+SHMF8Tq0eekd9TdOsGZcZd32mC7U6aW67CY	\N	8fAUyKYTqlWgX7TZ8w0LUYr7SN7mFRyR	6	dummy_fcm_token
69	Oscar 2	davidvalencia0526@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$ntP639t7LwUAgFDKuTcmpA$FXRNnqt9Nv5FtqxMX4555RJlZOjcUQj94TlY9sd0BgM	ByJb	\N	6	\N
46	Natal	nataromu760@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$Zax1DoHwPoewllLKWSslZA$P4jbwPiz5boj1hxK/DCvWIpCXP/cYVM1XisMBuRmIlQ	\N	\N	6	\N
89	Test User	test_83543108-2286-422d-9fd7-0861a82c6f81@example.com	$argon2id$v=19$m=65536,t=3,p=4$ZMx5zznnHGOM8X5vzVlr7Q$A+dtAcNLh2D/ksY5vc0TAsWW4bJoLkkQ3hsqxxKvOSs	\N	fnIRRCA5DwuC2n7o7Ud4htDw9jVnLSkn	6	dummy_fcm_token
90	Test User	test_ce03c34d-33d9-4cdc-b04b-b39f6e7fb248@example.com	$argon2id$v=19$m=65536,t=3,p=4$kbJ2LuUcYyyltFZKyZlzDg$ShMtlOUL8bW1qWdENalyTbU4EZPDvXdSqHGwACJuWTs	\N	NxMZ4tLMeUBbXPvP2bVJNmyw5HIC3HVm	6	dummy_fcm_token
91	Test User	test_81390978-e375-4a87-a927-694f8b64b53b@example.com	$argon2id$v=19$m=65536,t=3,p=4$SAkBoFRqjTGGEOIco5QyZg$S8/ZdK71SV2OWtyBkEIzyHAazPpeFCU4I8IuPROMHZo	\N	PS0bb4TtihUeJygAbgK12ZHKduzo8XIe	6	dummy_fcm_token
14	Deissy 	deismar12@yahoo.es	$argon2id$v=19$m=65536,t=3,p=4$C6HUWotxTimF0BqjlFKqNQ$eUx0xI5FAA0BXNqe0xEVV9m8r8KSLQ9IzE7O2p25Q3g	\N	\N	6	\N
29	PruebaAutomatizada2	prueba3@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$aC2lFML4n3OuNQZgLOVcaw$frWVAnQXxYma0DTtSrfB2ZgCkEPepFsCmoRh5WJ9zEw	cd0SmGAKJNf7zF7Gre_jbw	\N	7	\N
9	Nata 	u20202192737@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$bg3hPEdIyRljDEFobU1JiQ$P5FHuuixhCvMlzvwQXEuJ3HEUtcyObG/zhUTq0ALboI	Hg0ZeVG-VdhVz93IdNc_5A	\N	7	\N
22	nata	natyrm151734444@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$/P8/x9gbo1SqFUJo7V0LwQ$8jAy/5tmTgjFisZuViRxYD817sG5CFvfOYmd8W3A1TI	\N	\N	6	\N
13	Pablo1	qweadd124@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$S8n5/19rDQEAwBiDUEoJAQ$76iV/JdqOMGb3OuEL00koEVDZ4TqhcpJ1AOfrUrgX5U	vBAyPHfwq9mOBkKHpL0NB8kU0tpM64HGStM4RxQfVWE	\N	6	\N
15	Prueba 1	correpruebas@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$plQq5fw/5zxHqDVmzBljrA$5p+Tfp1I4dIwYmxNDFdfb/pJNmaN+lcBkopEMdkZcdw	\N	\N	6	\N
31	pruebas	prueba@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$LkUIQYhxLgVgTKmVUooR4g$DcdS5j9Lpp94qAO3leLOwnlD/wY4CVog5KbrDEqofvA	0qQY5fLLBD1WKUkmFZgCbw	\N	7	\N
7	Nata	Natyrm15173444@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$cA5BqLV2LqW0NobQGqP0Hg$ahhzOO07G1vUKu21fBz3XFOY8OTDQV6P3i9UKLD1Tzs	qk3EDV4IBUL30FlvTVVnYN5gYZx5oDh0-_v4yBdrCcs	\N	7	\N
27	PruebaAutomatizada2	prueba2@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$vbfWurf2vnfOmdNay7lXag$ks4b5Xn68JRG12XHl7Rc/1ow2hELvRgXURSJuGc74j8	q_FtkFcqY15MkRo2SQlHxQ	\N	7	\N
18	prueba07	ninipenija@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$9B7jfC/FOKdUai2l9B6D0A$r4waQghxy07bwKLX94uZ5ZbkkZ6B2hZfzJMcHZYXbwU	\N	\N	7	\N
42	nata	Natyrm1517444@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$jhHCOKeUEiLEGEPImdM6pw$S7Pl+zsNRCcKvwVsaslRO7g7hFzHi/d9hQMr36uutl4	cn6dD_BE9N4	\N	7	\N
51	carlos Mauricio Vargas Monje 	carlos.mvm@hotmail.com	$argon2id$v=19$m=65536,t=3,p=4$rHUuZax1LgVgbE1JKWUMoQ$tX1et+SYC8g0HuoSHpmt3AkWmyCcFffXxIzMoiKQzL4	\N	OIsEfraZs5xfaD_FNMytDu7IikdsBW4sev2wI0vMHTg	6	\N
52	Sandra 	samy.mu14@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$z9mbk9I6ByBEaO2dk5KSMg$YyptIREJBKaU56flaUiPi8qymPkQYEKO2lUlqE/1Wvs	\N	\N	6	\N
53	Alfonso	alejo1004ramirez@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$2xvjPAfgPCcEQCjlXMs5xw$mf6gYWyYEA4UUjQipl7zJp7HzGbN8VA+f9wgdUaQBbY	\N	Z0l8aXE_Lshore82C1YTXZOAAYB8x-IyCD06yLL83tg	6	\N
54	Marlon 	mafgogo13@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$nRPinBPCOEdISckZw9h7jw$fP1QfbKmKAqOOgq5/W57dIHtohiWAO/D7jbmeX1AIEY	\N	\N	6	\N
49	Wilmar Trujillo Guzmán 	w_ilmar@live.com	$argon2id$v=19$m=65536,t=3,p=4$xpiTEsKYk9Jayznn3Pt/Lw$HedzfS9gQh5NcFsUfraJIYgCJ6bE1uUKOIUJhNHy4sc	\N	\N	6	\N
55	Fabio Andres Pineda Sandoval	fp.7753@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$DsFYq/XeuxcCoHSu1VqLEQ$ME7mZBuf6zQJ4yNmoL9SQNHE0Cn+8PZNS9fNx8fSZzI	7d48ffaxwfg	\N	6	\N
56	Brasco	u20202191181@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$BKB0znlPyTnnHCMEQGgt5Q$Dm3YbcgQ+xl9fM9tbyygJxVZVcA9ViK0la20YIbcxR0	gYWvh6g-WtA	\N	7	\N
70	テスト@例.中国рфпароль123⚡🔥💧漢字🚀🌍パスワード💻🔒😊صسشذ𠜎𡃁𡈼𥻘𠮷あいうえおカタカナПривет🚀💼📊	fajopasouqua-2830@yopmail.com	$argon2id$v=19$m=65536,t=3,p=4$WivFOOf837t37l2rlZJSqg$a5dmg4B8aBIlht0wN10znXf2wTxnNa0q6LqO+zQaG90	\N	\N	6	\N
74	na	natyrm@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$dS5l7H1PSSllzHmvNeb8/w$RViw9Q2RITApiMQ/oeVhAo6jDC+M36V+0QxdjfT3YZ0	\N	\N	6	\N
66	Aura LC	auralopezcarabali@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$orTWeo9xbk3pXYtxLuV8Lw$CRSeuLtV8BCo2UXFjg/rkddfyMcCRp2X69vTWI4FrOk	\N	5AaIRFlLxhX5YsKi7-OngFgau41zpHIv1Tjoj-jrNi8	6	\N
59	Diego	jdco.ayco1010@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$ag2h9D6HMOb8nxPCeA/hHA$dtr9lLkM2hVG6OFLsByVJgwm+zetsd+ao48BvRE9jQY	M7A3hwDEG38	\N	6	\N
77	pruebaCuenta	PruebaCuenta2@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$sdb6HwMg5Nyb8/7/n1NKSQ$ovShYiCfMo2TOYnYX9YcKb3g17gdjS4h9yRas6GJwQg	\N	\N	6	\N
60	Juan David 	juandavid12gomez@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$+7/33nsPIQRAaG0Nwfh/bw$9MTOXUUEvzGWOoxNpmofJJVZpf+CThCD0VmdU6KDH0E	\N	\N	6	\N
65	Sara Elissa Duran	u20171155993@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$rpUSglBqLQXgnFNqjdE6Rw$fMD8mmt6Qz9sK7rJAlnP1gTT0etskgUB4V7dpskfWcM	GIAd	\N	6	\N
50	Natalia Rodríguez Muñoz	narodriguezmu@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$pzSG8N57r1XKeY/R+h+DUA$o/fUCBvCNzOh4LfMblm6qMP21VsKTbO3BJogjFbdaRU	K1WUF4fCRbQ	AsHMZZ288four2b9XF2nSaF5bSX8tSyH	6	ei0EjSB-RkGgWWLwx6A5Ap:APA91bHC2mkeoghTr_nLFNCwaLGX4XrFCV_taODqHUECyefddVAc-JZMgEvOrDDY9GocKM1nXTPGz-UnBkEljSVkJCsDR8q1LTlp4E53f5azrFEbQn7wBZn3Z8gcLLjphKBssb6cUL4e
81	Nata	Romu@gamil.com	$argon2id$v=19$m=65536,t=3,p=4$SAlBSEmJcW5NSWltrRXCGA$wLXLtVbl02o2jHvEQydPcWqestsNapPXoMyIvboacCg	JztM	\N	7	\N
63	' or '1'='1	juandavidtorrentelopez@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$SCkFgBBCyFlrLcUYA2BsrQ$JDN1b8vnQp/f+RPOmPF2SvXDo0Q15UaL8DvnTi5uRmk	\N	\N	6	\N
83	string	correofalso@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$oHROqXVuLeVcC4GQkjIGwA$YhXruyHz2WM1tZK3b+Cu8/qy2SoAIdnUQikL8zCLkPI	\N	\N	6	\N
79	sadra	sandramil@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$yhnjfK+1Nkbo/Z+TsvZ+jw$7L3iOUaawC0lJM1wSv6iK59EkrPAkcChHElNKEhXhbU	\N	BbYx9xbH8e9UwBXFI8oqEybKCWB4BEzT	6	\N
86	Test User	test_846598f1-0df5-496d-bbf9-fbd0ddf482f2@example.com	$argon2id$v=19$m=65536,t=3,p=4$+X/vHUOoFcJYq7V2LiVEaA$jnfHv8vW3WYm8y5ky/lNpr9dr5TUrdntcEYuJrkQemI	\N	\N	6	\N
84	Test User	test@example.com	$argon2id$v=19$m=65536,t=3,p=4$NCZkbK01BuB8D6FUynnPuQ$CWwjsdtIsONAbpIlqnlXe/3kkmtXXJ0hqxwStvq+4Ds	\N	zpC79bZmTd809pI95XrpFGGugYboWyAN	6	dummy_fcm_token
88	Test User	test_0a3eeff9-9f05-4825-bf36-c2e999751579@example.com	$argon2id$v=19$m=65536,t=3,p=4$bm0NwVhrzfnfu5eSEuL8Xw$XfL9l6oGxXvSGa529bJzshQ9ZrhI8iz+LKMnPKvaatU	\N	6JAGJMWmGGfZxawC7qxgsixcmC4Dv8qP	6	dummy_fcm_token
40	Luisa Suarez	luross.1601@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$htC6t3YuJeTcOwdgrJVyjg$DSYUIeqROpNkfCVgDjx05N4vva3UGJLQJQAC/aeMdho	\N	mV6G9qPFvmR3v6k5u6NGFgfFIB8XgTQY	6	eJLthM7bRvKIlvEPdAFEFD:APA91bFb4xVrYHlnsqgmN4es2eVfVak4BdBikMmIcr90lalLG-UtkGbosRSoM9bbUd7m2CANRcBXeBYnwC6zWdtOxIunjVxqyqlfs5-9i3mXeDlJsVELrME
26	Brayan	anbrawil@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$/z9HSMmZEwKg1HqPkXJOaQ$1jLXsdktePCQgIgc5T6XJYm9OW7v8fYwzpNIRM9LZnc	\N	\N	6	\N
30	Brayan Trujillo 	anbrawil2@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$bs0ZY2xNaU1p7f3/fw/BuA$fzGBoYloBWL7O9AZa1Da/hOlojCFJg4jOFgeynmIIfQ	\N	GJwES1PtXOQe9VR3HE9eczWc4qtV3jj9	6	cX3vZ8eDQeypDcKCKhnwGj:APA91bGvYl1R--W5gMW1nTQ0paptB1Iln5-QZe0sqk6kE8Hg72tnLxyzhRzD8oAbgHCJAg2qLAxc2MrIDjOquzXaa5GobghWwiHGmlFdBrk3vrI3djNQvtM
98	Pruebas	pruebacolaborador@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$WKuVMuacs9Y6h9B6z/n/3w$D0EMTag08JPBtiAkGp+X0TJ1XzeCInRU0of0IjAMEIs	\N	\N	6	\N
100	Valentina Oso	fotonicamaxima@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$8F7LOefc+x8jxLi3VkqpVQ$RSZU8Q2rNEKjluWQl/TAa4kNYnDjWToA0dBTvX6AzSo	\N	\N	6	\N
101	axt	proiddeimmunnappe-5367@yopmail.com	$argon2id$v=19$m=65536,t=3,p=4$TolRSumdU8r5H6M0BqBUSg$U7fm20H+NAtmEOccu7BQgzlDtjrhngv7k4FInbD9nrs	\N	\N	6	\N
99	Kevin	U20192182970@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$hRCC8H5PSekdQyhlrNWaMw$FSqJZyVZbqGTDYf2CgN77jW3O40KOLg1jtOb0kfn2zg	\N	nKEyAm1cBzI2oUJ6UOAOHnjS4TOKUOk8	6	eD04Rbu7TF6b0QMMyC5qyk:APA91bGutz3XelkVpiro5azDBT2i-dL6eOPCrLA8JoIvXtRlS4AbbLBGn3QqvM-5Ats21TVXJRyIuQmEBcScb1geZ3w_SbmAOjQnyG_gG0CtSGLN0AK2AmG8zrfSGLtDPYpG-Sc8ZK12
105	Samboni	Kevin.samboni@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$vdd6D6F0bi1FiNFaK+W89w$flYpHs/zpwmUFy0ByJIfE2pYgML60bAPkfjNoHI4+js	\N	\N	6	\N
102	Daniellkk	U20202191528@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$BCAkhDDmPOccQwihdG5tzQ$JHa/H6fWyDx46nibVlHGsUVzbKZf7s11ECHWZOu6Wuc	\N	\N	6	\N
110	Marcela Ramirez 	marcelaramirez09@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$xDhHaM0ZI6RUai2FkDJmLA$iM0HOwyYeS2le4Xfqj6l6cdIEIt08U591gT6btYdPcw	sdWZ	\N	7	\N
111	marcela silva	marcelaramirezsilva09@gamil.com	$argon2id$v=19$m=65536,t=3,p=4$D2EsRYixdi7lvHeOMQbgnA$FapDml0FQtwqMbgCOPF16uXfSk7PXtk3JgDUc4ek1ik	YXo1	\N	7	\N
107	LuisFer	luis.gonzalez@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$CyFkrLX2vvees1aqNaaUMg$vjNcLYiNB2kJX/CC33UKUycGKidmHco2QyP7ks8rD84	\N	hljjkDhSZRlBpt3ne4xJqFEqukuMHWcX	6	dEliUboaRMGMhX29GKwsQP:APA91bGMwSrxE-QFxeyaGMYBBLK6UQESzaPKjZyqQtpeX8ML9ka-2BHKEOt0-TBGmelY2OfVjorClKZBxnz_HHgAuUZzPTx09pdBaUHCahE4YPgBcEnlwMs
106	anandjs	ninipenijaa@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$jDFm7F2LcQ5ByHmvNQZgTA$KBUdbLzUrtPewOuwVLenWZ8LL8giRSje6QzRKjZ8Srk	Hnc6	\N	7	\N
80	Valentina2	u20201188877@usco.edu.co	$argon2id$v=19$m=65536,t=3,p=4$UWrtnbM2ZswZw5jzvhcixA$42Y2zMyibY+xi3kaG8+DxPkFSNnEGCyQ1srUdjVVphQ	\N	Qjx33IeAQD3udDYbbIogLzbNB6xcM6QY	6	dgAHF_XvQdKikux0ov9euM:APA91bEOSyBVWcL7jHxxjFBNWwpVxh6KzjMoxhLM2Uy3GEOlFljjzd0WBjjGw7S7I-WA9AigcSwEmQwXfmebqJg6ar1KqvqunWx3OYbPFfcOLzzZVCLfnmU
104	Geraldine 	geralespinosa1420@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$aO19T2nNuTdGiFHq3XsPgQ$X4X/Glf8zJ6WPRggY07xhbVeltgITbreoAh4dRv8Rbg	\N	rs5vphPdr30XnMdndKxP9YAtbeAw5R6o	6	epcNjiUnTSqRvPap-c6nOs:APA91bEqIE8tYWivkEYhOcGm2UFUFENDkqxMZw_NvhEY5D4_eaCSGZAOIUJ-HHrRDj7q5KWtd8utiB7C-0smTfrHYA3vtzD7oHmAj_F7nOJfeVD2mfcUxg8
64	Sebastian Ramirez Silva 2026	sebastian18huila@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$hrBWam2t1dp7D6EUYgwhRA$Dah/BWReuT6+PrQLk1O0+dwB3FhVydozLN07+PAVnpg	\N	\N	6	\N
109	José manuel	aprende.con.jose.123@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$+x+jtBaCkJKy1tr7v7d2rg$emzdmPuGcodxSvylNt/aFse8I/wkE6QlxrD94mC3SLQ	\N	fsdP1drSxl6lvR44oBzynFklAxy3xdDh	6	cJldRd6KSz6RU63LmARsnK:APA91bFjv8H9zYn44cbyeiS84-immV2GlHtVf9d7t7F47A2XCKrfrc4VNyUC-_GBSG8WjFL7ZPeg9V2qG1b9cJt3t3HjZI_matQyQWZtChI1UiIENRkOo98
112	Martha Monje	marcemotru@hotmail.com	$argon2id$v=19$m=65536,t=3,p=4$VKrVujeGUCpFSEmpVarVeg$Xyh78v6gzzULDjOpumC7HDidbJ1xS+NYUOMlSDO453I	\N	\N	6	\N
103	isis	crochetisis22@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$W2uN8R4jZEzJ2VuLcY4RIg$CPVSJhjKsQGNGjjaLXkZOEXMb3yQzmqofeZ2OBhJVtk	\N	\N	6	\N
37	Valen audit	valen.pol.os13@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$Tekd43zPWYuRcq6VEsK4Vw$2AsbLCroLFv+heay24XmBR3TJ5yt7RjABPvZCOrHyZg	MUmp	Az7Kt6IfA5st1aucyOs9umKz4iXpg2qN	6	eXPlwhsjQeWYsgqPWhv5-J:APA91bGoTltKoM5P-XvfZHOBcAapThw3BbdergxKwizcMHDkqLFPOBrbuRAbMBiZ-n5kG5cYxbllhy3Y2m02r9V0EBGQhLWqS3XlURzdxIbSsTtvwOWIbLM
108	John SR	u20202193043@usco.edu.com	$argon2id$v=19$m=65536,t=3,p=4$7R0jhPC+t7aWspbyvleKEQ$ceAl+Mp1smH+NfrXtJlShiMCt5RjN4QxAEypAzSSKdY	aWFx	\N	7	\N
2	Natalia Rodríguez Mu	natyrm15173444@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$Q0iJce5dK0UIYWwthRAiBA$uiaKZ7cwmPZni6yMXlmKagv0ODlN9bm37ZrsHtBpJ4k	\N	2We5QQQt03wNhVzGlDa4MjtwPvj64BGT	6	eXPlwhsjQeWYsgqPWhv5-J:APA91bGoTltKoM5P-XvfZHOBcAapThw3BbdergxKwizcMHDkqLFPOBrbuRAbMBiZ-n5kG5cYxbllhy3Y2m02r9V0EBGQhLWqS3XlURzdxIbSsTtvwOWIbLM
\.


--
-- Data for Name: invitation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invitation (invitation_id, email, suggested_role, status_id, farm_id, inviter_user_id, date) FROM stdin;
1	narodriguezmu@gmail.com	Operador de campo	16	67	46	2024-09-24 19:07:33.630782
2	nataromu761@gmail.com	Operador de campo	16	62	38	2024-09-24 19:09:12.981387
3	PruebaCuenta2@gmail.com	Administrador de finca	16	62	38	2024-09-24 19:34:33.808516
5	PruebaCuenta2@gmail.com	Operador de campo	16	8	38	2024-09-24 20:18:27.750103
4	u20202191528@usco.edu.co	Operador de campo	17	49	77	2024-09-24 19:36:51.055171
6	u20202191528@usco.edu.co	Operador de campo	17	49	77	2024-09-24 20:32:34.239424
7	u20202191528@usco.edu.co	Administrador de finca	16	49	77	2024-09-24 20:34:16.107698
8	narodriguezmu@gmail.com	Operador de campo	24	49	38	2024-09-24 20:54:37.824798
10	u20202192371@usco.edu.co	Operador de campo	16	47	2	2024-09-30 19:22:40.764948
9	u20202191528@usco.edu.co	Operador de campo	17	33	8	2024-09-26 00:13:49.902647
11	u20202191528@usco.edu.co	Operador de campo	16	31	8	2024-09-30 21:46:28.793285
12	u20202191528@usco.edu.co	Administrador de finca	16	31	8	2024-09-30 23:18:35.923213
13	natyrm15173444@gmail.com	Operador de campo	16	31	8	2024-10-01 16:53:31.367622
14	natyrm15173444@gmail.com	Administrador de finca	16	31	8	2024-10-01 16:54:53.285223
15	u20202191528@usco.edu.co	Administrador de finca	16	111	98	2024-10-03 15:04:37.501349
16	PruebaCuenta2@gmail.com	Operador de campo	16	111	98	2024-10-03 15:09:33.660231
17	pruebacolaborador@gmail.com	Administrador de finca	16	31	8	2024-10-03 15:40:38.802039
19	davidvalencia0526@gmail.com	Operador de campo	16	31	2	2024-10-05 06:33:56.226903
18	PruebaCuenta2@gmail.com	Operador de campo	16	111	98	2024-10-03 16:12:39.354022
20	PruebaCuenta2@gmail.com	Operador de campo	16	62	38	2024-10-07 19:31:34.397233
21	pruebacolaborador@gmail.com	Administrador de finca	16	62	38	2024-10-07 19:31:55.197248
22	PruebaCuenta2@gmail.com	Administrador de finca	16	62	38	2024-10-07 19:42:22.204903
23	natyrm15173444@gmail.com	Administrador de finca	16	2	38	2024-10-07 19:56:41.906184
24	anbrawil2@gmail.com	Operador de campo	16	2	2	2024-10-08 02:12:10.859937
25	anbrawil2@gmail.com	Operador de campo	16	2	2	2024-10-08 02:14:22.982962
26	natyrm15173444@gmail.com	Administrador de finca	17	4	38	2024-10-08 02:19:27.625899
27	natyrm15173444@gmail.com	Administrador de finca	16	7	38	2024-10-08 02:22:50.394484
29	sebastian18huila@gmail.com	Administrador de finca	16	2	2	2024-10-08 03:06:13.813306
28	U20192182970@usco.edu.co	Administrador de finca	16	2	2	2024-10-08 02:36:14.793468
30	PruebaCuenta2@gmail.com	Administrador de finca	16	4	38	2024-10-09 15:29:49.817942
33	natyrm15173444@gmail.com	Administrador de finca	16	111	38	2024-10-15 18:43:44.264457
34	u20202192371@usco.edu.co	Administrador de finca	16	111	38	2024-10-15 18:45:50.431717
35	u20171155993@usco.edu.co	Operador de campo	16	126	69	2024-10-17 19:55:57.831354
36	u20171155993@usco.edu.co	Operador de campo	16	125	69	2024-10-17 20:00:20.834646
37	davidvalencia0526@gmail.com	Administrador de finca	16	16	37	2024-10-17 20:40:47.648594
38	deissymlr@gmail.com	Operador de campo	24	127	66	2024-10-17 21:11:28.256765
39	nataromu760@gmail.com	Operador de campo	16	2	2	2024-10-20 21:36:53.449986
31	u20202191528@usco.edu.co	Administrador de finca	16	51	77	2024-10-09 15:37:12.305905
32	u20202191528@usco.edu.co	Administrador de finca	16	53	77	2024-10-09 15:37:53.822963
40	nataromu760@gmail.com	Operador de campo	16	136	2	2024-10-21 04:55:28.334193
42	natyrm15173444@gmail.com	Administrador de finca	16	67	46	2024-10-26 14:58:06.265761
41	nataromu762@gmail.com	Administrador de finca	16	113	2	2024-10-23 22:59:51.271878
44	crochetisis22@gmail.com	Administrador de finca	16	113	2	2024-10-26 17:24:13.887986
45	crochetisis22@gmail.com	Administrador de finca	17	113	2	2024-10-26 17:26:03.254317
46	natyrm15173444@gmail.com	Operador de campo	16	144	103	2024-10-29 10:02:01.874762
48	anbrawil2@gmail.com	Operador de campo	16	143	105	2024-10-30 04:31:45.298065
49	Kevin.samboni@usco.edu.co	Operador de campo	16	32	30	2024-11-07 09:13:49.049753
50	anbrawil@gmail.com	Operador de campo	16	41	30	2024-11-07 10:24:31.382242
47	anbrawil@gmail.com	Operador de campo	17	143	105	2024-10-30 04:26:49.323775
51	Kevin.samboni@usco.edu.co	Operador de campo	16	41	30	2024-11-07 10:27:23.847494
52	u20202193043@usco.edu.com	Operador de campo	24	2	64	2024-11-07 13:13:33.311133
53	u20202193043@usco.edu.co	Operador de campo	16	2	64	2024-11-07 13:22:45.443409
55	natyrm15173444@gmail.com	Administrador de finca	16	150	109	2024-11-12 19:06:12.342433
56	valen.pol.os13@gmail.com	Operador de campo	16	151	40	2024-11-13 12:38:13.455278
54	PruebaCuenta2@gmail.com	Administrador de finca	16	149	38	2024-11-12 17:08:09.563888
57	PruebaCuenta2@gmail.com	Administrador de finca	24	152	38	2024-11-14 08:33:32.928611
58	u20202191528@usco.edu.co	Operador de campo	16	31	8	2024-11-14 09:11:43.44001
59	u20202191528@usco.edu.co	Operador de campo	16	30	8	2024-11-14 09:14:52.926809
61	PruebaCuenta2@gmail.com	Operador de campo	24	156	112	2024-11-25 10:45:41.426204
60	u20202191528@usco.edu.co	Operador de campo	16	156	112	2024-11-25 10:45:33.568104
62	valen.pol.os13@gmail.com	Operador de campo	16	157	80	2024-11-25 12:04:48.369982
63	u20201188877@usco.edu.co	Operador de campo	16	20	37	2024-11-25 12:17:14.036736
64	anbrawil2@gmail.com	Operador de campo	24	144	103	2024-11-28 12:11:23.382612
65	u20202193043@usco.edu.co	Operador de campo	16	154	64	2024-11-28 12:44:20.3917
66	u20202191528@usco.edu.co	Operador de campo	16	160	103	2024-11-28 14:23:12.92728
\.


--
-- Data for Name: notification_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_type (notification_type_id, name) FROM stdin;
1	Invitation
2	reminder
3	Invitation_accepted
4	invitation_rejected
5	Asignacion_tarea
6	Actualizacion_tarea
7	EliminacionTarea
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notifications_id, message, date, user_id, invitation_id, notification_type_id, farm_id, status_id) FROM stdin;
1	Has sido invitado como Operador de campo a la finca Finca naromu761	2024-09-24 19:07:33.645295	50	1	1	67	19
3	El usuario Natalia Rodríguez Muñoz ha aceptado tu invitación a la finca Finca naromu761.	2024-09-24 19:10:20.436207	46	1	3	67	19
2	Has sido invitado como Operador de campo a la finca fincaprueba	2024-09-24 19:09:12.987851	76	2	1	62	19
4	El usuario nataromu ha aceptado tu invitación a la finca ExcepcionesFinca.	2024-09-24 19:26:34.138839	38	2	3	62	19
5	Has sido invitado como Administrador de finca a la finca ExcepcionesFinca	2024-09-24 19:34:33.814056	77	3	1	62	19
7	El usuario pruebaCuenta ha aceptado tu invitación a la finca ExcepcionesFinca.	2024-09-24 19:49:06.968817	38	3	3	62	19
8	Has sido invitado como Operador de campo a la finca prueba 4	2024-09-24 20:18:27.762055	77	5	1	8	19
9	El usuario pruebaCuenta ha aceptado tu invitación a la finca prueba 4.	2024-09-24 20:20:34.998125	38	5	3	8	19
6	Has sido invitado como Operador de campo a la finca finca pruebas	2024-09-24 19:36:51.081797	38	4	1	49	19
10	El usuario 😄😄😄 ha rechazado tu invitación a la finca finca pruebas.	2024-09-24 20:31:14.741668	77	4	4	49	19
11	Has sido invitado como Operador de campo a la finca finca pruebas	2024-09-24 20:32:34.245634	38	6	1	49	19
12	El usuario 😄😄😄 ha rechazado tu invitación a la finca finca pruebas.	2024-09-24 20:33:19.496779	77	6	4	49	19
13	Has sido invitado como Administrador de finca a la finca finca pruebas	2024-09-24 20:34:16.128086	38	7	1	49	19
14	El usuario 😄😄😄 ha aceptado tu invitación a la finca finca pruebas.	2024-09-24 20:38:56.347419	77	7	3	49	19
15	Has sido invitado como Operador de campo a la finca finca pruebas	2024-09-24 20:54:37.830065	50	8	1	49	18
17	Has sido invitado como Operador de campo a la finca Segunda tercera	2024-09-30 19:22:40.777718	8	10	1	47	19
18	El usuario Dylan23 ha aceptado tu invitación a la finca Segunda tercera.	2024-09-30 19:25:44.416047	2	10	3	47	19
16	Has sido invitado como Operador de campo a la finca Finca prueba 3. 	2024-09-26 00:13:49.909564	38	9	1	33	19
20	El usuario 😄😄😄 ha rechazado tu invitación a la finca Finca prueba 3. .	2024-09-30 21:47:02.660184	8	9	4	33	19
19	Has sido invitado como Operador de campo a la finca finca2	2024-09-30 21:46:28.804371	38	11	1	31	19
21	El usuario 😄😄😄 ha aceptado tu invitación a la finca finca2.	2024-09-30 21:47:06.335254	8	11	3	31	19
22	Has sido invitado como Administrador de finca a la finca finca2	2024-09-30 23:18:35.930458	38	12	1	31	19
23	El usuario 😄😄😄 ha aceptado tu invitación a la finca finca2.	2024-09-30 23:31:24.369362	8	12	3	31	19
24	Has sido invitado como Operador de campo a la finca finca2	2024-10-01 16:53:31.397606	2	13	1	31	19
25	El usuario Natalia Rodríguez ha aceptado tu invitación a la finca finca2.	2024-10-01 16:53:57.616331	8	13	3	31	19
26	Has sido invitado como Administrador de finca a la finca finca2	2024-10-01 16:54:53.294995	2	14	1	31	19
27	El usuario Natalia Rodríguez ha aceptado tu invitación a la finca finca2.	2024-10-01 16:55:26.412625	8	14	3	31	19
28	Has sido invitado como Administrador de finca a la finca PruebaColaboradores	2024-10-03 15:04:37.537205	38	15	1	111	19
29	El usuario 😄😄😄 ha aceptado tu invitación a la finca PruebaColaboradores.	2024-10-03 15:05:56.378426	98	15	3	111	19
30	Has sido invitado como Operador de campo a la finca PruebaColaboradores	2024-10-03 15:09:33.672169	77	16	1	111	19
31	El usuario pruebaCuenta ha aceptado tu invitación a la finca PruebaColaboradores.	2024-10-03 15:11:03.389085	98	16	3	111	19
32	Has sido invitado como Administrador de finca a la finca finca2	2024-10-03 15:40:38.82375	98	17	1	31	19
33	El usuario Pruebas ha aceptado tu invitación a la finca finca2.	2024-10-03 15:42:19.803579	8	17	3	31	19
35	Has sido invitado como Operador de campo a la finca finca2	2024-10-05 06:33:56.241676	69	19	1	31	19
36	El usuario Oscar David ha aceptado tu invitación a la finca finca2.	2024-10-05 06:34:32.931017	2	19	3	31	19
34	Has sido invitado como Operador de campo a la finca PruebaColaboradores	2024-10-03 16:12:39.374813	77	18	1	111	19
39	El usuario pruebaCuenta ha aceptado tu invitación a la finca PruebaColaboradores.	2024-10-07 19:32:45.556088	98	18	3	111	19
37	Has sido invitado como Operador de campo a la finca ExcepcionesFinca	2024-10-07 19:31:34.410946	77	20	1	62	19
40	El usuario pruebaCuenta ha aceptado tu invitación a la finca ExcepcionesFinca.	2024-10-07 19:32:50.223481	38	20	3	62	19
38	Has sido invitado como Administrador de finca a la finca ExcepcionesFinca	2024-10-07 19:31:55.209044	98	21	1	62	19
41	El usuario Pruebas ha aceptado tu invitación a la finca ExcepcionesFinca.	2024-10-07 19:34:00.263735	38	21	3	62	19
42	Has sido invitado como Administrador de finca a la finca ExcepcionesFinca	2024-10-07 19:42:22.214904	77	22	1	62	19
43	El usuario pruebaCuenta ha aceptado tu invitación a la finca ExcepcionesFinca.	2024-10-07 19:42:40.51148	38	22	3	62	19
44	Has sido invitado como Administrador de finca a la finca prueba1	2024-10-07 19:56:41.917597	2	23	1	2	19
45	El usuario Natalia Rodríguez Mu ha aceptado tu invitación a la finca prueba1.	2024-10-07 19:57:05.240962	38	23	3	2	19
46	Has sido invitado como Operador de campo a la finca prueba2	2024-10-08 02:12:10.872007	30	24	1	2	19
47	El usuario Brayan Trujillo  ha aceptado tu invitación a la finca prueba2.	2024-10-08 02:13:22.730792	2	24	3	2	19
48	Has sido invitado como Operador de campo a la finca prueba2	2024-10-08 02:14:22.996092	30	25	1	2	19
49	El usuario Brayan Trujillo  ha aceptado tu invitación a la finca prueba2.	2024-10-08 02:14:35.929677	2	25	3	2	19
50	Has sido invitado como Administrador de finca a la finca prueba2 	2024-10-08 02:19:27.635659	2	26	1	4	19
51	El usuario Natalia Rodríguez Mu ha rechazado tu invitación a la finca prueba2 .	2024-10-08 02:22:29.270379	38	26	4	4	19
52	Has sido invitado como Administrador de finca a la finca finca 03	2024-10-08 02:22:50.403821	2	27	1	7	19
53	El usuario Natalia Rodríguez Mu ha aceptado tu invitación a la finca finca 03.	2024-10-08 02:23:29.761234	38	27	3	7	19
54	Has sido invitado como Administrador de finca a la finca prueba2	2024-10-08 02:36:14.804391	99	28	1	2	19
55	Has sido invitado como Administrador de finca a la finca prueba2	2024-10-08 03:06:13.835993	64	29	1	2	19
56	El usuario Sebastian Ramirez S ha aceptado tu invitación a la finca prueba2.	2024-10-08 03:07:08.82275	2	29	3	2	19
57	El usuario Kevin ha aceptado tu invitación a la finca prueba2.	2024-10-08 16:43:22.662281	2	28	3	2	19
58	Has sido invitado como Administrador de finca a la finca prueba2 	2024-10-09 15:29:49.837183	77	30	1	4	19
59	El usuario pruebaCuenta ha aceptado tu invitación a la finca prueba2 .	2024-10-09 15:30:36.659002	38	30	3	4	19
62	Has sido invitado como Administrador de finca a la finca PruebaColaboradores	2024-10-15 18:43:44.287915	2	33	1	111	19
63	El usuario Natalia Rodríguez Mu ha aceptado tu invitación a la finca PruebaColaboradores.	2024-10-15 18:44:04.906809	38	33	3	111	19
64	Has sido invitado como Administrador de finca a la finca PruebaColaboradores	2024-10-15 18:45:50.47147	8	34	1	111	19
65	El usuario Dylan23 ha aceptado tu invitación a la finca PruebaColaboradores.	2024-10-15 18:47:19.266078	38	34	3	111	19
66	Has sido invitado como Operador de campo a la finca finca 1 de David operador	2024-10-17 19:55:57.886423	65	35	1	126	19
67	El usuario Sara Elissa Duran ha aceptado tu invitación a la finca finca 1 de David operador.	2024-10-17 19:57:43.477467	69	35	3	126	19
68	Has sido invitado como Operador de campo a la finca finca 1 de david	2024-10-17 20:00:20.846704	65	36	1	125	19
69	El usuario Sara Elissa Duran ha aceptado tu invitación a la finca finca 1 de david.	2024-10-17 20:01:01.365171	69	36	3	125	19
70	Has sido invitado como Administrador de finca a la finca La Pola	2024-10-17 20:40:47.669359	69	37	1	16	19
71	El usuario Oscar 2 ha aceptado tu invitación a la finca La Pola.	2024-10-17 20:41:54.474617	37	37	3	16	19
72	Has sido invitado como Operador de campo a la finca La chiquis	2024-10-17 21:11:28.289181	62	38	1	127	18
73	Has sido invitado como Operador de campo a la finca prueba2	2024-10-20 21:36:53.469522	46	39	1	2	19
74	El usuario Natal ha aceptado tu invitación a la finca prueba2.	2024-10-20 21:37:01.744807	2	39	3	2	19
60	Has sido invitado como Administrador de finca a la finca pruebaFincaExitosa	2024-10-09 15:37:12.315287	38	31	1	51	19
102	El usuario Daniel Pruebas  ha aceptado tu invitación a la finca pruebaFincaExitosa.	2024-10-20 23:23:49.39772	77	31	3	51	19
61	Has sido invitado como Administrador de finca a la finca FincaInvalidaa	2024-10-09 15:37:53.863747	38	32	1	53	19
103	El usuario Daniel Pruebas  ha aceptado tu invitación a la finca FincaInvalidaa.	2024-10-20 23:23:51.998022	77	32	3	53	19
393	Has sido invitado como Operador de campo a la finca 976	2024-11-25 12:17:14.202459	80	63	1	20	19
396	La tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis ha sido eliminada.	2024-11-25 00:00:00	2	\N	7	144	31
399	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-27	2024-11-25 00:00:00	2	\N	5	144	21
402	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-25	2024-11-25 00:00:00	2	\N	5	144	21
406	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
111	Se le ha asignado una tarea de Detección de plagas en el lote lote 1 de la finca prueba2 en la fecha 2024-10-20	2024-10-20 00:00:00	46	\N	5	2	21
112	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:34:01.509173	46	\N	5	2	21
113	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:34:03.485236	46	\N	5	2	21
114	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:36:01.609947	46	\N	5	2	21
115	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:36:03.524008	46	\N	5	2	21
116	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:41:01.484637	46	\N	5	2	21
117	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:41:03.349463	46	\N	5	2	21
118	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:45:01.368948	46	\N	5	2	21
119	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 21:45:03.218086	46	\N	5	2	21
120	Se le ha asignado una tarea de Detección de enfermedades en el lote lote 1 de la finca prueba2 en la fecha 2024-10-20	2024-10-20 00:00:00	46	\N	5	2	21
121	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 22:05:01.409508	46	\N	5	2	21
122	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 22:05:03.346064	46	\N	5	2	21
123	El colaborador Natal tiene una tarea de Detección de enfermedades para hoy en el lote lote 1 de la finca prueba2.	2024-10-20 22:05:05.345506	2	\N	5	2	21
124	Has sido invitado como Operador de campo a la finca Pruebas tareas 2	2024-10-21 04:55:28.356162	46	40	1	136	19
125	El usuario Natal ha aceptado tu invitación a la finca Pruebas tareas 2.	2024-10-21 04:55:40.333292	2	40	3	136	19
126	Se le ha asignado una tarea de Detección de plagas en el lote lote prueba 2 de la finca Pruebas tareas 2 en la fecha 2024-10-21	2024-10-20 00:00:00	46	\N	5	136	21
127	La fecha de la tarea de Detección de plagas en el lote lote 1 de la finca Pruebas tareas 1 ha sido actualizada a 2024-10-24	2024-10-21 00:00:00	46	\N	5	2	21
128	Se le ha asignado una tarea de Detección de plagas en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-21	2024-10-21 00:00:00	46	\N	5	2	21
129	Se le ha asignado una tarea de Detección de plagas en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-23	2024-10-21 00:00:00	46	\N	5	2	21
130	La fecha de la tarea de Detección de plagas en el lote lote 1 de la finca Pruebas tareas 1 ha sido actualizada a 2024-10-22	2024-10-21 00:00:00	46	\N	5	2	21
131	La fecha de la tarea de Detección de enfermedades en el lote lote 1 de la finca Pruebas tareas 1 ha sido actualizada a 2024-10-23	2024-10-21 00:00:00	46	\N	5	2	21
132	La fecha de la tarea de 'Detección de plagas' en el lote lote 1 de la finca Pruebas tareas 1 ha sido actualizada a 2024-10-25.	2024-10-21 00:00:00	46	\N	5	2	21
133	El nombre de la tarea ha sido actualizado a 'Detección de enfermedades' en el lote lote 1 de la finca Pruebas tareas 1. La fecha de la tarea de 'Detección de enfermedades' en el lote lote 1 de la finca Pruebas tareas 1 ha sido actualizada a 2024-10-24.	2024-10-21 00:00:00	46	\N	5	2	21
135	Tienes una tarea de Detección de plagas para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-24 17:05:00.240423	46	\N	5	2	21
136	El colaborador Natal tiene una tarea de Detección de enfermedades para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-24 17:05:00.772014	2	\N	5	2	21
137	Tienes una tarea de Detección de enfermedades para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-24 17:05:00.834294	46	\N	5	2	21
138	Has sido invitado como Administrador de finca a la finca Finca naromu761	2024-10-26 14:58:06.280284	2	42	1	67	19
139	El usuario Natalia Rodríguez Mu ha aceptado tu invitación a la finca Finca naromu761.	2024-10-26 15:46:06.215442	46	42	3	67	19
134	Has sido invitado como Administrador de finca a la finca Finca 5	2024-10-23 22:59:51.29379	82	41	1	113	19
141	El usuario naty rmu ha aceptado tu invitación a la finca Finca 5.	2024-10-26 17:21:54.352509	2	41	3	113	19
142	Has sido invitado como Administrador de finca a la finca Finca 5	2024-10-26 17:24:13.896713	103	44	1	113	19
143	El usuario isis ha aceptado tu invitación a la finca Finca 5.	2024-10-26 17:24:29.920975	2	44	3	113	19
144	Has sido invitado como Administrador de finca a la finca Finca 5	2024-10-26 17:26:03.264979	103	45	1	113	19
145	El usuario isis ha rechazado tu invitación a la finca Finca 5.	2024-10-26 17:26:17.216649	2	45	4	113	19
146	Se le ha asignado una tarea de Chequeo de Salud en el lote jkz de la finca Finca 5 en la fecha 2024-10-28	2024-10-27 00:00:00	82	\N	5	113	21
147	El colaborador naty rmu tiene una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-10-28 17:05:00.276955	2	\N	5	113	21
148	Tienes una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-10-28 17:05:00.483639	82	\N	5	113	21
149	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-29	2024-10-28 00:00:00	46	\N	5	2	21
150	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-27	2024-10-28 00:00:00	46	\N	5	2	21
151	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-27	2024-10-28 00:00:00	46	\N	5	2	21
152	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-27	2024-10-28 00:00:00	46	\N	5	2	21
153	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-27	2024-10-28 00:00:00	46	\N	5	2	21
154	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-21	2024-10-28 00:00:00	30	\N	5	2	21
155	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-22	2024-10-28 00:00:00	30	\N	5	2	21
156	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-31	2024-10-28 00:00:00	30	\N	5	2	21
157	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-29	2024-10-28 00:00:00	30	\N	5	2	21
158	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-29	2024-10-28 00:00:00	38	\N	5	2	21
159	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-21	2024-10-28 00:00:00	46	\N	5	2	21
160	El colaborador Natal tiene una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00.148835	2	\N	5	2	21
161	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00.450077	46	\N	5	2	21
162	El colaborador Brayan Trujillo  tiene una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00.469996	2	\N	5	2	21
163	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00.567304	30	\N	5	2	21
164	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de estado de maduración para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00.587421	2	\N	5	2	21
165	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00.744133	38	\N	5	2	21
166	Has sido invitado como Operador de campo a la finca finca isis	2024-10-29 10:02:01.964129	2	46	1	144	19
167	El usuario Natalia Rodríguez Mu ha aceptado tu invitación a la finca finca isis.	2024-10-29 10:02:22.753994	103	46	3	144	19
168	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-10-30	2024-10-29 00:00:00	2	\N	5	144	21
169	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-10-22	2024-10-29 00:00:00	2	\N	5	144	21
170	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-23	2024-10-29 00:00:00	38	\N	5	2	21
171	Se te ha desasignado la tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	38	\N	5	2	21
172	Se te ha asignado una nueva tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1 para la fecha 2024-10-24.	2024-10-29 00:00:00	30	\N	5	2	21
173	Se te ha desasignado la tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	30	\N	5	2	21
174	Se te ha asignado una nueva tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1 para la fecha 2024-10-31.	2024-10-29 00:00:00	38	\N	5	2	21
175	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-31	2024-10-29 00:00:00	38	\N	5	2	21
176	Se le ha asignado una tarea de Chequeo de Salud en el lote lote prueba 2 de la finca Pruebas tareas 2 en la fecha 2024-10-30	2024-10-29 00:00:00	46	\N	5	136	21
177	Se le ha asignado una tarea de Chequeo de Salud en el lote lote prueba 2 de la finca Pruebas tareas 2 en la fecha 2024-10-24	2024-10-29 00:00:00	46	\N	5	136	21
178	La tarea de Chequeo de Salud en el lote lote prueba 2 de la finca Pruebas tareas 2 ha sido eliminada.	2024-10-29 00:00:00	46	\N	7	136	31
179	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote prueba 2 de la finca Pruebas tareas 2 en la fecha 2024-10-31	2024-10-29 00:00:00	46	\N	5	136	21
180	Se te ha desasignado la tarea de labor cultural 'Chequeo de estado de maduración' en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	38	\N	5	2	21
181	Se te ha asignado una nueva tarea de labor cultural 'Chequeo de estado de maduración' en el lote lote 1 de la finca Pruebas tareas 1 para la fecha 2024-10-31.	2024-10-29 00:00:00	30	\N	5	2	21
182	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	38	\N	6	2	32
183	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	30	\N	6	2	32
184	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	30	\N	6	2	32
185	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	30	\N	6	2	32
186	Se te ha desasignado la tarea de labor cultural 'Chequeo de estado de maduración' en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	30	\N	5	2	21
187	Se te ha asignado una nueva tarea de labor cultural 'Chequeo de estado de maduración' en el lote lote 1 de la finca Pruebas tareas 1 para la fecha 2024-10-31.	2024-10-29 00:00:00	38	\N	5	2	21
188	Se te ha desasignado la tarea de labor cultural 'Chequeo de estado de maduración' en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	38	\N	5	2	21
189	Se te ha asignado una nueva tarea de labor cultural 'Chequeo de estado de maduración' en el lote lote 1 de la finca Pruebas tareas 1 para la fecha 2024-10-31.	2024-10-29 00:00:00	46	\N	5	2	21
190	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	46	\N	6	2	32
191	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	38	\N	6	2	32
192	Se te ha desasignado la tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	46	\N	5	2	21
193	Se te ha asignado una nueva tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1 para la fecha 2024-10-30.	2024-10-29 00:00:00	38	\N	5	2	21
194	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	38	\N	6	2	32
195	Se te ha desasignado la tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	38	\N	5	2	21
196	Se te ha asignado una nueva tarea de labor cultural 'Chequeo de Salud' en el lote lote 1 de la finca Pruebas tareas 1 para la fecha 2024-10-31.	2024-10-29 00:00:00	46	\N	5	2	21
197	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-10-29 00:00:00	46	\N	6	2	32
198	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-30	2024-10-29 00:00:00	30	\N	5	2	21
199	Se le ha asignado una tarea de Chequeo de Salud en el lote PruebaEdicion  de la finca PruebaColaboradores en la fecha 2024-10-30	2024-10-29 00:00:00	77	\N	5	111	21
200	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-28	2024-10-29 00:00:00	46	\N	5	2	21
201	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-13	2024-10-29 00:00:00	46	\N	5	2	21
202	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote PruebaEdicion  de la finca PruebaColaboradores en la fecha 2024-10-31	2024-10-29 00:00:00	2	\N	5	111	21
203	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-30	2024-10-29 00:00:00	30	\N	5	2	21
204	Se le ha asignado una tarea de Chequeo de Salud en el lote PruebaEdicion  de la finca PruebaColaboradores en la fecha 2024-10-26	2024-10-29 00:00:00	2	\N	5	111	21
205	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca Pruebas tareas 1 en la fecha 2024-10-31	2024-10-29 00:00:00	38	\N	5	2	21
206	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebalista de la finca prueba2  en la fecha 2024-10-30	2024-10-29 00:00:00	77	\N	5	4	21
207	Se le ha asignado una tarea de Chequeo de Salud en el lote loteError de la finca prueba2  en la fecha 2024-10-29	2024-10-29 00:00:00	77	\N	5	4	21
208	Se le ha asignado una tarea de Chequeo de Salud en el lote loteError de la finca prueba2  en la fecha 2024-10-30	2024-10-29 00:00:00	77	\N	5	4	21
209	Se le ha asignado una tarea de Chequeo de Salud en el lote loteError de la finca PruebaColaboradores en la fecha 2024-10-29	2024-10-29 00:00:00	2	\N	5	111	21
210	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote loteError de la finca PruebaColaboradores en la fecha 2024-10-30	2024-10-29 00:00:00	77	\N	5	111	21
211	El colaborador Natal tiene una tarea de Chequeo de estado de maduración para hoy en el lote lote prueba 2 de la finca Pruebas tareas 2.	2024-10-30 00:00:00.880155	2	\N	5	136	21
212	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote lote prueba 2 de la finca Pruebas tareas 2.	2024-10-30 00:00:01.360604	46	\N	5	136	21
213	El colaborador Brayan Trujillo  tiene una tarea de Chequeo de estado de maduración para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-30 00:00:01.382888	2	\N	5	2	21
214	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-30 00:00:01.462934	30	\N	5	2	21
215	El colaborador pruebaCuenta tiene una tarea de Chequeo de Salud para hoy en el lote PruebaEdicion  de la finca PruebaColaboradores.	2024-10-30 00:00:01.485404	38	\N	5	111	21
216	Tienes una tarea de Chequeo de Salud para hoy en el lote PruebaEdicion  de la finca PruebaColaboradores.	2024-10-30 00:00:01.498544	77	\N	5	111	21
217	El colaborador Brayan Trujillo  tiene una tarea de Chequeo de estado de maduración para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-30 00:00:01.566121	2	\N	5	2	21
218	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-30 00:00:01.642322	30	\N	5	2	21
219	El colaborador pruebaCuenta tiene una tarea de Chequeo de Salud para hoy en el lote pruebalista de la finca prueba2 .	2024-10-30 00:00:01.663164	38	\N	5	4	21
220	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebalista de la finca prueba2 .	2024-10-30 00:00:01.687329	77	\N	5	4	21
221	El colaborador pruebaCuenta tiene una tarea de Chequeo de Salud para hoy en el lote loteError de la finca prueba2 .	2024-10-30 00:00:01.785437	38	\N	5	4	21
222	Tienes una tarea de Chequeo de Salud para hoy en el lote loteError de la finca prueba2 .	2024-10-30 00:00:01.80356	77	\N	5	4	21
223	El colaborador pruebaCuenta tiene una tarea de Chequeo de estado de maduración para hoy en el lote loteError de la finca PruebaColaboradores.	2024-10-30 00:00:01.883343	38	\N	5	111	21
224	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote loteError de la finca PruebaColaboradores.	2024-10-30 00:00:01.903446	77	\N	5	111	21
225	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de estado de maduración para hoy en el lote lote Isis 1 de la finca finca isis.	2024-10-30 00:00:01.977018	103	\N	5	144	21
226	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote lote Isis 1 de la finca finca isis.	2024-10-30 00:00:01.992356	2	\N	5	144	21
227	El colaborador naty rmu tiene una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-10-30 00:00:02.273646	2	\N	5	113	21
228	Tienes una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-10-30 00:00:02.404979	82	\N	5	113	21
230	Has sido invitado como Operador de campo a la finca finca Q	2024-10-30 04:31:45.308539	30	48	1	143	19
231	El usuario Brayan Trujillo  ha aceptado tu invitación a la finca finca Q.	2024-10-30 04:32:29.989637	105	48	3	143	19
232	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca finca Q en la fecha 2024-11-01	2024-10-30 00:00:00	30	\N	5	143	21
233	La tarea de Chequeo de Salud en el lote lote 1 de la finca finca Q ha sido eliminada.	2024-10-30 00:00:00	30	\N	7	143	31
234	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca finca Q en la fecha 2024-11-04	2024-10-30 00:00:00	30	\N	5	143	21
235	Se ha actualizado una tarea del lote lote 1 de la finca finca Q.	2024-10-30 00:00:00	30	\N	6	143	32
236	La tarea de Chequeo de Salud en el lote lote 1 de la finca finca Q ha sido eliminada.	2024-10-30 00:00:00	30	\N	7	143	31
237	El colaborador Natal tiene una tarea de Chequeo de Salud para hoy en el lote lote prueba 2 de la finca Pruebas tareas 2.	2024-10-31 00:00:00.282598	2	\N	5	136	21
238	Tienes una tarea de Chequeo de Salud para hoy en el lote lote prueba 2 de la finca Pruebas tareas 2.	2024-10-31 00:00:00.660899	46	\N	5	136	21
239	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de estado de maduración para hoy en el lote PruebaEdicion  de la finca PruebaColaboradores.	2024-10-31 00:00:00.695762	38	\N	5	111	21
240	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote PruebaEdicion  de la finca PruebaColaboradores.	2024-10-31 00:00:00.713791	2	\N	5	111	21
241	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-31 00:00:00.787376	2	\N	5	2	21
242	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-10-31 00:00:00.863118	38	\N	5	2	21
243	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-11-01	2024-10-31 00:00:00	8	\N	5	111	21
244	La tarea de Chequeo de estado de maduración en el lote pruebaTareas de la finca PruebaColaboradores ha sido eliminada.	2024-10-31 00:00:00	8	\N	7	111	31
229	Has sido invitado como Operador de campo a la finca finca Q	2024-10-30 04:26:49.370074	26	47	1	143	19
245	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-10-30	2024-10-31 00:00:00	2	\N	5	111	21
247	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2025-04-17	2024-10-31 00:00:00	77	\N	5	111	21
252	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-01 00:00:01.396136	8	\N	5	111	21
246	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-10-23	2024-10-31 00:00:00	2	\N	5	111	21
248	Se le ha asignado una tarea de Chequeo de Salud en el lote lote py de la finca polita en la fecha 2024-11-01	2024-10-31 00:00:00	38	\N	5	18	21
253	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote lote py de la finca polita.	2024-11-01 00:00:01.495319	37	\N	5	18	21
249	El colaborador Brayan Trujillo  tiene una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca finca Q.	2024-11-01 00:00:00.337533	105	\N	5	143	21
250	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca finca Q.	2024-11-01 00:00:01.306323	30	\N	5	143	21
251	El colaborador Dylan23 tiene una tarea de Chequeo de estado de maduración para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-01 00:00:01.375058	38	\N	5	111	21
254	Tienes una tarea de Chequeo de Salud para hoy en el lote lote py de la finca polita.	2024-11-01 00:00:01.596004	38	\N	5	18	21
255	El colaborador Brayan Trujillo  tiene una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca finca Q.	2024-11-03 00:00:00.275587	105	\N	5	143	21
256	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca finca Q.	2024-11-03 00:00:00.382515	30	\N	5	143	21
257	Se le ha asignado una tarea de Chequeo de Salud en el lote jkz de la finca Finca 5 en la fecha 2024-11-14	2024-11-03 00:00:00	82	\N	5	113	21
258	La tarea de Chequeo de Salud en el lote jkz de la finca Finca 5 ha sido eliminada.	2024-11-03 00:00:00	82	\N	7	113	31
259	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
260	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
261	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
262	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
263	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
264	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
265	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
266	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
267	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-02	2024-11-03 00:00:00	38	\N	5	49	21
268	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
269	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
270	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
271	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
272	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
273	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
274	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
275	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
276	Se le ha asignado una tarea de Chequeo de Salud en el lote jkz de la finca Finca 5 en la fecha 2024-11-06	2024-11-03 00:00:00	82	\N	5	113	21
277	Se le ha asignado una tarea de Chequeo de Salud en el lote jkz de la finca Finca 5 en la fecha 2024-11-02	2024-11-03 00:00:00	82	\N	5	113	21
278	La tarea de Chequeo de estado de maduración en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
279	La tarea de Chequeo de estado de maduración en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
280	Se le ha asignado una tarea de Chequeo de Salud en el lote jkz de la finca Finca 5 en la fecha 2024-11-02	2024-11-03 00:00:00	82	\N	5	113	21
281	Se le ha asignado una tarea de Chequeo de Salud en el lote jkz de la finca Finca 5 en la fecha 2024-11-02	2024-11-03 00:00:00	82	\N	5	113	21
282	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
283	La tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas ha sido eliminada.	2024-11-03 00:00:00	38	\N	7	49	31
284	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote #1 de la finca finca pruebas en la fecha 2024-11-04	2024-11-03 00:00:00	38	\N	5	49	21
285	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:00.860431	77	\N	5	49	21
286	Tienes una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:01.980213	38	\N	5	49	21
287	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:02.001862	77	\N	5	49	21
288	Tienes una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:02.199574	38	\N	5	49	21
289	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:02.440044	77	\N	5	49	21
290	Tienes una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:02.589321	38	\N	5	49	21
291	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:02.648756	77	\N	5	49	21
292	Tienes una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:02.750128	38	\N	5	49	21
293	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de estado de maduración para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:03.261756	77	\N	5	49	21
294	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:03.378602	38	\N	5	49	21
295	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de estado de maduración para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:03.487507	77	\N	5	49	21
296	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:03.582708	38	\N	5	49	21
297	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:03.63037	77	\N	5	49	21
298	Tienes una tarea de Chequeo de Salud para hoy en el lote Lote #1 de la finca finca pruebas.	2024-11-04 00:00:03.824071	38	\N	5	49	21
299	El colaborador naty rmu tiene una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-11-06 00:00:00.336869	2	\N	5	113	21
300	Tienes una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-11-06 00:00:01.185198	82	\N	5	113	21
301	Se le ha asignado una tarea de Chequeo de Salud en el lote hjs de la finca Finca 5 en la fecha 2024-11-05	2024-11-06 00:00:00	82	\N	5	113	21
302	Has sido invitado como Operador de campo a la finca La Arcadia	2024-11-07 09:13:49.333695	105	49	1	32	19
303	El usuario Samboni ha aceptado tu invitación a la finca La Arcadia.	2024-11-07 09:14:18.393299	30	49	3	32	19
304	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca La Arcadia en la fecha 2024-11-03	2024-11-07 00:00:00	105	\N	5	32	21
305	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca La Arcadia en la fecha 2024-11-08	2024-11-07 00:00:00	105	\N	5	32	21
306	Se ha actualizado una tarea del lote lote 1 de la finca La Arcadia.	2024-11-07 00:00:00	105	\N	6	32	32
307	La tarea de Chequeo de Salud en el lote lote 1 de la finca La Arcadia ha sido eliminada.	2024-11-07 00:00:00	105	\N	7	32	31
308	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 1 de la finca La Arcadia en la fecha 2024-11-08	2024-11-07 00:00:00	105	\N	5	32	21
309	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca La Arcadia en la fecha 2024-11-03	2024-11-07 00:00:00	105	\N	5	32	21
310	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca La Arcadia en la fecha 2024-11-09	2024-11-07 00:00:00	105	\N	5	32	21
311	Has sido invitado como Operador de campo a la finca el toro	2024-11-07 10:24:31.430087	26	50	1	41	19
312	El usuario Brayan ha aceptado tu invitación a la finca el toro.	2024-11-07 10:24:56.962031	30	50	3	41	19
313	El usuario Brayan ha rechazado tu invitación a la finca finca Q.	2024-11-07 10:24:59.566812	105	47	4	143	19
314	Se le ha asignado una tarea de Chequeo de Salud en el lote lotes de la finca el toro en la fecha 2024-11-08	2024-11-07 00:00:00	26	\N	5	41	21
315	Has sido invitado como Operador de campo a la finca el toro	2024-11-07 10:27:24.001087	105	51	1	41	19
316	El usuario Samboni ha aceptado tu invitación a la finca el toro.	2024-11-07 10:27:57.400889	30	51	3	41	19
317	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lotes de la finca el toro en la fecha 2024-11-18	2024-11-07 00:00:00	105	\N	5	41	21
318	La tarea de Chequeo de Salud en el lote Lote #1 de la finca PRUEBAS COSTOS ha sido eliminada.	2024-11-07 00:00:00	38	\N	7	49	31
319	Has sido invitado como Operador de campo a la finca Pruebas tareas 1	2024-11-07 13:13:33.327699	108	52	1	2	18
320	Has sido invitado como Operador de campo a la finca Pruebas tareas 1	2024-11-07 13:22:45.465435	6	53	1	2	19
321	El usuario sebastian ramirez ha aceptado tu invitación a la finca Pruebas tareas 1.	2024-11-07 13:31:52.916455	64	53	3	2	19
322	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca La Arcadia.	2024-11-09 00:00:00.273488	105	\N	5	32	21
323	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca La Arcadia.	2024-11-09 00:00:01.307752	105	\N	5	32	21
324	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-11-10	2024-11-09 00:00:00	2	\N	5	111	21
325	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-11-09	2024-11-09 00:00:00	2	\N	5	111	21
326	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-11-09	2024-11-09 00:00:00	2	\N	5	111	21
327	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-11-10	2024-11-09 00:00:00	2	\N	5	111	21
328	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaTareas de la finca PruebaColaboradores en la fecha 2024-11-10	2024-11-09 00:00:00	2	\N	5	111	21
329	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-10 00:00:00.735428	38	\N	5	111	21
330	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-10 00:00:01.482247	2	\N	5	111	21
331	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-10 00:00:01.532837	38	\N	5	111	21
332	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-10 00:00:01.641525	2	\N	5	111	21
333	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-10 00:00:01.700454	38	\N	5	111	21
334	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebaTareas de la finca PruebaColaboradores.	2024-11-10 00:00:01.78629	2	\N	5	111	21
335	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-13	2024-11-11 00:00:00	2	\N	5	144	21
336	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote py de la finca polita en la fecha 2024-11-12	2024-11-11 00:00:00	38	\N	5	18	21
337	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de estado de maduración para hoy en el lote lote py de la finca polita.	2024-11-12 00:00:00.199077	37	\N	5	18	21
339	Has sido invitado como Administrador de finca a la finca san isidro	2024-11-12 19:06:12.374408	2	55	1	150	19
340	El usuario Natalia Rodríguez Mu ha aceptado tu invitación a la finca san isidro.	2024-11-12 19:07:10.441514	109	55	3	150	19
341	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 1 de la finca polita en la fecha 2024-11-13	2024-11-13 00:00:00	38	\N	5	18	21
342	Has sido invitado como Operador de campo a la finca La Finca de Lú	2024-11-13 12:38:13.470242	37	56	1	151	19
343	El usuario Valen ha aceptado tu invitación a la finca La Finca de Lú.	2024-11-13 12:48:03.416749	40	56	3	151	19
345	Se ha actualizado una tarea del lote lote 1 de la finca Pruebas tareas 1.	2024-11-13 00:00:00	38	\N	6	2	32
344	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-14	2024-11-13 00:00:00	2	\N	5	111	21
347	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 2 de la finca Pruebas tareas 1 en la fecha 2024-11-14	2024-11-13 00:00:00	38	\N	5	2	21
346	Se le ha asignado una tarea de Chequeo de Salud en el lote lote 2 de la finca Pruebas tareas 1 en la fecha 2024-11-14	2024-11-13 00:00:00	38	\N	5	2	21
348	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-14	2024-11-13 00:00:00	77	\N	5	111	21
338	Has sido invitado como Administrador de finca a la finca prueba Integración	2024-11-12 17:08:09.589838	77	54	1	149	19
349	El usuario pruebaCuenta ha aceptado tu invitación a la finca prueba Integración.	2024-11-13 15:37:20.726981	38	54	3	149	19
350	El colaborador naty rmu tiene una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-11-14 00:00:00.400397	2	\N	5	113	21
351	Tienes una tarea de Chequeo de Salud para hoy en el lote jkz de la finca Finca 5.	2024-11-14 00:00:00.664263	82	\N	5	113	21
352	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-14 00:00:00.766436	38	\N	5	111	21
353	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-14 00:00:00.907461	2	\N	5	111	21
354	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-11-14 00:00:01.254768	2	\N	5	2	21
355	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 1 de la finca Pruebas tareas 1.	2024-11-14 00:00:01.472369	38	\N	5	2	21
356	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote lote 2 de la finca Pruebas tareas 1.	2024-11-14 00:00:01.548332	2	\N	5	2	21
357	Tienes una tarea de Chequeo de Salud para hoy en el lote lote 2 de la finca Pruebas tareas 1.	2024-11-14 00:00:01.609932	38	\N	5	2	21
358	El colaborador Daniel Pruebas  tiene una tarea de Chequeo de estado de maduración para hoy en el lote lote 2 de la finca Pruebas tareas 1.	2024-11-14 00:00:01.712813	2	\N	5	2	21
359	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote lote 2 de la finca Pruebas tareas 1.	2024-11-14 00:00:01.804438	38	\N	5	2	21
360	El colaborador pruebaCuenta tiene una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-14 00:00:01.878143	38	\N	5	111	21
361	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-14 00:00:01.952242	77	\N	5	111	21
362	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-15	2024-11-14 00:00:00	77	\N	5	111	21
363	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-15	2024-11-14 00:00:00	77	\N	5	111	21
364	Has sido invitado como Administrador de finca a la finca Prueba render	2024-11-14 08:33:32.942336	77	57	1	152	18
365	Has sido invitado como Operador de campo a la finca finca 2	2024-11-14 09:11:43.473252	38	58	1	31	19
367	El usuario Pruebas  ha aceptado tu invitación a la finca finca 2.	2024-11-14 09:15:08.517945	8	58	3	31	19
366	Has sido invitado como Operador de campo a la finca                   ddf                                                                  	2024-11-14 09:14:52.955688	38	59	1	30	19
368	El usuario Pruebas  ha aceptado tu invitación a la finca                   ddf                                                                  .	2024-11-14 09:15:17.625917	8	59	3	30	19
369	Se le ha asignado una tarea de Chequeo de Salud en el lote hola s de la finca finca 2 en la fecha 2024-11-14	2024-11-14 00:00:00	38	\N	5	31	21
370	Se le ha asignado una tarea de Chequeo de Salud en el lote hola s de la finca finca 2 en la fecha 2024-11-15	2024-11-14 00:00:00	38	\N	5	31	21
371	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-14	2024-11-14 00:00:00	8	\N	5	111	21
372	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-15	2024-11-14 00:00:00	8	\N	5	111	21
373	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-15	2024-11-14 00:00:00	2	\N	5	111	21
374	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote 2 de la finca Pruebas tareas 1 en la fecha 2024-11-14	2024-11-14 00:00:00	37	\N	5	2	21
375	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-15	2024-11-14 00:00:00	2	\N	5	111	21
376	El colaborador pruebaCuenta tiene una tarea de Chequeo de estado de maduración para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-15 00:00:00.308264	38	\N	5	111	21
377	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-15 00:00:00.481777	77	\N	5	111	21
378	El colaborador Pruebas  tiene una tarea de Chequeo de Salud para hoy en el lote hola s de la finca finca 2.	2024-11-15 00:00:00.51548	8	\N	5	31	21
379	Tienes una tarea de Chequeo de Salud para hoy en el lote hola s de la finca finca 2.	2024-11-15 00:00:00.578365	38	\N	5	31	21
380	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-15 00:00:00.730175	38	\N	5	111	21
381	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-15 00:00:00.822675	2	\N	5	111	21
382	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de estado de maduración para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-15 00:00:00.852435	38	\N	5	111	21
383	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-15 00:00:00.9564	2	\N	5	111	21
384	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote lotes de la finca el toro.	2024-11-18 00:00:00.352307	105	\N	5	41	21
386	Has sido invitado como Operador de campo a la finca Las delicias	2024-11-25 10:45:41.440853	77	61	1	156	18
385	Has sido invitado como Operador de campo a la finca Las delicias	2024-11-25 10:45:33.59047	38	60	1	156	19
387	El usuario Prueba ha aceptado tu invitación a la finca Las delicias.	2024-11-25 10:55:00.675278	112	60	3	156	19
388	Se le ha asignado una tarea de Chequeo de Salud en el lote Castillo de la finca Las delicias en la fecha 2024-11-26	2024-11-25 00:00:00	38	\N	5	156	21
389	Has sido invitado como Operador de campo a la finca Prueba detección	2024-11-25 12:04:48.424036	37	62	1	157	19
390	El usuario Valen audit ha aceptado tu invitación a la finca Prueba detección.	2024-11-25 12:05:13.426885	80	62	3	157	19
392	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote 1 de la finca Prueba detección en la fecha 2024-11-25	2024-11-25 00:00:00	37	\N	5	157	21
391	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote Lote 1 de la finca Prueba detección en la fecha 2024-11-25	2024-11-25 00:00:00	37	\N	5	157	21
394	El usuario Valentina2 ha aceptado tu invitación a la finca 976.	2024-11-25 12:17:38.915728	37	63	3	20	19
397	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-25	2024-11-25 00:00:00	2	\N	5	144	21
400	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-25	2024-11-25 00:00:00	2	\N	5	144	21
403	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
404	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
407	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
395	Se le ha asignado una tarea de Chequeo de Salud en el lote Lote 1 de la finca Prueba detección en la fecha 2024-11-26	2024-11-25 00:00:00	37	\N	5	157	21
398	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-25	2024-11-25 00:00:00	2	\N	5	144	21
401	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-25	2024-11-25 00:00:00	2	\N	5	144	21
405	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
408	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
409	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-25	2024-11-25 00:00:00	2	\N	5	144	21
410	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
411	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
412	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
413	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-26	2024-11-25 00:00:00	2	\N	5	144	21
414	El colaborador Prueba tiene una tarea de Chequeo de Salud para hoy en el lote Castillo de la finca Las delicias.	2024-11-26 00:00:00.416776	112	\N	5	156	21
415	Tienes una tarea de Chequeo de Salud para hoy en el lote Castillo de la finca Las delicias.	2024-11-26 00:00:00.438126	38	\N	5	156	21
416	El colaborador Valen audit tiene una tarea de Chequeo de Salud para hoy en el lote Lote 1 de la finca Prueba detección.	2024-11-26 00:00:00.461882	80	\N	5	157	21
417	Tienes una tarea de Chequeo de Salud para hoy en el lote Lote 1 de la finca Prueba detección.	2024-11-26 00:00:00.834363	37	\N	5	157	21
418	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote lote Isis 1 de la finca finca isis.	2024-11-26 00:00:00.876737	103	\N	5	144	21
419	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote lote Isis 1 de la finca finca isis.	2024-11-27 00:00:00.307916	103	\N	5	144	21
420	Tienes una tarea de Chequeo de Salud para hoy en el lote lote Isis 1 de la finca finca isis.	2024-11-27 00:00:00.967944	2	\N	5	144	21
421	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-29	2024-11-28 00:00:00	2	\N	5	144	21
422	Se le ha asignado una tarea de Chequeo de Salud en el lote lote Isis 1 de la finca finca isis en la fecha 2024-11-29	2024-11-28 00:00:00	2	\N	5	144	21
423	Has sido invitado como Operador de campo a la finca finca isis	2024-11-28 12:11:23.403897	30	64	1	144	18
424	Has sido invitado como Operador de campo a la finca la arboleda	2024-11-28 12:44:20.402505	6	65	1	154	19
425	El usuario sebastian ramirez ha aceptado tu invitación a la finca la arboleda.	2024-11-28 12:44:47.791192	64	65	3	154	19
426	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote el platanal de la finca la arboleda en la fecha 2024-11-28	2024-11-28 00:00:00	6	\N	5	154	21
427	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote el platanal de la finca la arboleda en la fecha 2024-11-28	2024-11-28 00:00:00	6	\N	5	154	21
428	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote el platanal de la finca la arboleda en la fecha 2024-11-29	2024-11-28 00:00:00	6	\N	5	154	21
429	Se le ha asignado una tarea de Chequeo de Salud en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-29	2024-11-28 00:00:00	2	\N	5	111	21
430	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote pruebaCostos de la finca PruebaColaboradores en la fecha 2024-11-30	2024-11-28 00:00:00	2	\N	5	111	21
431	Has sido invitado como Operador de campo a la finca Farm 1	2024-11-28 14:23:12.938469	38	66	1	160	19
432	El usuario Prueba ha aceptado tu invitación a la finca Farm 1.	2024-11-28 14:23:19.471619	103	66	3	160	19
433	Se le ha asignado una tarea de Chequeo de Salud en el lote Plot 1 de la finca Farm 1 en la fecha 2024-11-29	2024-11-28 00:00:00	38	\N	5	160	21
434	Se le ha asignado una tarea de Chequeo de estado de maduración en el lote Plot 1 de la finca Farm 1 en la fecha 2024-11-29	2024-11-28 00:00:00	38	\N	5	160	21
435	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote el platanal de la finca la arboleda.	2024-11-29 00:00:00.501316	6	\N	5	154	21
436	El colaborador Natalia Rodríguez Mu tiene una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-29 00:00:01.563218	38	\N	5	111	21
437	Tienes una tarea de Chequeo de Salud para hoy en el lote pruebaCostos de la finca PruebaColaboradores.	2024-11-29 00:00:01.57701	2	\N	5	111	21
438	El colaborador Prueba tiene una tarea de Chequeo de Salud para hoy en el lote Plot 1 de la finca Farm 1.	2024-11-29 00:00:01.593873	103	\N	5	160	21
439	Tienes una tarea de Chequeo de Salud para hoy en el lote Plot 1 de la finca Farm 1.	2024-11-29 00:00:01.605679	38	\N	5	160	21
440	El colaborador Prueba tiene una tarea de Chequeo de estado de maduración para hoy en el lote Plot 1 de la finca Farm 1.	2024-11-29 00:00:01.641604	103	\N	5	160	21
441	Tienes una tarea de Chequeo de estado de maduración para hoy en el lote Plot 1 de la finca Farm 1.	2024-11-29 00:00:01.657192	38	\N	5	160	21
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission (permission_id, description, name) FROM stdin;
1	Permite al usuario modificar la informacion de la finca	edit_farm
5	Permite al usuario eliminar finca de  donde es propietario  	delete_farm
6	Permite al usuario eliminar administrador de finca 	delete_administrador_farm
7	Permite al usuario eliminar operador de campo 	delete_operador_farm
2	Permite al usuario agregar administrador de finca 	add_administrador_farm
3	Permite al usuario agregar operador de campo 	add_operador_farm
9	Permite al usuario listar los colaboradores de una finca	read_collaborators
10	Permite al usuario editar un rol de colaborador a operador de campo	edit_operador_farm
11	Permite al usuario editar un rol de colaborador a administrador de finca	edit_administrador_farm
4	Permite al usuario agregar lotes 	add_plot
12	Permiso para editar lotes	edit_plot
13	Permiso para eliminar lotes	delete_plot
14	Permiso para agregar floraciones	add_flowering
15	Permiso para editar floraciones	edit_flowering
8	Permite al usuario listar los lotes 	read_plots
16	Permiso para listar floraciones	read_flowering
17	Permiso para eliminar floraciones	delete_flowering
18	Permite al usuario ver reportes de la finca	read_report
19	Permite al usuario agregar una tarea de labor cultural\n	add_cultural_work_task
21	Permite al usuario leer las tarea de labor cultural de un lote	read_cultural_work_task
20	Permite al usuario completar una tarea de labor cultural	complete_cultural_work_task
22	Permite al usuario modificar la información de la tarea de labor cultural	edit_cultural_work_task
23	Permite al usuario eliminar la tarea de labor cultural	delete_cultural_work_task
24	Permite al usuario ver las transaciones de la finca	read_transaction
25	Permite al usuario editar las transaciones de la finca	edit_transaction
26	Permite al usuario agregar las transaciones de la finca	add_transaction
27	Permite al usuario eliminar las transaciones de la finca	delete_transaction
28	Permiso para realizar detecciones	perform_detection
29	Permite al usuario ver los reportes financieron	read_financial_report
31	Permite al usuario ver los reportes de maduracion	read_maturation_checks
30	Permite al usuario ver los reportes de salud	read_health_checks_report
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (role_id, name) FROM stdin;
1	Propietario
3	Operador de campo
2	Administrador de finca
\.


--
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permission (role_id, permission_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
1	8
1	7
2	1
2	3
2	7
2	9
1	9
1	10
1	11
1	12
1	13
2	12
2	13
1	14
1	15
2	14
2	15
1	16
1	17
2	4
2	10
2	16
2	17
1	18
2	8
1	19
3	20
1	21
1	22
1	23
1	26
1	25
1	27
1	24
1	28
2	28
3	28
1	29
2	24
2	25
2	26
2	27
1	30
1	31
\.


--
-- Data for Name: transaction_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_type (transaction_type_id, name) FROM stdin;
1	Ingreso
2	Gasto
\.


--
-- Data for Name: transaction_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_category (transaction_category_id, name, transaction_type_id) FROM stdin;
1	Venta de café	1
2	Otros	1
3	Pagos a colaboradores	2
4	Fertilizantes	2
5	Plaguicidas/herbicidas	2
6	Otros	2
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction (transaction_id, plot_id, description, transaction_type_id, transaction_date, status_id, value, transaction_category_id, creador_id) FROM stdin;
56	56		1	2024-11-12	33	50000	1	103
58	59	prueba fechas	1	2024-10-19	33	200000	2	38
59	59	fechas	2	2024-10-26	33	200000	3	38
60	59	venta	1	2024-11-01	33	500000	1	38
61	59	gastos	2	2024-11-08	33	1000000	5	38
62	69	PruebaBD	1	2024-11-11	34	300000	1	38
63	69	Prueba edit bd	1	2024-11-12	34	700000	1	38
66	72	venta café prueba	1	2024-11-13	33	5000000	1	38
67	72	gastos herbicidas	2	2024-11-14	33	2500000	5	38
70	61	Venta café julian	1	2024-11-24	33	250000	1	37
73	83		2	2024-11-28	33	35000	4	103
7	49	\N	1	2024-11-03	33	25	1	2
8	49	Holsaaaaaaaa	1	2024-11-03	33	36	1	2
14	49	string	1	2024-11-03	33	47	1	2
2	49	string	2	2024-11-03	33	25	5	2
3	49	string	2	2024-11-03	33	25	6	2
4	49	string	2	2024-11-03	34	25	4	2
13	48		2	2024-11-03	33	35	3	2
32	64		2	2024-11-04	33	36	3	2
9	48	popo	2	2024-11-02	34	32	6	2
17	6		1	2024-11-03	33	60000	1	2
16	6	Venta cafécito	1	2024-11-03	34	36	1	2
12	48	hu	1	2024-11-03	34	35	1	2
15	48	ju	2	2024-11-02	33	65	3	2
18	48	bjj	1	2024-11-02	33	35	2	2
11	48	hhj djdjsk	1	2024-11-03	33	10000	1	2
21	38	pago guadañada jajsjshshssjsjjsjdhshshhsshshshhsha	2	2024-11-02	34	30000	3	2
24	38		1	2024-11-03	34	300000	1	2
23	38		1	2024-11-03	34	300000	1	2
22	38		1	2024-11-02	34	300000	1	2
19	38		2	2024-11-01	34	500	3	2
6	49		2	2024-11-03	33	250	4	2
33	65	Abono F70	2	2024-11-05	33	3800000	4	2
29	38	7	2	2024-11-03	34	88	4	2
28	38		1	2024-11-03	34	88	1	2
25	38		2	2024-11-03	34	300000000	6	2
34	65	Venta de 3 cargas	1	2024-11-01	33	4200000	1	2
35	65	venta 1 carga café	1	2024-11-04	33	2000000	1	2
10	48	jj	2	2024-11-02	34	1000000	6	2
27	63		1	2024-11-03	33	9999999	2	2
38	61		1	2024-11-05	33	120000	1	2
39	61	wd1d	1	2024-11-05	33	1200000	1	2
36	61	ggjbvcghjjjjjjjjgfftjjcfhnbcfhnfrjb xftkkb 	2	2024-11-06	34	2504385588	4	2
30	49	jsjs	1	2024-11-03	34	6999999999	1	2
1	49	string	1	2024-11-03	34	999999999	2	2
5	49	string	1	2024-11-03	34	3255522223	1	2
31	64		1	2024-11-02	33	36	1	2
37	61	holaa	2	2024-11-06	33	2368	3	2
41	38		2	2024-11-04	34	100000	4	2
40	38		1	2024-10-26	34	26101970	2	2
20	38	venta número 3 de la semana	2	2024-10-19	34	19102002	3	2
26	38		1	2024-09-03	34	3092001	1	2
44	57		2	2024-11-07	33	300000	4	2
45	38		2	2024-11-06	34	20000	3	2
42	38	Venta de cafe pasilla	1	2024-11-07	33	1000008	1	2
46	38		2	2024-08-24	33	100000	5	2
47	38		1	2024-11-06	33	10000	1	2
43	38	Pago cogedores de cafe	2	2024-11-07	33	400000	3	2
48	61	hola	2	2024-11-06	33	23500	4	2
49	61		2	2024-11-06	33	23000	5	2
50	61		1	2024-11-06	33	235000	2	2
52	59	venta día de hoy	1	2024-11-12	33	1000000	1	2
53	59	gastos fertilizantes 	2	2024-11-10	33	300000	4	2
54	37	venta cafe	1	2024-11-12	33	3000000	1	2
55	37	Compra plaguicidas el toro	2	2024-11-11	33	1000000	5	2
57	56		2	2024-11-12	33	35000	4	\N
64	56		2	2024-11-12	33	3650	4	103
65	59	prueba	1	2024-11-13	34	1000000000	1	38
68	66	bulto de abono	2	2024-11-20	33	50000	5	30
69	66	semana laborada	2	2024-11-20	33	250000	3	30
51	68		1	2024-11-06	34	230000	1	2
71	74	para abonar	2	2024-11-26	33	2000000	4	64
72	74	venta de carga y media de cafe	1	2024-11-26	33	4000000	1	64
\.


--
-- Data for Name: user_role_farm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_farm (user_role_farm_id, role_id, user_id, farm_id, status_id) FROM stdin;
127	1	38	102	22
128	1	38	103	22
129	1	38	104	22
35	1	50	35	22
75	1	50	63	22
76	1	50	64	22
77	1	50	65	22
1	1	50	1	22
143	1	38	111	22
4	1	38	4	22
5	1	38	5	22
6	1	38	6	22
7	1	38	7	22
8	1	38	8	22
9	1	38	9	22
10	1	38	10	22
11	1	38	11	22
12	1	38	12	22
13	1	38	13	22
14	1	38	14	22
15	1	8	15	22
16	1	37	16	22
17	1	37	17	22
18	1	37	18	22
19	1	8	19	22
20	1	37	20	22
21	1	8	21	22
22	1	37	22	22
23	1	8	23	22
24	1	8	24	22
25	1	37	25	22
26	1	8	26	22
27	1	37	27	22
28	1	38	28	22
30	1	8	30	22
31	1	8	31	22
32	1	30	32	22
33	1	50	33	22
34	1	50	34	22
130	1	38	105	22
36	1	50	36	22
29	3	8	36	22
37	1	59	37	22
38	1	58	38	22
39	1	66	39	22
40	1	67	40	22
41	1	30	41	22
43	1	2	43	22
44	1	38	44	22
45	1	38	45	22
46	1	37	46	22
47	1	2	47	22
42	2	50	42	22
48	3	50	48	22
49	1	77	49	22
50	1	77	50	22
51	1	77	51	22
52	1	77	52	22
53	1	77	53	22
54	1	77	54	22
55	1	77	55	22
56	1	38	56	22
57	1	38	57	22
58	1	38	58	22
59	1	38	59	22
60	1	78	60	22
61	3	79	60	22
64	3	46	36	22
135	1	87	107	23
66	3	2	33	22
67	2	8	33	22
68	3	37	33	22
136	1	87	108	22
153	1	2	2	22
72	3	38	18	22
73	1	50	61	22
78	1	76	66	22
65	2	46	35	23
79	2	76	35	23
83	2	76	35	23
131	3	8	47	23
70	3	50	31	23
84	2	76	35	23
85	3	76	35	23
86	3	76	35	22
87	1	46	67	22
88	3	50	67	22
89	1	38	68	22
92	3	77	8	22
94	1	38	69	22
95	1	38	70	22
96	1	38	71	22
97	1	38	72	22
98	1	38	73	22
99	1	38	74	22
100	1	38	75	22
101	1	38	76	22
102	1	38	77	22
103	1	38	78	22
104	1	38	79	22
105	1	38	80	22
106	1	38	81	22
107	1	38	82	22
108	1	38	83	22
109	1	38	84	22
110	1	38	85	22
111	1	38	86	22
112	1	38	87	22
113	1	38	88	22
114	1	38	89	22
115	1	38	90	22
116	1	38	91	22
117	1	38	92	22
118	1	38	93	22
119	1	38	94	22
120	1	38	95	22
121	1	38	96	22
122	1	38	97	22
123	1	38	98	22
124	1	38	99	22
125	1	38	100	22
126	1	38	101	22
137	1	87	109	22
132	2	38	31	23
145	2	98	31	22
138	1	2	110	22
139	3	2	31	23
140	2	2	31	22
142	1	98	112	22
3	2	8	35	23
133	1	38	31	23
144	3	77	111	23
147	1	2	113	22
148	1	2	114	22
90	3	76	62	23
91	2	77	62	23
149	3	77	111	22
151	2	98	62	22
150	3	77	62	23
152	2	77	62	22
74	3	38	62	22
154	1	2	115	22
155	1	38	116	22
146	3	69	31	23
141	2	98	111	22
93	2	38	49	22
71	3	37	2	22
2	3	38	2	22
69	2	50	2	23
156	3	30	2	23
157	3	30	2	22
158	3	2	7	22
159	1	2	117	22
160	2	64	2	22
161	2	99	2	22
162	1	2	118	22
163	1	2	119	22
164	1	99	120	22
166	1	2	121	22
169	1	50	122	22
170	1	50	123	22
172	1	69	125	22
173	1	69	126	22
174	3	65	126	23
175	3	65	125	22
176	2	69	16	22
177	1	66	127	22
185	1	2	135	22
186	3	46	2	22
187	2	38	51	22
188	2	38	53	22
189	1	2	136	22
190	3	46	136	22
192	1	38	138	22
195	2	2	67	22
196	1	104	141	22
198	2	103	113	23
199	1	2	142	22
200	1	105	143	22
201	1	103	144	22
202	3	2	144	22
167	3	2	111	22
165	3	77	4	22
203	3	30	143	22
168	3	8	111	22
197	3	82	113	22
204	1	2	145	22
205	1	2	146	22
206	1	2	147	22
207	1	107	148	22
208	3	105	32	22
209	3	26	41	22
210	3	105	41	22
211	3	6	2	22
212	1	38	149	22
213	1	109	150	22
214	2	2	150	22
215	1	40	151	22
216	3	37	151	22
217	2	77	149	22
218	1	38	152	22
219	3	38	31	22
220	3	38	30	22
221	1	64	153	22
222	1	64	154	22
223	1	2	155	22
224	1	112	156	22
225	3	38	156	22
226	1	80	157	22
227	3	37	157	22
228	3	80	20	22
229	1	80	158	22
230	1	38	159	22
231	3	6	154	22
232	1	103	160	22
233	3	38	160	22
\.