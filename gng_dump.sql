--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23 (Ubuntu 10.23-0ubuntu0.18.04.2+esm1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- Name: comprises; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.comprises (
    gng_id integer NOT NULL,
    company_id integer NOT NULL,
    member_id integer NOT NULL
);


ALTER TABLE public.comprises OWNER TO c370_s100;

--
-- Name: global_affiliate; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.global_affiliate (
    company_id integer NOT NULL,
    company_name character varying(255),
    company_location character varying(255),
    company_phone character varying(15),
    company_email character varying(255)
);


ALTER TABLE public.global_affiliate OWNER TO c370_s100;

--
-- Name: member; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.member (
    member_id integer NOT NULL,
    member_name character varying(255),
    member_phone character varying(15),
    member_email character varying(255),
    member_notes character varying(255)
);


ALTER TABLE public.member OWNER TO c370_s100;

--
-- Name: volunteer; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.volunteer (
    volunteer_id integer NOT NULL,
    volunteer_name character varying(255),
    tier character varying(255),
    volunteer_phone character varying(15),
    volunteer_email character varying(255),
    volunteer_notes character varying(255)
);


ALTER TABLE public.volunteer OWNER TO c370_s100;

--
-- Name: affiliate_volunteer_relationship; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.affiliate_volunteer_relationship AS
 SELECT g.company_name,
    mem.member_name
   FROM ((public.global_affiliate g
     JOIN public.comprises c_mem ON ((g.company_id = c_mem.member_id)))
     JOIN public.member mem ON ((c_mem.member_id = mem.member_id)))
  WHERE ((mem.member_name)::text IN ( SELECT volunteer.volunteer_name
           FROM public.volunteer
        INTERSECT
         SELECT member.member_name
           FROM public.member));


ALTER TABLE public.affiliate_volunteer_relationship OWNER TO c370_s100;

--
-- Name: expenses; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.expenses (
    campaign_id integer,
    material character varying(255),
    description text,
    cost numeric(10,2),
    date_of_purchase date
);


ALTER TABLE public.expenses OWNER TO c370_s100;

--
-- Name: avg_cost; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.avg_cost AS
 SELECT e.material,
    avg(e.cost) AS average_cost
   FROM public.expenses e
  GROUP BY e.material
 HAVING (count(e.material) >= 2);


ALTER TABLE public.avg_cost OWNER TO c370_s100;

--
-- Name: campaign; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.campaign (
    campaign_id integer NOT NULL,
    campaign_name character varying(255),
    start_date date,
    end_date date,
    phase character varying(255),
    budget numeric(10,2),
    campaign_notes character varying(255)
);


ALTER TABLE public.campaign OWNER TO c370_s100;

--
-- Name: campaign_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.campaign_campaign_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_campaign_id_seq OWNER TO c370_s100;

--
-- Name: campaign_campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.campaign_campaign_id_seq OWNED BY public.campaign.campaign_id;


--
-- Name: campaign_expenses_after_aug; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.campaign_expenses_after_aug AS
 SELECT c.campaign_name,
    e.material,
    e.description,
    e.cost,
    e.date_of_purchase
   FROM (public.expenses e
     JOIN public.campaign c ON ((e.campaign_id = c.campaign_id)))
  WHERE (e.date_of_purchase > '2024-08-10'::date);


ALTER TABLE public.campaign_expenses_after_aug OWNER TO c370_s100;

--
-- Name: campaign_expenses_summary; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.campaign_expenses_summary AS
 SELECT c.campaign_name,
    c.budget AS total_budget,
    sum(e.cost) AS total_expenses
   FROM (public.campaign c
     LEFT JOIN public.expenses e ON ((c.campaign_id = e.campaign_id)))
  GROUP BY c.campaign_id, c.campaign_name, c.budget;


ALTER TABLE public.campaign_expenses_summary OWNER TO c370_s100;

--
-- Name: complicated_expense_query; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.complicated_expense_query AS
 SELECT expenses.material
   FROM public.expenses
  WHERE ((expenses.campaign_id < 3) AND (expenses.cost = ( SELECT expenses_1.cost
           FROM public.expenses expenses_1
          WHERE ((expenses_1.date_of_purchase > '2024-05-10'::date) AND (expenses_1.date_of_purchase <= '2024-05-15'::date)))));


ALTER TABLE public.complicated_expense_query OWNER TO c370_s100;

--
-- Name: computer_system; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.computer_system (
    cpu_id integer NOT NULL,
    campaign_id integer,
    employee_id integer,
    member_id integer,
    volunteer_id integer,
    donor_id integer
);


ALTER TABLE public.computer_system OWNER TO c370_s100;

--
-- Name: computer_system_cpu_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.computer_system_cpu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.computer_system_cpu_id_seq OWNER TO c370_s100;

--
-- Name: computer_system_cpu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.computer_system_cpu_id_seq OWNED BY public.computer_system.cpu_id;


--
-- Name: donor; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.donor (
    donor_id integer NOT NULL,
    donor_name character varying(255),
    primary_donor_contact character varying(255),
    amount numeric(10,2),
    donor_phone character varying(15)
);


ALTER TABLE public.donor OWNER TO c370_s100;

--
-- Name: donor_donor_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.donor_donor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donor_donor_id_seq OWNER TO c370_s100;

--
-- Name: donor_donor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.donor_donor_id_seq OWNED BY public.donor.donor_id;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    employee_name character varying(255),
    "position" character varying(255),
    salary numeric(10,2),
    date_hired date
);


ALTER TABLE public.employee OWNER TO c370_s100;

--
-- Name: employs; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.employs (
    gng_id integer NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE public.employs OWNER TO c370_s100;

--
-- Name: green_not_greed; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.green_not_greed (
    gng_id integer NOT NULL,
    gng_name character varying(255),
    gng_email character varying(255),
    gng_phone character varying(15)
);


ALTER TABLE public.green_not_greed OWNER TO c370_s100;

--
-- Name: supports; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.supports (
    gng_id integer NOT NULL,
    donor_id integer NOT NULL
);


ALTER TABLE public.supports OWNER TO c370_s100;

--
-- Name: employee_donor_relationship; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.employee_donor_relationship AS
 SELECT e.employee_name,
    e."position",
    d.donor_name,
    d.primary_donor_contact
   FROM ((((public.employee e
     JOIN public.employs emp ON ((e.employee_id = emp.employee_id)))
     JOIN public.green_not_greed gng ON ((emp.gng_id = gng.gng_id)))
     JOIN public.supports s ON ((gng.gng_id = s.gng_id)))
     JOIN public.donor d ON ((s.donor_id = d.donor_id)));


ALTER TABLE public.employee_donor_relationship OWNER TO c370_s100;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_employee_id_seq OWNER TO c370_s100;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- Name: employee_salaries_date_hired; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.employee_salaries_date_hired AS
 SELECT employee.salary,
    employee.employee_name
   FROM public.employee
  WHERE ((employee.salary > 25000.00) AND (employee.date_hired >= '2023-03-05'::date));


ALTER TABLE public.employee_salaries_date_hired OWNER TO c370_s100;

--
-- Name: event; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.event (
    event_id integer NOT NULL,
    event_name character varying(255),
    event_location character varying(255),
    event_description text,
    event_date date
);


ALTER TABLE public.event OWNER TO c370_s100;

--
-- Name: event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.event_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_event_id_seq OWNER TO c370_s100;

--
-- Name: event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.event_event_id_seq OWNED BY public.event.event_id;


--
-- Name: fundraiser; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.fundraiser (
    event_id integer NOT NULL,
    target_goal numeric(10,2),
    funds_raised numeric(10,2),
    sponsorship character varying(255)
);


ALTER TABLE public.fundraiser OWNER TO c370_s100;

--
-- Name: global_affiliate_company_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.global_affiliate_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.global_affiliate_company_id_seq OWNER TO c370_s100;

--
-- Name: global_affiliate_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.global_affiliate_company_id_seq OWNED BY public.global_affiliate.company_id;


--
-- Name: green_not_greed_gng_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.green_not_greed_gng_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.green_not_greed_gng_id_seq OWNER TO c370_s100;

--
-- Name: green_not_greed_gng_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.green_not_greed_gng_id_seq OWNED BY public.green_not_greed.gng_id;


--
-- Name: located_at; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.located_at (
    gng_id integer NOT NULL,
    office_id integer NOT NULL
);


ALTER TABLE public.located_at OWNER TO c370_s100;

--
-- Name: manages; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.manages (
    gng_id integer NOT NULL,
    cpu_ip character varying(255) NOT NULL
);


ALTER TABLE public.manages OWNER TO c370_s100;

--
-- Name: member_member_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.member_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_member_id_seq OWNER TO c370_s100;

--
-- Name: member_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.member_member_id_seq OWNED BY public.member.member_id;


--
-- Name: participates; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.participates (
    event_id integer NOT NULL,
    volunteer_id integer NOT NULL
);


ALTER TABLE public.participates OWNER TO c370_s100;

--
-- Name: member_volunteer_participation; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.member_volunteer_participation AS
 SELECT m.member_id,
    v.volunteer_id,
    m.member_name,
    e.event_name
   FROM (((public.member m
     JOIN public.volunteer v ON (((m.member_name)::text = (v.volunteer_name)::text)))
     JOIN public.participates p ON ((v.volunteer_id = p.volunteer_id)))
     JOIN public.event e ON ((p.event_id = e.event_id)));


ALTER TABLE public.member_volunteer_participation OWNER TO c370_s100;

--
-- Name: not_fundraiser; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.not_fundraiser AS
 SELECT event.event_name
   FROM public.event
EXCEPT ALL
 SELECT event.event_name
   FROM public.event
  WHERE (event.event_id IN ( SELECT fundraiser.event_id
           FROM public.fundraiser));


ALTER TABLE public.not_fundraiser OWNER TO c370_s100;

--
-- Name: represents; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.represents (
    url character varying(255) NOT NULL,
    campaign_id integer NOT NULL
);


ALTER TABLE public.represents OWNER TO c370_s100;

--
-- Name: not_pushed; Type: VIEW; Schema: public; Owner: c370_s100
--

CREATE VIEW public.not_pushed AS
 SELECT c.campaign_name
   FROM (public.campaign c
     LEFT JOIN public.represents r ON ((c.campaign_id = r.campaign_id)))
  WHERE (r.campaign_id IS NULL);


ALTER TABLE public.not_pushed OWNER TO c370_s100;

--
-- Name: office; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.office (
    office_id integer NOT NULL,
    office_address character varying(255),
    office_phone character varying(15),
    rent numeric(10,2)
);


ALTER TABLE public.office OWNER TO c370_s100;

--
-- Name: office_office_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.office_office_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.office_office_id_seq OWNER TO c370_s100;

--
-- Name: office_office_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.office_office_id_seq OWNED BY public.office.office_id;


--
-- Name: organizes; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.organizes (
    gng_id integer NOT NULL,
    campaign_id integer NOT NULL
);


ALTER TABLE public.organizes OWNER TO c370_s100;

--
-- Name: plans; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.plans (
    campaign_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.plans OWNER TO c370_s100;

--
-- Name: pushes_to; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.pushes_to (
    cpu_id integer NOT NULL,
    url character varying(255) NOT NULL
);


ALTER TABLE public.pushes_to OWNER TO c370_s100;

--
-- Name: volunteer_volunteer_id_seq; Type: SEQUENCE; Schema: public; Owner: c370_s100
--

CREATE SEQUENCE public.volunteer_volunteer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteer_volunteer_id_seq OWNER TO c370_s100;

--
-- Name: volunteer_volunteer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s100
--

ALTER SEQUENCE public.volunteer_volunteer_id_seq OWNED BY public.volunteer.volunteer_id;


--
-- Name: website; Type: TABLE; Schema: public; Owner: c370_s100
--

CREATE TABLE public.website (
    url character varying(255) NOT NULL,
    twitter character varying(255),
    facebook character varying(255)
);


ALTER TABLE public.website OWNER TO c370_s100;

--
-- Name: campaign campaign_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.campaign ALTER COLUMN campaign_id SET DEFAULT nextval('public.campaign_campaign_id_seq'::regclass);


--
-- Name: computer_system cpu_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.computer_system ALTER COLUMN cpu_id SET DEFAULT nextval('public.computer_system_cpu_id_seq'::regclass);


--
-- Name: donor donor_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.donor ALTER COLUMN donor_id SET DEFAULT nextval('public.donor_donor_id_seq'::regclass);


--
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- Name: event event_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.event ALTER COLUMN event_id SET DEFAULT nextval('public.event_event_id_seq'::regclass);


--
-- Name: global_affiliate company_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.global_affiliate ALTER COLUMN company_id SET DEFAULT nextval('public.global_affiliate_company_id_seq'::regclass);


--
-- Name: green_not_greed gng_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.green_not_greed ALTER COLUMN gng_id SET DEFAULT nextval('public.green_not_greed_gng_id_seq'::regclass);


--
-- Name: member member_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.member ALTER COLUMN member_id SET DEFAULT nextval('public.member_member_id_seq'::regclass);


--
-- Name: office office_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.office ALTER COLUMN office_id SET DEFAULT nextval('public.office_office_id_seq'::regclass);


--
-- Name: volunteer volunteer_id; Type: DEFAULT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.volunteer ALTER COLUMN volunteer_id SET DEFAULT nextval('public.volunteer_volunteer_id_seq'::regclass);


--
-- Data for Name: campaign; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.campaign (campaign_id, campaign_name, start_date, end_date, phase, budget, campaign_notes) FROM stdin;
6	Cat love big box	2019-03-12	2020-06-12	Execution	30.00	\N
7	Lee's cowboy boots	2024-05-17	2024-05-18	Planning	500.00	\N
8	Billy Bob Goes to the Fair	2003-12-12	2009-12-12	Monitoring	1000.00	\N
9	Here is a new campaign	2003-12-12	2004-12-12	Execution	900.00	\N
2	Bring Back the James Bay Beach Fires	2024-08-15	2024-09-15	Monitoring	12000.00	\N
3	Not Enough Ice Cream For Everyone	2024-10-10	2024-11-10	Planning	9500.00	\N
4	Big Trees, Big Yes!	2024-06-01	2024-07-01	Execution	8000.00	\N
5	oooga boogaa	2000-12-12	2003-12-12	Planning	400000.00	\N
\.


--
-- Data for Name: comprises; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.comprises (gng_id, company_id, member_id) FROM stdin;
5	1	8
5	1	13
5	2	10
5	3	6
5	4	2
5	4	4
5	5	17
5	6	15
5	7	12
5	8	11
5	8	1
5	9	20
\.


--
-- Data for Name: computer_system; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.computer_system (cpu_id, campaign_id, employee_id, member_id, volunteer_id, donor_id) FROM stdin;
\.


--
-- Data for Name: donor; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.donor (donor_id, donor_name, primary_donor_contact, amount, donor_phone) FROM stdin;
1	eco inc	homer	25000.00	123-456-7890
2	saveearth foundation	bart	50000.00	234-567-8901
3	cleantech innovations	marge	30000.00	345-678-9012
4	greenfuture group	lisa	20000.00	456-789-0123
5	eco corp	maggie	40000.00	567-890-1234
6	sustainable solutions	ned	35000.00	678-901-2345
7	renewable resources ltd.	milhouse	28000.00	789-012-3456
8	planetpreservers	nelson	100000.00	890-123-4567
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.employee (employee_id, employee_name, "position", salary, date_hired) FROM stdin;
1	Mei Ling	Head of Donations	25000.00	2023-03-05
2	Alice Johnson	Manager	35000.00	2023-01-15
3	Mohammed Khan	Assistant Manager	30000.00	2023-02-10
4	Jackson Smith	Marketing Specialist	28000.00	2023-04-20
5	Fatima Patel	Accountant	32000.00	2023-05-12
6	Ethan Thompson	Customer Service Representative	23000.00	2023-06-30
\.


--
-- Data for Name: employs; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.employs (gng_id, employee_id) FROM stdin;
4	1
5	2
5	3
3	4
1	6
2	6
3	6
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.event (event_id, event_name, event_location, event_description, event_date) FROM stdin;
1	#mofire	james bay beach	cleanup to support	2024-08-27
2	ice cream social	main street plaza	social event	2024-10-22
3	diy ice cream workshop	community center	workshop	2024-11-07
4	save the big tree	civic center plaza	tree-saving event	2025-04-20
5	beach cleanup party	coastal community beach	cleanup party	2025-07-02
6	Save the Turts	Tofino	Quick catch em all!	2004-10-17
9	gator boots for me	victoria	get me boots	2025-12-12
8	hands off my kitty	my house	meow hissss	2023-12-12
16	dark cloud	over	deg\\bug = hard	2003-12-12
17	dark cloud	over me	debug ahhh	2000-12-12
18	3	las vegas	3 times the charm	2003-12-12
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.expenses (campaign_id, material, description, cost, date_of_purchase) FROM stdin;
2	Posters	Printing	500.00	2024-05-15
2	Placards	Volunteer supplies	300.00	2024-05-20
2	Firewood	Beach event supplies	700.00	2024-08-10
2	Marshmallows	Bonfire event	200.00	2024-08-12
3	Ice Cream Cones	Refreshments	400.00	2024-10-25
3	T-shirts	Volunteer attire	600.00	2024-10-30
3	Flyers	Advertising materials	300.00	2024-05-10
2	Blankets	Beach event supplies	600.00	2024-08-08
3	Hot dogs	Bonfire event refreshments	150.00	2024-08-12
4	Balloons	Decoration	200.00	2024-10-20
4	Posters	Printing	900.00	2024-05-18
4	Placards	Volunteer supplies	100.00	2024-05-25
4	T-shirts	Promotional attire	1100.00	2024-11-02
4	Flyers	Advertising materials	200.00	2024-05-18
\.


--
-- Data for Name: fundraiser; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.fundraiser (event_id, target_goal, funds_raised, sponsorship) FROM stdin;
1	5000.00	2000.00	Local businesses sponsorships
2	3000.00	1500.00	Community donations and grants
6	10000.00	100.00	James Bay turtle shop
8	1000000.00	0.00	meow mix
9	500.00	0.00	none yet
17	90000.00	3.00	Big Z Tires
18	5555.00	3333.00	pitch n putt
\.


--
-- Data for Name: global_affiliate; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.global_affiliate (company_id, company_name, company_location, company_phone, company_email) FROM stdin;
1	abc corporation	los angeles	987-654-3210	john@abc.com
2	thugs not rugs	nanaimo	764-255-8769	june@rugs.com
3	thugs not rugs	duncan	929-255-8769	beanie@rugs.com
4	thugs not rugs	victoria	250-255-8769	gurwinder@rugs.com
5	currs n furs	fort mcneil	604-888-8888	wolfy@currrrrr.com
6	currs n furs	yukon	753-888-8888	bigbear@currrrrr.com
7	its a hard knock life	surrey	456-654-4567	harv@hkl.com
8	its a hard knock life	vancouver	604-654-4567	harv@hkl.com
9	its a hard knock life	victoria	250-654-4567	harv@hkl.com
10	its a hard knock life	langford	778-654-4567	harv@hkl.com
\.


--
-- Data for Name: green_not_greed; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.green_not_greed (gng_id, gng_name, gng_email, gng_phone) FROM stdin;
1	green not greed organization	info@greennotgreed.org	123-456-7890
2	green not greed organization	generalenquiries@greennotgreed.org	999-999-9999
3	green not greed organization	emergency@greennotgreed.org	911-911-9111
4	green not greed organization	donor_support@greennotgreed.org	987-654-3333
5	green not greed organization	members_official@greennotgreed.org	987-654-8888
\.


--
-- Data for Name: located_at; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.located_at (gng_id, office_id) FROM stdin;
1	1
2	1
3	1
\.


--
-- Data for Name: manages; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.manages (gng_id, cpu_ip) FROM stdin;
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.member (member_id, member_name, member_phone, member_email, member_notes) FROM stdin;
1	Boris	250-123-4567	boris.badenov@gmail.com	\N
2	Natasha	250-234-5678	natasha.fatale@gmail.com	\N
3	Rocky	250-345-6789	rocky.squirrel@gmail.com	\N
4	Bullwinkle	250-456-7890	bullwinkle.moose@gmail.com	\N
5	Fearless	250-567-8901	fearless.leader@gmail.com	\N
6	Jules	250-111-1111	jules@gmail.com	\N
7	Vincent	250-222-2222	vincent@gmail.com	\N
8	Mia	250-333-3333	mia@gmail.com	\N
9	Butch	250-444-4444	butch@gmail.com	\N
10	Marcellus	250-555-5555	marcellus@gmail.com	\N
11	Winston	250-666-7777	winston.wolf@gmail.com	\N
12	Bruce	250-777-7777	bruce@gmail.com	\N
13	Samuel	250-888-8888	samuel@gmail.com	\N
14	Quentin	250-999-9999	quentin@gmail.com	\N
15	Henrik	250-123-4567	henrik@gmail.com	\N
16	Daniel	250-234-5678	daniel@gmail.com	\N
17	Pavel	250-345-6789	pavel@gmail.com	\N
18	Richard	250-456-7890	richard@gmail.com	\N
19	Erlich	250-567-8901	erlich@gmail.com	\N
20	Jared	250-678-9012	jared@gmail.com	\N
\.


--
-- Data for Name: office; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.office (office_id, office_address, office_phone, rent) FROM stdin;
1	123 Beach Avenue, Victoria, BC V8N 2J5, Canada	250-123-4567	3500.00
\.


--
-- Data for Name: organizes; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.organizes (gng_id, campaign_id) FROM stdin;
1	2
1	3
1	4
2	2
2	3
2	4
\.


--
-- Data for Name: participates; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.participates (event_id, volunteer_id) FROM stdin;
1	23
2	6
3	30
5	15
3	11
2	27
1	5
1	4
5	29
3	20
4	3
1	16
2	32
2	17
3	14
4	8
2	26
1	10
3	1
5	28
3	22
4	12
2	7
1	13
4	25
5	31
2	18
3	19
4	9
1	24
5	21
2	2
3	34
3	35
6	22
8	23
9	39
9	37
5	43
6	45
18	11
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.plans (campaign_id, event_id) FROM stdin;
2	6
7	9
3	8
2	4
3	5
3	1
4	2
4	3
7	16
7	17
8	18
\.


--
-- Data for Name: pushes_to; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.pushes_to (cpu_id, url) FROM stdin;
\.


--
-- Data for Name: represents; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.represents (url, campaign_id) FROM stdin;
https://jamesbaybeachfires.com	3
https://icecreampleasures.com	4
\.


--
-- Data for Name: supports; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.supports (gng_id, donor_id) FROM stdin;
4	1
4	2
4	3
4	4
4	5
4	6
4	7
4	8
\.


--
-- Data for Name: volunteer; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.volunteer (volunteer_id, volunteer_name, tier, volunteer_phone, volunteer_email, volunteer_notes) FROM stdin;
1	cloud	one	250-123-4567	cloud@gmail.com	\N
2	tifa	two	250-234-5678	tifa@gmail.com	\N
3	chandra	one	250-456-7890	chandra@gmail.com	\N
4	Boris	one	250-123-4567	boris.badenov@gmail.com	\N
5	george	two	250-901-2345	george@gmail.com	\N
6	tupac	two	250-123-4567	tupac@gmail.com	\N
7	biggie	two	250-234-5678	biggie@gmail.com	\N
8	shakespeare	one	250-123-4567	shakespeare@gmail.com	\N
9	Bullwinkle	one	250-456-7890	bullwinkle.moose@gmail.com	\N
10	williams	two	250-345-6789	williams@gmail.com	\N
11	hansberry	one	250-456-7890	hansberry@gmail.com	\N
12	hitchcock	two	250-567-8901	hitchcock@gmail.com	\N
13	spielberg	two	250-678-9012	spielberg@gmail.com	\N
14	leonardo	two	250-999-8888	leonardo.turtle@gmail.com	\N
15	natasha	two	250-234-5678	natasha@gmail.com	\N
16	Mia	two	250-333-3333	mia@gmail.com	\N
17	Vincent	one	250-222-2222	vincent@gmail.com	\N
18	Butch	one	250-444-4444	butch@gmail.com	\N
19	Marcellus	two	250-555-5555	marcellus@gmail.com	\N
20	coppola	two	250-901-2345	coppola@gmail.com	\N
21	keynes	one	250-012-3456	keynes@gmail.com	\N
22	friedman	two	250-234-5678	friedman@gmail.com	\N
23	krugman	one	250-345-6789	krugman@gmail.com	\N
24	Henrik	two	250-123-4567	henrik@gmail.com	\N
25	Daniel	two	250-234-5678	daniel@gmail.com	\N
26	zack	one	250-678-9012	zack@gmail.com	\N
27	kelly	two	250-789-0123	kelly@gmail.com	\N
28	acslater	two	250-890-1234	acslater@gmail.com	\N
29	jessie	one	250-901-2345	jessie@gmail.com	\N
30	lisa	two	250-012-3456	lisa@gmail.com	\N
31	jules	one	250-111-1111	jules@gmail.com	\N
32	vincent	two	250-222-2222	vincent@gmail.com	\N
35	lee	two	9297131	marmaduke@gmail.com	\N
34	Lee	two	9297131	marmaduke@gmail.com	\N
36	zorro	one	9999998888	z@gmail.com	\N
37	kiki cat	one	i'm a cat	kiki@gmail.com	\N
38	It's mee a maaaario	one	455-677-9870	peachy@gmail.com	\N
39	Dirk	one	677-980-7543	diggler@gmail.comm	\N
40	Jake the Snake	two	345-345-3456	snake@gmail.com	\N
41	LeeRoi	one	777-777-7777	mar@gmail.com	\N
42	bo	one	333-333-3333	horvat@gmail.com	\N
43	bugsy	one	444-444-4444	bug@gmail.com	\N
44	new volunteer	one	333-333-333	l@gmail.com	\N
45	Big Z	two	222-222-2222	ZZZZ@gmail.com	\N
\.


--
-- Data for Name: website; Type: TABLE DATA; Schema: public; Owner: c370_s100
--

COPY public.website (url, twitter, facebook) FROM stdin;
https://jamesbaybeachfires.com	@jamesbaybeachfires	https://facebook.com/JamesBayBeachFires
https://icecreampleasures.com	@icecreampleasures	https://facebook.com/IceCreamPleasures
\.


--
-- Name: campaign_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.campaign_campaign_id_seq', 9, true);


--
-- Name: computer_system_cpu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.computer_system_cpu_id_seq', 8, true);


--
-- Name: donor_donor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.donor_donor_id_seq', 8, true);


--
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 6, true);


--
-- Name: event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.event_event_id_seq', 18, true);


--
-- Name: global_affiliate_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.global_affiliate_company_id_seq', 10, true);


--
-- Name: green_not_greed_gng_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.green_not_greed_gng_id_seq', 5, true);


--
-- Name: member_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.member_member_id_seq', 20, true);


--
-- Name: office_office_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.office_office_id_seq', 1, false);


--
-- Name: volunteer_volunteer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s100
--

SELECT pg_catalog.setval('public.volunteer_volunteer_id_seq', 45, true);


--
-- Name: campaign campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.campaign
    ADD CONSTRAINT campaign_pkey PRIMARY KEY (campaign_id);


--
-- Name: comprises comprises_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.comprises
    ADD CONSTRAINT comprises_pkey PRIMARY KEY (gng_id, company_id, member_id);


--
-- Name: computer_system computer_system_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.computer_system
    ADD CONSTRAINT computer_system_pkey PRIMARY KEY (cpu_id);


--
-- Name: donor donor_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.donor
    ADD CONSTRAINT donor_pkey PRIMARY KEY (donor_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: employs employs_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.employs
    ADD CONSTRAINT employs_pkey PRIMARY KEY (gng_id, employee_id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);


--
-- Name: fundraiser fundraiser_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.fundraiser
    ADD CONSTRAINT fundraiser_pkey PRIMARY KEY (event_id);


--
-- Name: global_affiliate global_affiliate_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.global_affiliate
    ADD CONSTRAINT global_affiliate_pkey PRIMARY KEY (company_id);


--
-- Name: green_not_greed green_not_greed_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.green_not_greed
    ADD CONSTRAINT green_not_greed_pkey PRIMARY KEY (gng_id);


--
-- Name: located_at located_at_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.located_at
    ADD CONSTRAINT located_at_pkey PRIMARY KEY (gng_id, office_id);


--
-- Name: manages manages_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.manages
    ADD CONSTRAINT manages_pkey PRIMARY KEY (gng_id, cpu_ip);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (member_id);


--
-- Name: office office_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.office
    ADD CONSTRAINT office_pkey PRIMARY KEY (office_id);


--
-- Name: organizes organizes_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.organizes
    ADD CONSTRAINT organizes_pkey PRIMARY KEY (gng_id, campaign_id);


--
-- Name: participates participates_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.participates
    ADD CONSTRAINT participates_pkey PRIMARY KEY (event_id, volunteer_id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (campaign_id, event_id);


--
-- Name: pushes_to pushes_to_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.pushes_to
    ADD CONSTRAINT pushes_to_pkey PRIMARY KEY (cpu_id, url);


--
-- Name: represents represents_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.represents
    ADD CONSTRAINT represents_pkey PRIMARY KEY (url, campaign_id);


--
-- Name: supports supports_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.supports
    ADD CONSTRAINT supports_pkey PRIMARY KEY (gng_id, donor_id);


--
-- Name: volunteer volunteer_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.volunteer
    ADD CONSTRAINT volunteer_pkey PRIMARY KEY (volunteer_id);


--
-- Name: website website_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.website
    ADD CONSTRAINT website_pkey PRIMARY KEY (url);


--
-- Name: comprises comprises_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.comprises
    ADD CONSTRAINT comprises_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.global_affiliate(company_id);


--
-- Name: comprises comprises_gng_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.comprises
    ADD CONSTRAINT comprises_gng_id_fkey FOREIGN KEY (gng_id) REFERENCES public.green_not_greed(gng_id);


--
-- Name: comprises comprises_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.comprises
    ADD CONSTRAINT comprises_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(member_id);


--
-- Name: employs employs_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.employs
    ADD CONSTRAINT employs_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- Name: employs employs_gng_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.employs
    ADD CONSTRAINT employs_gng_id_fkey FOREIGN KEY (gng_id) REFERENCES public.green_not_greed(gng_id);


--
-- Name: expenses expenses_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.campaign(campaign_id);


--
-- Name: fundraiser fundraiser_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.fundraiser
    ADD CONSTRAINT fundraiser_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(event_id);


--
-- Name: located_at located_at_gng_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.located_at
    ADD CONSTRAINT located_at_gng_id_fkey FOREIGN KEY (gng_id) REFERENCES public.green_not_greed(gng_id);


--
-- Name: located_at located_at_office_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.located_at
    ADD CONSTRAINT located_at_office_id_fkey FOREIGN KEY (office_id) REFERENCES public.office(office_id);


--
-- Name: organizes organizes_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.organizes
    ADD CONSTRAINT organizes_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.campaign(campaign_id);


--
-- Name: organizes organizes_gng_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.organizes
    ADD CONSTRAINT organizes_gng_id_fkey FOREIGN KEY (gng_id) REFERENCES public.green_not_greed(gng_id);


--
-- Name: participates participates_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.participates
    ADD CONSTRAINT participates_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(event_id);


--
-- Name: participates participates_volunteer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.participates
    ADD CONSTRAINT participates_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.volunteer(volunteer_id);


--
-- Name: plans plans_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.campaign(campaign_id);


--
-- Name: plans plans_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(event_id);


--
-- Name: pushes_to pushes_to_cpu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.pushes_to
    ADD CONSTRAINT pushes_to_cpu_id_fkey FOREIGN KEY (cpu_id) REFERENCES public.computer_system(cpu_id);


--
-- Name: represents represents_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.represents
    ADD CONSTRAINT represents_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.campaign(campaign_id);


--
-- Name: represents represents_url_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.represents
    ADD CONSTRAINT represents_url_fkey FOREIGN KEY (url) REFERENCES public.website(url);


--
-- Name: supports supports_donor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.supports
    ADD CONSTRAINT supports_donor_id_fkey FOREIGN KEY (donor_id) REFERENCES public.donor(donor_id);


--
-- Name: supports supports_gng_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s100
--

ALTER TABLE ONLY public.supports
    ADD CONSTRAINT supports_gng_id_fkey FOREIGN KEY (gng_id) REFERENCES public.green_not_greed(gng_id);


--
-- PostgreSQL database dump complete
--

