--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Categories" (
    "Code" character varying(50) NOT NULL,
    "Name" character varying(200) NOT NULL,
    "ParentCode" character varying(50)
);


ALTER TABLE public."Categories" OWNER TO postgres;

--
-- Name: TransactionSplits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TransactionSplits" (
    "Id" text NOT NULL,
    "TransactionId" character varying(50) NOT NULL,
    "CategoryCode" character varying(50) NOT NULL,
    "Amount" numeric(18,2) NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."TransactionSplits" OWNER TO postgres;

--
-- Name: Transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transactions" (
    "Id" character varying(50) NOT NULL,
    "BeneficiaryName" character varying(200),
    "Date" timestamp with time zone NOT NULL,
    "Direction" text NOT NULL,
    "Amount" numeric(18,2) NOT NULL,
    "Description" character varying(500),
    "Currency" character varying(3) NOT NULL,
    "Mcc" integer,
    "Kind" text NOT NULL,
    catcode character varying(50)
);


ALTER TABLE public."Transactions" OWNER TO postgres;

--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- Data for Name: Categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Categories" ("Code", "Name", "ParentCode") FROM stdin;
B	Auto & Transport	\N
C	Bills & Utilities	\N
0	Other	A
1	Other	B
10	Internet	C
100	Credit Card Payment	S
103	Air Travel	T
A	Misc Expenses	\N
104	Hotel	T
105	Rental Car & Taxi	T
106	Vacation	T
11	Mobile Phone	C
12	Television	C
13	Utilities	C
15	Books & Supplies	D
17	Tuition	D
2	Auto Insurance	B
20	Arts	E
21	Movies & DVDs	E
22	Music	E
23	Newspapers & Magazines	E
25	ATM Fee	F
26	Bank Fee	F
28	Late Fee	F
3	Auto Leasing	B
33	Life Insurance	G
38	Groceries	U
39	Restaurants	U
4	Gas & Fuel	B
41	Charity	H
42	Gift	H
44	Dentist	I
45	Doctor	I
46	Eyecare	I
47	Gym	I
48	Health Insurance	I
49	Pharmacy	I
5	Parking	B
50	Sports	I
53	Home Improvement	J
54	Home Insurance	J
55	Home Services	J
56	Home Supplies	J
58	Mortgage & Rent	J
59	Other	K
60	Bonus	K
61	Interest Income	K
62	Paycheck	K
64	Rental Income	K
67	Allowance	L
68	Baby Supplies	L
7	Service & Parts	B
71	Kids Activities	L
72	Toys	L
74	Loan Fees and Charges	M
77	Loan Payment	M
80	Hair	N
82	Spa & Massage	N
83	Other	O
84	Pet Food & Supplies	O
85	Pet Grooming	O
86	Veterinary	O
88	Books	P
89	Clothing	P
9	Home Phone	C
90	Electronics & Software	P
92	Sporting Goods	P
96	Property Tax	R
98	Income Tax	R
D	Education	\N
E	Entertainment	\N
F	Fees & Charges	\N
G	Financial	\N
H	Gifts & Donations	\N
I	Health & Fitness	\N
J	Home	\N
K	Income	\N
L	Kids	\N
M	Loans	\N
N	Personal Care	\N
O	Pets	\N
P	Shopping	\N
R	Taxes	\N
S	Transfer	\N
T	Travel	\N
U	Food & Dining	\N
Z	Split	\N
\.


--
-- Data for Name: TransactionSplits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TransactionSplits" ("Id", "TransactionId", "CategoryCode", "Amount", "CreatedAt") FROM stdin;
31ffad4b-6d8a-44cd-a114-8445ce874eb8	10326647	2	30.50	2025-07-27 03:57:08.590531+02
7d6eac40-3fd4-454d-bfc5-0e9bfb2d0be6	10326647	1	20.00	2025-07-27 03:57:08.590527+02
\.


--
-- Data for Name: Transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transactions" ("Id", "BeneficiaryName", "Date", "Direction", "Amount", "Description", "Currency", "Mcc", "Kind", catcode) FROM stdin;
57650239	Glovo	2021-12-27 01:00:00+01	D	19.10	Food delivery	USD	5811	Pmt	103
10108594	Home cleaning service	2021-10-20 02:00:00+02	D	45.90	Cleaning	USD	\N	Pmt	\N
10517968	Heating	2021-05-11 02:00:00+02	D	50.90	Utilities payment	USD	\N	Pmt	\N
10613403	Home cleaning service	2021-04-01 02:00:00+02	D	50.40	Cleaning	USD	\N	Pmt	\N
11054450	A1 Telecom	2021-03-07 01:00:00+01	D	5.50	Phone bill	USD	\N	Pmt	\N
11214644		2021-05-09 02:00:00+02	D	241.10	ATM withdrawal	USD	\N	Wdw	\N
11415482	Hulu	2021-04-22 02:00:00+02	D	5.40	Netflix subscription	USD	\N	Pmt	\N
12150661	Swimming school	2021-05-24 02:00:00+02	D	28.40	Membership	USD	\N	Pmt	\N
12787396	Visa	2021-07-14 02:00:00+02	D	54.40	Pay with Mastercard	USD	\N	Pmt	\N
12912046	Generali	2021-12-17 01:00:00+01	D	45.10	Extended health insurance	USD	\N	Pmt	\N
13375803	Coinbase	2021-11-12 01:00:00+01	C	628.40	Cryptocurrency sales	USD	\N	Dep	\N
13503667	MasterCard	2021-04-12 02:00:00+02	D	77.50	Pay with Visa	USD	\N	Pmt	\N
13592768	Coinbase	2021-10-27 02:00:00+02	C	624.30	Cryptocurrency sales	USD	\N	Dep	\N
13743307	Heating	2021-01-10 01:00:00+01	D	63.00	Utilities payment	USD	\N	Pmt	\N
13969038	Generali	2021-02-08 01:00:00+01	D	45.50	Extended health insurance	USD	\N	Pmt	\N
14482560	Pet salon Rex	2021-11-11 01:00:00+01	D	10.30	Grooming	USD	\N	Pmt	\N
10023191	Adobe	2021-08-25 02:00:00+02	D	18.20	TV	USD	5045	Pmt	90
16265468	Generali ado	2021-02-14 01:00:00+01	D	789.40	Kasko insurance	USD	6381	Pmt	\N
16506265	Precision Optics	2021-09-02 02:00:00+02	D	125.50	Sun glasses	USD	\N	Pmt	\N
16871465		2021-10-15 02:00:00+02	D	242.60	ATM withdrawal	USD	\N	Wdw	\N
17079478	Bank of America	2021-09-12 02:00:00+02	D	2.80	ATM withdrawal fee	USD	\N	Fee	\N
17317872	Home cleaning service	2021-08-13 02:00:00+02	D	45.40	Cleaning	USD	\N	Pmt	\N
17441792	Pet salon Rex	2021-09-28 02:00:00+02	D	10.50	Grooming	USD	\N	Pmt	\N
17470795	Earnest	2021-12-07 01:00:00+01	D	15.80	Charge pay	USD	\N	Fee	\N
17484730	Emmezeta	2021-01-09 01:00:00+01	D	41.90	Appliances	USD	5712	Pmt	\N
18237211	Hulu	2021-03-16 01:00:00+01	D	9.50	Netflix subscription	USD	\N	Pmt	\N
18400415	MasterCard	2021-09-13 02:00:00+02	D	79.30	Pay with Visa	USD	\N	Pmt	\N
18548250	Home cleaning service	2021-10-20 02:00:00+02	D	46.50	Cleaning	USD	\N	Pmt	\N
18570037	Generali	2021-03-24 01:00:00+01	D	45.60	Extended health insurance	USD	\N	Pmt	\N
18617893	Hulu	2021-08-08 02:00:00+02	D	5.40	Hulu subscription	USD	\N	Pmt	\N
18709472	A1 Telecom	2021-01-06 01:00:00+01	D	6.90	Phone bill	USD	\N	Pmt	\N
18731176		2021-01-18 01:00:00+01	D	204.10	ATM withdrawal	USD	\N	Wdw	\N
19124644	Generali	2021-12-20 01:00:00+01	D	45.10	Extended health insurance	USD	\N	Pmt	\N
19536279	Electro distribution	2021-03-09 01:00:00+01	D	66.10	Utilities payment	USD	\N	Pmt	\N
19845649	Home cleaning service	2021-06-14 02:00:00+02	D	46.00	Cleaning	USD	\N	Pmt	\N
20242555	Travel house	2021-04-02 02:00:00+02	D	888.70	Vacation	USD	5962	Pmt	\N
20480868	Johnson & Johnson	2021-10-09 02:00:00+02	D	69.80	Baby nursery	USD	\N	Pmt	\N
20667289	Amazon	2021-12-13 01:00:00+01	D	16.00	Amazon Kindle subscription	USD	\N	Pmt	\N
20694176	Home cleaning service	2021-02-28 01:00:00+01	D	47.80	Cleaning	USD	\N	Pmt	\N
21129807	PersonalLoans	2021-11-19 01:00:00+01	D	9.60	Charge pay	USD	\N	Fee	\N
21227361	Generali	2021-04-24 02:00:00+02	D	45.40	Extended health insurance	USD	\N	Pmt	\N
21296484	Intersport	2021-08-13 02:00:00+02	D	121.30	Hiking	USD	5941	Pmt	\N
21844448	Earnest	2021-03-04 01:00:00+01	D	11.50	Charge pay	USD	\N	Fee	\N
22332965	Generali	2021-09-21 02:00:00+02	D	45.10	Extended health insurance	USD	\N	Pmt	\N
23640269	Electro distribution	2021-02-22 01:00:00+01	D	77.90	Utilities payment	USD	\N	Pmt	\N
23828515	Netflix	2021-07-27 02:00:00+02	D	8.20	Hulu subscription	USD	\N	Pmt	\N
23988646	Coinbase	2021-07-21 02:00:00+02	C	515.10	Cryptocurrency sales	USD	\N	Dep	\N
23999951	Netflix	2021-08-15 02:00:00+02	D	9.10	Netflix subscription	USD	\N	Pmt	\N
24004997	Volvo service	2021-07-24 02:00:00+02	D	299.80	Regular service	USD	7538	Pmt	\N
24336861	Heating	2021-03-03 01:00:00+01	D	95.90	Utilities payment	USD	\N	Pmt	\N
24353202	Swimming school	2021-07-11 02:00:00+02	D	30.30	Club membership	USD	\N	Pmt	\N
24839524	Pet salon Rex	2021-01-08 01:00:00+01	D	10.30	Grooming	USD	\N	Pmt	\N
25031271	Springfield	2021-11-04 01:00:00+01	D	222.80	Fotwear	USD	\N	Pmt	\N
25121097		2021-03-18 01:00:00+01	D	127.80	ATM withdrawal	USD	\N	Wdw	\N
25199888	Generali	2021-07-27 02:00:00+02	D	45.50	Extended health insurance	USD	\N	Pmt	\N
25290482	Bank of America	2021-05-16 02:00:00+02	D	5.00	Online banking fee	USD	\N	Fee	\N
25343631	Pet salon Rex	2021-10-01 02:00:00+02	D	10.50	Grooming	USD	\N	Pmt	\N
25378012	Heating	2021-07-23 02:00:00+02	D	67.00	Utilities payment	USD	\N	Pmt	\N
25468057	R-Pharm	2021-09-10 02:00:00+02	D	33.20	Home care	USD	5912	Pmt	\N
25497564	Heating	2021-05-01 02:00:00+02	D	53.70	Utilities payment	USD	\N	Pmt	\N
25511607	Pet salon Rex	2021-08-08 02:00:00+02	D	10.00	Grooming	USD	\N	Pmt	\N
25661064	Swimming school	2021-01-06 01:00:00+01	D	27.10	Membership	USD	\N	Pmt	\N
26007217	Amazon	2021-08-11 02:00:00+02	D	7.80	Book	USD	\N	Pmt	\N
26024259	Bank of America	2021-06-25 02:00:00+02	D	7.80	Revolut Silver subscription	USD	\N	Fee	\N
26174855	Hulu	2021-02-12 01:00:00+01	D	10.50	Netflix subscription	USD	\N	Pmt	\N
26246109	Hulu	2021-08-06 02:00:00+02	D	8.30	Netflix subscription	USD	\N	Pmt	\N
26443996	Pet salon Rex	2021-06-28 02:00:00+02	D	10.30	Grooming	USD	\N	Pmt	\N
26608760	Auto registration agency "Sport"	2021-07-06 02:00:00+02	D	284.00	Yearly car registration 	USD	7542	Pmt	\N
27170962	Visa	2021-06-03 02:00:00+02	D	43.00	Pay with Mastercard	USD	\N	Pmt	\N
27447845	ToysRUS	2021-10-28 02:00:00+02	D	49.60	Dolls	USD	5945	Pmt	\N
27697612	Karate club	2021-01-23 01:00:00+01	D	29.90	Club membership	USD	\N	Pmt	\N
27776411	Generali	2021-02-14 01:00:00+01	D	45.50	Extended health insurance	USD	\N	Pmt	\N
27846899		2021-05-05 02:00:00+02	D	190.30	ATM withdrawal	USD	\N	Wdw	\N
28111114	Bank of America	2021-11-22 01:00:00+01	D	3.50	ATM withdrawal fee	USD	\N	Fee	\N
28166245	Hulu	2021-05-03 02:00:00+02	D	9.30	Hulu subscription	USD	\N	Pmt	\N
29218165	Karate club	2021-10-01 02:00:00+02	D	22.50	Club membership	USD	\N	Pmt	\N
33106431		2021-11-20 01:00:00+01	D	221.70	ATM withdrawal	USD	\N	Wdw	77
29576441	Bank of America	2021-12-14 01:00:00+01	D	4.00	ATM withdrawal fee	USD	\N	Fee	\N
30305697	Earnest	2021-10-08 02:00:00+02	D	8.50	Charge pay	USD	\N	Fee	\N
30612835	Bank of America	2021-12-03 01:00:00+01	D	4.00	ATM withdrawal fee	USD	\N	Fee	\N
31000600	Amazon	2021-12-15 01:00:00+01	D	13.50	Book	USD	\N	Pmt	\N
31551099	Pet salon Rex	2021-01-27 01:00:00+01	D	10.70	Grooming	USD	\N	Pmt	\N
31795569	Generali	2021-02-21 01:00:00+01	D	45.90	Extended health insurance	USD	\N	Pmt	\N
31946105	Emmezeta	2021-04-16 02:00:00+02	D	52.90	Appliances	USD	5712	Pmt	\N
32058742	Hulu	2021-04-05 02:00:00+02	D	9.50	Netflix subscription	USD	\N	Pmt	\N
32255175	Netflix	2021-09-23 02:00:00+02	D	7.30	Hulu subscription	USD	\N	Pmt	\N
32425141	Emmezeta	2021-09-20 02:00:00+02	D	42.00	Furniture	USD	5712	Pmt	\N
32670635	Earnest	2021-05-28 02:00:00+02	D	9.60	Charge pay	USD	\N	Fee	\N
32671432	Legend	2021-01-26 01:00:00+01	D	273.40	Fotwear	USD	\N	Pmt	\N
33377022	Electro distribution	2021-12-17 01:00:00+01	D	66.30	Utilities payment	USD	\N	Pmt	\N
33494785	Home cleaning service	2021-12-16 01:00:00+01	D	47.30	Cleaning	USD	\N	Pmt	\N
33842223	Electro distribution	2021-09-14 02:00:00+02	D	76.40	Utilities payment	USD	\N	Pmt	\N
34319628	Hulu	2021-02-02 01:00:00+01	D	10.00	Netflix subscription	USD	\N	Pmt	\N
34686440	Heating	2021-11-22 01:00:00+01	D	98.10	Utilities payment	USD	\N	Pmt	\N
35220328	R-Pharm	2021-12-26 01:00:00+01	D	38.70	Home care	USD	5912	Pmt	M
34782681	Pet salon Rex	2021-11-25 01:00:00+01	D	10.90	Grooming	USD	\N	Pmt	\N
35924168	Hooters Air	2021-12-26 01:00:00+01	D	504.00	Ticket pay	USD	\N	Pmt	84
34904719	Generali	2021-08-13 02:00:00+02	D	45.60	Extended health insurance	USD	\N	Pmt	\N
35067897	Bank of America	2021-12-03 01:00:00+01	D	5.70	ATM withdrawal fee	USD	\N	Fee	\N
35238945		2021-06-13 02:00:00+02	D	159.50	ATM withdrawal	USD	\N	Wdw	\N
35262874	A1 Telecom	2021-01-18 01:00:00+01	D	6.10	Phone bill	USD	\N	Pmt	\N
35272422		2021-04-12 02:00:00+02	D	155.30	ATM withdrawal	USD	\N	Wdw	\N
35431913	Private consulting co	2021-09-06 02:00:00+02	C	773.80	Cryptocurrency sales	USD	\N	Dep	\N
35439980	Netflix	2021-12-13 01:00:00+01	D	5.10	Hulu subscription	USD	\N	Pmt	\N
35750091	Karate club	2021-02-24 01:00:00+01	D	24.90	Club membership	USD	\N	Pmt	\N
35938062	Bank of America	2021-03-21 01:00:00+01	D	4.80	Online banking fee	USD	\N	Fee	\N
36443001		2021-02-22 01:00:00+01	D	261.30	ATM withdrawal	USD	\N	Wdw	\N
36456188	Generali	2021-01-22 01:00:00+01	D	45.50	Extended health insurance	USD	\N	Pmt	\N
36679148	Home cleaning service	2021-03-03 01:00:00+01	D	50.40	Cleaning	USD	\N	Pmt	\N
36857155	MasterCard	2021-10-01 02:00:00+02	D	44.60	Pay with Visa	USD	\N	Pmt	\N
37050048	Earnest	2021-06-10 02:00:00+02	D	7.10	Charge pay	USD	\N	Fee	\N
37054139	Lego	2021-12-11 01:00:00+01	D	27.20	Action Figures	USD	5945	Pmt	\N
37384667	Gerber Products Company	2021-09-01 02:00:00+02	D	79.10	Baby wardrobe	USD	\N	Pmt	\N
37630799		2021-11-16 01:00:00+01	D	295.50	ATM withdrawal	USD	\N	Wdw	\N
37907095	Hulu	2021-10-19 02:00:00+02	D	6.80	Netflix subscription	USD	\N	Pmt	\N
38257273	Bank of America	2021-08-21 02:00:00+02	D	5.20	ATM withdrawal fee	USD	\N	Fee	\N
38261701	Bank of America	2021-02-23 01:00:00+01	D	3.20	Online banking fee	USD	\N	Fee	\N
38287786	Netflix	2021-11-15 01:00:00+01	D	9.70	Netflix subscription	USD	\N	Pmt	\N
38585832	Private consulting co	2021-12-12 01:00:00+01	C	776.20	Project based fee	USD	\N	Dep	\N
38831670	Bank of America	2021-08-27 02:00:00+02	D	2.20	ATM withdrawal fee	USD	\N	Fee	\N
39038619		2021-07-05 02:00:00+02	D	242.50	ATM withdrawal	USD	\N	Wdw	\N
39402677	Bank of America	2021-03-03 01:00:00+01	D	5.40	Revolut Silver subscription	USD	\N	Fee	\N
39501055	Amazon	2021-08-20 02:00:00+02	D	8.70	Amazon Kindle subscription	USD	\N	Pmt	\N
40053033	Heating	2021-10-12 02:00:00+02	D	97.80	Utilities payment	USD	\N	Pmt	\N
40404277	Karate club	2021-06-01 02:00:00+02	D	28.60	Club membership	USD	\N	Pmt	\N
40818997	Electro distribution	2021-06-18 02:00:00+02	D	68.90	Utilities payment	USD	\N	Pmt	\N
40847561	Electro distribution	2021-03-06 01:00:00+01	D	45.80	Utilities payment	USD	\N	Pmt	\N
41607473	Home cleaning service	2021-04-02 02:00:00+02	D	47.40	Cleaning	USD	\N	Pmt	\N
41661527	Hulu	2021-09-06 02:00:00+02	D	10.60	Netflix subscription	USD	\N	Pmt	\N
41883185		2021-06-05 02:00:00+02	D	176.40	ATM withdrawal	USD	\N	Wdw	\N
41990408	Bank of America	2021-10-02 02:00:00+02	D	12.20	Late fee	USD	\N	Fee	\N
42056591	Home cleaning service	2021-04-11 02:00:00+02	D	48.30	Cleaning	USD	\N	Pmt	\N
42133993	Intersport	2021-09-20 02:00:00+02	D	131.50	Basketball	USD	5941	Pmt	\N
42148328	Amazon	2021-03-26 01:00:00+01	D	7.60	Book	USD	\N	Pmt	\N
42247740	Pet salon Rex	2021-03-09 01:00:00+01	D	10.50	Grooming	USD	\N	Pmt	\N
42342810	Generali	2021-11-21 01:00:00+01	D	45.50	Extended health insurance	USD	\N	Pmt	\N
42374342	Amazon	2021-06-23 02:00:00+02	D	9.80	Book	USD	\N	Pmt	\N
46433318	Heating	2021-12-26 01:00:00+01	D	48.40	Utilities payment	USD	\N	Pmt	77
42920242		2021-08-12 02:00:00+02	D	166.30	ATM withdrawal	USD	\N	Wdw	\N
43287158	Generali	2021-04-26 02:00:00+02	D	45.00	Extended health insurance	USD	\N	Pmt	\N
43287646	Home cleaning service	2021-04-25 02:00:00+02	D	48.50	Cleaning	USD	\N	Pmt	\N
43728875	Electro distribution	2021-04-02 02:00:00+02	D	90.70	Utilities payment	USD	\N	Pmt	\N
43893103	Pet salon Rex	2021-04-18 02:00:00+02	D	10.20	Grooming	USD	\N	Pmt	\N
43969713	Connexus	2021-09-15 02:00:00+02	D	400.80	Mortgage pay	USD	\N	Pmt	\N
44062965	Hulu	2021-05-13 02:00:00+02	D	8.60	Netflix subscription	USD	\N	Pmt	\N
44881457	Hulu	2021-07-15 02:00:00+02	D	8.70	Netflix subscription	USD	\N	Pmt	\N
44991704	Amazon	2021-05-22 02:00:00+02	D	13.80	Book	USD	\N	Pmt	\N
45419440	Karate club	2021-10-08 02:00:00+02	D	20.20	Club membership	USD	\N	Pmt	\N
45707636	Generali	2021-01-10 01:00:00+01	D	45.80	Extended health insurance	USD	\N	Pmt	\N
45916154	Generali	2021-04-12 02:00:00+02	D	45.70	Extended health insurance	USD	\N	Pmt	\N
46043457	Swimming school	2021-02-26 01:00:00+01	D	24.00	Club membership	USD	\N	Pmt	\N
46251212	Swimming school	2021-01-03 01:00:00+01	D	22.00	Membership	USD	\N	Pmt	\N
46265311		2021-04-26 02:00:00+02	D	149.20	ATM withdrawal	USD	\N	Wdw	\N
46597930	Johnson & Johnson	2021-08-16 02:00:00+02	D	58.10	Baby wardrobe	USD	\N	Pmt	\N
47152441	Netflix	2021-12-11 01:00:00+01	D	9.20	Hulu subscription	USD	\N	Pmt	\N
47190808	Home cleaning service	2021-08-15 02:00:00+02	D	49.60	Cleaning	USD	\N	Pmt	\N
47317900	Best Western	2021-01-16 01:00:00+01	D	1542.10	Hotel	USD	7011	Pmt	\N
47458905	Generali ado	2021-06-26 02:00:00+02	D	373.50	Kasko insurance	USD	6381	Pmt	\N
47521445		2021-10-07 02:00:00+02	D	256.30	ATM withdrawal	USD	\N	Wdw	\N
47721259		2021-10-28 02:00:00+02	D	114.00	ATM withdrawal	USD	\N	Wdw	\N
47836243	Auto registration agency "Sport"	2021-09-24 02:00:00+02	D	214.10	Car wash with waxing	USD	7542	Pmt	\N
48124924	MasterCard	2021-03-03 01:00:00+01	D	57.40	Pay with Visa	USD	\N	Pmt	\N
48213156	MasterCard	2021-06-12 02:00:00+02	D	38.90	Pay with Mastercard	USD	\N	Pmt	\N
48547275	Swimming school	2021-08-16 02:00:00+02	D	28.10	Membership	USD	\N	Pmt	\N
49576581	Heating	2021-10-11 02:00:00+02	D	59.40	Utilities payment	USD	\N	Pmt	\N
50183941	Bank of America	2021-12-08 01:00:00+01	D	7.60	Online banking fee	USD	\N	Fee	\N
50235631	Best Western	2021-05-25 02:00:00+02	D	1563.50	Hotel	USD	7011	Pmt	\N
50289390	Bank of America	2021-01-19 01:00:00+01	D	7.90	Online banking fee	USD	\N	Fee	\N
50478161	Johnson & Johnson	2021-12-14 01:00:00+01	D	43.20	Baby nursery	USD	\N	Pmt	\N
50559764	A1 Telecom	2021-01-09 01:00:00+01	D	6.10	Phone bill	USD	\N	Pmt	\N
50776634	DogiZone	2021-10-17 02:00:00+02	D	32.30	Vaccination	USD	\N	Pmt	\N
51239393	Gerber Products Company	2021-12-03 01:00:00+01	D	52.40	Baby wardrobe	USD	\N	Pmt	\N
51385470	A1 Telecom	2021-09-11 02:00:00+02	D	6.20	Phone bill	USD	\N	Pmt	\N
51517103	Hooters Air	2021-03-24 01:00:00+01	D	487.30	Ticket pay	USD	\N	Pmt	\N
51637696	Electro distribution	2021-05-11 02:00:00+02	D	46.00	Utilities payment	USD	\N	Pmt	\N
51680642		2021-05-06 02:00:00+02	D	153.30	ATM withdrawal	USD	\N	Wdw	\N
51869487	Amazon	2021-10-05 02:00:00+02	D	17.40	Amazon Kindle subscription	USD	\N	Pmt	\N
49426791	Adobe	2021-02-27 01:00:00+01	D	16.70	Games	USD	5045	Pmt	90
52981902	Swimming school	2021-09-07 02:00:00+02	D	23.80	Membership	USD	\N	Pmt	\N
56653638		2021-11-20 01:00:00+01	D	134.00	ATM withdrawal	USD	\N	Wdw	L
53216135	Hulu	2021-02-26 01:00:00+01	D	10.70	Hulu subscription	USD	\N	Pmt	\N
54087134	Earnest	2021-08-04 02:00:00+02	D	6.20	Charge pay	USD	\N	Fee	\N
54301158	Connexus	2021-07-03 02:00:00+02	D	400.50	Mortgage pay	USD	\N	Pmt	\N
54381518	Pet salon Rex	2021-03-01 01:00:00+01	D	10.00	Grooming	USD	\N	Pmt	\N
54855887	Orange	2021-10-12 02:00:00+02	D	5.60	Phone bill	USD	\N	Pmt	\N
55142815	Homeowners Insurance	2021-10-10 02:00:00+02	D	45.00	Home	USD	\N	Pmt	\N
55328081	Bank of America	2021-01-16 01:00:00+01	D	4.40	ATM withdrawal fee	USD	\N	Fee	\N
55381024	Home cleaning service	2021-08-23 02:00:00+02	D	47.60	Cleaning	USD	\N	Pmt	\N
55684785	Bank of America	2021-08-08 02:00:00+02	D	12.60	Late fee	USD	\N	Fee	\N
55820285	Hulu	2021-08-07 02:00:00+02	D	8.50	Netflix subscription	USD	\N	Pmt	\N
56001337	Home cleaning service	2021-11-12 01:00:00+01	D	48.30	Cleaning	USD	\N	Pmt	\N
56190221	Home cleaning service	2021-04-04 02:00:00+02	D	50.30	Cleaning	USD	\N	Pmt	\N
56263795	Swimming school	2021-10-01 02:00:00+02	D	25.60	Club membership	USD	\N	Pmt	\N
56603162	Gerber Products Company	2021-04-14 02:00:00+02	D	54.70	Baby wardrobe	USD	\N	Pmt	\N
53262616	Glovo	2021-11-10 01:00:00+01	D	44.50	Food delivery	USD	5811	Pmt	39
57613960	Electro distribution	2021-04-18 02:00:00+02	D	54.00	Utilities payment	USD	\N	Pmt	\N
57913436		2021-04-23 02:00:00+02	D	162.00	ATM withdrawal	USD	\N	Wdw	\N
58695247	A1 Telecom	2021-06-04 02:00:00+02	D	6.20	Phone bill	USD	\N	Pmt	\N
58741126	Bank of America	2021-03-10 01:00:00+01	D	5.70	ATM withdrawal fee	USD	\N	Fee	\N
58899244	Home cleaning service	2021-04-21 02:00:00+02	D	51.00	Cleaning	USD	\N	Pmt	\N
58976045	Heating	2021-10-09 02:00:00+02	D	80.10	Utilities payment	USD	\N	Pmt	\N
59098190	Volvo service	2021-05-17 02:00:00+02	D	225.00	Regular service	USD	7538	Pmt	\N
59865534	Karate club	2021-01-15 01:00:00+01	D	22.20	Club membership	USD	\N	Pmt	\N
60014073	Karate club	2021-04-23 02:00:00+02	D	20.60	Club membership	USD	\N	Pmt	\N
60572795	Netflix	2021-07-09 02:00:00+02	D	8.70	Hulu subscription	USD	\N	Pmt	\N
60674642	Coinbase	2021-10-03 02:00:00+02	C	835.40	Project based fee	USD	\N	Dep	\N
60866991	Karate club	2021-01-25 01:00:00+01	D	29.50	Membership	USD	\N	Pmt	\N
61657063	Home cleaning service	2021-12-12 01:00:00+01	D	45.40	Cleaning	USD	\N	Pmt	\N
62184132	Home cleaning service	2021-12-01 01:00:00+01	D	47.50	Cleaning	USD	\N	Pmt	\N
62811505	Coinbase	2021-01-19 01:00:00+01	C	939.70	Project based fee	USD	\N	Dep	\N
63172972	PersonalLoans	2021-11-06 01:00:00+01	D	6.80	Charge pay	USD	\N	Fee	\N
64069956	Electro distribution	2021-08-22 02:00:00+02	D	67.70	Utilities payment	USD	\N	Pmt	\N
64853660	Visa	2021-03-19 01:00:00+01	D	83.20	Pay with Mastercard	USD	\N	Pmt	\N
64880870	PersonalLoans	2021-02-11 01:00:00+01	D	9.90	Charge pay	USD	\N	Fee	\N
65126953	Bank of America	2021-09-07 02:00:00+02	D	4.80	Online banking fee	USD	\N	Fee	\N
65253880	Legend	2021-05-23 02:00:00+02	D	230.20	Clothes	USD	\N	Pmt	\N
65566786	Hulu	2021-11-05 01:00:00+01	D	7.40	Netflix subscription	USD	\N	Pmt	\N
65818094	Home cleaning service	2021-07-22 02:00:00+02	D	50.90	Cleaning	USD	\N	Pmt	\N
65883674	Bank of America	2021-04-23 02:00:00+02	D	4.70	Revolut Silver subscription	USD	\N	Fee	\N
66371293	Bank of America	2021-07-17 02:00:00+02	D	2.70	ATM withdrawal fee	USD	\N	Fee	\N
66430374	Karate club	2021-01-12 01:00:00+01	D	24.40	Club membership	USD	\N	Pmt	\N
66775618	Home cleaning service	2021-02-05 01:00:00+01	D	50.60	Cleaning	USD	\N	Pmt	\N
67229124	Johnson & Johnson	2021-11-15 01:00:00+01	D	85.50	Baby wardrobe	USD	\N	Pmt	\N
67266572	Swimming school	2021-11-28 01:00:00+01	D	25.20	Club membership	USD	\N	Pmt	\N
67356712	Coinbase	2021-02-02 01:00:00+01	C	928.60	Project based fee	USD	\N	Dep	\N
67749582	Coinbase	2021-05-11 02:00:00+02	C	645.60	Cryptocurrency sales	USD	\N	Dep	\N
68077710	Amazon	2021-04-13 02:00:00+02	D	12.90	Book	USD	\N	Pmt	\N
68586385	Generali	2021-06-06 02:00:00+02	D	45.10	Extended health insurance	USD	\N	Pmt	\N
68771956	Home cleaning service	2021-04-03 02:00:00+02	D	49.50	Cleaning	USD	\N	Pmt	\N
68970618	Connexus	2021-11-14 01:00:00+01	D	400.80	Mortgage pay	USD	\N	Pmt	\N
69048741	Swimming school	2021-05-23 02:00:00+02	D	21.20	Membership	USD	\N	Pmt	\N
69109474	Heating	2021-03-16 01:00:00+01	D	34.00	Utilities payment	USD	\N	Pmt	\N
69296761	Visa	2021-09-22 02:00:00+02	D	66.20	Pay with Mastercard	USD	\N	Pmt	\N
69304214	Generali	2021-02-07 01:00:00+01	D	45.10	Extended health insurance	USD	\N	Pmt	\N
69495844	Gerber Products Company	2021-08-06 02:00:00+02	D	67.30	Baby nursery	USD	\N	Pmt	\N
69950535	Pet salon Rex	2021-08-28 02:00:00+02	D	10.60	Grooming	USD	\N	Pmt	\N
69960872	Heating	2021-05-24 02:00:00+02	D	83.30	Utilities payment	USD	\N	Pmt	\N
70084400	Amazon	2021-03-01 01:00:00+01	D	8.00	Amazon Kindle subscription	USD	\N	Pmt	\N
70261366	Orange	2021-02-21 01:00:00+01	D	5.00	Phone bill	USD	\N	Pmt	\N
70330922		2021-08-12 02:00:00+02	D	151.00	ATM withdrawal	USD	\N	Wdw	\N
70502723	Electro distribution	2021-09-04 02:00:00+02	D	77.60	Utilities payment	USD	\N	Pmt	\N
70572176	Home cleaning service	2021-07-12 02:00:00+02	D	45.60	Cleaning	USD	\N	Pmt	\N
70729124	Electro distribution	2021-05-22 02:00:00+02	D	91.20	Utilities payment	USD	\N	Pmt	\N
70926853	Travel house	2021-01-17 01:00:00+01	D	532.40	Vacation	USD	5962	Pmt	\N
71697862	Orange	2021-05-19 02:00:00+02	D	5.70	Phone bill	USD	\N	Pmt	\N
71773916	Generali	2021-08-16 02:00:00+02	D	45.90	Extended health insurance	USD	\N	Pmt	\N
72976201	Swimming school	2021-06-25 02:00:00+02	D	28.70	Membership	USD	\N	Pmt	\N
73218465	Visa	2021-09-01 02:00:00+02	D	33.90	Pay with Visa	USD	\N	Pmt	\N
74452868	Coinbase	2021-05-12 02:00:00+02	C	724.20	Project based fee	USD	\N	Dep	\N
74734869	Bank of America	2021-01-09 01:00:00+01	D	5.00	Revolut Silver subscription	USD	\N	Fee	\N
75182589	Bank of America	2021-02-02 01:00:00+01	D	7.60	Online banking fee	USD	\N	Fee	\N
75565411	Johnson & Johnson	2021-09-03 02:00:00+02	D	80.10	Baby nursery	USD	\N	Pmt	\N
75618674	Generali	2021-12-02 01:00:00+01	D	45.10	Extended health insurance	USD	\N	Pmt	\N
75638541	Asseco	2021-08-13 02:00:00+02	C	8132.00	Bonus deposit	USD	\N	Dep	\N
75840817	Ikea	2021-03-26 01:00:00+01	D	45.70	Appliances	USD	5712	Pmt	\N
76045991	Hulu	2021-10-17 02:00:00+02	D	9.00	Netflix subscription	USD	\N	Pmt	\N
76183746	Netflix	2021-11-19 01:00:00+01	D	9.10	Netflix subscription	USD	\N	Pmt	\N
76352744	Generali	2021-06-02 02:00:00+02	D	46.00	Extended health insurance	USD	\N	Pmt	\N
77227016	Private consulting co	2021-06-27 02:00:00+02	C	621.40	Cryptocurrency sales	USD	\N	Dep	\N
77374230	Karate club	2021-09-02 02:00:00+02	D	26.20	Membership	USD	\N	Pmt	\N
78153934	Gerber Products Company	2021-02-23 01:00:00+01	D	78.00	Baby wardrobe	USD	\N	Pmt	\N
78202162	Orange	2021-10-24 02:00:00+02	D	6.90	Phone bill	USD	\N	Pmt	\N
78660436	Generali	2021-08-05 02:00:00+02	D	45.00	Extended health insurance	USD	\N	Pmt	\N
78831329	Springfield	2021-06-06 02:00:00+02	D	276.20	Fotwear	USD	\N	Pmt	\N
79467261	MasterCard	2021-04-16 02:00:00+02	D	96.20	Pay with Mastercard	USD	\N	Pmt	\N
80168207	Generali	2021-06-07 02:00:00+02	D	45.60	Extended health insurance	USD	\N	Pmt	\N
80679455	PersonalLoans	2021-03-10 01:00:00+01	D	12.50	Charge pay	USD	\N	Fee	\N
80943502	Coinbase	2021-09-16 02:00:00+02	C	977.50	Cryptocurrency sales	USD	\N	Dep	\N
80963231	A1 Telecom	2021-06-08 02:00:00+02	D	5.70	Phone bill	USD	\N	Pmt	\N
81260772		2021-04-16 02:00:00+02	D	242.00	ATM withdrawal	USD	\N	Wdw	\N
81508787	Generali	2021-08-06 02:00:00+02	D	45.60	Extended health insurance	USD	\N	Pmt	\N
81703532	MasterCard	2021-10-15 02:00:00+02	D	83.80	Pay with Mastercard	USD	\N	Pmt	\N
81792092	PersonalLoans	2021-05-15 02:00:00+02	D	7.00	Charge pay	USD	\N	Fee	\N
82346258	Bank of America	2021-07-11 02:00:00+02	D	4.90	ATM withdrawal fee	USD	\N	Fee	\N
82378068	Bank of America	2021-05-09 02:00:00+02	D	5.00	Revolut Silver subscription	USD	\N	Fee	\N
83041035	Bank of America	2021-04-17 02:00:00+02	D	4.10	Revolut Silver subscription	USD	\N	Fee	\N
83696992	Bank of America	2021-02-28 01:00:00+01	D	6.60	Online banking fee	USD	\N	Fee	\N
83894581	A1 Telecom	2021-10-22 02:00:00+02	D	5.60	Phone bill	USD	\N	Pmt	\N
84127016	Bank of America	2021-08-19 02:00:00+02	D	4.30	Online banking fee	USD	\N	Fee	\N
84165596		2021-08-03 02:00:00+02	D	132.10	ATM withdrawal	USD	\N	Wdw	\N
84468698		2021-09-14 02:00:00+02	D	291.20	ATM withdrawal	USD	\N	Wdw	\N
84672865	Home cleaning service	2021-06-17 02:00:00+02	D	48.40	Cleaning	USD	\N	Pmt	\N
85103658		2021-06-24 02:00:00+02	D	156.30	ATM withdrawal	USD	\N	Wdw	\N
85152490	Bank of America	2021-05-06 02:00:00+02	D	7.60	Online banking fee	USD	\N	Fee	\N
85289908	Bank of America	2021-08-18 02:00:00+02	D	6.80	Revolut Silver subscription	USD	\N	Fee	\N
85329257	Home cleaning service	2021-04-01 02:00:00+02	D	45.80	Cleaning	USD	\N	Pmt	\N
86045078	Johnson & Johnson	2021-11-28 01:00:00+01	D	81.00	Baby nursery	USD	\N	Pmt	\N
85609414	Adobe	2021-03-17 01:00:00+01	D	19.50	Games	USD	5045	Pmt	90
86175280	Earnest	2021-03-08 01:00:00+01	D	6.70	Charge pay	USD	\N	Fee	\N
86781380	Amazon	2021-04-11 02:00:00+02	D	13.70	Book	USD	\N	Pmt	\N
87415014	Bank of America	2021-11-24 01:00:00+01	D	5.80	ATM withdrawal fee	USD	\N	Fee	\N
87551784	Swimming school	2021-11-15 01:00:00+01	D	25.90	Club membership	USD	\N	Pmt	\N
88132422	Connexus	2021-04-06 02:00:00+02	D	400.60	Mortgage pay	USD	\N	Pmt	\N
88422634	Generali	2021-07-13 02:00:00+02	D	45.60	Extended health insurance	USD	\N	Pmt	\N
88805298	Gerber Products Company	2021-09-23 02:00:00+02	D	101.00	Baby wardrobe	USD	\N	Pmt	\N
89434996	Karate club	2021-08-12 02:00:00+02	D	27.20	Membership	USD	\N	Pmt	\N
89554504	Swimming school	2021-02-13 01:00:00+01	D	20.40	Membership	USD	\N	Pmt	\N
89936274	Bank of America	2021-02-22 01:00:00+01	D	4.70	Revolut Silver subscription	USD	\N	Fee	\N
10248426	Jill	2021-11-18 01:00:00+01	D	48.70	Allowance	USD	\N	Pmt	A
10047525	Tele9	2021-07-13 02:00:00+02	D	18.10	Television bill	USD	\N	Pmt	12
10058284	Orange	2021-08-16 02:00:00+02	D	24.50	Internet bill	USD	\N	Pmt	10
10124603	Comcast	2021-06-26 02:00:00+02	D	15.70	Television bill	USD	\N	Pmt	12
10166729	Pet hotel Happy Dog	2021-04-21 02:00:00+02	D	100.60	Monthly stay	USD	5995	Pmt	84
10326647	Jill	2021-11-16 01:00:00+01	D	50.50	Allowance	USD	\N	Pmt	67
10364820	The barbers	2021-08-19 02:00:00+02	D	22.70	Haircut	USD	7230	Pmt	80
10421646	City parkings	2021-05-05 02:00:00+02	D	2.80	Parking fee	USD	7523	Pmt	5
10448202	Fit and Fun	2021-08-08 02:00:00+02	D	20.50	Gym membership	USD	\N	Pmt	47
10549898	Delhaize	2021-09-28 02:00:00+02	D	94.70	Supermaket shopping	USD	5200	Pmt	56
10566088	UniCredit Leasing	2021-03-21 01:00:00+01	D	450.00	Financial leasing	USD	7394	Pmt	3
10569953	Wolt	2021-10-05 02:00:00+02	D	43.10	Food delivery	USD	5811	Pmt	39
10578334	Glovo	2021-08-24 02:00:00+02	D	15.00	Food delivery	USD	5811	Pmt	39
10700110	Delhaize	2021-03-18 01:00:00+01	D	39.80	Supermaket shopping	USD	5499	Pmt	38
11008302	Red Cross	2021-02-16 01:00:00+01	D	52.10	Charity	USD	\N	Pmt	41
11100097	Lidl	2021-07-12 02:00:00+02	D	73.30	Supermaket shopping	USD	5200	Pmt	56
11138313	Glovo	2021-05-19 02:00:00+02	D	36.90	Food delivery	USD	5811	Pmt	39
11219573	Glovo	2021-04-05 02:00:00+02	D	17.20	Food delivery	USD	5811	Pmt	39
11265683	Apple	2021-05-04 02:00:00+02	D	15.10	Spotify premium subscription	USD	5733	Pmt	22
11316805	Glovo	2021-07-17 02:00:00+02	D	46.90	Food delivery	USD	5811	Pmt	39
11329310	Wolt	2021-02-03 01:00:00+01	D	27.40	Food delivery	USD	5811	Pmt	39
11405257	Shell	2021-01-16 01:00:00+01	D	45.40	Gasoline purchases	USD	5983	Pmt	4
11522708	Glovo	2021-12-06 01:00:00+01	D	44.60	Food delivery	USD	5811	Pmt	39
11537344	Wolt	2021-05-18 02:00:00+02	D	29.20	Food delivery	USD	5811	Pmt	39
11544899	Swimming pool Activa	2021-06-28 02:00:00+02	D	15.80	Table tennis 2 hrs	USD	5655	Pmt	50
11778002	Glovo	2021-05-19 02:00:00+02	D	45.20	Food delivery	USD	5811	Pmt	39
11951369	Serenity Wellnes	2021-02-27 01:00:00+01	D	25.40	Spa treatment	USD	8050	Pmt	82
12029899	Fit and Fun	2021-08-22 02:00:00+02	D	24.60	Personal trainer	USD	\N	Pmt	47
12052308	Orange	2021-11-03 01:00:00+01	D	20.10	Internet bill	USD	\N	Pmt	10
12088253	Hertz	2021-03-06 01:00:00+01	D	14.50	Taxi	USD	7519	Pmt	105
12175584	Lidl	2021-04-07 02:00:00+02	D	30.40	Supermaket shopping	USD	5499	Pmt	38
12211755	Asseco	2021-04-03 02:00:00+02	C	2313.30	Salary	USD	\N	Sal	62
12341904	A1 Telecom	2021-09-05 02:00:00+02	D	27.60	Internet bill	USD	\N	Pmt	10
12391398	Lidl	2021-12-19 01:00:00+01	D	99.80	Supermaket shopping	USD	5200	Pmt	56
12438945	Save our kids	2021-04-05 02:00:00+02	D	52.00	Charity	USD	\N	Pmt	41
12729613	Pet shop	2021-04-07 02:00:00+02	D	23.80	Shopping	USD	5995	Pmt	84
12781189	Wolt	2021-07-09 02:00:00+02	D	41.60	Food delivery	USD	5811	Pmt	39
12787056	Wolt	2021-06-23 02:00:00+02	D	42.00	Food delivery	USD	5811	Pmt	39
12863727	A1 Telecom	2021-02-20 01:00:00+01	D	29.30	Internet bill	USD	\N	Pmt	10
12887873	Glovo	2021-04-24 02:00:00+02	D	16.10	Food delivery	USD	5811	Pmt	39
12912239	The barbers	2021-10-23 02:00:00+02	D	35.00	Haircut	USD	7230	Pmt	80
13043638	Glovo	2021-07-28 02:00:00+02	D	42.20	Food delivery	USD	5811	Pmt	39
13142380	Faculty of contemporary arts	2021-05-26 02:00:00+02	D	164.60	Tuition	USD	8299	Pmt	17
13288456	Lidl	2021-06-26 02:00:00+02	D	35.50	Supermaket shopping	USD	5499	Pmt	38
13309495	Glovo	2021-09-20 02:00:00+02	D	28.50	Food delivery	USD	5811	Pmt	39
13417221	Jill	2021-06-22 02:00:00+02	D	38.90	Allowance	USD	\N	Pmt	67
13428868	Glovo	2021-06-05 02:00:00+02	D	32.10	Food delivery	USD	5811	Pmt	39
13485416	Delhaize	2021-11-23 01:00:00+01	D	33.00	Supermaket shopping	USD	5499	Pmt	38
13609418	Lidl	2021-02-11 01:00:00+01	D	40.70	Supermaket shopping	USD	5499	Pmt	38
13662479	Wolt	2021-08-03 02:00:00+02	D	38.60	Food delivery	USD	5811	Pmt	39
13776086	Glovo	2021-09-11 02:00:00+02	D	51.00	Food delivery	USD	5811	Pmt	39
13787142	T-Mobile	2021-07-22 02:00:00+02	D	13.60	Mobile phone bill	USD	\N	Pmt	11
13793179	Lidl	2021-01-10 01:00:00+01	D	31.70	Supermaket shopping	USD	5499	Pmt	38
13907913	Delhaize	2021-09-08 02:00:00+02	D	81.30	Supermaket shopping	USD	5200	Pmt	56
13921480	T-Mobile	2021-01-23 01:00:00+01	D	20.40	Mobile phone bill	USD	\N	Pmt	11
14027691	Glovo	2021-06-19 02:00:00+02	D	24.30	Food delivery	USD	5811	Pmt	39
14181379	Wolt	2021-09-24 02:00:00+02	D	23.40	Food delivery	USD	5811	Pmt	39
14191784	Jill	2021-03-26 01:00:00+01	D	36.20	Allowance	USD	\N	Pmt	67
14241748	Wolt	2021-06-02 02:00:00+02	D	50.60	Food delivery	USD	5811	Pmt	39
14464698	Delhaize	2021-06-23 02:00:00+02	D	36.90	Supermaket shopping	USD	5499	Pmt	38
14652043	Serenity Wellnes	2021-04-16 02:00:00+02	D	21.90	Massage	USD	8050	Pmt	82
14747494	Glovo	2021-01-12 01:00:00+01	D	18.80	Food delivery	USD	5811	Pmt	39
14831330	A1 Telecom	2021-10-15 02:00:00+02	D	34.70	Internet bill	USD	\N	Pmt	10
14946456	Lidl	2021-09-10 02:00:00+02	D	33.70	Supermaket shopping	USD	5499	Pmt	38
15073047	Medigroup	2021-07-13 02:00:00+02	D	57.40	Specialist	USD	8011	Pmt	45
15122088	Glovo	2021-01-01 01:00:00+01	D	44.30	Food delivery	USD	5811	Pmt	39
15179953	T-Mobile	2021-10-02 02:00:00+02	D	14.80	Mobile phone bill	USD	\N	Pmt	11
15187916	The barbers	2021-12-11 01:00:00+01	D	25.30	Haircut	USD	7230	Pmt	80
15200726	Wolt	2021-02-10 01:00:00+01	D	50.00	Food delivery	USD	5811	Pmt	39
15233362	Hertz	2021-04-08 02:00:00+02	D	11.80	Taxi	USD	7519	Pmt	105
15267535	Glovo	2021-12-08 01:00:00+01	D	36.60	Food delivery	USD	5811	Pmt	39
15372512	Fit and Fun	2021-02-02 01:00:00+01	D	29.50	Personal trainer	USD	\N	Pmt	47
15387438	Delhaize	2021-04-20 02:00:00+02	D	37.70	Supermaket shopping	USD	5499	Pmt	38
15553657	Wolt	2021-09-23 02:00:00+02	D	19.20	Food delivery	USD	5811	Pmt	39
15590012	Pet hotel Happy Dog	2021-05-22 02:00:00+02	D	100.30	Monthly stay	USD	5995	Pmt	84
15668675	Wolt	2021-07-26 02:00:00+02	D	48.10	Food delivery	USD	5811	Pmt	39
15721708	Music school	2021-10-09 02:00:00+02	D	176.30	Tuition	USD	8299	Pmt	17
15739146	Wolt	2021-07-21 02:00:00+02	D	50.70	Food delivery	USD	5811	Pmt	39
15799125	Pet store	2021-10-10 02:00:00+02	D	22.00	Shopping	USD	5995	Pmt	84
15830107	Book depository	2021-10-23 02:00:00+02	D	11.50	Book	USD	\N	Pmt	15
15877780	Glovo	2021-05-25 02:00:00+02	D	33.80	Food delivery	USD	5811	Pmt	39
15879337	Glovo	2021-07-05 02:00:00+02	D	43.40	Food delivery	USD	5811	Pmt	39
15986259	Tele9	2021-10-15 02:00:00+02	D	14.50	Television bill	USD	\N	Pmt	12
16012190	Wolt	2021-11-07 01:00:00+01	D	40.30	Food delivery	USD	5811	Pmt	39
16022872	Pet hotel Happy Dog	2021-01-28 01:00:00+01	D	100.80	Monthly stay	USD	5995	Pmt	84
16041598	Glovo	2021-11-27 01:00:00+01	D	31.10	Food delivery	USD	5811	Pmt	39
16071863	Lidl	2021-11-26 01:00:00+01	D	33.70	Supermaket shopping	USD	5499	Pmt	38
16158965	Lily	2021-04-12 02:00:00+02	D	38.70	Medicine	USD	5912	Pmt	49
16166338	Glovo	2021-03-01 01:00:00+01	D	34.80	Food delivery	USD	5811	Pmt	39
16228661	Hertz	2021-04-16 02:00:00+02	D	10.20	Car rent	USD	7519	Pmt	105
16317033	Glovo	2021-03-14 01:00:00+01	D	31.20	Food delivery	USD	5811	Pmt	39
16365278	Glovo	2021-05-18 02:00:00+02	D	20.30	Food delivery	USD	5811	Pmt	39
16410046	Protetcta	2021-10-12 02:00:00+02	D	27.50	Doctor's appointment	USD	8011	Pmt	45
16419247	Lidl	2021-01-07 01:00:00+01	D	33.10	Supermaket shopping	USD	5499	Pmt	38
16431877	New York Times	2021-07-22 02:00:00+02	D	4.90	New York Times	USD	5192	Pmt	88
16530178	Lidl	2021-04-01 02:00:00+02	D	34.30	Supermaket shopping	USD	5499	Pmt	38
16642307	MetLife	2021-04-17 02:00:00+02	D	201.00	Life insurance premium	USD	6300	Pmt	33
16725691	Fit and Fun	2021-05-26 02:00:00+02	D	24.30	Gym membership	USD	\N	Pmt	47
16816038	Josh	2021-10-27 02:00:00+02	D	39.20	Allowance	USD	\N	Pmt	67
16932601	Medilife	2021-02-20 01:00:00+01	D	42.80	General Practitioner	USD	8011	Pmt	45
17039506	Glovo	2021-05-04 02:00:00+02	D	15.50	Food delivery	USD	5811	Pmt	39
17210563	Wolt	2021-11-13 01:00:00+01	D	27.10	Food delivery	USD	5811	Pmt	39
17255605	Delhaize	2021-04-23 02:00:00+02	D	90.20	Supermaket shopping	USD	5200	Pmt	56
17281392	Wolt	2021-02-18 01:00:00+01	D	43.60	Food delivery	USD	5811	Pmt	39
17360272	New York Times	2021-10-23 02:00:00+02	D	5.20	National Geographic	USD	5192	Pmt	88
17444905	Glovo	2021-04-23 02:00:00+02	D	18.70	Food delivery	USD	5811	Pmt	39
17453807	Pet shop	2021-08-16 02:00:00+02	D	21.60	Shopping	USD	5995	Pmt	84
17498427	Spotify	2021-02-09 01:00:00+01	D	16.00	Apple music subscription	USD	5733	Pmt	22
17563885	Orange	2021-07-21 02:00:00+02	D	34.70	Internet bill	USD	\N	Pmt	10
17574037	Glovo	2021-06-28 02:00:00+02	D	29.70	Food delivery	USD	5811	Pmt	39
17603597	Blue moon spa	2021-09-07 02:00:00+02	D	21.60	Spa treatment	USD	8050	Pmt	82
17750470	Office365	2021-04-17 02:00:00+02	D	19.00	TV	USD	5045	Pmt	90
17757610	Serenity Wellnes	2021-08-17 02:00:00+02	D	23.00	Massage	USD	8050	Pmt	82
17871871	Delhaize	2021-03-22 01:00:00+01	D	34.00	Supermaket shopping	USD	5499	Pmt	38
17927225	Wolt	2021-02-04 01:00:00+01	D	49.80	Food delivery	USD	5811	Pmt	39
18052882	A1 Telecom	2021-09-03 02:00:00+02	D	17.10	Mobile phone bill	USD	\N	Pmt	11
18068621	Delhaize	2021-11-20 01:00:00+01	D	33.90	Supermaket shopping	USD	5499	Pmt	38
18103482	Table tenis club PingPong	2021-08-26 02:00:00+02	D	12.10	Table tennis 2 hrs	USD	5655	Pmt	50
18112493	T-Mobile	2021-06-26 02:00:00+02	D	16.00	Mobile phone bill	USD	\N	Pmt	11
18122741	City parkings	2021-02-23 01:00:00+01	D	2.00	Parking fee	USD	7523	Pmt	5
18310268	Wolt	2021-09-11 02:00:00+02	D	23.10	Food delivery	USD	5811	Pmt	39
18628174	Blue moon spa	2021-04-27 02:00:00+02	D	21.50	Spa treatment	USD	8050	Pmt	82
18644716	Raiffeisen Leasing	2021-10-07 02:00:00+02	D	450.10	Financial leasing	USD	7394	Pmt	3
18794635	T-Mobile	2021-09-07 02:00:00+02	D	16.90	Mobile phone bill	USD	\N	Pmt	11
18846955	A1 Telecom	2021-04-20 02:00:00+02	D	12.50	Mobile phone bill	USD	\N	Pmt	11
18912877	Lidl	2021-02-24 01:00:00+01	D	89.50	Supermaket shopping	USD	5200	Pmt	56
18928786	Wolt	2021-07-10 02:00:00+02	D	21.20	Food delivery	USD	5811	Pmt	39
19088602	Delhaize	2021-01-03 01:00:00+01	D	33.50	Supermaket shopping	USD	5499	Pmt	38
19243824	Lily	2021-11-23 01:00:00+01	D	30.70	Medicine	USD	5912	Pmt	49
19306119	Fit and Fun	2021-01-14 01:00:00+01	D	24.40	Personal trainer	USD	\N	Pmt	47
19616194	Orange	2021-10-07 02:00:00+02	D	21.80	Internet bill	USD	\N	Pmt	10
19636514	Red Cross	2021-11-14 01:00:00+01	D	99.70	Charity	USD	\N	Pmt	41
19776028	Wolt	2021-07-21 02:00:00+02	D	34.60	Food delivery	USD	5811	Pmt	39
19847714	Tele9	2021-11-19 01:00:00+01	D	18.60	Television bill	USD	\N	Pmt	12
20078149	Wolt	2021-12-05 01:00:00+01	D	28.30	Food delivery	USD	5811	Pmt	39
20119018	Pet hotel Happy Dog	2021-09-11 02:00:00+02	D	100.10	Monthly stay	USD	5995	Pmt	84
20133283	Wolt	2021-09-08 02:00:00+02	D	47.00	Food delivery	USD	5811	Pmt	39
20249039	Gift shop	2021-12-28 01:00:00+01	D	108.90	Birthday gifts	USD	5947	Pmt	42
20563202	Shell	2021-07-20 02:00:00+02	D	72.90	Gasoline purchases	USD	5983	Pmt	4
20670750	Revolut	2021-01-10 01:00:00+01	D	3.30	Revolut Silver subscription	USD	\N	Fee	25
20743203	Wolt	2021-05-11 02:00:00+02	D	46.30	Food delivery	USD	5811	Pmt	39
20753352	Asseco	2021-04-13 02:00:00+02	C	2497.10	Salary	USD	\N	Sal	62
21267660	Wolt	2021-05-27 02:00:00+02	D	45.80	Food delivery	USD	5811	Pmt	39
21392130	Glovo	2021-10-23 02:00:00+02	D	43.30	Food delivery	USD	5811	Pmt	39
21409960	Wolt	2021-08-26 02:00:00+02	D	42.10	Food delivery	USD	5811	Pmt	39
21538025	Chevron	2021-10-19 02:00:00+02	D	43.40	Gasoline purchases	USD	5983	Pmt	4
21579385	Glovo	2021-12-02 01:00:00+01	D	44.70	Food delivery	USD	5811	Pmt	39
21806306	Wolt	2021-12-01 01:00:00+01	D	20.70	Food delivery	USD	5811	Pmt	39
21856282	Revolut	2021-12-09 01:00:00+01	D	3.90	ATM withdrawal fee	USD	\N	Fee	25
21951934	Glovo	2021-03-05 01:00:00+01	D	42.90	Food delivery	USD	5811	Pmt	39
22149999	Gift Voucher	2021-04-18 02:00:00+02	D	171.70	Birthday gifts	USD	5947	Pmt	42
22253331	Faculty of contemporary arts	2021-03-01 01:00:00+01	D	196.70	Tuition	USD	8299	Pmt	17
22308911	Barber shop	2021-08-14 02:00:00+02	D	29.60	Haircut	USD	7230	Pmt	80
22914665	National Geographic	2021-09-15 02:00:00+02	D	5.80	New York Times	USD	5192	Pmt	88
22968080	National Geographic	2021-03-01 01:00:00+01	D	4.20	New York Times	USD	5192	Pmt	88
23492626	Glovo	2021-05-25 02:00:00+02	D	33.60	Food delivery	USD	5811	Pmt	39
23499396	Delhaize	2021-08-10 02:00:00+02	D	41.00	Supermaket shopping	USD	5499	Pmt	38
23629944	Claire Stevens	2021-02-05 01:00:00+01	C	300.80	Monthly rent	USD	\N	Dep	58
23654702	Delhaize	2021-09-26 02:00:00+02	D	33.80	Supermaket shopping	USD	5499	Pmt	38
23687436	Glovo	2021-09-15 02:00:00+02	D	49.70	Food delivery	USD	5811	Pmt	39
23692934	Wolt	2021-01-21 01:00:00+01	D	27.40	Food delivery	USD	5811	Pmt	39
24004723	Wolt	2021-04-14 02:00:00+02	D	42.70	Food delivery	USD	5811	Pmt	39
24380867	Pet hotel Happy Dog	2021-02-14 01:00:00+01	D	100.50	Monthly stay	USD	5995	Pmt	84
24415144	Wells Fargo	2021-01-22 01:00:00+01	D	64.10	Loan Payment	USD	\N	Pmt	77
24419286	Claire Stevens	2021-01-01 01:00:00+01	C	300.10	Monthly rent	USD	\N	Dep	58
24529138	Glovo	2021-06-11 02:00:00+02	D	49.30	Food delivery	USD	5811	Pmt	39
24623757	Glovo	2021-12-09 01:00:00+01	D	43.50	Food delivery	USD	5811	Pmt	39
24636611	Jill	2021-10-19 02:00:00+02	D	41.40	Allowance	USD	\N	Pmt	67
24743691	Revolut	2021-09-07 02:00:00+02	D	5.90	Online banking fee	USD	\N	Fee	25
25051010	Glovo	2021-10-18 02:00:00+02	D	41.30	Food delivery	USD	5811	Pmt	39
25127761	Glovo	2021-08-12 02:00:00+02	D	46.20	Food delivery	USD	5811	Pmt	39
25128541	MetLife	2021-03-02 01:00:00+01	D	200.50	Life insurance premium	USD	6300	Pmt	33
25182041	Wolt	2021-01-09 01:00:00+01	D	24.50	Food delivery	USD	5811	Pmt	39
25211120	Glovo	2021-06-03 02:00:00+02	D	20.40	Food delivery	USD	5811	Pmt	39
25268458	City parkings	2021-12-21 01:00:00+01	D	2.50	Parking fee	USD	7523	Pmt	5
25319112	New York Times	2021-04-18 02:00:00+02	D	5.50	New York Times	USD	5192	Pmt	88
25561285	Fit and Fun	2021-01-16 01:00:00+01	D	24.40	Gym membership	USD	\N	Pmt	47
25577580	Book depository	2021-02-17 01:00:00+01	D	14.70	Amazon Kindle subscription	USD	\N	Pmt	15
25644337	Jill	2021-11-10 01:00:00+01	D	31.80	Allowance	USD	\N	Pmt	67
25666040	A1 Telecom	2021-08-28 02:00:00+02	D	17.20	Mobile phone bill	USD	\N	Pmt	11
25670793	New York Times	2021-10-13 02:00:00+02	D	3.60	New York Times	USD	5192	Pmt	88
25728595	Lidl	2021-02-11 01:00:00+01	D	35.60	Supermaket shopping	USD	5499	Pmt	38
25776549	Table tenis club PingPong	2021-11-09 01:00:00+01	D	15.30	Daily pool ticket	USD	5655	Pmt	50
25814966	Amazon	2021-02-18 01:00:00+01	D	20.60	Science fiction	USD	5192	Pmt	88
25869612	Hertz	2021-05-02 02:00:00+02	D	13.10	Taxi	USD	7519	Pmt	105
25943368	Chevron	2021-11-03 01:00:00+01	D	77.10	Gasoline purchases	USD	5983	Pmt	4
26037089	Comcast	2021-09-06 02:00:00+02	D	11.80	Television bill	USD	\N	Pmt	12
26151806	T-Mobile	2021-08-02 02:00:00+02	D	15.80	Mobile phone bill	USD	\N	Pmt	11
26260247	Music school	2021-06-02 02:00:00+02	D	187.40	Tuition	USD	8299	Pmt	17
26373541	Wolt	2021-11-13 01:00:00+01	D	34.80	Food delivery	USD	5811	Pmt	39
26383748	Book depository	2021-12-06 01:00:00+01	D	17.20	Book	USD	\N	Pmt	15
26402275	Raiffeisen Leasing	2021-03-19 01:00:00+01	D	451.00	Financial leasing	USD	7394	Pmt	3
26599175	The barbers	2021-11-05 01:00:00+01	D	27.10	Haircut	USD	7230	Pmt	80
26744744	Lidl	2021-01-09 01:00:00+01	D	33.90	Supermaket shopping	USD	5499	Pmt	38
26768209	Blue moon spa	2021-04-02 02:00:00+02	D	22.30	Massage	USD	8050	Pmt	82
26836710	Glovo	2021-04-08 02:00:00+02	D	15.90	Food delivery	USD	5811	Pmt	39
26901838	Revolut	2021-04-17 02:00:00+02	D	5.60	ATM withdrawal fee	USD	\N	Fee	25
26973873	Glovo	2021-11-26 01:00:00+01	D	48.90	Food delivery	USD	5811	Pmt	39
27026831	Faculty of contemporary arts	2021-04-08 02:00:00+02	D	181.60	Tuition	USD	8299	Pmt	17
27035641	Glovo	2021-11-23 01:00:00+01	D	19.20	Food delivery	USD	5811	Pmt	39
27088707	Claire Stevens	2021-02-20 01:00:00+01	C	300.80	Monthly rent	USD	\N	Dep	58
27105360	Lily	2021-09-02 02:00:00+02	D	33.50	Medicine	USD	5912	Pmt	49
27120629	Protetcta	2021-07-27 02:00:00+02	D	26.20	Doctor's appointment	USD	8011	Pmt	45
27148066	Comcast	2021-02-03 01:00:00+01	D	11.30	Television bill	USD	\N	Pmt	12
27156890	Wolt	2021-03-26 01:00:00+01	D	41.50	Food delivery	USD	5811	Pmt	39
27315864	Hertz	2021-07-16 02:00:00+02	D	10.60	Car rent	USD	7519	Pmt	105
27329787	Glovo	2021-09-21 02:00:00+02	D	49.10	Food delivery	USD	5811	Pmt	39
27739718	Office365	2021-11-21 01:00:00+01	D	17.10	TV	USD	5045	Pmt	90
27801747	Lidl	2021-05-16 02:00:00+02	D	30.10	Supermaket shopping	USD	5499	Pmt	38
27849453	Tele9	2021-02-02 01:00:00+01	D	11.60	Television bill	USD	\N	Pmt	12
27881938	Lidl	2021-05-08 02:00:00+02	D	40.10	Supermaket shopping	USD	5499	Pmt	38
27921598	Delhaize	2021-04-11 02:00:00+02	D	82.00	Supermaket shopping	USD	5200	Pmt	56
27969440	Swimming pool Activa	2021-02-26 01:00:00+01	D	10.40	Daily pool ticket	USD	5655	Pmt	50
27976815	Fit and Fun	2021-04-18 02:00:00+02	D	25.80	Gym membership	USD	\N	Pmt	47
28133657	Lidl	2021-04-08 02:00:00+02	D	93.30	Supermaket shopping	USD	5200	Pmt	56
28199360	Shell	2021-07-20 02:00:00+02	D	54.30	Gasoline purchases	USD	5983	Pmt	4
28237996	Delhaize	2021-08-06 02:00:00+02	D	34.80	Supermaket shopping	USD	5499	Pmt	38
28438926	Revolut	2021-09-17 02:00:00+02	D	3.70	Revolut Silver subscription	USD	\N	Fee	25
28506860	A1 Telecom	2021-01-25 01:00:00+01	D	12.40	Mobile phone bill	USD	\N	Pmt	11
28533093	Delhaize	2021-08-09 02:00:00+02	D	30.60	Supermaket shopping	USD	5499	Pmt	38
28591000	Glovo	2021-08-01 02:00:00+02	D	43.40	Food delivery	USD	5811	Pmt	39
28632888	Delhaize	2021-08-07 02:00:00+02	D	33.10	Supermaket shopping	USD	5499	Pmt	38
28647896	Wolt	2021-06-21 02:00:00+02	D	42.80	Food delivery	USD	5811	Pmt	39
28670410	Wolt	2021-01-06 01:00:00+01	D	48.40	Food delivery	USD	5811	Pmt	39
28679831	Wolt	2021-10-26 02:00:00+02	D	15.10	Food delivery	USD	5811	Pmt	39
28718229	Glovo	2021-09-27 02:00:00+02	D	32.60	Food delivery	USD	5811	Pmt	39
28749057	Wolt	2021-05-02 02:00:00+02	D	32.10	Food delivery	USD	5811	Pmt	39
28801699	Table tenis club PingPong	2021-10-06 02:00:00+02	D	10.60	Table tennis 2 hrs	USD	5655	Pmt	50
28813980	Glovo	2021-01-18 01:00:00+01	D	38.00	Food delivery	USD	5811	Pmt	39
28962498	Glovo	2021-02-27 01:00:00+01	D	32.40	Food delivery	USD	5811	Pmt	39
28976696	Wolt	2021-12-13 01:00:00+01	D	50.60	Food delivery	USD	5811	Pmt	39
29025706	Lidl	2021-06-08 02:00:00+02	D	34.70	Supermaket shopping	USD	5499	Pmt	38
29043681	Glovo	2021-11-10 01:00:00+01	D	23.10	Food delivery	USD	5811	Pmt	39
29176780	Glovo	2021-01-18 01:00:00+01	D	50.00	Food delivery	USD	5811	Pmt	39
29252863	Sixt GmbH	2021-05-23 02:00:00+02	D	10.00	Car rent	USD	7519	Pmt	105
29290813	Book depository	2021-07-21 02:00:00+02	D	19.70	Amazon Kindle subscription	USD	\N	Pmt	15
29322322	Chase	2021-01-24 01:00:00+01	D	400.40	Rent pay	USD	\N	Pmt	58
29382356	Lidl	2021-03-13 01:00:00+01	D	34.90	Supermaket shopping	USD	5499	Pmt	38
29414113	Lidl	2021-07-26 02:00:00+02	D	88.50	Supermaket shopping	USD	5200	Pmt	56
29420070	Wolt	2021-01-20 01:00:00+01	D	43.70	Food delivery	USD	5811	Pmt	39
29796533	T-Mobile	2021-08-21 02:00:00+02	D	13.20	Mobile phone bill	USD	\N	Pmt	11
29842914	Glovo	2021-07-23 02:00:00+02	D	31.90	Food delivery	USD	5811	Pmt	39
29906504	Red Cross	2021-06-18 02:00:00+02	D	66.30	Charity	USD	\N	Pmt	41
30005272	A1 Telecom	2021-09-18 02:00:00+02	D	18.40	Mobile phone bill	USD	\N	Pmt	11
30143305	Wolt	2021-08-15 02:00:00+02	D	47.20	Food delivery	USD	5811	Pmt	39
30284301	Wolt	2021-01-17 01:00:00+01	D	23.60	Food delivery	USD	5811	Pmt	39
30302164	T-Mobile	2021-10-16 02:00:00+02	D	14.20	Mobile phone bill	USD	\N	Pmt	11
30446210	A1 Telecom	2021-08-21 02:00:00+02	D	19.10	Mobile phone bill	USD	\N	Pmt	11
30467833	Wolt	2021-03-08 01:00:00+01	D	37.50	Food delivery	USD	5811	Pmt	39
30512270	Wolt	2021-08-04 02:00:00+02	D	36.20	Food delivery	USD	5811	Pmt	39
30567845	Table tenis club PingPong	2021-06-11 02:00:00+02	D	15.70	Table tennis 2 hrs	USD	5655	Pmt	50
30770768	Glovo	2021-07-03 02:00:00+02	D	17.80	Food delivery	USD	5811	Pmt	39
30780970	City parkings	2021-11-10 01:00:00+01	D	1.90	Parking fee	USD	7523	Pmt	5
30790257	Wolt	2021-03-15 01:00:00+01	D	18.40	Food delivery	USD	5811	Pmt	39
30829925	Glovo	2021-09-07 02:00:00+02	D	40.50	Food delivery	USD	5811	Pmt	39
30997470	Faculty of contemporary arts	2021-12-19 01:00:00+01	D	181.00	Tuition	USD	8299	Pmt	17
31153688	Glovo	2021-02-07 01:00:00+01	D	33.30	Food delivery	USD	5811	Pmt	39
31454690	Glovo	2021-10-01 02:00:00+02	D	17.00	Food delivery	USD	5811	Pmt	39
31456783	Delhaize	2021-08-02 02:00:00+02	D	35.00	Supermaket shopping	USD	5499	Pmt	38
31488575	Wolt	2021-07-08 02:00:00+02	D	16.70	Food delivery	USD	5811	Pmt	39
31560846	Wolt	2021-02-11 01:00:00+01	D	24.30	Food delivery	USD	5811	Pmt	39
31571587	Delhaize	2021-03-27 01:00:00+01	D	37.70	Supermaket shopping	USD	5499	Pmt	38
31635942	Adobe	2021-12-16 01:00:00+01	D	11.20	Games	USD	5045	Pmt	90
31662178	Glovo	2021-12-15 01:00:00+01	D	26.70	Food delivery	USD	5811	Pmt	39
31677312	Lidl	2021-03-19 01:00:00+01	D	33.50	Supermaket shopping	USD	5499	Pmt	38
31849343	Delhaize	2021-05-16 02:00:00+02	D	83.90	Supermaket shopping	USD	5200	Pmt	56
31859291	Lidl	2021-06-24 02:00:00+02	D	83.80	Supermaket shopping	USD	5200	Pmt	56
31930196	Claire Stevens	2021-01-06 01:00:00+01	C	300.10	Monthly rent	USD	\N	Dep	58
31952674	Josh	2021-01-01 01:00:00+01	D	35.10	Allowance	USD	\N	Pmt	67
32080328	Wolt	2021-04-15 02:00:00+02	D	33.80	Food delivery	USD	5811	Pmt	39
32085157	Blue moon spa	2021-07-21 02:00:00+02	D	20.30	Spa treatment	USD	8050	Pmt	82
32085229	Music school	2021-01-26 01:00:00+01	D	169.90	Tuition	USD	8299	Pmt	17
32135981	Wolt	2021-05-21 02:00:00+02	D	44.40	Food delivery	USD	5811	Pmt	39
32192649	Glovo	2021-02-16 01:00:00+01	D	26.20	Food delivery	USD	5811	Pmt	39
32283888	Glovo	2021-12-21 01:00:00+01	D	23.80	Food delivery	USD	5811	Pmt	39
32446632	Wolt	2021-06-07 02:00:00+02	D	24.30	Food delivery	USD	5811	Pmt	39
32462400	Wolt	2021-03-27 01:00:00+01	D	39.40	Food delivery	USD	5811	Pmt	39
32475545	Delhaize	2021-05-16 02:00:00+02	D	39.90	Supermaket shopping	USD	5499	Pmt	38
32481620	Save our kids	2021-08-19 02:00:00+02	D	78.30	Charity	USD	\N	Pmt	41
32663461	Wolt	2021-03-10 01:00:00+01	D	22.50	Food delivery	USD	5811	Pmt	39
32815199	Glovo	2021-06-06 02:00:00+02	D	49.80	Food delivery	USD	5811	Pmt	39
32891413	City parkings	2021-09-19 02:00:00+02	D	1.30	Parking fee	USD	7523	Pmt	5
32909323	Lending Club	2021-05-07 02:00:00+02	D	64.00	Loan Payment	USD	\N	Pmt	77
32955143	Tax company	2021-02-04 01:00:00+01	D	2315.00	Tax pay	USD	9311	Pmt	96
32995890	Glovo	2021-03-25 01:00:00+01	D	40.10	Food delivery	USD	5811	Pmt	39
33000832	Revolut	2021-04-15 02:00:00+02	D	5.30	ATM withdrawal fee	USD	\N	Fee	25
33062101	Lidl	2021-01-13 01:00:00+01	D	37.10	Supermaket shopping	USD	5499	Pmt	38
33092630	Red Cross	2021-12-12 01:00:00+01	D	48.90	Charity	USD	\N	Pmt	41
33288207	A1 Telecom	2021-05-05 02:00:00+02	D	29.50	Internet bill	USD	\N	Pmt	10
33401399	Adobe	2021-12-28 01:00:00+01	D	12.60	TV	USD	5045	Pmt	90
33505815	A1 Telecom	2021-10-22 02:00:00+02	D	24.70	Internet bill	USD	\N	Pmt	10
33623005	Glovo	2021-11-22 01:00:00+01	D	37.40	Food delivery	USD	5811	Pmt	39
34041787	Connexus	2021-10-09 02:00:00+02	D	400.10	Rent pay	USD	\N	Pmt	58
34131085	Glovo	2021-02-08 01:00:00+01	D	41.70	Food delivery	USD	5811	Pmt	39
34250943	City parkings	2021-06-10 02:00:00+02	D	1.40	Parking fee	USD	7523	Pmt	5
34448613	Real Estate	2021-08-20 02:00:00+02	D	151.40	Tax pay	USD	9311	Pmt	96
34485388	Protetcta	2021-09-04 02:00:00+02	D	24.00	Doctor's appointment	USD	8011	Pmt	45
34663615	Wolt	2021-08-14 02:00:00+02	D	22.00	Food delivery	USD	5811	Pmt	39
34713137	Raiffeisen Leasing	2021-05-02 02:00:00+02	D	450.90	Financial leasing	USD	7394	Pmt	3
34881422	Glovo	2021-03-21 01:00:00+01	D	36.90	Food delivery	USD	5811	Pmt	39
34941181	Glovo	2021-12-01 01:00:00+01	D	36.60	Food delivery	USD	5811	Pmt	39
35066055	Asseco	2021-05-06 02:00:00+02	C	2446.90	Salary	USD	\N	Sal	62
35139353	Revolut	2021-05-17 02:00:00+02	C	273.30	Interest	USD	\N	Dep	25
35183593	Table tenis club PingPong	2021-10-15 02:00:00+02	D	10.80	Table tennis 2 hrs	USD	5655	Pmt	50
35212561	Office365	2021-04-16 02:00:00+02	D	19.70	TV	USD	5045	Pmt	90
35345408	City parkings	2021-01-18 01:00:00+01	D	2.00	Parking fee	USD	7523	Pmt	5
35409985	Orange	2021-02-07 01:00:00+01	D	26.10	Internet bill	USD	\N	Pmt	10
35545492	Wolt	2021-02-23 01:00:00+01	D	24.50	Food delivery	USD	5811	Pmt	39
35567490	Glovo	2021-09-03 02:00:00+02	D	25.00	Food delivery	USD	5811	Pmt	39
35746907	Save our kids	2021-09-01 02:00:00+02	D	91.70	Charity	USD	\N	Pmt	41
35806343	Chase	2021-01-13 01:00:00+01	D	400.90	Rent pay	USD	\N	Pmt	58
35806463	Orange	2021-05-28 02:00:00+02	D	20.60	Internet bill	USD	\N	Pmt	10
35873729	MetLife	2021-03-19 01:00:00+01	D	200.80	Life insurance premium	USD	6300	Pmt	33
35897484	Glovo	2021-09-19 02:00:00+02	D	32.70	Food delivery	USD	5811	Pmt	39
35977262	New York Times	2021-06-20 02:00:00+02	D	4.10	National Geographic	USD	5192	Pmt	88
36000405	Wolt	2021-01-18 01:00:00+01	D	39.00	Food delivery	USD	5811	Pmt	39
36003414	Glovo	2021-11-27 01:00:00+01	D	35.90	Food delivery	USD	5811	Pmt	39
36095133	Book depository	2021-09-17 02:00:00+02	D	11.30	Book	USD	\N	Pmt	15
36137786	Spotify	2021-03-08 01:00:00+01	D	15.60	Apple music subscription	USD	5733	Pmt	22
36154674	Revolut	2021-01-25 01:00:00+01	D	4.40	ATM withdrawal fee	USD	\N	Fee	25
36192049	Wolt	2021-12-12 01:00:00+01	D	35.30	Food delivery	USD	5811	Pmt	39
36292652	Glovo	2021-06-24 02:00:00+02	D	25.60	Food delivery	USD	5811	Pmt	39
36303640	Lidl	2021-03-16 01:00:00+01	D	40.00	Supermaket shopping	USD	5499	Pmt	38
36370226	Glovo	2021-04-19 02:00:00+02	D	47.50	Food delivery	USD	5811	Pmt	39
36526776	Red Cross	2021-01-19 01:00:00+01	D	98.80	Charity	USD	\N	Pmt	41
36604310	Comcast	2021-04-12 02:00:00+02	D	16.60	Television bill	USD	\N	Pmt	12
36764687	Glovo	2021-05-12 02:00:00+02	D	33.50	Food delivery	USD	5811	Pmt	39
36801838	Wolt	2021-11-22 01:00:00+01	D	34.90	Food delivery	USD	5811	Pmt	39
36900893	Glovo	2021-12-03 01:00:00+01	D	39.20	Food delivery	USD	5811	Pmt	39
36923376	Faculty of contemporary arts	2021-06-10 02:00:00+02	D	166.00	Tuition	USD	8299	Pmt	17
36958785	City parkings	2021-04-21 02:00:00+02	D	1.80	Parking fee	USD	7523	Pmt	5
37010602	Swimming pool Activa	2021-05-24 02:00:00+02	D	12.10	Table tennis 2 hrs	USD	5655	Pmt	50
37082520	Glovo	2021-09-28 02:00:00+02	D	31.20	Food delivery	USD	5811	Pmt	39
37150929	Glovo	2021-08-20 02:00:00+02	D	48.30	Food delivery	USD	5811	Pmt	39
37191564	Glovo	2021-08-10 02:00:00+02	D	38.40	Food delivery	USD	5811	Pmt	39
37395197	Glovo	2021-05-18 02:00:00+02	D	25.40	Food delivery	USD	5811	Pmt	39
37642221	Glovo	2021-01-23 01:00:00+01	D	47.00	Food delivery	USD	5811	Pmt	39
37734533	Glovo	2021-02-20 01:00:00+01	D	46.70	Food delivery	USD	5811	Pmt	39
37785375	Pet store	2021-01-27 01:00:00+01	D	22.30	Shopping	USD	5995	Pmt	84
37852815	Delhaize	2021-05-20 02:00:00+02	D	34.30	Supermaket shopping	USD	5499	Pmt	38
38081007	Wolt	2021-09-17 02:00:00+02	D	45.10	Food delivery	USD	5811	Pmt	39
38114025	Dental Plus	2021-05-22 02:00:00+02	D	30.30	Doctor's appointment	USD	8011	Pmt	45
38194569	Wolt	2021-11-22 01:00:00+01	D	50.60	Food delivery	USD	5811	Pmt	39
38223295	Wolt	2021-09-17 02:00:00+02	D	19.40	Food delivery	USD	5811	Pmt	39
38281845	Fit and Fun	2021-05-19 02:00:00+02	D	21.80	Personal trainer	USD	\N	Pmt	47
38283842	Sixt GmbH	2021-05-04 02:00:00+02	D	12.40	Car rent	USD	7519	Pmt	105
38450379	Blue moon spa	2021-01-03 01:00:00+01	D	22.50	Massage	USD	8050	Pmt	82
38480830	Pet shop	2021-10-21 02:00:00+02	D	25.70	Shopping	USD	5995	Pmt	84
38483304	Wolt	2021-03-28 01:00:00+01	D	36.30	Food delivery	USD	5811	Pmt	39
38516274	Fit and Fun	2021-06-24 02:00:00+02	D	27.20	Personal trainer	USD	\N	Pmt	47
38573776	T-Mobile	2021-09-21 02:00:00+02	D	14.40	Mobile phone bill	USD	\N	Pmt	11
38614165	Glovo	2021-06-02 02:00:00+02	D	25.60	Food delivery	USD	5811	Pmt	39
38678838	Wolt	2021-10-10 02:00:00+02	D	33.70	Food delivery	USD	5811	Pmt	39
38751212	Lidl	2021-07-18 02:00:00+02	D	85.60	Supermaket shopping	USD	5200	Pmt	56
38852592	Fit and Fun	2021-03-04 01:00:00+01	D	27.10	Personal trainer	USD	\N	Pmt	47
38970077	Glovo	2021-01-09 01:00:00+01	D	31.30	Food delivery	USD	5811	Pmt	39
39165382	Glovo	2021-12-05 01:00:00+01	D	28.80	Food delivery	USD	5811	Pmt	39
39175391	Save our kids	2021-12-23 01:00:00+01	D	26.30	Charity	USD	\N	Pmt	41
39222365	Faculty of contemporary arts	2021-03-17 01:00:00+01	D	155.10	Tuition	USD	8299	Pmt	17
39301115	Glovo	2021-06-21 02:00:00+02	D	17.90	Food delivery	USD	5811	Pmt	39
39320915	Lending Club	2021-06-01 02:00:00+02	D	40.20	Loan Payment	USD	\N	Pmt	77
39418979	A1 Telecom	2021-08-08 02:00:00+02	D	26.70	Internet bill	USD	\N	Pmt	10
39522352	Josh	2021-03-02 01:00:00+01	D	42.20	Allowance	USD	\N	Pmt	67
39573433	Wolt	2021-09-21 02:00:00+02	D	51.00	Food delivery	USD	5811	Pmt	39
39591523	City parkings	2021-07-17 02:00:00+02	D	1.60	Parking fee	USD	7523	Pmt	5
39751149	Wolt	2021-07-17 02:00:00+02	D	24.20	Food delivery	USD	5811	Pmt	39
39961719	Chevron	2021-07-05 02:00:00+02	D	95.60	Gasoline purchases	USD	5983	Pmt	4
40158705	Barber shop	2021-04-06 02:00:00+02	D	24.60	Hair dye	USD	7230	Pmt	80
40176261	A1 Telecom	2021-06-01 02:00:00+02	D	17.30	Mobile phone bill	USD	\N	Pmt	11
40182091	Glovo	2021-03-01 01:00:00+01	D	30.10	Food delivery	USD	5811	Pmt	39
40208406	Adobe	2021-01-24 01:00:00+01	D	16.60	Games	USD	5045	Pmt	90
40236657	Medigroup	2021-12-06 01:00:00+01	D	48.10	Specialist	USD	8011	Pmt	45
40261513	Claire Stevens	2021-09-09 02:00:00+02	C	300.80	Monthly rent	USD	\N	Dep	58
40275245	Wolt	2021-11-27 01:00:00+01	D	42.60	Food delivery	USD	5811	Pmt	39
40304231	Real Estate	2021-04-21 02:00:00+02	D	167.10	Tax pay	USD	9311	Pmt	96
40315975	Glovo	2021-12-06 01:00:00+01	D	31.20	Food delivery	USD	5811	Pmt	39
40321434	MetLife	2021-04-10 02:00:00+02	D	200.10	Life insurance premium	USD	6300	Pmt	33
40328813	Glovo	2021-02-24 01:00:00+01	D	27.60	Food delivery	USD	5811	Pmt	39
40472982	Josh	2021-08-14 02:00:00+02	D	34.60	Allowance	USD	\N	Pmt	67
40474619	Adobe	2021-01-03 01:00:00+01	D	20.10	Games	USD	5045	Pmt	90
40790136	Delhaize	2021-03-07 01:00:00+01	D	37.70	Supermaket shopping	USD	5499	Pmt	38
40800049	Hertz	2021-07-22 02:00:00+02	D	10.10	Taxi	USD	7519	Pmt	105
40811501	Glovo	2021-04-01 02:00:00+02	D	45.30	Food delivery	USD	5811	Pmt	39
40883447	Lidl	2021-05-15 02:00:00+02	D	77.30	Supermaket shopping	USD	5200	Pmt	56
40918362	Wolt	2021-05-25 02:00:00+02	D	37.50	Food delivery	USD	5811	Pmt	39
40973670	Wolt	2021-04-27 02:00:00+02	D	17.90	Food delivery	USD	5811	Pmt	39
41076447	Spotify	2021-08-19 02:00:00+02	D	15.30	Apple music subscription	USD	5733	Pmt	22
41156182	Serenity Wellnes	2021-07-01 02:00:00+02	D	24.30	Spa treatment	USD	8050	Pmt	82
41169227	Comcast	2021-04-01 02:00:00+02	D	11.00	Television bill	USD	\N	Pmt	12
41251620	Wolt	2021-10-11 02:00:00+02	D	31.20	Food delivery	USD	5811	Pmt	39
41275648	National Geographic	2021-07-01 02:00:00+02	D	4.40	New York Times	USD	5192	Pmt	88
41276012	City parkings	2021-08-09 02:00:00+02	D	2.10	Parking fee	USD	7523	Pmt	5
41408537	Wolt	2021-11-04 01:00:00+01	D	44.90	Food delivery	USD	5811	Pmt	39
41464495	Wolt	2021-07-08 02:00:00+02	D	29.40	Food delivery	USD	5811	Pmt	39
41527424	Glovo	2021-05-13 02:00:00+02	D	50.10	Food delivery	USD	5811	Pmt	39
41634772	Lidl	2021-06-19 02:00:00+02	D	30.80	Supermaket shopping	USD	5499	Pmt	38
41724617	Adobe	2021-04-12 02:00:00+02	D	18.60	Games	USD	5045	Pmt	90
41758382	City parkings	2021-08-24 02:00:00+02	D	2.60	Parking fee	USD	7523	Pmt	5
41859698	Wolt	2021-07-21 02:00:00+02	D	31.30	Food delivery	USD	5811	Pmt	39
41864438	City parkings	2021-12-23 01:00:00+01	D	2.10	Parking fee	USD	7523	Pmt	5
42051150	Delhaize	2021-12-06 01:00:00+01	D	35.20	Supermaket shopping	USD	5499	Pmt	38
42051784	Wolt	2021-12-19 01:00:00+01	D	23.20	Food delivery	USD	5811	Pmt	39
42122897	A1 Telecom	2021-03-09 01:00:00+01	D	20.50	Mobile phone bill	USD	\N	Pmt	11
42270338	Wolt	2021-09-12 02:00:00+02	D	49.20	Food delivery	USD	5811	Pmt	39
42324432	Connexus	2021-11-09 01:00:00+01	D	400.50	Rent pay	USD	\N	Pmt	58
42356974	Comcast	2021-02-26 01:00:00+01	D	20.00	Television bill	USD	\N	Pmt	12
42494853	MetLife	2021-04-11 02:00:00+02	D	200.80	Life insurance premium	USD	6300	Pmt	33
42528258	Wolt	2021-06-16 02:00:00+02	D	43.60	Food delivery	USD	5811	Pmt	39
42572989	Wolt	2021-02-04 01:00:00+01	D	20.70	Food delivery	USD	5811	Pmt	39
42653813	Lily	2021-06-03 02:00:00+02	D	32.10	Medicine	USD	5912	Pmt	49
42663079	Wolt	2021-11-25 01:00:00+01	D	24.60	Food delivery	USD	5811	Pmt	39
42703423	Medilife	2021-07-27 02:00:00+02	D	51.50	Specialist	USD	8011	Pmt	45
42710441	Spotify	2021-09-10 02:00:00+02	D	15.30	Spotify premium subscription	USD	5733	Pmt	22
42722837	Sixt GmbH	2021-06-03 02:00:00+02	D	10.30	Car rent	USD	7519	Pmt	105
42857192	Wolt	2021-08-08 02:00:00+02	D	30.40	Food delivery	USD	5811	Pmt	39
43061695	Wolt	2021-03-21 01:00:00+01	D	47.20	Food delivery	USD	5811	Pmt	39
43126377	Jill	2021-08-22 02:00:00+02	D	37.40	Allowance	USD	\N	Pmt	67
43248167	Pet shop	2021-03-07 01:00:00+01	D	23.80	Shopping	USD	5995	Pmt	84
43319213	Dental Plus	2021-08-24 02:00:00+02	D	29.30	Doctor's appointment	USD	8011	Pmt	45
43336057	Lidl	2021-12-19 01:00:00+01	D	38.50	Supermaket shopping	USD	5499	Pmt	38
43379314	Wolt	2021-11-03 01:00:00+01	D	24.00	Food delivery	USD	5811	Pmt	39
43572207	Glovo	2021-03-04 01:00:00+01	D	45.50	Food delivery	USD	5811	Pmt	39
43584577	Lending Club	2021-08-21 02:00:00+02	D	74.30	Loan Payment	USD	\N	Pmt	77
43610796	Faculty of contemporary arts	2021-11-11 01:00:00+01	D	183.10	Tuition	USD	8299	Pmt	17
43619895	Office365	2021-10-11 02:00:00+02	D	16.70	Games	USD	5045	Pmt	90
43658389	Glovo	2021-08-24 02:00:00+02	D	32.40	Food delivery	USD	5811	Pmt	39
43671471	Table tenis club PingPong	2021-06-11 02:00:00+02	D	13.90	Daily pool ticket	USD	5655	Pmt	50
43709973	Tele9	2021-06-13 02:00:00+02	D	14.40	Television bill	USD	\N	Pmt	12
43960417	Lidl	2021-08-06 02:00:00+02	D	74.40	Supermaket shopping	USD	5200	Pmt	56
44051113	Residential Property	2021-07-23 02:00:00+02	D	180.00	Tax pay	USD	9311	Pmt	96
44194108	Pet shop	2021-08-26 02:00:00+02	D	21.10	Shopping	USD	5995	Pmt	84
44459054	Wolt	2021-06-26 02:00:00+02	D	26.60	Food delivery	USD	5811	Pmt	39
44481097	Shell	2021-09-03 02:00:00+02	D	105.90	Gasoline purchases	USD	5983	Pmt	4
44582621	Lidl	2021-02-28 01:00:00+01	D	32.60	Supermaket shopping	USD	5499	Pmt	38
44612571	Glovo	2021-07-04 02:00:00+02	D	46.60	Food delivery	USD	5811	Pmt	39
44640927	Glovo	2021-08-06 02:00:00+02	D	24.80	Food delivery	USD	5811	Pmt	39
44679002	Glovo	2021-05-19 02:00:00+02	D	45.10	Food delivery	USD	5811	Pmt	39
44738521	Medilife	2021-05-17 02:00:00+02	D	48.50	Specialist	USD	8011	Pmt	45
45046317	Glovo	2021-12-18 01:00:00+01	D	21.30	Food delivery	USD	5811	Pmt	39
45153700	Fit and Fun	2021-09-09 02:00:00+02	D	28.40	Gym membership	USD	\N	Pmt	47
45215367	Jill	2021-01-24 01:00:00+01	D	45.70	Allowance	USD	\N	Pmt	67
45251421	Serenity Wellnes	2021-03-21 01:00:00+01	D	20.60	Spa treatment	USD	8050	Pmt	82
45330161	Wolt	2021-04-18 02:00:00+02	D	38.60	Food delivery	USD	5811	Pmt	39
45353764	Wolt	2021-05-08 02:00:00+02	D	33.90	Food delivery	USD	5811	Pmt	39
45492355	Glovo	2021-06-19 02:00:00+02	D	37.70	Food delivery	USD	5811	Pmt	39
45573282	Wolt	2021-10-02 02:00:00+02	D	32.50	Food delivery	USD	5811	Pmt	39
46133888	Wolt	2021-03-01 01:00:00+01	D	36.60	Food delivery	USD	5811	Pmt	39
46134066	Revolut	2021-01-06 01:00:00+01	D	4.60	ATM withdrawal fee	USD	\N	Fee	25
46151174	Wolt	2021-01-26 01:00:00+01	D	38.80	Food delivery	USD	5811	Pmt	39
46155679	Wolt	2021-11-21 01:00:00+01	D	38.80	Food delivery	USD	5811	Pmt	39
46237893	Wolt	2021-12-05 01:00:00+01	D	46.40	Food delivery	USD	5811	Pmt	39
46321805	Wolt	2021-12-19 01:00:00+01	D	22.00	Food delivery	USD	5811	Pmt	39
46531845	Lidl	2021-05-19 02:00:00+02	D	31.50	Supermaket shopping	USD	5499	Pmt	38
46698487	Glovo	2021-09-01 02:00:00+02	D	19.10	Food delivery	USD	5811	Pmt	39
46709053	Delhaize	2021-02-07 01:00:00+01	D	36.90	Supermaket shopping	USD	5499	Pmt	38
46722956	City parkings	2021-06-09 02:00:00+02	D	2.50	Parking fee	USD	7523	Pmt	5
46769565	Lending Club	2021-08-27 02:00:00+02	D	44.20	Loan Payment	USD	\N	Pmt	77
46974553	Comcast	2021-11-14 01:00:00+01	D	10.30	Television bill	USD	\N	Pmt	12
47105503	Book depository	2021-02-13 01:00:00+01	D	15.80	Book	USD	\N	Pmt	15
47417977	Delhaize	2021-04-12 02:00:00+02	D	34.50	Supermaket shopping	USD	5499	Pmt	38
47454144	Hertz	2021-03-19 01:00:00+01	D	15.60	Taxi	USD	7519	Pmt	105
47708919	Chase	2021-07-05 02:00:00+02	D	400.80	Rent pay	USD	\N	Pmt	58
47761879	Apple	2021-07-23 02:00:00+02	D	15.60	Spotify premium subscription	USD	5733	Pmt	22
47798608	City parkings	2021-02-28 01:00:00+01	D	1.40	Parking fee	USD	7523	Pmt	5
47932666	Delhaize	2021-08-17 02:00:00+02	D	32.70	Supermaket shopping	USD	5499	Pmt	38
47965387	Wolt	2021-06-23 02:00:00+02	D	31.70	Food delivery	USD	5811	Pmt	39
48087796	Raiffeisen Leasing	2021-09-26 02:00:00+02	D	450.30	Financial leasing	USD	7394	Pmt	3
48182784	Medigroup	2021-11-28 01:00:00+01	D	56.20	General Practitioner	USD	8011	Pmt	45
48260170	Swimming pool Activa	2021-04-10 02:00:00+02	D	13.90	Daily pool ticket	USD	5655	Pmt	50
48381512	Delhaize	2021-10-04 02:00:00+02	D	31.00	Supermaket shopping	USD	5499	Pmt	38
48442765	Glovo	2021-12-15 01:00:00+01	D	16.70	Food delivery	USD	5811	Pmt	39
48519516	Glovo	2021-02-12 01:00:00+01	D	19.20	Food delivery	USD	5811	Pmt	39
48606693	Connexus	2021-10-16 02:00:00+02	D	400.60	Rent pay	USD	\N	Pmt	58
48623663	Fit and Fun	2021-12-27 01:00:00+01	D	30.30	Gym membership	USD	\N	Pmt	47
48710983	A1 Telecom	2021-11-21 01:00:00+01	D	20.90	Mobile phone bill	USD	\N	Pmt	11
48747430	Lidl	2021-05-04 02:00:00+02	D	38.00	Supermaket shopping	USD	5499	Pmt	38
48755533	Residential Property	2021-12-18 01:00:00+01	D	166.20	Tax pay	USD	9311	Pmt	96
48763143	Tele9	2021-04-12 02:00:00+02	D	10.60	Television bill	USD	\N	Pmt	12
48787348	Glovo	2021-01-22 01:00:00+01	D	36.30	Food delivery	USD	5811	Pmt	39
48826635	Lidl	2021-08-14 02:00:00+02	D	32.60	Supermaket shopping	USD	5499	Pmt	38
48918075	Wolt	2021-12-16 01:00:00+01	D	34.70	Food delivery	USD	5811	Pmt	39
49152289	Fit and Fun	2021-05-03 02:00:00+02	D	22.70	Gym membership	USD	\N	Pmt	47
49173606	Gift shop	2021-07-17 02:00:00+02	D	128.10	Birthday gifts	USD	5947	Pmt	42
49228660	Shell	2021-10-24 02:00:00+02	D	77.40	Gasoline purchases	USD	5983	Pmt	4
49246022	Glovo	2021-08-10 02:00:00+02	D	44.00	Food delivery	USD	5811	Pmt	39
49287421	City parkings	2021-12-10 01:00:00+01	D	1.10	Parking fee	USD	7523	Pmt	5
49396339	MetLife	2021-05-08 02:00:00+02	D	200.40	Life insurance premium	USD	6300	Pmt	33
49548658	Delhaize	2021-06-22 02:00:00+02	D	39.00	Supermaket shopping	USD	5499	Pmt	38
49604265	A1 Telecom	2021-04-13 02:00:00+02	D	24.80	Internet bill	USD	\N	Pmt	10
49676911	Pet hotel Happy Dog	2021-12-15 01:00:00+01	D	100.10	Monthly stay	USD	5995	Pmt	84
49895939	Claire Stevens	2021-02-21 01:00:00+01	C	301.00	Monthly rent	USD	\N	Dep	58
49931536	A1 Telecom	2021-03-21 01:00:00+01	D	14.20	Mobile phone bill	USD	\N	Pmt	11
50196265	Table tenis club PingPong	2021-12-24 01:00:00+01	D	15.10	Daily pool ticket	USD	5655	Pmt	50
50301963	Wolt	2021-06-28 02:00:00+02	D	19.30	Food delivery	USD	5811	Pmt	39
50374360	New York Times	2021-08-28 02:00:00+02	D	4.70	New York Times	USD	5192	Pmt	88
50487794	Glovo	2021-02-16 01:00:00+01	D	23.00	Food delivery	USD	5811	Pmt	39
50496538	T-Mobile	2021-11-09 01:00:00+01	D	13.20	Mobile phone bill	USD	\N	Pmt	11
50825185	Revolut	2021-08-10 02:00:00+02	D	5.90	Revolut Silver subscription	USD	\N	Fee	25
50836882	Lidl	2021-12-20 01:00:00+01	D	92.20	Supermaket shopping	USD	5200	Pmt	56
51022583	Tele9	2021-06-15 02:00:00+02	D	20.50	Television bill	USD	\N	Pmt	12
51023898	Table tenis club PingPong	2021-01-02 01:00:00+01	D	12.30	Daily pool ticket	USD	5655	Pmt	50
51145886	Lidl	2021-11-06 01:00:00+01	D	33.20	Supermaket shopping	USD	5499	Pmt	38
51271190	Comcast	2021-08-20 02:00:00+02	D	20.30	Television bill	USD	\N	Pmt	12
51397021	Lidl	2021-03-05 01:00:00+01	D	93.70	Supermaket shopping	USD	5200	Pmt	56
51452231	Book depository	2021-09-10 02:00:00+02	D	12.60	Amazon Kindle subscription	USD	\N	Pmt	15
51528621	Wolt	2021-12-16 01:00:00+01	D	20.40	Food delivery	USD	5811	Pmt	39
51689818	Fit and Fun	2021-09-09 02:00:00+02	D	28.50	Gym membership	USD	\N	Pmt	47
51711818	Dental Plus	2021-07-12 02:00:00+02	D	15.30	Doctor's appointment	USD	8011	Pmt	45
51803613	Glovo	2021-02-04 01:00:00+01	D	48.80	Food delivery	USD	5811	Pmt	39
51850161	Wolt	2021-09-20 02:00:00+02	D	19.60	Food delivery	USD	5811	Pmt	39
52174379	City parkings	2021-12-28 01:00:00+01	D	1.20	Parking fee	USD	7523	Pmt	5
52299796	A1 Telecom	2021-05-13 02:00:00+02	D	33.20	Internet bill	USD	\N	Pmt	10
52315763	Faculty of contemporary arts	2021-04-18 02:00:00+02	D	167.80	Tuition	USD	8299	Pmt	17
52343821	Sixt GmbH	2021-04-19 02:00:00+02	D	11.60	Car rent	USD	7519	Pmt	105
52385743	Wolt	2021-02-07 01:00:00+01	D	30.30	Food delivery	USD	5811	Pmt	39
52403046	Serenity Wellnes	2021-09-01 02:00:00+02	D	21.10	Massage	USD	8050	Pmt	82
52466008	Wolt	2021-02-21 01:00:00+01	D	49.90	Food delivery	USD	5811	Pmt	39
52598314	A1 Telecom	2021-07-04 02:00:00+02	D	15.20	Mobile phone bill	USD	\N	Pmt	11
52600204	Table tenis club PingPong	2021-12-07 01:00:00+01	D	15.20	Daily pool ticket	USD	5655	Pmt	50
52635945	Glovo	2021-07-05 02:00:00+02	D	23.40	Food delivery	USD	5811	Pmt	39
52778926	Faculty of contemporary arts	2021-01-27 01:00:00+01	D	163.40	Tuition	USD	8299	Pmt	17
52785288	Tele9	2021-11-27 01:00:00+01	D	15.70	Television bill	USD	\N	Pmt	12
52828800	Glovo	2021-06-03 02:00:00+02	D	37.70	Food delivery	USD	5811	Pmt	39
52970552	City parkings	2021-11-03 01:00:00+01	D	2.20	Parking fee	USD	7523	Pmt	5
52979952	Revolut	2021-01-13 01:00:00+01	D	5.50	ATM withdrawal fee	USD	\N	Fee	25
53061796	Dental Plus	2021-12-23 01:00:00+01	D	29.90	Doctor's appointment	USD	8011	Pmt	45
53235293	Tele9	2021-05-20 02:00:00+02	D	14.50	Television bill	USD	\N	Pmt	12
53688672	City parkings	2021-11-23 01:00:00+01	D	1.90	Parking fee	USD	7523	Pmt	5
53870822	Apple	2021-03-06 01:00:00+01	D	15.90	Spotify premium subscription	USD	5733	Pmt	22
54053847	Faculty of contemporary arts	2021-11-07 01:00:00+01	D	158.20	Tuition	USD	8299	Pmt	17
54105405	Glovo	2021-09-12 02:00:00+02	D	38.30	Food delivery	USD	5811	Pmt	39
54157087	Real Estate	2021-12-16 01:00:00+01	D	157.00	Tax pay	USD	9311	Pmt	96
54240054	Claire Stevens	2021-10-12 02:00:00+02	C	300.60	Monthly rent	USD	\N	Dep	58
54545537	City parkings	2021-01-08 01:00:00+01	D	1.50	Parking fee	USD	7523	Pmt	5
54550411	Glovo	2021-09-07 02:00:00+02	D	27.20	Food delivery	USD	5811	Pmt	39
54666733	MetLife	2021-09-25 02:00:00+02	D	200.10	Life insurance premium	USD	6300	Pmt	33
54741976	Wolt	2021-05-27 02:00:00+02	D	22.40	Food delivery	USD	5811	Pmt	39
54803074	Glovo	2021-01-10 01:00:00+01	D	47.10	Food delivery	USD	5811	Pmt	39
54857125	A1 Telecom	2021-12-10 01:00:00+01	D	12.10	Mobile phone bill	USD	\N	Pmt	11
54945283	Adobe	2021-07-24 02:00:00+02	D	11.10	Games	USD	5045	Pmt	90
54958642	Lidl	2021-07-02 02:00:00+02	D	30.70	Supermaket shopping	USD	5499	Pmt	38
54996600	Lidl	2021-04-25 02:00:00+02	D	74.10	Supermaket shopping	USD	5200	Pmt	56
55000954	Glovo	2021-09-20 02:00:00+02	D	34.10	Food delivery	USD	5811	Pmt	39
55042469	UniCredit Leasing	2021-06-03 02:00:00+02	D	450.10	Financial leasing	USD	7394	Pmt	3
55106881	Delhaize	2021-01-19 01:00:00+01	D	30.30	Supermaket shopping	USD	5499	Pmt	38
55133330	Glovo	2021-07-02 02:00:00+02	D	30.10	Food delivery	USD	5811	Pmt	39
55206970	Glovo	2021-05-23 02:00:00+02	D	40.40	Food delivery	USD	5811	Pmt	39
55263919	Glovo	2021-07-04 02:00:00+02	D	29.50	Food delivery	USD	5811	Pmt	39
55472439	Wolt	2021-01-21 01:00:00+01	D	19.30	Food delivery	USD	5811	Pmt	39
55475831	Wolt	2021-06-14 02:00:00+02	D	27.60	Food delivery	USD	5811	Pmt	39
55541588	Shell	2021-01-25 01:00:00+01	D	41.90	Gasoline purchases	USD	5983	Pmt	4
55606973	MetLife	2021-12-26 01:00:00+01	D	200.50	Life insurance premium	USD	6300	Pmt	33
55666996	Wolt	2021-06-01 02:00:00+02	D	35.20	Food delivery	USD	5811	Pmt	39
55679730	Barber shop	2021-04-07 02:00:00+02	D	28.80	Hair dye	USD	7230	Pmt	80
55683973	Wolt	2021-10-20 02:00:00+02	D	24.70	Food delivery	USD	5811	Pmt	39
55728558	Delhaize	2021-06-14 02:00:00+02	D	36.40	Supermaket shopping	USD	5499	Pmt	38
55734581	Wolt	2021-03-06 01:00:00+01	D	40.60	Food delivery	USD	5811	Pmt	39
55791400	Hertz	2021-11-22 01:00:00+01	D	15.80	Taxi	USD	7519	Pmt	105
55815716	New York Times	2021-03-22 01:00:00+01	D	3.70	National Geographic	USD	5192	Pmt	88
55836439	Faculty of contemporary arts	2021-01-07 01:00:00+01	D	185.50	Tuition	USD	8299	Pmt	17
55845532	Sixt GmbH	2021-11-01 01:00:00+01	D	15.20	Car rent	USD	7519	Pmt	105
55989567	Fit and Fun	2021-09-10 02:00:00+02	D	23.50	Personal trainer	USD	\N	Pmt	47
56055965	National Geographic	2021-08-11 02:00:00+02	D	4.30	National Geographic	USD	5192	Pmt	88
56146772	City parkings	2021-07-15 02:00:00+02	D	2.40	Parking fee	USD	7523	Pmt	5
56194708	Glovo	2021-04-11 02:00:00+02	D	24.20	Food delivery	USD	5811	Pmt	39
56230289	Revolut	2021-01-12 01:00:00+01	D	3.50	ATM withdrawal fee	USD	\N	Fee	25
56241175	Wolt	2021-06-08 02:00:00+02	D	30.60	Food delivery	USD	5811	Pmt	39
56345828	A1 Telecom	2021-03-27 01:00:00+01	D	34.10	Internet bill	USD	\N	Pmt	10
56500502	National Geographic	2021-01-06 01:00:00+01	D	4.80	National Geographic	USD	5192	Pmt	88
56523061	Delhaize	2021-11-05 01:00:00+01	D	97.90	Supermaket shopping	USD	5200	Pmt	56
56524968	Gift Voucher	2021-07-10 02:00:00+02	D	57.30	Other gifts	USD	5947	Pmt	42
56555459	R-Pharm	2021-03-23 01:00:00+01	D	30.70	Medicine	USD	5912	Pmt	49
56591253	Glovo	2021-02-08 01:00:00+01	D	41.50	Food delivery	USD	5811	Pmt	39
56670501	Wolt	2021-05-17 02:00:00+02	D	46.60	Food delivery	USD	5811	Pmt	39
56719085	City parkings	2021-11-27 01:00:00+01	D	1.70	Parking fee	USD	7523	Pmt	5
56765457	A1 Telecom	2021-03-14 01:00:00+01	D	18.60	Mobile phone bill	USD	\N	Pmt	11
56796132	Wolt	2021-09-24 02:00:00+02	D	36.40	Food delivery	USD	5811	Pmt	39
56822011	Glovo	2021-11-03 01:00:00+01	D	23.00	Food delivery	USD	5811	Pmt	39
56824971	T-Mobile	2021-03-18 01:00:00+01	D	13.20	Mobile phone bill	USD	\N	Pmt	11
56960364	Wolt	2021-11-13 01:00:00+01	D	39.00	Food delivery	USD	5811	Pmt	39
57135566	A1 Telecom	2021-05-19 02:00:00+02	D	13.20	Mobile phone bill	USD	\N	Pmt	11
57150698	Glovo	2021-04-25 02:00:00+02	D	17.50	Food delivery	USD	5811	Pmt	39
57169461	Glovo	2021-02-10 01:00:00+01	D	30.60	Food delivery	USD	5811	Pmt	39
57195573	A1 Telecom	2021-05-23 02:00:00+02	D	33.50	Internet bill	USD	\N	Pmt	10
57240692	Glovo	2021-08-21 02:00:00+02	D	39.10	Food delivery	USD	5811	Pmt	39
57327406	Wolt	2021-12-11 01:00:00+01	D	46.90	Food delivery	USD	5811	Pmt	39
57430900	Glovo	2021-09-11 02:00:00+02	D	39.70	Food delivery	USD	5811	Pmt	39
57453138	T-Mobile	2021-12-08 01:00:00+01	D	12.60	Mobile phone bill	USD	\N	Pmt	11
57456544	New York Times	2021-04-07 02:00:00+02	D	5.70	National Geographic	USD	5192	Pmt	88
57484714	Tele9	2021-12-16 01:00:00+01	D	19.00	Television bill	USD	\N	Pmt	12
57517957	Serenity Wellnes	2021-08-19 02:00:00+02	D	23.80	Spa treatment	USD	8050	Pmt	82
57536214	Wolt	2021-11-07 01:00:00+01	D	49.30	Food delivery	USD	5811	Pmt	39
57798469	Josh	2021-04-27 02:00:00+02	D	41.10	Allowance	USD	\N	Pmt	67
57852212	Glovo	2021-10-26 02:00:00+02	D	15.70	Food delivery	USD	5811	Pmt	39
57934670	Faculty of contemporary arts	2021-05-27 02:00:00+02	D	180.20	Tuition	USD	8299	Pmt	17
58005439	Orange	2021-05-10 02:00:00+02	D	34.60	Internet bill	USD	\N	Pmt	10
58040610	Glovo	2021-04-14 02:00:00+02	D	49.50	Food delivery	USD	5811	Pmt	39
58046641	Wolt	2021-12-08 01:00:00+01	D	20.70	Food delivery	USD	5811	Pmt	39
58058332	Glovo	2021-03-05 01:00:00+01	D	22.00	Food delivery	USD	5811	Pmt	39
58200155	Asseco	2021-01-17 01:00:00+01	C	2382.40	Salary	USD	\N	Sal	62
58228826	Pet hotel Happy Dog	2021-07-09 02:00:00+02	D	100.10	Monthly stay	USD	5995	Pmt	84
58287808	Wolt	2021-05-20 02:00:00+02	D	21.60	Food delivery	USD	5811	Pmt	39
58308855	Serenity Wellnes	2021-07-19 02:00:00+02	D	22.20	Massage	USD	8050	Pmt	82
58361465	Hertz	2021-02-02 01:00:00+01	D	14.70	Car rent	USD	7519	Pmt	105
58556632	Wolt	2021-12-21 01:00:00+01	D	30.00	Food delivery	USD	5811	Pmt	39
58838367	Delhaize	2021-02-20 01:00:00+01	D	31.60	Supermaket shopping	USD	5499	Pmt	38
58856951	Red Cross	2021-07-10 02:00:00+02	D	33.70	Charity	USD	\N	Pmt	41
58871468	Fit and Fun	2021-04-01 02:00:00+02	D	23.20	Personal trainer	USD	\N	Pmt	47
58884779	Claire Stevens	2021-05-27 02:00:00+02	C	300.10	Monthly rent	USD	\N	Dep	58
59160066	Office365	2021-01-13 01:00:00+01	D	18.20	TV	USD	5045	Pmt	90
59194264	A1 Telecom	2021-11-23 01:00:00+01	D	19.20	Mobile phone bill	USD	\N	Pmt	11
59322988	Lidl	2021-08-27 02:00:00+02	D	32.80	Supermaket shopping	USD	5499	Pmt	38
59377025	Book depository	2021-10-17 02:00:00+02	D	16.20	Book	USD	\N	Pmt	15
59419204	Music school	2021-07-27 02:00:00+02	D	152.60	Tuition	USD	8299	Pmt	17
59433187	Glovo	2021-11-01 01:00:00+01	D	21.60	Food delivery	USD	5811	Pmt	39
59482560	Delhaize	2021-03-14 01:00:00+01	D	30.30	Supermaket shopping	USD	5499	Pmt	38
59623097	Glovo	2021-08-10 02:00:00+02	D	30.40	Food delivery	USD	5811	Pmt	39
59714066	T-Mobile	2021-01-28 01:00:00+01	D	16.80	Mobile phone bill	USD	\N	Pmt	11
59715866	Glovo	2021-03-19 01:00:00+01	D	39.10	Food delivery	USD	5811	Pmt	39
59799014	Wolt	2021-04-04 02:00:00+02	D	29.00	Food delivery	USD	5811	Pmt	39
59812305	Josh	2021-11-08 01:00:00+01	D	43.80	Allowance	USD	\N	Pmt	67
59869789	Lily	2021-12-01 01:00:00+01	D	39.50	Medicine	USD	5912	Pmt	49
59957633	Asseco	2021-10-28 02:00:00+02	C	2499.40	Salary	USD	\N	Sal	62
60255138	City parkings	2021-12-04 01:00:00+01	D	1.90	Parking fee	USD	7523	Pmt	5
60285486	Lidl	2021-10-15 02:00:00+02	D	40.50	Supermaket shopping	USD	5499	Pmt	38
60304957	City parkings	2021-09-02 02:00:00+02	D	2.30	Parking fee	USD	7523	Pmt	5
60344073	MetLife	2021-07-23 02:00:00+02	D	200.30	Life insurance premium	USD	6300	Pmt	33
60419284	Barber shop	2021-11-10 01:00:00+01	D	37.60	Hair dye	USD	7230	Pmt	80
60444928	National Geographic	2021-07-25 02:00:00+02	D	5.90	New York Times	USD	5192	Pmt	88
60446112	National Geographic	2021-03-18 01:00:00+01	D	5.50	New York Times	USD	5192	Pmt	88
60451717	Asseco	2021-07-05 02:00:00+02	C	2432.00	Salary	USD	\N	Sal	62
60483499	Orange	2021-10-23 02:00:00+02	D	25.10	Internet bill	USD	\N	Pmt	10
60642645	Glovo	2021-06-01 02:00:00+02	D	41.40	Food delivery	USD	5811	Pmt	39
60661008	Lidl	2021-05-28 02:00:00+02	D	36.10	Supermaket shopping	USD	5499	Pmt	38
60671038	Claire Stevens	2021-07-25 02:00:00+02	C	300.60	Monthly rent	USD	\N	Dep	58
60833191	Wolt	2021-06-24 02:00:00+02	D	46.20	Food delivery	USD	5811	Pmt	39
60942536	Fit and Fun	2021-10-21 02:00:00+02	D	29.40	Personal trainer	USD	\N	Pmt	47
61131546	Glovo	2021-11-16 01:00:00+01	D	48.80	Food delivery	USD	5811	Pmt	39
61252646	City parkings	2021-12-25 01:00:00+01	D	2.40	Parking fee	USD	7523	Pmt	5
61363595	T-Mobile	2021-08-11 02:00:00+02	D	13.60	Mobile phone bill	USD	\N	Pmt	11
61393516	Dental Plus	2021-01-06 01:00:00+01	D	20.90	Doctor's appointment	USD	8011	Pmt	45
61550061	Delhaize	2021-01-10 01:00:00+01	D	40.70	Supermaket shopping	USD	5499	Pmt	38
61653623	Orange	2021-11-23 01:00:00+01	D	27.00	Internet bill	USD	\N	Pmt	10
61683793	Hertz	2021-12-17 01:00:00+01	D	14.70	Taxi	USD	7519	Pmt	105
61972330	Glovo	2021-12-17 01:00:00+01	D	43.80	Food delivery	USD	5811	Pmt	39
61979670	Wolt	2021-08-24 02:00:00+02	D	15.00	Food delivery	USD	5811	Pmt	39
62163515	Lidl	2021-12-13 01:00:00+01	D	94.40	Supermaket shopping	USD	5200	Pmt	56
62166651	Delhaize	2021-04-01 02:00:00+02	D	30.90	Supermaket shopping	USD	5499	Pmt	38
62185692	Wolt	2021-07-04 02:00:00+02	D	46.30	Food delivery	USD	5811	Pmt	39
62189376	Gift shop	2021-04-19 02:00:00+02	D	57.30	Birthday gifts	USD	5947	Pmt	42
62219630	Pet hotel Happy Dog	2021-10-09 02:00:00+02	D	100.60	Monthly stay	USD	5995	Pmt	84
62242503	Comcast	2021-04-24 02:00:00+02	D	18.30	Television bill	USD	\N	Pmt	12
62247645	Wolt	2021-10-27 02:00:00+02	D	15.10	Food delivery	USD	5811	Pmt	39
62332295	Delhaize	2021-09-24 02:00:00+02	D	31.60	Supermaket shopping	USD	5499	Pmt	38
62376166	Revolut	2021-09-21 02:00:00+02	D	6.30	Revolut Silver subscription	USD	\N	Fee	25
62403764	Wolt	2021-01-10 01:00:00+01	D	20.20	Food delivery	USD	5811	Pmt	39
62460917	Lidl	2021-09-05 02:00:00+02	D	39.60	Supermaket shopping	USD	5499	Pmt	38
62511511	City parkings	2021-01-05 01:00:00+01	D	2.30	Parking fee	USD	7523	Pmt	5
62678590	City parkings	2021-03-16 01:00:00+01	D	2.70	Parking fee	USD	7523	Pmt	5
62684206	Glovo	2021-01-15 01:00:00+01	D	48.90	Food delivery	USD	5811	Pmt	39
62686611	Wolt	2021-03-15 01:00:00+01	D	19.90	Food delivery	USD	5811	Pmt	39
62726303	Book depository	2021-04-24 02:00:00+02	D	7.20	Amazon Kindle subscription	USD	\N	Pmt	15
62728791	Lidl	2021-09-19 02:00:00+02	D	37.90	Supermaket shopping	USD	5499	Pmt	38
62748919	Asseco	2021-09-04 02:00:00+02	C	2497.60	Salary	USD	\N	Sal	62
62809479	Glovo	2021-03-12 01:00:00+01	D	22.80	Food delivery	USD	5811	Pmt	39
63017868	Glovo	2021-02-24 01:00:00+01	D	19.40	Food delivery	USD	5811	Pmt	39
63079325	Tele9	2021-09-28 02:00:00+02	D	13.80	Television bill	USD	\N	Pmt	12
63131923	Wolt	2021-05-15 02:00:00+02	D	17.60	Food delivery	USD	5811	Pmt	39
63189966	Wolt	2021-10-12 02:00:00+02	D	37.50	Food delivery	USD	5811	Pmt	39
63219460	Glovo	2021-04-17 02:00:00+02	D	15.20	Food delivery	USD	5811	Pmt	39
63228493	Fit and Fun	2021-02-25 01:00:00+01	D	21.40	Gym membership	USD	\N	Pmt	47
63296671	Revolut	2021-12-07 01:00:00+01	D	3.20	ATM withdrawal fee	USD	\N	Fee	25
63481773	Lidl	2021-01-17 01:00:00+01	D	32.90	Supermaket shopping	USD	5499	Pmt	38
63503062	Wolt	2021-07-15 02:00:00+02	D	32.70	Food delivery	USD	5811	Pmt	39
63717018	Protetcta	2021-03-11 01:00:00+01	D	29.40	Doctor's appointment	USD	8011	Pmt	45
63727508	Wolt	2021-06-11 02:00:00+02	D	16.70	Food delivery	USD	5811	Pmt	39
63809101	Delhaize	2021-02-23 01:00:00+01	D	30.40	Supermaket shopping	USD	5499	Pmt	38
63809308	Table tenis club PingPong	2021-01-24 01:00:00+01	D	13.40	Table tennis 2 hrs	USD	5655	Pmt	50
63826888	Glovo	2021-01-25 01:00:00+01	D	41.60	Food delivery	USD	5811	Pmt	39
63836126	Lidl	2021-10-15 02:00:00+02	D	35.20	Supermaket shopping	USD	5499	Pmt	38
63897326	Fit and Fun	2021-01-18 01:00:00+01	D	27.30	Gym membership	USD	\N	Pmt	47
64156976	Revolut	2021-02-24 01:00:00+01	D	4.30	ATM withdrawal fee	USD	\N	Fee	25
64169459	T-Mobile	2021-07-24 02:00:00+02	D	16.00	Mobile phone bill	USD	\N	Pmt	11
64402112	T-Mobile	2021-05-01 02:00:00+02	D	15.50	Mobile phone bill	USD	\N	Pmt	11
64474596	Comcast	2021-08-09 02:00:00+02	D	15.70	Television bill	USD	\N	Pmt	12
64570414	Wolt	2021-10-05 02:00:00+02	D	35.80	Food delivery	USD	5811	Pmt	39
64596902	Fit and Fun	2021-07-19 02:00:00+02	D	26.20	Personal trainer	USD	\N	Pmt	47
64704112	Wolt	2021-10-02 02:00:00+02	D	42.60	Food delivery	USD	5811	Pmt	39
64747015	Office365	2021-05-23 02:00:00+02	D	11.90	Games	USD	5045	Pmt	90
64783618	Glovo	2021-10-04 02:00:00+02	D	45.20	Food delivery	USD	5811	Pmt	39
64844805	Lily	2021-03-03 01:00:00+01	D	38.90	Medicine	USD	5912	Pmt	49
64855695	City parkings	2021-08-04 02:00:00+02	D	1.30	Parking fee	USD	7523	Pmt	5
64956400	Glovo	2021-08-27 02:00:00+02	D	25.40	Food delivery	USD	5811	Pmt	39
65079418	Glovo	2021-02-17 01:00:00+01	D	17.10	Food delivery	USD	5811	Pmt	39
65192788	Serenity Wellnes	2021-03-23 01:00:00+01	D	20.90	Massage	USD	8050	Pmt	82
65422095	Orange	2021-03-24 01:00:00+01	D	21.90	Internet bill	USD	\N	Pmt	10
65487464	Adobe	2021-09-01 02:00:00+02	D	16.40	Games	USD	5045	Pmt	90
65551121	Apple	2021-08-16 02:00:00+02	D	15.70	Spotify premium subscription	USD	5733	Pmt	22
65715123	Office365	2021-05-27 02:00:00+02	D	18.70	Games	USD	5045	Pmt	90
65756810	Faculty of contemporary arts	2021-05-20 02:00:00+02	D	186.50	Tuition	USD	8299	Pmt	17
65798098	New York Times	2021-01-17 01:00:00+01	D	5.40	New York Times	USD	5192	Pmt	88
65815632	Wolt	2021-12-06 01:00:00+01	D	37.60	Food delivery	USD	5811	Pmt	39
65831260	Josh	2021-10-17 02:00:00+02	D	34.60	Allowance	USD	\N	Pmt	67
65912072	Raiffeisen Leasing	2021-01-08 01:00:00+01	D	450.50	Financial leasing	USD	7394	Pmt	3
66010387	Glovo	2021-09-23 02:00:00+02	D	20.20	Food delivery	USD	5811	Pmt	39
66229487	Faculty of contemporary arts	2021-01-01 01:00:00+01	D	187.20	Tuition	USD	8299	Pmt	17
66280681	T-Mobile	2021-09-27 02:00:00+02	D	15.20	Mobile phone bill	USD	\N	Pmt	11
66314737	Adobe	2021-10-19 02:00:00+02	D	11.30	Games	USD	5045	Pmt	90
66405592	Wolt	2021-08-13 02:00:00+02	D	49.90	Food delivery	USD	5811	Pmt	39
66447839	Adobe	2021-08-11 02:00:00+02	D	10.80	Games	USD	5045	Pmt	90
66469636	R-Pharm	2021-04-02 02:00:00+02	D	38.70	Medicine	USD	5912	Pmt	49
66478054	Hertz	2021-06-10 02:00:00+02	D	15.40	Car rent	USD	7519	Pmt	105
66515860	New York Times	2021-11-11 01:00:00+01	D	5.90	New York Times	USD	5192	Pmt	88
66580403	Glovo	2021-03-06 01:00:00+01	D	36.80	Food delivery	USD	5811	Pmt	39
66667541	City parkings	2021-11-15 01:00:00+01	D	2.70	Parking fee	USD	7523	Pmt	5
66745234	Tele9	2021-04-25 02:00:00+02	D	10.50	Television bill	USD	\N	Pmt	12
66758659	Delhaize	2021-08-09 02:00:00+02	D	86.20	Supermaket shopping	USD	5200	Pmt	56
66797216	Book depository	2021-01-09 01:00:00+01	D	126.10	Books	USD	\N	Pmt	15
66909495	Book depository	2021-12-23 01:00:00+01	D	14.20	Book	USD	\N	Pmt	15
66918473	Josh	2021-07-03 02:00:00+02	D	48.70	Allowance	USD	\N	Pmt	67
66930857	City parkings	2021-04-03 02:00:00+02	D	2.90	Parking fee	USD	7523	Pmt	5
67126878	Glovo	2021-02-27 01:00:00+01	D	43.90	Food delivery	USD	5811	Pmt	39
67157207	Delhaize	2021-07-10 02:00:00+02	D	34.90	Supermaket shopping	USD	5499	Pmt	38
67238049	Glovo	2021-05-23 02:00:00+02	D	34.80	Food delivery	USD	5811	Pmt	39
67251535	Book depository	2021-01-02 01:00:00+01	D	15.60	Amazon Kindle subscription	USD	\N	Pmt	15
67398830	Music school	2021-04-19 02:00:00+02	D	157.90	Tuition	USD	8299	Pmt	17
67414938	Wolt	2021-06-21 02:00:00+02	D	40.40	Food delivery	USD	5811	Pmt	39
67551085	Glovo	2021-07-01 02:00:00+02	D	24.00	Food delivery	USD	5811	Pmt	39
67876402	Adobe	2021-03-04 01:00:00+01	D	11.00	TV	USD	5045	Pmt	90
67938471	Glovo	2021-10-28 02:00:00+02	D	48.10	Food delivery	USD	5811	Pmt	39
67939217	City parkings	2021-12-24 01:00:00+01	D	1.20	Parking fee	USD	7523	Pmt	5
67952685	A1 Telecom	2021-03-07 01:00:00+01	D	34.00	Internet bill	USD	\N	Pmt	10
67979945	Glovo	2021-06-04 02:00:00+02	D	28.90	Food delivery	USD	5811	Pmt	39
68026771	Wolt	2021-06-13 02:00:00+02	D	15.30	Food delivery	USD	5811	Pmt	39
68133666	Swimming pool Activa	2021-07-20 02:00:00+02	D	12.00	Table tennis 2 hrs	USD	5655	Pmt	50
68207272	Wolt	2021-01-18 01:00:00+01	D	38.30	Food delivery	USD	5811	Pmt	39
68385714	City parkings	2021-11-10 01:00:00+01	D	2.40	Parking fee	USD	7523	Pmt	5
68396471	Glovo	2021-11-25 01:00:00+01	D	15.80	Food delivery	USD	5811	Pmt	39
68462287	Pet shop	2021-07-01 02:00:00+02	D	25.40	Shopping	USD	5995	Pmt	84
68514521	Wolt	2021-02-02 01:00:00+01	D	15.50	Food delivery	USD	5811	Pmt	39
68755095	Glovo	2021-12-12 01:00:00+01	D	44.60	Food delivery	USD	5811	Pmt	39
68794249	Book depository	2021-07-07 02:00:00+02	D	14.00	Amazon Kindle subscription	USD	\N	Pmt	15
69032602	Wolt	2021-05-06 02:00:00+02	D	47.20	Food delivery	USD	5811	Pmt	39
69103489	Hertz	2021-07-03 02:00:00+02	D	14.90	Taxi	USD	7519	Pmt	105
69117927	Wolt	2021-06-23 02:00:00+02	D	47.50	Food delivery	USD	5811	Pmt	39
69139972	Wolt	2021-12-18 01:00:00+01	D	30.10	Food delivery	USD	5811	Pmt	39
69142233	Wolt	2021-12-04 01:00:00+01	D	47.70	Food delivery	USD	5811	Pmt	39
69165310	R-Pharm	2021-02-20 01:00:00+01	D	37.30	Medicine	USD	5912	Pmt	49
69172653	Glovo	2021-08-07 02:00:00+02	D	36.30	Food delivery	USD	5811	Pmt	39
69611262	Glovo	2021-11-02 01:00:00+01	D	48.70	Food delivery	USD	5811	Pmt	39
69635201	Glovo	2021-05-05 02:00:00+02	D	18.60	Food delivery	USD	5811	Pmt	39
69706266	Serenity Wellnes	2021-12-22 01:00:00+01	D	23.70	Spa treatment	USD	8050	Pmt	82
69742238	Wolt	2021-08-19 02:00:00+02	D	49.30	Food delivery	USD	5811	Pmt	39
69854485	Glovo	2021-07-06 02:00:00+02	D	22.60	Food delivery	USD	5811	Pmt	39
69868691	Delhaize	2021-10-20 02:00:00+02	D	39.70	Supermaket shopping	USD	5499	Pmt	38
69872134	Lidl	2021-10-21 02:00:00+02	D	39.00	Supermaket shopping	USD	5499	Pmt	38
69872702	MetLife	2021-06-09 02:00:00+02	D	200.40	Life insurance premium	USD	6300	Pmt	33
69950114	Jill	2021-02-26 01:00:00+01	D	39.90	Allowance	USD	\N	Pmt	67
69969043	Lidl	2021-01-19 01:00:00+01	D	34.40	Supermaket shopping	USD	5499	Pmt	38
70061986	Serenity Wellnes	2021-09-01 02:00:00+02	D	21.30	Spa treatment	USD	8050	Pmt	82
70081297	Glovo	2021-10-22 02:00:00+02	D	35.50	Food delivery	USD	5811	Pmt	39
70413225	Delhaize	2021-12-07 01:00:00+01	D	40.00	Supermaket shopping	USD	5499	Pmt	38
70473238	Glovo	2021-03-28 01:00:00+01	D	15.20	Food delivery	USD	5811	Pmt	39
70572567	A1 Telecom	2021-05-25 02:00:00+02	D	15.00	Mobile phone bill	USD	\N	Pmt	11
70632405	Glovo	2021-01-17 01:00:00+01	D	32.00	Food delivery	USD	5811	Pmt	39
70740505	Wolt	2021-06-28 02:00:00+02	D	41.00	Food delivery	USD	5811	Pmt	39
70811255	City parkings	2021-06-09 02:00:00+02	D	1.60	Parking fee	USD	7523	Pmt	5
70889975	Glovo	2021-02-03 01:00:00+01	D	23.70	Food delivery	USD	5811	Pmt	39
70919477	Claire Stevens	2021-01-07 01:00:00+01	C	300.10	Monthly rent	USD	\N	Dep	58
70960727	UniCredit Leasing	2021-10-11 02:00:00+02	D	450.30	Financial leasing	USD	7394	Pmt	3
70976000	Claire Stevens	2021-05-10 02:00:00+02	C	300.40	Monthly rent	USD	\N	Dep	58
71204698	Glovo	2021-10-21 02:00:00+02	D	45.10	Food delivery	USD	5811	Pmt	39
71233330	Glovo	2021-01-01 01:00:00+01	D	17.00	Food delivery	USD	5811	Pmt	39
71234195	A1 Telecom	2021-06-08 02:00:00+02	D	26.70	Internet bill	USD	\N	Pmt	10
71433274	Apple	2021-04-07 02:00:00+02	D	15.70	Apple music subscription	USD	5733	Pmt	22
71492996	Glovo	2021-07-01 02:00:00+02	D	39.00	Food delivery	USD	5811	Pmt	39
71499210	The barbers	2021-06-20 02:00:00+02	D	28.60	Haircut	USD	7230	Pmt	80
71708912	Wolt	2021-10-17 02:00:00+02	D	28.90	Food delivery	USD	5811	Pmt	39
71750058	Delhaize	2021-04-08 02:00:00+02	D	30.70	Supermaket shopping	USD	5499	Pmt	38
71761727	Serenity Wellnes	2021-12-03 01:00:00+01	D	23.10	Spa treatment	USD	8050	Pmt	82
71767649	Pet hotel Happy Dog	2021-05-13 02:00:00+02	D	100.50	Monthly stay	USD	5995	Pmt	84
71784584	Lidl	2021-08-04 02:00:00+02	D	34.40	Supermaket shopping	USD	5499	Pmt	38
71881460	Glovo	2021-03-22 01:00:00+01	D	21.80	Food delivery	USD	5811	Pmt	39
72012064	Delhaize	2021-08-18 02:00:00+02	D	36.50	Supermaket shopping	USD	5499	Pmt	38
72046445	City parkings	2021-10-03 02:00:00+02	D	1.20	Parking fee	USD	7523	Pmt	5
72098747	Lidl	2021-06-22 02:00:00+02	D	34.70	Supermaket shopping	USD	5499	Pmt	38
72359262	Wells Fargo	2021-04-04 02:00:00+02	D	38.20	Loan Payment	USD	\N	Pmt	77
72500295	Wolt	2021-06-16 02:00:00+02	D	15.70	Food delivery	USD	5811	Pmt	39
72519920	Serenity Wellnes	2021-04-03 02:00:00+02	D	23.50	Massage	USD	8050	Pmt	82
72617432	Pet store	2021-09-17 02:00:00+02	D	23.80	Shopping	USD	5995	Pmt	84
72626830	Jill	2021-03-27 01:00:00+01	D	50.10	Allowance	USD	\N	Pmt	67
72661802	Wolt	2021-05-25 02:00:00+02	D	27.90	Food delivery	USD	5811	Pmt	39
72707824	Jill	2021-06-25 02:00:00+02	D	39.60	Allowance	USD	\N	Pmt	67
72734640	Swimming pool Activa	2021-11-28 01:00:00+01	D	12.40	Daily pool ticket	USD	5655	Pmt	50
73137207	Glovo	2021-11-07 01:00:00+01	D	47.30	Food delivery	USD	5811	Pmt	39
73231441	Delhaize	2021-10-26 02:00:00+02	D	32.00	Supermaket shopping	USD	5499	Pmt	38
73233292	Spotify	2021-06-09 02:00:00+02	D	15.70	Apple music subscription	USD	5733	Pmt	22
73316470	Wolt	2021-01-10 01:00:00+01	D	21.60	Food delivery	USD	5811	Pmt	39
73393927	National Geographic	2021-04-14 02:00:00+02	D	5.10	National Geographic	USD	5192	Pmt	88
73429464	Wolt	2021-09-21 02:00:00+02	D	20.50	Food delivery	USD	5811	Pmt	39
73499286	Lidl	2021-03-13 01:00:00+01	D	30.20	Supermaket shopping	USD	5499	Pmt	38
73611126	Blue moon spa	2021-09-17 02:00:00+02	D	25.10	Spa treatment	USD	8050	Pmt	82
73621891	Glovo	2021-03-20 01:00:00+01	D	29.30	Food delivery	USD	5811	Pmt	39
73634659	Delhaize	2021-09-20 02:00:00+02	D	40.10	Supermaket shopping	USD	5499	Pmt	38
73669183	Fit and Fun	2021-06-20 02:00:00+02	D	20.60	Personal trainer	USD	\N	Pmt	47
74014301	Raiffeisen Leasing	2021-02-24 01:00:00+01	D	450.00	Financial leasing	USD	7394	Pmt	3
74089501	Glovo	2021-06-05 02:00:00+02	D	19.10	Food delivery	USD	5811	Pmt	39
74228925	Adobe	2021-11-16 01:00:00+01	D	12.00	TV	USD	5045	Pmt	90
74478939	Pet store	2021-07-20 02:00:00+02	D	24.80	Shopping	USD	5995	Pmt	84
74502677	Wolt	2021-10-06 02:00:00+02	D	24.90	Food delivery	USD	5811	Pmt	39
74699073	Delhaize	2021-05-22 02:00:00+02	D	33.70	Supermaket shopping	USD	5499	Pmt	38
74857935	Save our kids	2021-10-12 02:00:00+02	D	56.70	Charity	USD	\N	Pmt	41
74868229	Office365	2021-02-22 01:00:00+01	D	10.60	Games	USD	5045	Pmt	90
74901989	Chase	2021-02-10 01:00:00+01	D	400.60	Rent pay	USD	\N	Pmt	58
74907364	Wolt	2021-09-09 02:00:00+02	D	15.80	Food delivery	USD	5811	Pmt	39
75032417	Glovo	2021-07-02 02:00:00+02	D	44.60	Food delivery	USD	5811	Pmt	39
75119370	Glovo	2021-06-04 02:00:00+02	D	38.60	Food delivery	USD	5811	Pmt	39
75444294	Wolt	2021-07-24 02:00:00+02	D	20.70	Food delivery	USD	5811	Pmt	39
75504265	Real Estate	2021-06-20 02:00:00+02	D	193.90	Tax pay	USD	9311	Pmt	96
75885438	Lidl	2021-05-20 02:00:00+02	D	100.60	Supermaket shopping	USD	5200	Pmt	56
75888461	A1 Telecom	2021-04-28 02:00:00+02	D	27.20	Internet bill	USD	\N	Pmt	10
75906428	Glovo	2021-09-07 02:00:00+02	D	33.10	Food delivery	USD	5811	Pmt	39
75932511	Wolt	2021-02-09 01:00:00+01	D	26.70	Food delivery	USD	5811	Pmt	39
76053069	Hertz	2021-01-01 01:00:00+01	D	11.60	Taxi	USD	7519	Pmt	105
76063629	Glovo	2021-07-14 02:00:00+02	D	17.80	Food delivery	USD	5811	Pmt	39
76087191	Delhaize	2021-03-09 01:00:00+01	D	37.90	Supermaket shopping	USD	5499	Pmt	38
76398578	Delhaize	2021-05-28 02:00:00+02	D	32.90	Supermaket shopping	USD	5499	Pmt	38
76525894	Wolt	2021-05-07 02:00:00+02	D	16.90	Food delivery	USD	5811	Pmt	39
76544689	Wolt	2021-04-12 02:00:00+02	D	43.60	Food delivery	USD	5811	Pmt	39
76584333	Wolt	2021-12-06 01:00:00+01	D	41.50	Food delivery	USD	5811	Pmt	39
76617746	Asseco	2021-03-15 01:00:00+01	C	2457.20	Salary	USD	\N	Sal	62
76677421	National Geographic	2021-02-14 01:00:00+01	D	4.50	National Geographic	USD	5192	Pmt	88
76883489	Delhaize	2021-08-12 02:00:00+02	D	39.70	Supermaket shopping	USD	5499	Pmt	38
76934379	Protetcta	2021-04-17 02:00:00+02	D	23.60	Doctor's appointment	USD	8011	Pmt	45
76988613	Glovo	2021-03-16 01:00:00+01	D	44.00	Food delivery	USD	5811	Pmt	39
77004257	Wolt	2021-05-11 02:00:00+02	D	28.90	Food delivery	USD	5811	Pmt	39
77063158	Josh	2021-09-19 02:00:00+02	D	35.30	Allowance	USD	\N	Pmt	67
77083739	Lending Club	2021-04-01 02:00:00+02	D	42.40	Loan Payment	USD	\N	Pmt	77
77130981	New York Times	2021-04-08 02:00:00+02	D	6.00	National Geographic	USD	5192	Pmt	88
77280316	MetLife	2021-01-04 01:00:00+01	D	200.90	Life insurance premium	USD	6300	Pmt	33
77386769	Fit and Fun	2021-12-13 01:00:00+01	D	24.10	Gym membership	USD	\N	Pmt	47
77428861	Glovo	2021-11-03 01:00:00+01	D	32.10	Food delivery	USD	5811	Pmt	39
77541439	Glovo	2021-02-27 01:00:00+01	D	44.40	Food delivery	USD	5811	Pmt	39
77558452	Chevron	2021-07-10 02:00:00+02	D	74.40	Gasoline purchases	USD	5983	Pmt	4
77672113	Glovo	2021-01-24 01:00:00+01	D	35.90	Food delivery	USD	5811	Pmt	39
77984990	Serenity Wellnes	2021-12-11 01:00:00+01	D	24.30	Massage	USD	8050	Pmt	82
77988353	Glovo	2021-08-25 02:00:00+02	D	17.30	Food delivery	USD	5811	Pmt	39
77995010	Wolt	2021-08-02 02:00:00+02	D	22.10	Food delivery	USD	5811	Pmt	39
78008116	Lending Club	2021-12-26 01:00:00+01	D	61.80	Loan Payment	USD	\N	Pmt	77
78392133	Sixt GmbH	2021-05-04 02:00:00+02	D	11.30	Taxi	USD	7519	Pmt	105
78578537	Lidl	2021-10-04 02:00:00+02	D	33.80	Supermaket shopping	USD	5499	Pmt	38
78584321	Residential Property	2021-04-10 02:00:00+02	D	172.40	Tax pay	USD	9311	Pmt	96
78624056	Lidl	2021-01-07 01:00:00+01	D	36.80	Supermaket shopping	USD	5499	Pmt	38
78625804	Pet hotel Happy Dog	2021-05-19 02:00:00+02	D	100.90	Monthly stay	USD	5995	Pmt	84
78627884	Music school	2021-01-22 01:00:00+01	D	199.10	Tuition	USD	8299	Pmt	17
78649843	Glovo	2021-02-03 01:00:00+01	D	26.40	Food delivery	USD	5811	Pmt	39
78768783	Wolt	2021-02-24 01:00:00+01	D	24.80	Food delivery	USD	5811	Pmt	39
78793209	MetLife	2021-06-03 02:00:00+02	D	201.00	Life insurance premium	USD	6300	Pmt	33
78796714	Comcast	2021-05-06 02:00:00+02	D	10.30	Television bill	USD	\N	Pmt	12
79075986	Serenity Wellnes	2021-05-25 02:00:00+02	D	21.80	Massage	USD	8050	Pmt	82
79145432	Lidl	2021-05-15 02:00:00+02	D	90.00	Supermaket shopping	USD	5200	Pmt	56
79146361	Wolt	2021-10-11 02:00:00+02	D	37.80	Food delivery	USD	5811	Pmt	39
79168933	National Geographic	2021-04-17 02:00:00+02	D	4.40	National Geographic	USD	5192	Pmt	88
79223553	Music school	2021-08-20 02:00:00+02	D	198.20	Tuition	USD	8299	Pmt	17
79248082	Pet hotel Happy Dog	2021-08-16 02:00:00+02	D	100.70	Monthly stay	USD	5995	Pmt	84
79283173	Wolt	2021-03-24 01:00:00+01	D	38.80	Food delivery	USD	5811	Pmt	39
79358545	Raiffeisen Leasing	2021-09-06 02:00:00+02	D	450.60	Financial leasing	USD	7394	Pmt	3
79522957	Glovo	2021-02-25 01:00:00+01	D	26.70	Food delivery	USD	5811	Pmt	39
79633437	Wolt	2021-02-23 01:00:00+01	D	34.70	Food delivery	USD	5811	Pmt	39
79643904	Pet store	2021-03-22 01:00:00+01	D	24.40	Shopping	USD	5995	Pmt	84
79644229	New York Times	2021-12-21 01:00:00+01	D	3.60	New York Times	USD	5192	Pmt	88
79671913	Asseco	2021-12-20 01:00:00+01	C	2458.40	Salary	USD	\N	Sal	62
79801658	Glovo	2021-11-23 01:00:00+01	D	50.90	Food delivery	USD	5811	Pmt	39
79804236	Adobe	2021-05-17 02:00:00+02	D	15.20	Games	USD	5045	Pmt	90
80018306	Wolt	2021-05-24 02:00:00+02	D	46.70	Food delivery	USD	5811	Pmt	39
80237628	Wolt	2021-11-20 01:00:00+01	D	21.70	Food delivery	USD	5811	Pmt	39
80305142	Table tenis club PingPong	2021-07-19 02:00:00+02	D	10.30	Table tennis 2 hrs	USD	5655	Pmt	50
80429865	Delhaize	2021-08-08 02:00:00+02	D	39.90	Supermaket shopping	USD	5499	Pmt	38
80437095	Wolt	2021-06-12 02:00:00+02	D	39.40	Food delivery	USD	5811	Pmt	39
80465508	Swimming pool Activa	2021-03-03 01:00:00+01	D	15.60	Table tennis 2 hrs	USD	5655	Pmt	50
80502762	Wolt	2021-10-26 02:00:00+02	D	38.90	Food delivery	USD	5811	Pmt	39
80551559	Wolt	2021-05-01 02:00:00+02	D	40.50	Food delivery	USD	5811	Pmt	39
80554166	Wolt	2021-08-10 02:00:00+02	D	17.10	Food delivery	USD	5811	Pmt	39
80694895	T-Mobile	2021-09-24 02:00:00+02	D	20.90	Mobile phone bill	USD	\N	Pmt	11
80728462	Revolut	2021-11-22 01:00:00+01	D	3.40	Revolut Silver subscription	USD	\N	Fee	25
80802711	Wolt	2021-01-27 01:00:00+01	D	25.60	Food delivery	USD	5811	Pmt	39
81106968	Asseco	2021-03-04 01:00:00+01	C	2376.50	Salary	USD	\N	Sal	62
81174489	Wolt	2021-05-27 02:00:00+02	D	36.60	Food delivery	USD	5811	Pmt	39
81175550	New York Times	2021-01-15 01:00:00+01	D	3.10	National Geographic	USD	5192	Pmt	88
81183969	Josh	2021-05-20 02:00:00+02	D	35.70	Allowance	USD	\N	Pmt	67
81206808	Apple	2021-01-19 01:00:00+01	D	15.20	Spotify premium subscription	USD	5733	Pmt	22
81379047	Lending Club	2021-01-10 01:00:00+01	D	33.20	Loan Payment	USD	\N	Pmt	77
81491994	Lidl	2021-02-20 01:00:00+01	D	37.30	Supermaket shopping	USD	5499	Pmt	38
81496870	Glovo	2021-01-27 01:00:00+01	D	36.10	Food delivery	USD	5811	Pmt	39
81554231	Lidl	2021-02-11 01:00:00+01	D	37.30	Supermaket shopping	USD	5499	Pmt	38
81592583	Claire Stevens	2021-06-09 02:00:00+02	C	300.70	Monthly rent	USD	\N	Dep	58
81883425	Blue moon spa	2021-12-27 01:00:00+01	D	24.10	Massage	USD	8050	Pmt	82
81957044	Wolt	2021-04-20 02:00:00+02	D	32.60	Food delivery	USD	5811	Pmt	39
81972960	Chase	2021-01-24 01:00:00+01	D	400.70	Rent pay	USD	\N	Pmt	58
82009773	Glovo	2021-09-08 02:00:00+02	D	20.30	Food delivery	USD	5811	Pmt	39
82016683	Lidl	2021-04-14 02:00:00+02	D	39.10	Supermaket shopping	USD	5499	Pmt	38
82062321	Swimming pool Activa	2021-05-12 02:00:00+02	D	15.20	Daily pool ticket	USD	5655	Pmt	50
82293549	City parkings	2021-06-19 02:00:00+02	D	1.90	Parking fee	USD	7523	Pmt	5
82337135	Comcast	2021-01-18 01:00:00+01	D	18.60	Television bill	USD	\N	Pmt	12
82392179	Glovo	2021-12-12 01:00:00+01	D	24.20	Food delivery	USD	5811	Pmt	39
82557584	Glovo	2021-11-27 01:00:00+01	D	16.10	Food delivery	USD	5811	Pmt	39
82672832	Glovo	2021-04-22 02:00:00+02	D	39.00	Food delivery	USD	5811	Pmt	39
82754807	Wolt	2021-04-02 02:00:00+02	D	26.60	Food delivery	USD	5811	Pmt	39
83001561	The barbers	2021-02-07 01:00:00+01	D	35.70	Haircut	USD	7230	Pmt	80
83101157	Wolt	2021-08-11 02:00:00+02	D	39.10	Food delivery	USD	5811	Pmt	39
83214659	Book depository	2021-05-19 02:00:00+02	D	121.60	Books	USD	\N	Pmt	15
83216834	Serenity Wellnes	2021-04-23 02:00:00+02	D	24.90	Massage	USD	8050	Pmt	82
83279666	Glovo	2021-06-27 02:00:00+02	D	50.70	Food delivery	USD	5811	Pmt	39
83386978	Glovo	2021-06-11 02:00:00+02	D	33.00	Food delivery	USD	5811	Pmt	39
83389417	Wolt	2021-07-01 02:00:00+02	D	35.70	Food delivery	USD	5811	Pmt	39
83427132	Music school	2021-08-18 02:00:00+02	D	169.90	Tuition	USD	8299	Pmt	17
83443227	Wolt	2021-08-13 02:00:00+02	D	26.20	Food delivery	USD	5811	Pmt	39
83689952	Table tenis club PingPong	2021-08-24 02:00:00+02	D	15.50	Table tennis 2 hrs	USD	5655	Pmt	50
83786736	Pet hotel Happy Dog	2021-09-08 02:00:00+02	D	100.70	Monthly stay	USD	5995	Pmt	84
83836055	Wolt	2021-04-23 02:00:00+02	D	21.80	Food delivery	USD	5811	Pmt	39
84003434	Glovo	2021-03-07 01:00:00+01	D	39.30	Food delivery	USD	5811	Pmt	39
84054407	Jill	2021-06-12 02:00:00+02	D	33.80	Allowance	USD	\N	Pmt	67
84071738	Wolt	2021-10-21 02:00:00+02	D	18.30	Food delivery	USD	5811	Pmt	39
84125709	Apple	2021-08-14 02:00:00+02	D	16.00	Apple music subscription	USD	5733	Pmt	22
84152054	Table tenis club PingPong	2021-04-16 02:00:00+02	D	11.80	Table tennis 2 hrs	USD	5655	Pmt	50
84330116	Sixt GmbH	2021-03-02 01:00:00+01	D	11.40	Car rent	USD	7519	Pmt	105
84394274	Protetcta	2021-11-22 01:00:00+01	D	17.50	Doctor's appointment	USD	8011	Pmt	45
84413223	Glovo	2021-03-26 01:00:00+01	D	17.30	Food delivery	USD	5811	Pmt	39
84544546	Dental Plus	2021-12-12 01:00:00+01	D	26.40	Doctor's appointment	USD	8011	Pmt	45
84550717	New York Times	2021-07-26 02:00:00+02	D	3.90	New York Times	USD	5192	Pmt	88
84566914	Table tenis club PingPong	2021-08-05 02:00:00+02	D	13.50	Daily pool ticket	USD	5655	Pmt	50
84630285	Revolut	2021-12-04 01:00:00+01	D	2.80	ATM withdrawal fee	USD	\N	Fee	25
84685491	Asseco	2021-10-02 02:00:00+02	C	2329.70	Salary	USD	\N	Sal	62
84719269	Sixt GmbH	2021-11-14 01:00:00+01	D	10.50	Car rent	USD	7519	Pmt	105
84738791	Glovo	2021-09-04 02:00:00+02	D	40.50	Food delivery	USD	5811	Pmt	39
84748806	Wolt	2021-08-05 02:00:00+02	D	41.30	Food delivery	USD	5811	Pmt	39
84794104	T-Mobile	2021-06-02 02:00:00+02	D	17.80	Mobile phone bill	USD	\N	Pmt	11
84802909	Lidl	2021-12-02 01:00:00+01	D	36.30	Supermaket shopping	USD	5499	Pmt	38
84874402	Chevron	2021-02-06 01:00:00+01	D	71.30	Gasoline purchases	USD	5983	Pmt	4
84895059	The barbers	2021-01-23 01:00:00+01	D	38.20	Haircut	USD	7230	Pmt	80
84915683	Lidl	2021-05-01 02:00:00+02	D	30.80	Supermaket shopping	USD	5499	Pmt	38
85015410	Delhaize	2021-11-21 01:00:00+01	D	40.50	Supermaket shopping	USD	5499	Pmt	38
85039329	Lidl	2021-08-25 02:00:00+02	D	32.10	Supermaket shopping	USD	5499	Pmt	38
85157558	Lidl	2021-11-25 01:00:00+01	D	40.10	Supermaket shopping	USD	5499	Pmt	38
85566023	Wolt	2021-12-27 01:00:00+01	D	28.20	Food delivery	USD	5811	Pmt	39
85605629	Wolt	2021-05-07 02:00:00+02	D	48.80	Food delivery	USD	5811	Pmt	39
85635367	Lending Club	2021-08-09 02:00:00+02	D	35.40	Loan Payment	USD	\N	Pmt	77
85696183	Glovo	2021-08-28 02:00:00+02	D	25.40	Food delivery	USD	5811	Pmt	39
85705641	Lending Club	2021-03-14 01:00:00+01	D	70.40	Loan Payment	USD	\N	Pmt	77
85715522	Glovo	2021-01-15 01:00:00+01	D	26.80	Food delivery	USD	5811	Pmt	39
85739193	Table tenis club PingPong	2021-08-23 02:00:00+02	D	10.00	Daily pool ticket	USD	5655	Pmt	50
85764195	Glovo	2021-10-07 02:00:00+02	D	19.20	Food delivery	USD	5811	Pmt	39
85783580	Hertz	2021-10-28 02:00:00+02	D	12.40	Car rent	USD	7519	Pmt	105
85822229	Wolt	2021-09-17 02:00:00+02	D	36.10	Food delivery	USD	5811	Pmt	39
85847794	Fit and Fun	2021-11-12 01:00:00+01	D	23.30	Personal trainer	USD	\N	Pmt	47
85911630	Wolt	2021-09-25 02:00:00+02	D	18.80	Food delivery	USD	5811	Pmt	39
85948375	A1 Telecom	2021-08-19 02:00:00+02	D	33.90	Internet bill	USD	\N	Pmt	10
85979197	UniCredit Leasing	2021-02-24 01:00:00+01	D	450.00	Financial leasing	USD	7394	Pmt	3
85983811	Office365	2021-04-04 02:00:00+02	D	16.70	TV	USD	5045	Pmt	90
86049607	Hertz	2021-06-02 02:00:00+02	D	13.80	Car rent	USD	7519	Pmt	105
86224596	Asseco	2021-10-07 02:00:00+02	C	2494.20	Salary	USD	\N	Sal	62
86366332	Glovo	2021-03-24 01:00:00+01	D	48.10	Food delivery	USD	5811	Pmt	39
86382560	City parkings	2021-08-02 02:00:00+02	D	2.20	Parking fee	USD	7523	Pmt	5
86549441	Lidl	2021-07-27 02:00:00+02	D	89.80	Supermaket shopping	USD	5200	Pmt	56
86556224	Serenity Wellnes	2021-04-24 02:00:00+02	D	20.10	Massage	USD	8050	Pmt	82
86735144	Faculty of contemporary arts	2021-04-14 02:00:00+02	D	199.30	Tuition	USD	8299	Pmt	17
87031393	Lidl	2021-01-11 01:00:00+01	D	90.70	Supermaket shopping	USD	5200	Pmt	56
87060158	Chevron	2021-10-21 02:00:00+02	D	60.40	Gasoline purchases	USD	5983	Pmt	4
87110956	Lending Club	2021-12-01 01:00:00+01	D	70.10	Loan Payment	USD	\N	Pmt	77
87296165	Wolt	2021-02-07 01:00:00+01	D	32.90	Food delivery	USD	5811	Pmt	39
87320434	Delhaize	2021-02-02 01:00:00+01	D	34.80	Supermaket shopping	USD	5499	Pmt	38
87379790	Revolut	2021-02-25 01:00:00+01	D	5.50	ATM withdrawal fee	USD	\N	Fee	25
87414176	Lidl	2021-03-22 01:00:00+01	D	31.60	Supermaket shopping	USD	5499	Pmt	38
87432031	Delhaize	2021-04-12 02:00:00+02	D	37.50	Supermaket shopping	USD	5499	Pmt	38
87499780	Swimming pool Activa	2021-02-12 01:00:00+01	D	15.20	Table tennis 2 hrs	USD	5655	Pmt	50
87624165	Glovo	2021-06-10 02:00:00+02	D	34.80	Food delivery	USD	5811	Pmt	39
87652164	City parkings	2021-08-05 02:00:00+02	D	2.50	Parking fee	USD	7523	Pmt	5
87703931	Save our kids	2021-02-25 01:00:00+01	D	43.00	Charity	USD	\N	Pmt	41
87777270	R-Pharm	2021-03-19 01:00:00+01	D	39.80	Medicine	USD	5912	Pmt	49
87799232	Jill	2021-04-14 02:00:00+02	D	48.60	Allowance	USD	\N	Pmt	67
87903961	Fit and Fun	2021-03-19 01:00:00+01	D	25.60	Gym membership	USD	\N	Pmt	47
87939023	Gift shop	2021-08-13 02:00:00+02	D	173.90	Birthday gifts	USD	5947	Pmt	42
87991257	Glovo	2021-01-11 01:00:00+01	D	40.60	Food delivery	USD	5811	Pmt	39
87993781	Glovo	2021-08-04 02:00:00+02	D	44.80	Food delivery	USD	5811	Pmt	39
88164688	UniCredit Leasing	2021-07-09 02:00:00+02	D	450.20	Financial leasing	USD	7394	Pmt	3
88185546	Glovo	2021-06-01 02:00:00+02	D	48.10	Food delivery	USD	5811	Pmt	39
88450187	T-Mobile	2021-01-15 01:00:00+01	D	13.20	Mobile phone bill	USD	\N	Pmt	11
88732506	Glovo	2021-02-28 01:00:00+01	D	29.00	Food delivery	USD	5811	Pmt	39
88920242	The barbers	2021-06-10 02:00:00+02	D	31.10	Haircut	USD	7230	Pmt	80
88965487	Wolt	2021-03-27 01:00:00+01	D	15.20	Food delivery	USD	5811	Pmt	39
89036399	Music school	2021-07-20 02:00:00+02	D	182.90	Tuition	USD	8299	Pmt	17
89107412	Pet shop	2021-12-19 01:00:00+01	D	22.60	Shopping	USD	5995	Pmt	84
89152762	Wolt	2021-10-06 02:00:00+02	D	26.40	Food delivery	USD	5811	Pmt	39
89154942	Glovo	2021-12-25 01:00:00+01	D	43.80	Food delivery	USD	5811	Pmt	39
89223418	Revolut	2021-03-25 01:00:00+01	D	3.40	ATM withdrawal fee	USD	\N	Fee	25
89258546	Jill	2021-05-01 02:00:00+02	D	47.90	Allowance	USD	\N	Pmt	67
89338217	Wolt	2021-06-28 02:00:00+02	D	50.30	Food delivery	USD	5811	Pmt	39
89356973	Glovo	2021-04-24 02:00:00+02	D	17.80	Food delivery	USD	5811	Pmt	39
89553878	Hertz	2021-08-14 02:00:00+02	D	10.20	Car rent	USD	7519	Pmt	105
89589207	Residential Property	2021-01-25 01:00:00+01	D	170.30	Tax pay	USD	9311	Pmt	96
89730748	Lidl	2021-10-06 02:00:00+02	D	39.10	Supermaket shopping	USD	5499	Pmt	38
89753715	Delhaize	2021-11-14 01:00:00+01	D	39.70	Supermaket shopping	USD	5499	Pmt	38
89808516	Delhaize	2021-07-04 02:00:00+02	D	39.40	Supermaket shopping	USD	5499	Pmt	38
89885929	Book depository	2021-05-21 02:00:00+02	D	13.40	Book	USD	\N	Pmt	15
89924962	Wolt	2021-02-18 01:00:00+01	D	28.50	Food delivery	USD	5811	Pmt	39
\.


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20250718212906_InitialPostgresClean	9.0.7
20250718223640_FixingDateTimeColumn	9.0.7
20250721183435_EnableTimeZoneOnTransactionDate	9.0.7
\.


--
-- Name: Categories PK_Categories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "PK_Categories" PRIMARY KEY ("Code");


--
-- Name: TransactionSplits PK_TransactionSplits; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TransactionSplits"
    ADD CONSTRAINT "PK_TransactionSplits" PRIMARY KEY ("Id");


--
-- Name: Transactions PK_Transactions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transactions"
    ADD CONSTRAINT "PK_Transactions" PRIMARY KEY ("Id");


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: IX_Categories_ParentCode; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Categories_ParentCode" ON public."Categories" USING btree ("ParentCode");


--
-- Name: IX_TransactionSplits_CategoryCode; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_TransactionSplits_CategoryCode" ON public."TransactionSplits" USING btree ("CategoryCode");


--
-- Name: IX_TransactionSplits_TransactionId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_TransactionSplits_TransactionId" ON public."TransactionSplits" USING btree ("TransactionId");


--
-- Name: IX_Transactions_catcode; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Transactions_catcode" ON public."Transactions" USING btree (catcode);


--
-- Name: Categories FK_Categories_Categories_ParentCode; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "FK_Categories_Categories_ParentCode" FOREIGN KEY ("ParentCode") REFERENCES public."Categories"("Code") ON DELETE RESTRICT;


--
-- Name: TransactionSplits FK_TransactionSplits_Categories_CategoryCode; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TransactionSplits"
    ADD CONSTRAINT "FK_TransactionSplits_Categories_CategoryCode" FOREIGN KEY ("CategoryCode") REFERENCES public."Categories"("Code") ON DELETE RESTRICT;


--
-- Name: TransactionSplits FK_TransactionSplits_Transactions_TransactionId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TransactionSplits"
    ADD CONSTRAINT "FK_TransactionSplits_Transactions_TransactionId" FOREIGN KEY ("TransactionId") REFERENCES public."Transactions"("Id") ON DELETE CASCADE;


--
-- Name: Transactions FK_Transactions_Categories_catcode; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transactions"
    ADD CONSTRAINT "FK_Transactions_Categories_catcode" FOREIGN KEY (catcode) REFERENCES public."Categories"("Code") ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

